# omarchy-roy

This repository contains custom configuration files for my Omarchy setup.

## Setup

### Installation

```bash
./install.sh
```

This script installs Omarchy-Roy to `~/.local/share/omarchy-roy`. Run this first if you're setting up for the first time.

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

This script backs up the original browser configuration files and applies custom fixes to prevent chrome-based browsers from crashing when switching workspaces.

## Directory Structure

- `bin/` - Shell scripts for setup and configuration
- `hypr/` - Hyperland window manager configuration
- `applications/` - Desktop application configurations
