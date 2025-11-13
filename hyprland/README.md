# Hyprland Scripts

Scripts for configuring [Hyprland](https://hyprland.org/) and [Omarchy](https://github.com/OmarCastro/omarchy).

## Scripts

### set-cursor-size.sh

Configures a custom cursor size in Hyprland/Omarchy by updating both environment variables and autostart settings.

**Features:**
- Sets `XCURSOR_SIZE` and `HYPRCURSOR_SIZE` environment variables
- Configures autostart to apply cursor size on login
- Automatically detects current cursor theme
- Applies changes immediately if Hyprland is running
- Idempotent (safe to run multiple times)
- Accepts optional cursor size parameter (default: 16)

**Usage:**
```bash
# Use default size (16)
./set-cursor-size.sh

# Specify custom size (between 8 and 64)
./set-cursor-size.sh 12
```

**Requirements:**
- Hyprland window manager
- Omarchy (for configuration structure)
- `gsettings` for cursor theme detection
