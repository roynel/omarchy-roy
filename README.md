# omarchy-roy

This repository contains custom configuration files for my Omarchy setup.

## Setup

### Installation

```bash
./install.sh
```

This script installs Omarchy-Roy to `~/.local/share/omarchy-roy`. It moves all files (including hidden files like `.git`) and cleans up the original directory. Run this first if you're setting up for the first time.

### Configuration Scripts

After installation, run these scripts to apply your custom configurations:

### Fix Monitor Resolution and Workspaces

```bash
./monitors-fix.sh
```

This script links your custom `monitors.conf` to fix monitor resolution and workspace settings.

### Add Custom Key Bindings

```bash
./add-bindings.sh
```

This script adds your custom key bindings from `hypr/bindings.conf` to the hyprland configuration. It checks if the bindings are already added to avoid duplicates.

### Fix Chrome-based Browsers

```bash
./chromebased-browser-fix.sh
```

This script backs up the original browser configuration files and applies custom fixes to prevent chrome-based browsers from crashing when switching workspaces. The script checks if each browser exists before applying fixes:
- **Setup**: `omarchy-launch-browser` script
- **Chromium**: Only applied if `chromium.desktop` exists
- **Brave**: Only applied if `brave-browser.desktop` exists

### Remove and Install Applications

```bash
./remove+install-apps.sh
```

This script manages package installation and removal:
- **Removes**: `1password-beta`, `1password-cli` (only if installed)
- **Installs via pacman**: `keepassxc`, `warp-terminal` (only if not already installed)
- **Installs via yay**: `brave-bin` (only if not already installed)

## Directory Structure

- `src/` - Source configuration files
  - `bin/` - Custom scripts and executables
  - `hypr/` - Hyprland window manager configuration
  - `applications/` - Desktop application configurations
