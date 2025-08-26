#!/bin/bash

# Install nm gui
paru -S --noconfirm --needed nmgui-bin

# Prevent systemd-networkd-wait-online timeout on boot
sudo systemctl disable systemd-networkd-wait-online.service
sudo systemctl mask systemd-networkd-wait-online.service
