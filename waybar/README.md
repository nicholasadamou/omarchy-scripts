# 📊 Waybar Scripts

Scripts for configuring [Waybar](https://github.com/Alexays/Waybar) status bar.

## 🛠️ Scripts

### 🕛 set-12hour.sh

Configures Waybar to display time in 12-hour format (AM/PM) instead of 24-hour format.

**Features:**
- 🔍 Automatically detects and converts 24-hour time format to 12-hour
- 💾 Creates a backup of the config before making changes
- 🔄 Reloads waybar automatically if it's running
- ♻️ Idempotent (safe to run multiple times)

**Usage:**
```bash
./set-12hour.sh
```

**Requirements:**
- 📊 Waybar status bar
