#!/usr/bin/env bash
# remove+install-apps.sh — Remove and install specific applications

set -e  # exit on any error

echo "=== Removing applications ==="

# Remove 1password-beta if installed
if pacman -Qi 1password-beta &>/dev/null; then
    echo "Removing 1password-beta..."
    sudo pacman -Rns --noconfirm 1password-beta
    echo "✓ Removed 1password-beta"
else
    echo "✓ 1password-beta is not installed, skipping removal"
fi

# Remove 1password-cli if installed
if pacman -Qi 1password-cli &>/dev/null; then
    echo "Removing 1password-cli..."
    sudo pacman -Rns --noconfirm 1password-cli
    echo "✓ Removed 1password-cli"
else
    echo "✓ 1password-cli is not installed, skipping removal"
fi

echo ""
echo "=== Installing applications ==="

# Install keepassxc if not already installed
if pacman -Qi keepassxc &>/dev/null; then
    echo "✓ keepassxc is already installed"
else
    echo "Installing keepassxc..."
    sudo pacman -S --noconfirm keepassxc
    echo "✓ Installed keepassxc"
fi

# Install warp-terminal if not already installed
if pacman -Qi warp-terminal &>/dev/null; then
    echo "✓ warp-terminal is already installed"
else
    echo "Installing warp-terminal..."
    sudo pacman -S --noconfirm warp-terminal
    echo "✓ Installed warp-terminal"
fi

# Install brave-bin via yay if not already installed
if pacman -Qi brave-bin &>/dev/null; then
    echo "✓ brave-bin is already installed"
else
    echo "Installing brave-bin via yay..."
    yay -S --noconfirm brave-bin
    echo "✓ Installed brave-bin"
fi

echo ""
echo "✓ All operations completed successfully!"
