# 🛠️ Omarchy Scripts

A collection of utility scripts for system setup and automation.

## 📦 Scripts

### 🖥️ [hyprland/](hyprland/)

Scripts for configuring [Hyprland](https://hyprland.org/) and [Omarchy](https://github.com/OmarCastro/omarchy).

See [hyprland/README.md](hyprland/README.md) for details.

### 📊 [waybar/](waybar/)

Scripts for configuring [Waybar](https://github.com/Alexays/Waybar) status bar.

See [waybar/README.md](waybar/README.md) for details.

### 📦 [snapd/](snapd/)

Scripts for installing and managing [snapd](https://snapcraft.io/) on Arch Linux.

See [snapd/README.md](snapd/README.md) for details.

### 🔖 [raindrop/](raindrop/)

Scripts for installing and managing [Raindrop.io](https://raindrop.io), an all-in-one bookmark manager.

See [raindrop/README.md](raindrop/README.md) for details.

### ⚡ [warp/](warp/)

Scripts for managing [Warp Terminal](https://www.warp.dev/) on Linux systems.

See [warp/README.md](warp/README.md) for details.

## 🧑‍💻 Development

### ✨ Code Quality

All scripts are checked with [ShellCheck](https://www.shellcheck.net/) to ensure quality and best practices.

#### 🪝 Pre-commit Hook

A pre-commit hook is configured to automatically run ShellCheck on any modified shell scripts before committing. This prevents committing code with shellcheck issues.

The hook is located at `.git/hooks/pre-commit` and will:
- ✅ Run automatically before each commit
- 🔍 Check all staged `.sh` and `.bash` files
- 🚫 Block the commit if any issues are found
- 📋 Require shellcheck to be installed locally

To bypass the hook (not recommended): `git commit --no-verify`

#### 🤖 GitHub Actions

Continuous Integration is set up via GitHub Actions to run ShellCheck on:
- 🚀 Every push to `main` or `master` branches
- 🔀 Every pull request targeting `main` or `master` branches

The workflow configuration is in `.github/workflows/shellcheck.yml`.

## 📄 License

MIT
