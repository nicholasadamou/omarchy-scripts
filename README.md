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

### Code Quality

All scripts are checked with [ShellCheck](https://www.shellcheck.net/) to ensure quality and best practices.

#### Pre-commit Hook

A pre-commit hook is configured to automatically run ShellCheck on any modified shell scripts before committing. This prevents committing code with shellcheck issues.

The hook is located at `.git/hooks/pre-commit` and will:
- Run automatically before each commit
- Check all staged `.sh` and `.bash` files
- Block the commit if any issues are found
- Require shellcheck to be installed locally

To bypass the hook (not recommended): `git commit --no-verify`

#### GitHub Actions

Continuous Integration is set up via GitHub Actions to run ShellCheck on:
- Every push to `main` or `master` branches
- Every pull request targeting `main` or `master` branches

The workflow configuration is in `.github/workflows/shellcheck.yml`.

## License

MIT
