# 🔖 Raindrop Scripts

Scripts for installing and managing [Raindrop.io](https://raindrop.io), an all-in-one bookmark manager.

## 💻 Scripts

### 📥 install.sh

Automates the installation of Raindrop.io via snap on Arch Linux.

**Features:**
- 📦 Installs snapd from AUR if not already installed
- ⚙️ Enables snapd services and AppArmor support (if available)
- 🔗 Sets up classic snap support
- 🔖 Installs Raindrop.io
- ✅ Checks for existing installation to avoid duplicates
- ♻️ Idempotent (safe to run multiple times)

**Usage:**
```bash
./install.sh
```

### 🗑️ uninstall.sh

Removes Raindrop.io and optionally snapd from your system.

**Features:**
- 🗑️ Removes Raindrop.io
- 🚫 Optionally removes snapd and all other snaps
- 🧹 Optionally cleans up snapd data directories
- ❓ Interactive prompts for safe removal
- ♻️ Idempotent (safe to run multiple times)

**Usage:**
```bash
./uninstall.sh
```

**Requirements:**
- 🐧 Arch Linux
- 📦 snapd (automatically installed by the script, or run `../snapd/install.sh` first)
- 🛠️ `git`, `makepkg`, and `sudo` for AUR package building
- 💻 Base development tools (base-devel package group)
