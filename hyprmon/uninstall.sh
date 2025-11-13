#!/bin/bash

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}=== hyprmon Uninstallation Script ===${NC}\n"

# Check if hyprmon is installed
if ! pacman -Qi hyprmon-bin &> /dev/null; then
    echo -e "${YELLOW}⚠ hyprmon is not installed${NC}"
    exit 0
fi

echo -e "${YELLOW}Removing hyprmon...${NC}"

if sudo pacman -Rns hyprmon-bin --noconfirm; then
    echo -e "${GREEN}✓ hyprmon removed successfully${NC}"
else
    echo -e "${YELLOW}⚠ Could not remove hyprmon package (attempting with -Rn)${NC}"
    if sudo pacman -Rn hyprmon-bin --noconfirm; then
        echo -e "${GREEN}✓ hyprmon removed${NC}"
    else
        echo -e "${RED}✗ Failed to remove hyprmon package${NC}"
        echo -e "${RED}You may need to remove it manually with: sudo pacman -R hyprmon-bin${NC}"
        exit 1
    fi
fi

# Check for config files
CONFIG_DIR="$HOME/.config/hyprmon"
if [[ -d "$CONFIG_DIR" ]]; then
    echo -e "\n${YELLOW}Configuration directory found at: $CONFIG_DIR${NC}"
    echo -e "${YELLOW}Remove configuration files? (y/N)${NC}"
    read -r REMOVE_CONFIG
    
    if [[ "$REMOVE_CONFIG" =~ ^[Yy]$ ]]; then
        if rm -rf "$CONFIG_DIR"; then
            echo -e "${GREEN}✓ Configuration files removed${NC}"
        else
            echo -e "${YELLOW}⚠ Could not remove configuration files${NC}"
        fi
    else
        echo -e "${YELLOW}Keeping configuration files${NC}"
    fi
fi

echo -e "\n${GREEN}=== Uninstallation Complete ===${NC}"
echo -e "hyprmon has been removed from your system"
