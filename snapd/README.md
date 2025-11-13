# Snapd Scripts

Scripts for installing and managing [snapd](https://snapcraft.io/) on Arch Linux.

## Scripts

### install.sh

Installs snapd from the AUR and configures it for use on Arch Linux.

**Features:**
- Builds and installs snapd from AUR
- Enables snapd socket and services
- Configures AppArmor support (if available)
- Sets up classic snap support with `/snap` symlink
- Idempotent (safe to run multiple times)

**Usage:**
```bash
./install.sh
```

### uninstall.sh

Removes snapd and all installed snaps from your system.

**Features:**
- Removes all installed snaps
- Disables snapd services
- Removes snapd package
- Optionally cleans up data directories
- Interactive prompts for safe removal

**Usage:**
```bash
./uninstall.sh
```

**Requirements:**
- Arch Linux
- `git`, `makepkg`, and `sudo` for AUR package building
- Base development tools (base-devel package group)
