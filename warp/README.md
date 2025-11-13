# ⚡ Warp Scripts

Scripts for managing [Warp Terminal](https://www.warp.dev/) on Linux systems.

## 💻 Scripts

### 📥 install.sh

Automates the installation of Warp Terminal.

**Features:**
- 💾 Downloads the latest Warp AppImage
- 📌 Installs to `/opt/warp.appimage`
- 🎨 Extracts and configures the application icon
- 📤 Creates a desktop entry for easy launching
- 🔄 Checks for updates on subsequent runs
- ✅ Updates the desktop database

**Usage:**
```bash
./install.sh
```

### 🗑️ uninstall.sh

Removes Warp Terminal from your system.

**Features:**
- 🗑️ Removes the AppImage from `/opt`
- 🚫 Removes the desktop entry
- 🎨 Removes the application icon
- 🔄 Updates the desktop database
- ♻️ Idempotent (safe to run multiple times)

**Usage:**
```bash
./uninstall.sh
```

**Requirements:**
- 🐧 Linux operating system
- 🌍 `curl` for downloading (install only)
- 🔐 `sudo` access (for installing/removing from `/opt`)
