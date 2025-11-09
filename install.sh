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
    
    # Move all files and folders (including hidden files) to the omarchy-roy directory
    shopt -s dotglob  # Enable matching hidden files
    mv "$SCRIPT_DIR"/* "$INSTALL_DIR/" 2>/dev/null || true
    shopt -u dotglob  # Disable matching hidden files
    
    # Remove the old source directory
    if [ "$SCRIPT_DIR" != "$INSTALL_DIR" ] && [ -d "$SCRIPT_DIR" ]; then
        rm -rf "$SCRIPT_DIR"
        echo "✓ Removed old installation directory: $SCRIPT_DIR"
    fi
    
    echo "✓ Omarchy-Roy installed successfully."
    echo "Location: $INSTALL_DIR"
    echo "Run: cd $INSTALL_DIR"
fi
