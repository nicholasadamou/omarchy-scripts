#!/bin/bash

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

echo -e "${GREEN}=== Raindrop.io Installation Script ===${NC}\n"

# Check if running on Arch Linux
if [[ ! -f /etc/arch-release ]]; then
    echo -e "${RED}Error: This script is designed for Arch Linux only.${NC}"
    exit 1
fi

# Check if snapd is installed, if not run the snapd install script
if ! command -v snap &> /dev/null; then
    echo -e "${YELLOW}snapd is not installed. Running snapd installation script...${NC}\n"
    
    if [[ -f "$PROJECT_ROOT/snapd/install.sh" ]]; then
        if bash "$PROJECT_ROOT/snapd/install.sh"; then
            echo -e "\n${GREEN}✓ snapd installation complete${NC}\n"
        else
            echo -e "${RED}✗ snapd installation failed${NC}"
            exit 1
        fi
    else
        echo -e "${RED}Error: snapd/install.sh not found at $PROJECT_ROOT/snapd/install.sh${NC}"
        echo -e "${RED}Please ensure the snapd install script exists or install snapd manually.${NC}"
        exit 1
    fi
else
    echo -e "${GREEN}✓ snapd is already installed${NC}"
fi

# Check if Raindrop is already installed
if snap list raindrop &> /dev/null; then
    echo -e "\n${GREEN}✓ Raindrop.io is already installed${NC}"
    INSTALLED_VERSION=$(snap list raindrop | tail -1 | awk '{print $2}')
    echo -e "Installed version: ${INSTALLED_VERSION}"
else
    # Install Raindrop
    echo -e "\n${YELLOW}Installing Raindrop.io...${NC}"
    if sudo snap install raindrop; then
        echo -e "${GREEN}✓ Raindrop.io installed successfully${NC}"
    else
        echo -e "${RED}✗ Failed to install Raindrop.io${NC}"
        exit 1
    fi
fi

# Create desktop file symlink for immediate availability in application launcher
SNAP_DESKTOP_FILE="/var/lib/snapd/desktop/applications/raindrop_raindrop.desktop"
USER_DESKTOP_FILE="${HOME}/.local/share/applications/raindrop.desktop"

if [[ -f "$SNAP_DESKTOP_FILE" ]]; then
    echo -e "\n${YELLOW}Creating desktop file symlink...${NC}"
    mkdir -p "${HOME}/.local/share/applications"
    if ln -sf "$SNAP_DESKTOP_FILE" "$USER_DESKTOP_FILE"; then
        echo -e "${GREEN}✓ Desktop file symlink created${NC}"
        
        # Update desktop database
        if command -v update-desktop-database &> /dev/null; then
            update-desktop-database "${HOME}/.local/share/applications/" 2>/dev/null || true
            echo -e "${GREEN}✓ Desktop database updated${NC}"
        fi
    else
        echo -e "${YELLOW}⚠ Could not create desktop file symlink${NC}"
    fi
fi

echo -e "\n${GREEN}=== Installation Complete ===${NC}"
echo -e "Raindrop.io has been installed successfully!"
echo -e "\nYou can launch Raindrop.io from your application menu or by running:"
echo -e "  snap run raindrop"
echo -e "\n${YELLOW}Note:${NC} If the app doesn't appear in your launcher, log out and back in."
