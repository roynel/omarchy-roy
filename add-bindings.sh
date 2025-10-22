#!/usr/bin/env bash
# add-bindings.sh — add custom key bindings to hyprland.conf

set -e  # exit on any error

HYPRLAND_CONF="$HOME/.config/hypr/hyprland.conf"
BINDING_SOURCE="source = ~/.local/share/omarchy-roy/hypr/bindings.conf"

# Check if the binding already exists
if grep -q "$BINDING_SOURCE" "$HYPRLAND_CONF"; then
    echo "✓ Custom bindings have already been added."
    echo "To update them, edit hypr/bindings.conf"
else
    echo "Adding custom bindings..."
    
    # Add two line breaks and then the custom bindings
    {
        echo ""
        echo "# Omarchy-Roy config"
        echo "source = ~/.local/share/omarchy-roy/hypr/bindings.conf"
    } >> "$HYPRLAND_CONF"
    
    echo "✓ Custom bindings added successfully."
fi
