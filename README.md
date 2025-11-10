# Omarchy Scripts

A collection of utility scripts for system setup and automation.

## Scripts

### install-warp.sh

Automates the installation of [Warp Terminal](https://www.warp.dev/) on Linux systems.

**Features:**
- Downloads the latest Warp AppImage
- Installs to `/opt/warp.appimage`
- Extracts and configures the application icon
- Creates a desktop entry for easy launching
- Updates the desktop database

**Usage:**
```bash
./install-warp.sh
```

**Requirements:**
- Linux operating system
- `curl` for downloading
- `sudo` access (for installing to `/opt`)

## Development

All scripts are checked with [ShellCheck](https://www.shellcheck.net/) to ensure quality and best practices.

## License

MIT
