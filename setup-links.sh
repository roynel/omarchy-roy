#!/usr/bin/env bash
# setup-link.sh — create all symlinks for omarchy-roy config

set -e  # exit on any error

echo "Creating symlinks..."

# hypr
ln -sf ~/.local/share/omarchy-roy/hypr/monitors.conf ~/.config/hypr/monitors.conf
ln -sf ~/.local/share/omarchy-roy/hypr/bindings.conf ~/.config/hypr/bindings.conf

# browsers
ln -sf ~/.local/share/omarchy-roy/bin/omarchy-launch-browser ~/.local/share/omarchy/bin/omarchy-launch-browser
ln -sf ~/.local/share/omarchy-roy/applications/brave-browser.desktop ~/.local/share/applications/brave-browser.desktop
ln -sf ~/.local/share/omarchy-roy/applications/chromium.desktop ~/.local/share/applications/chromium.desktop

echo "✓ All symlinks created successfully."
