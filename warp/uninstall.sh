#!/bin/bash

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Configuration
INSTALL_DIR="/opt"
APPIMAGE_PATH="${INSTALL_DIR}/warp.appimage"
DESKTOP_ENTRY="${HOME}/.local/share/applications/warp.desktop"
ICON_DIR="${HOME}/.local/share/icons"
ICON_PATH="${ICON_DIR}/warp.png"

echo -e "${GREEN}=== Warp Terminal Uninstallation Script ===${NC}\n"

# Check if Warp is installed
if [[ ! -f "$APPIMAGE_PATH" ]] && [[ ! -f "$DESKTOP_ENTRY" ]] && [[ ! -f "$ICON_PATH" ]]; then
    echo -e "${YELLOW}Warp Terminal does not appear to be installed.${NC}"
fi

# Remove AppImage
if [[ -f "$APPIMAGE_PATH" ]]; then
    echo -e "${YELLOW}Removing Warp AppImage...${NC}"
    if [[ -w "$INSTALL_DIR" ]]; then
        rm -f "$APPIMAGE_PATH"
    else
        sudo rm -f "$APPIMAGE_PATH"
    fi
    echo -e "${GREEN}✓ Removed ${APPIMAGE_PATH}${NC}"
else
    echo -e "${YELLOW}⚠ AppImage not found at ${APPIMAGE_PATH}${NC}"
fi

# Remove desktop entry
if [[ -f "$DESKTOP_ENTRY" ]]; then
    echo -e "${YELLOW}Removing desktop entry...${NC}"
    rm -f "$DESKTOP_ENTRY"
    echo -e "${GREEN}✓ Removed ${DESKTOP_ENTRY}${NC}"
else
    echo -e "${YELLOW}⚠ Desktop entry not found at ${DESKTOP_ENTRY}${NC}"
fi

# Remove icon
if [[ -f "$ICON_PATH" ]]; then
    echo -e "${YELLOW}Removing icon...${NC}"
    rm -f "$ICON_PATH"
    echo -e "${GREEN}✓ Removed ${ICON_PATH}${NC}"
else
    echo -e "${YELLOW}⚠ Icon not found at ${ICON_PATH}${NC}"
fi

# Update desktop database
if command -v update-desktop-database &> /dev/null; then
    update-desktop-database "$(dirname "$DESKTOP_ENTRY")" 2>/dev/null || true
    echo -e "${GREEN}✓ Desktop database updated${NC}"
fi

echo -e "\n${GREEN}=== Uninstallation Complete ===${NC}"
echo -e "Warp Terminal has been removed from your system."
