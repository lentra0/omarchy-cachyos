#!/bin/bash

# Prevent systemd-networkd-wait-online timeout on boot
sudo systemctl disable systemd-networkd-wait-online.service
sudo systemctl mask systemd-networkd-wait-online.service

# Install impala
paru -S --noconfirm --needed impala

# Install iwd explicitly
if ! command -v iwctl &>/dev/null; then
  paru -S --noconfirm --needed iwd
  sudo systemctl enable iwd
fi

# iwd now handles DHCP
sudo mkdir /etc/iwd
sudo tee /etc/iwd/main.conf >/dev/null <<EOF
[General]
EnableNetworkConfiguration=true
EOF

# Block network manager from impairing iwd
sudo tee /etc/NetworkManager/conf.d/10-ignore-wifi.conf >/dev/null <<EOF
[keyfile]
unmanaged-devices=interface-name:wlan0
EOF
