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

# 3. WAYBAR CONFIGURATION PATCHING
WAYBAR_CONFIG="$HOME/.config/waybar/config.jsonc"

if [ ! -f "$WAYBAR_CONFIG" ]; then
    echo "Warning: Waybar config file not found at $WAYBAR_CONFIG"
    echo "Skipping waybar configuration..."
else
    echo "Patching waybar configuration for split-monitor-workspaces..."
    
    # Backup waybar config
    cp "$WAYBAR_CONFIG" "$WAYBAR_CONFIG.bak"
    echo "✓ Backup created at $WAYBAR_CONFIG.bak"
    
    # Get monitor names
    MONITOR1=$(hyprctl monitors | grep -m1 "Monitor" | awk '{print $2}')
    MONITOR2=$(hyprctl monitors | grep "Monitor" | tail -1 | awk '{print $2}')
    
    echo "Detected monitors: $MONITOR1 and $MONITOR2"
    
    # Create a temporary Python script to update the JSON
    python3 << 'PYTHON_SCRIPT'
import json
import re
import os
import sys

# Read the config file
config_path = os.path.expanduser("~/.config/waybar/config.jsonc")
with open(config_path, 'r') as f:
    content = f.read()

# Remove comments (JSONC to JSON)
content_no_comments = re.sub(r'//.*', '', content)
content_no_comments = re.sub(r'/\*.*?\*/', '', content_no_comments, flags=re.DOTALL)

# Parse JSON
config = json.loads(content_no_comments)

# Get monitor names from hyprctl
import subprocess
monitors_output = subprocess.check_output(['hyprctl', 'monitors']).decode('utf-8')
monitor_lines = [line for line in monitors_output.split('\n') if line.startswith('Monitor')]
monitor1 = monitor_lines[0].split()[1] if len(monitor_lines) > 0 else "VGA-1"
monitor2 = monitor_lines[1].split()[1] if len(monitor_lines) > 1 else "HDMI-A-2"

# Update hyprland/workspaces configuration
if 'hyprland/workspaces' in config:
    workspaces_config = config['hyprland/workspaces']
    
    # Add all-outputs: false if not present
    workspaces_config['all-outputs'] = False
    
    # Update format-icons to include workspaces 11-20
    if 'format-icons' not in workspaces_config:
        workspaces_config['format-icons'] = {}
    
    format_icons = workspaces_config['format-icons']
    # First monitor workspaces 1-10
    for i in range(1, 10):
        format_icons[str(i)] = str(i)
    format_icons["10"] = "0"
    
    # Second monitor workspaces 11-20 (displayed as 1-9, 0)
    for i in range(11, 20):
        format_icons[str(i)] = str(i - 10)
    format_icons["20"] = "0"
    
    format_icons["default"] = ""
    format_icons["active"] = "󱓻"
    
    # Set persistent workspaces per monitor
    workspaces_config['persistent-workspaces'] = {
        monitor1: list(range(1, 11)),
        monitor2: list(range(11, 21))
    }
    
    config['hyprland/workspaces'] = workspaces_config

# Write back to file
with open(config_path, 'w') as f:
    json.dump(config, f, indent=2)

print(f"✓ Waybar config updated for monitors: {monitor1} (1-10) and {monitor2} (11-20)")
PYTHON_SCRIPT
    
    if [ $? -eq 0 ]; then
        echo "✓ Waybar configuration patched successfully"
        
        # Restart waybar
        echo "Restarting waybar..."
        killall waybar 2>/dev/null || true
        waybar &
        echo "✓ Waybar restarted"
    else
        echo "Error: Failed to patch waybar configuration"
        exit 1
    fi
fi

echo ""
echo "✓ All patches applied successfully!"
