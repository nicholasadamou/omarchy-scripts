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

echo -e "${GREEN}=== Raindrop.io Uninstallation Script ===${NC}\n"

# Check if snap is installed
if ! command -v snap &> /dev/null; then
    echo -e "${YELLOW}⚠ snapd is not installed, nothing to uninstall${NC}"
    exit 0
fi

# Check if Raindrop is installed
if ! snap list raindrop &> /dev/null; then
    echo -e "${YELLOW}⚠ Raindrop.io is not installed${NC}"
else
    echo -e "${YELLOW}Removing Raindrop.io...${NC}"
    if sudo snap remove raindrop; then
        echo -e "${GREEN}✓ Raindrop.io removed successfully${NC}"
    else
        echo -e "${RED}✗ Failed to remove Raindrop.io${NC}"
        exit 1
    fi
fi

# Ask if user wants to remove snapd as well
echo -e "\n${YELLOW}Do you want to remove snapd completely? (y/N)${NC}"
read -r REMOVE_SNAPD

if [[ "$REMOVE_SNAPD" =~ ^[Yy]$ ]]; then
    if [[ -f "$PROJECT_ROOT/snapd/uninstall.sh" ]]; then
        echo -e "${YELLOW}Running snapd uninstallation script...${NC}\n"
        if bash "$PROJECT_ROOT/snapd/uninstall.sh"; then
            echo -e "\n${GREEN}✓ snapd uninstallation complete${NC}"
        else
            echo -e "${RED}✗ snapd uninstallation failed${NC}"
            exit 1
        fi
    else
        echo -e "${RED}Error: snapd/uninstall.sh not found at $PROJECT_ROOT/snapd/uninstall.sh${NC}"
        echo -e "${RED}Please remove snapd manually if needed.${NC}"
        exit 1
    fi
else
    echo -e "${YELLOW}Keeping snapd installed${NC}"
fi

echo -e "\n${GREEN}=== Uninstallation Complete ===${NC}"
echo -e "Raindrop.io has been removed from your system"
