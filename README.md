# Omarchy Scripts

A collection of utility scripts for system setup and automation.

## Scripts

### warp/

Scripts for managing [Warp Terminal](https://www.warp.dev/) on Linux systems.

#### install.sh

Automates the installation of Warp Terminal.

**Features:**
- Downloads the latest Warp AppImage
- Installs to `/opt/warp.appimage`
- Extracts and configures the application icon
- Creates a desktop entry for easy launching
- Checks for updates on subsequent runs
- Updates the desktop database

**Usage:**
```bash
./warp/install.sh
```

#### uninstall.sh

Removes Warp Terminal from your system.

**Features:**
- Removes the AppImage from `/opt`
- Removes the desktop entry
- Removes the application icon
- Updates the desktop database
- Idempotent (safe to run multiple times)

**Usage:**
```bash
./warp/uninstall.sh
```

**Requirements:**
- Linux operating system
- `curl` for downloading (install only)
- `sudo` access (for installing/removing from `/opt`)

## Development

All scripts are checked with [ShellCheck](https://www.shellcheck.net/) to ensure quality and best practices.

## License

MIT
