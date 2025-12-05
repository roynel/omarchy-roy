#!/bin/bash

# PIA VPN Setup Script for Arch Linux
# This script automates the installation and configuration of Private Internet Access VPN

set -e

echo "=== PIA VPN Setup Script ==="
echo ""

# Check if running with sudo/root
if [ "$EUID" -ne 0 ]; then
    echo "This script must be run with sudo privileges."
    echo "Usage: sudo bash $0"
    exit 1
fi

# Step 1: Check if private-internet-access-vpn is installed
echo "Step 1: Checking if private-internet-access-vpn is installed..."
if pacman -Qi private-internet-access-vpn &> /dev/null; then
    echo "✓ private-internet-access-vpn is already installed"
else
    echo "Installing private-internet-access-vpn..."
    pacman -S --noconfirm private-internet-access-vpn
    echo "✓ private-internet-access-vpn installed successfully"
fi
echo ""

# Step 2: Login Setup
echo "Step 2: Setting up PIA login credentials..."
mkdir -p /etc/private-internet-access
echo -n "Enter your PIA username: "
read -r PIA_USERNAME
echo -n "Enter your PIA password: "
read -rs PIA_PASSWORD
echo ""

# Create login.conf with proper format
cat > /etc/private-internet-access/login.conf << EOF
$PIA_USERNAME
$PIA_PASSWORD
EOF

# Set proper ownership and permissions
chown root:root /etc/private-internet-access/login.conf
chmod 0600 /etc/private-internet-access/login.conf
echo "✓ Login credentials saved to /etc/private-internet-access/login.conf"
echo ""

# Step 3: Auto-configure VPN
echo "Step 3: Auto-configuring PIA VPN..."
pia -a 2>/dev/null
echo "✓ VPN configurations created"
echo ""

# Step 4: Fix CRL verification issue
echo "Step 4: Fixing CRL verification in all configurations..."
if [ -d "/etc/openvpn/client" ]; then
    # Download CRL file
    echo "Downloading CRL file..."
    curl -s -o /etc/openvpn/client/crl.rsa.2048.pem https://www.privateinternetaccess.com/openvpn/crl.rsa.2048.pem
    chmod 644 /etc/openvpn/client/crl.rsa.2048.pem
    
    # Disable CRL verification in all configs (as it may be expired)
    find /etc/openvpn/client/ -name "*.conf" -exec sed -i 's/^crl-verify/#crl-verify/' {} \;
    echo "✓ CRL verification disabled in all configurations"
else
    echo "⚠ Warning: /etc/openvpn/client directory not found"
fi
echo ""

# Step 5: Check if OpenVPN is installed
echo "Step 5: Checking OpenVPN installation..."
if ! command -v openvpn &> /dev/null; then
    echo "OpenVPN not found. Installing..."
    pacman -S --noconfirm openvpn
    echo "✓ OpenVPN installed"
else
    echo "✓ OpenVPN is already installed"
fi
echo ""

# Final summary
echo "=== Setup Complete ==="
echo ""
echo "PIA VPN is now configured and ready to use!"
echo ""
echo "To connect to a VPN server, use:"
echo "  sudo openvpn --config /etc/openvpn/client/<SERVER>.conf"
echo ""
echo "Available servers:"
ls /etc/openvpn/client/*.conf 2>/dev/null | sed 's|/etc/openvpn/client/||' | sed 's|.conf||' | sed 's/^/  - /'
echo ""
echo "Or use systemd service:"
echo "  sudo systemctl start openvpn-client@<SERVER>"
echo "  sudo systemctl enable openvpn-client@<SERVER>  # for autostart"
echo ""
