#!/usr/bin/env bash
# install.sh — install Omarchy-Roy configuration

set -e  # exit on any error

INSTALL_DIR="$HOME/.local/share/omarchy-roy"

if [ -d "$INSTALL_DIR" ]; then
    echo "✓ Omarchy-Roy has already been installed."
else
    echo "Installing Omarchy-Roy..."
    
    # Create the directory
    mkdir -p "$INSTALL_DIR"
    
    # Get the directory where this script is located
    SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    
    # Move all files and folders to the omarchy-roy directory
    mv "$SCRIPT_DIR"/* "$INSTALL_DIR/" 2>/dev/null || true
    
    echo "✓ Omarchy-Roy installed successfully."
    echo "Location: $INSTALL_DIR"
    echo "Run: cd $INSTALL_DIR"
fi
