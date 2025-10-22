#!/usr/bin/env bash
# fix-monitors.sh — fix monitor resolution by linking custom monitors.conf

set -e  # exit on any error

echo "Fixing monitor resolution..."

# hypr
ln -sf ~/.local/share/omarchy-roy/hypr/monitors.conf ~/.config/hypr/monitors.conf

echo "✓ Monitor resolution and workspaces fixed successfully."
