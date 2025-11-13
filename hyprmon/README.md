# 🖥️ hyprmon Scripts

Scripts for installing and managing [hyprmon](https://github.com/erans/hyprmon), a multi-monitor profile manager for Hyprland.

## 💻 Scripts

### 📥 install.sh

Installs hyprmon from the AUR on Arch Linux.

**Features:**
- 🔨 Builds and installs hyprmon-bin from AUR
- ✅ Checks for Hyprland installation
- 🔄 Supports reinstall/update of existing installation
- ⚠️ Warns if Hyprland is not detected
- ♻️ Idempotent (safe to run multiple times)

**Usage:**
```bash
./install.sh
```

### 🗑️ uninstall.sh

Removes hyprmon from your system.

**Features:**
- 🗑️ Removes hyprmon package
- 📁 Optionally removes configuration files
- ❓ Interactive prompts for safe removal
- ♻️ Idempotent (safe to run multiple times)

**Usage:**
```bash
./uninstall.sh
```

**Requirements:**
- 🐧 Arch Linux
- 🖥️ Hyprland (recommended)
- 🛠️ `git`, `makepkg`, and `sudo` for AUR package building
- 💻 Base development tools (base-devel package group)

## 📖 About hyprmon

hyprmon is a multi-monitor profile manager for Hyprland that allows you to:
- 💾 Save monitor configurations as profiles
- 🔄 Quickly switch between different monitor setups
- ⚙️ Manage multiple monitor layouts for different scenarios

For more information, visit the [hyprmon GitHub repository](https://github.com/erans/hyprmon).
