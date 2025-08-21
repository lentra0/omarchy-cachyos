#!/bin/bash

# Install iwd explicitly
if ! command -v iwctl &>/dev/null; then
  yay -S --noconfirm --needed iwd
  sudo systemctl enable iwd
fi

# Prevent systemd-networkd-wait-online timeout on boot

sudo systemctl disable systemd-networkd-wait-online.service

sudo systemctl mask systemd-networkd-wait-online.service
