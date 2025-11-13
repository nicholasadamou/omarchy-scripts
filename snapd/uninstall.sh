#!/bin/bash

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}=== snapd Uninstallation Script ===${NC}\n"

# Check if snap is installed
if ! command -v snap &> /dev/null; then
    echo -e "${YELLOW}⚠ snapd is not installed, nothing to uninstall${NC}"
    exit 0
fi

# Check if there are any snaps installed
SNAP_COUNT=$(snap list 2>/dev/null | tail -n +2 | wc -l)

if [ "$SNAP_COUNT" -gt 0 ]; then
    echo -e "${YELLOW}⚠ Warning: You have $SNAP_COUNT snap(s) installed:${NC}"
    snap list | tail -n +2 | awk '{print "  - " $1 " (" $2 ")"}'
    echo -e "\n${YELLOW}All snaps must be removed before uninstalling snapd.${NC}"
    echo -e "${YELLOW}Remove all snaps now? (y/N)${NC}"
    read -r REMOVE_ALL
    
    if [[ "$REMOVE_ALL" =~ ^[Yy]$ ]]; then
        echo -e "${YELLOW}Removing all snaps...${NC}"
        while IFS= read -r snap_name; do
            echo -e "${YELLOW}Removing $snap_name...${NC}"
            if sudo snap remove "$snap_name"; then
                echo -e "${GREEN}✓ Removed $snap_name${NC}"
            else
                echo -e "${RED}✗ Failed to remove $snap_name${NC}"
                echo -e "${RED}Please remove snaps manually before uninstalling snapd${NC}"
                exit 1
            fi
        done < <(snap list | tail -n +2 | awk '{print $1}')
    else
        echo -e "${YELLOW}Aborted. Please remove snaps manually and run this script again.${NC}"
        exit 0
    fi
fi

# Disable and stop snapd services
echo -e "\n${YELLOW}Disabling snapd services...${NC}"
sudo systemctl disable --now snapd.socket 2>/dev/null || true
sudo systemctl disable --now snapd.service 2>/dev/null || true
sudo systemctl disable --now snapd.apparmor.service 2>/dev/null || true
echo -e "${GREEN}✓ snapd services disabled${NC}"

# Remove classic snap symlink
if [[ -L /snap ]]; then
    echo -e "${YELLOW}Removing /snap symlink...${NC}"
    if sudo rm /snap; then
        echo -e "${GREEN}✓ /snap symlink removed${NC}"
    else
        echo -e "${YELLOW}⚠ Could not remove /snap symlink${NC}"
    fi
fi

# Remove snapd package
echo -e "${YELLOW}Removing snapd package...${NC}"
if sudo pacman -Rns snapd --noconfirm; then
    echo -e "${GREEN}✓ snapd package removed successfully${NC}"
else
    echo -e "${YELLOW}⚠ Could not remove snapd package (attempting with -Rn)${NC}"
    if sudo pacman -Rn snapd --noconfirm; then
        echo -e "${GREEN}✓ snapd package removed${NC}"
    else
        echo -e "${RED}✗ Failed to remove snapd package${NC}"
        echo -e "${RED}You may need to remove it manually with: sudo pacman -R snapd${NC}"
        exit 1
    fi
fi

# Ask about removing snap directories
echo -e "\n${YELLOW}Remove snapd data directories? This will delete all snap data. (y/N)${NC}"
read -r REMOVE_DATA

if [[ "$REMOVE_DATA" =~ ^[Yy]$ ]]; then
    echo -e "${YELLOW}Removing snapd directories...${NC}"
    
    dirs_to_remove=(
        "/var/lib/snapd"
        "/var/cache/snapd"
        "$HOME/snap"
    )
    
    for dir in "${dirs_to_remove[@]}"; do
        if [[ -d "$dir" ]]; then
            if [[ "$dir" == "$HOME/snap" ]]; then
                rm -rf "$dir"
                echo -e "${GREEN}✓ Removed $dir${NC}"
            else
                if sudo rm -rf "$dir"; then
                    echo -e "${GREEN}✓ Removed $dir${NC}"
                else
                    echo -e "${YELLOW}⚠ Could not remove $dir${NC}"
                fi
            fi
        fi
    done
    
    echo -e "${GREEN}✓ snapd data directories removed${NC}"
else
    echo -e "${YELLOW}Keeping snapd data directories${NC}"
fi

echo -e "\n${GREEN}=== Uninstallation Complete ===${NC}"
echo -e "snapd has been removed from your system"
