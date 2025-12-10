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

# Install Mega CMD if not already installed
if pacman -Qi megacmd &>/dev/null; then
    echo "✓ megacmd is already installed"
else
    echo "Installing Mega CMD..."
    cd /tmp
    wget https://mega.nz/linux/repo/Arch_Extra/x86_64/megacmd-x86_64.pkg.tar.zst
    sudo pacman -U --noconfirm megacmd-x86_64.pkg.tar.zst
    rm -f megacmd-x86_64.pkg.tar.zst
    cd - > /dev/null
    echo "✓ Installed megacmd"
fi

# Install Zed Editor if not already installed
if pacman -Qi zed &>/dev/null; then
    echo "✓ zed is already installed"
else
    echo "Installing Zed Editor and dependencies..."
    sudo pacman -S --noconfirm zed vulkan-intel
    sudo ln -sf /usr/lib/zed/zed-editor /usr/bin/zed
    echo "✓ Installed zed"
fi

echo ""
echo "✓ All operations completed successfully!"
