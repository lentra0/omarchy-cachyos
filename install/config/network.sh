#!/bin/bash

# Install iwd explicitly
if ! command -v iwctl &>/dev/null; then
  paru -S --noconfirm --needed iwd
  sudo systemctl enable iwd
fi

# Prevent systemd-networkd-wait-online timeout on boot

sudo systemctl disable systemd-networkd-wait-online.service
sudo systemctl mask systemd-networkd-wait-online.service

# Block network manager from impairing iwd
sudo tee /etc/NetworkManager/conf.d/10-ignore-wifi.conf >/dev/null <<EOF
[keyfile]
unmanaged-devices=interface-name:wlan0
EOF

# DHCP is handled by dhcpcd
yay -S --noconfirm dhcpcd
sudo systemctl enable dhcpcd.service
