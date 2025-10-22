#!/usr/bin/env bash
# chromebased-browser-fix — fix chrome-based browsers crashing when switching workspaces
# This script backs up the original files and creates symlinks to the custom configurations

set -e  # exit on any error

echo "Backing up original files and setting up chrome-based browser fixes..."

# browsers
cp ~/.local/share/omarchy/bin/omarchy-launch-browser ~/.local/share/omarchy/bin/omarchy-launch-browser.bak
ln -sf ~/.local/share/omarchy-roy/bin/omarchy-launch-browser ~/.local/share/omarchy/bin/omarchy-launch-browser

cp ~/.local/share/applications/brave-browser.desktop ~/.local/share/applications/brave-browser.desktop.bak
ln -sf ~/.local/share/omarchy-roy/applications/brave-browser.desktop ~/.local/share/applications/brave-browser.desktop

cp ~/.local/share/applications/chromium.desktop ~/.local/share/applications/chromium.desktop.bak
ln -sf ~/.local/share/omarchy-roy/applications/chromium.desktop ~/.local/share/applications/chromium.desktop

echo "✓ Chrome-based browser fixes applied successfully."
