#!/bin/bash

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}=== snapd Installation Script ===${NC}\n"

# Check if running on Arch Linux
if [[ ! -f /etc/arch-release ]]; then
    echo -e "${RED}Error: This script is designed for Arch Linux only.${NC}"
    exit 1
fi

# Check for required commands for AUR build
for cmd in git makepkg sudo; do
    if ! command -v $cmd &> /dev/null; then
        echo -e "${RED}Error: $cmd is required but not installed.${NC}"
        exit 1
    fi
done

# Check if snapd is already installed
if command -v snap &> /dev/null; then
    echo -e "${GREEN}✓ snapd is already installed${NC}"
    snap --version
else
    echo -e "${YELLOW}Installing snapd from AUR...${NC}"
    
    # Create temporary directory for building
    BUILD_DIR=$(mktemp -d)
    cd "$BUILD_DIR"
    
    # Clone snapd from AUR
    echo -e "${YELLOW}Cloning snapd from AUR...${NC}"
    if ! git clone https://aur.archlinux.org/snapd.git; then
        echo -e "${RED}✗ Failed to clone snapd repository${NC}"
        rm -rf "$BUILD_DIR"
        exit 1
    fi
    
    cd snapd
    
    # Build and install snapd
    echo -e "${YELLOW}Building and installing snapd (this may take a few minutes)...${NC}"
    if ! makepkg -si --noconfirm; then
        echo -e "${RED}✗ Failed to build/install snapd${NC}"
        cd - > /dev/null
        rm -rf "$BUILD_DIR"
        exit 1
    fi
    
    # Clean up
    cd - > /dev/null
    rm -rf "$BUILD_DIR"
    
    echo -e "${GREEN}✓ snapd installed successfully${NC}"
fi

# Enable snapd socket
echo -e "\n${YELLOW}Enabling snapd socket...${NC}"
if sudo systemctl enable --now snapd.socket; then
    echo -e "${GREEN}✓ snapd socket enabled${NC}"
else
    echo -e "${YELLOW}⚠ Could not enable snapd socket (may already be enabled)${NC}"
fi

# Check if AppArmor is enabled
if systemctl is-active --quiet apparmor 2>/dev/null; then
    echo -e "${YELLOW}AppArmor detected, enabling snapd.apparmor.service...${NC}"
    if sudo systemctl enable --now snapd.apparmor.service; then
        echo -e "${GREEN}✓ snapd.apparmor.service enabled${NC}"
    else
        echo -e "${YELLOW}⚠ Could not enable snapd.apparmor.service${NC}"
    fi
else
    echo -e "${GREEN}✓ AppArmor not detected, skipping snapd.apparmor.service${NC}"
fi

# Enable classic snap support
if [[ ! -L /snap ]]; then
    echo -e "${YELLOW}Creating symbolic link for classic snap support...${NC}"
    if sudo ln -s /var/lib/snapd/snap /snap; then
        echo -e "${GREEN}✓ Classic snap support enabled${NC}"
    else
        echo -e "${YELLOW}⚠ Could not create /snap symlink (may already exist)${NC}"
    fi
else
    echo -e "${GREEN}✓ Classic snap support already enabled${NC}"
fi

echo -e "\n${GREEN}=== Installation Complete ===${NC}"
echo -e "snapd has been installed and configured successfully!"
echo -e "\n${YELLOW}IMPORTANT:${NC} You need to log out and log back in (or restart your system)"
echo -e "to ensure snap's paths are updated correctly.\n"
echo -e "After logging back in, you can install snaps using:"
echo -e "  sudo snap install <package-name>"
echo -e "\nTo search for snaps:"
echo -e "  snap find <search-term>"
