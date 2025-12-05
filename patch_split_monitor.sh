#!/usr/bin/env bash
# patch_split_monitor.sh — patch monitor keybindings to use split-monitor-workspaces plugin

set -e  # exit on any error

# FILE TO PATCH
# using $HOME to ensure the path expands correctly
CONFIG_FILE="$HOME/.local/share/omarchy/default/hypr/bindings/tiling-v2.conf"
PLUGIN_NAME="split-monitor-workspaces"
PLUGIN_URL="https://github.com/Duckonaut/split-monitor-workspaces"

# 1. PLUGIN MANAGEMENT LOGIC
echo "Checking Hyprland plugin status..."

# Check if hyprpm is available
if ! command -v hyprpm &> /dev/null; then
    echo "Error: hyprpm command not found. Please ensure Hyprland development tools are installed."
    exit 1
fi

# Check if the plugin is in the list
if ! hyprpm list | grep -q "$PLUGIN_NAME"; then
    echo "Plugin '$PLUGIN_NAME' is NOT installed."
    echo "Installing from $PLUGIN_URL..."
    
    if hyprpm add "$PLUGIN_URL"; then
        echo "✓ Plugin added successfully"
        hyprpm enable "$PLUGIN_NAME"
        hyprpm reload
    else
        echo "Error: Failed to add plugin. Please check your internet connection or headers"
        exit 1
    fi
else
    echo "✓ Plugin '$PLUGIN_NAME' is already installed"
    echo "Ensuring it is enabled and reloading..."
    hyprpm enable "$PLUGIN_NAME"
    hyprpm reload
fi

# 2. FILE PATCHING LOGIC
# Check if config file exists
if [ ! -f "$CONFIG_FILE" ]; then
    echo "Error: Config file $CONFIG_FILE not found!"
    exit 1
fi

echo "Backing up config file..."
cp "$CONFIG_FILE" "$CONFIG_FILE.bak"
echo "✓ Backup created at $CONFIG_FILE.bak"

echo "Patching lines to use split-monitor-workspaces..."

# 1. Patch 'workspace' -> 'split-workspace'
sed -i 's/, workspace,/, split-workspace,/g' "$CONFIG_FILE"

# 2. Patch 'movetoworkspace' -> 'split-movetoworkspace'
sed -i 's/, movetoworkspace,/, split-movetoworkspace,/g' "$CONFIG_FILE"

# 3. Patch 'movetoworkspacesilent' -> 'split-movetoworkspacesilent'
sed -i 's/, movetoworkspacesilent,/, split-movetoworkspacesilent,/g' "$CONFIG_FILE"

echo "✓ Split-monitor-workspaces plugin installed and keybindings patched successfully."
