#!/bin/bash

# Install GUI for NM
paru -S --noconfirm --needed nm-connection-editor

# Prevent systemd-networkd-wait-online timeout on boot
sudo systemctl disable systemd-networkd-wait-online.service
sudo systemctl mask systemd-networkd-wait-online.service
