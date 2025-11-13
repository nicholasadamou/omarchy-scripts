#!/bin/bash

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}=== hyprmon Installation Script ===${NC}\n"

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

# Check if Hyprland is installed
if ! command -v hyprctl &> /dev/null; then
    echo -e "${YELLOW}⚠ Warning: Hyprland does not appear to be installed.${NC}"
    echo -e "${YELLOW}hyprmon requires Hyprland to function.${NC}"
    echo -e "\n${YELLOW}Continue anyway? (y/N)${NC}"
    read -r CONTINUE
    if [[ ! "$CONTINUE" =~ ^[Yy]$ ]]; then
        echo -e "${YELLOW}Installation cancelled.${NC}"
        exit 0
    fi
fi

# Check if hyprmon is already installed
if pacman -Qi hyprmon-bin &> /dev/null; then
    echo -e "${GREEN}✓ hyprmon is already installed${NC}"
    INSTALLED_VERSION=$(pacman -Qi hyprmon-bin | grep '^Version' | awk '{print $3}')
    echo -e "Installed version: ${INSTALLED_VERSION}"
    
    echo -e "\n${YELLOW}Reinstall/update hyprmon? (y/N)${NC}"
    read -r REINSTALL
    if [[ ! "$REINSTALL" =~ ^[Yy]$ ]]; then
        echo -e "${GREEN}Keeping current installation.${NC}"
        exit 0
    fi
fi

echo -e "${YELLOW}Installing hyprmon from AUR...${NC}"

# Create temporary directory for building
BUILD_DIR=$(mktemp -d)
cd "$BUILD_DIR"

# Clone hyprmon-bin from AUR
echo -e "${YELLOW}Cloning hyprmon-bin from AUR...${NC}"
if ! git clone https://aur.archlinux.org/hyprmon-bin.git; then
    echo -e "${RED}✗ Failed to clone hyprmon-bin repository${NC}"
    rm -rf "$BUILD_DIR"
    exit 1
fi

cd hyprmon-bin

# Build and install hyprmon
echo -e "${YELLOW}Building and installing hyprmon...${NC}"
if ! makepkg -si --noconfirm; then
    echo -e "${RED}✗ Failed to build/install hyprmon${NC}"
    cd - > /dev/null
    rm -rf "$BUILD_DIR"
    exit 1
fi

# Clean up
cd - > /dev/null
rm -rf "$BUILD_DIR"

echo -e "\n${GREEN}=== Installation Complete ===${NC}"
echo -e "hyprmon has been installed successfully!"
echo -e "\nhyprmon is a multi-monitor profile manager for Hyprland."
echo -e "\nYou can launch it from your application menu or by running:"
echo -e "  hyprmon"
echo -e "\nFor more information, visit:"
echo -e "  https://github.com/erans/hyprmon"
