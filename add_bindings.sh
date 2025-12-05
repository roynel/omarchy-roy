#!/usr/bin/env bash
# add-bindings.sh — add custom key bindings to hyprland.conf

set -e  # exit on any error

HYPRLAND_CONF="$HOME/.config/hypr/hyprland.conf"
BINDING_SOURCE="source = ~/.local/share/omarchy-roy/src/hypr/bindings.conf"
WINDOWRULES_SOURCE="source = ~/.local/share/omarchy-roy/src/hypr/windowrules.conf"

# Check if both sources already exist
if grep -q "$BINDING_SOURCE" "$HYPRLAND_CONF" && grep -q "$WINDOWRULES_SOURCE" "$HYPRLAND_CONF"; then
    echo "✓ Custom bindings and window rules have already been added."
    echo "To update them, edit hypr/bindings.conf or hypr/windowrules.conf"
else
    echo "Adding custom bindings and window rules..."
    
    # Add two line breaks and then the custom bindings
    {
        echo ""
        echo "# Omarchy-Roy config"
        echo "source = ~/.local/share/omarchy-roy/src/hypr/bindings.conf"
        echo "source = ~/.local/share/omarchy-roy/src/hypr/windowrules.conf"
    } >> "$HYPRLAND_CONF"
    
    echo "✓ Custom bindings + window rules added successfully."
fi
