#!/bin/bash

# Install iwd explicitly
if ! command -v iwctl &>/dev/null; then
  yay -S --noconfirm --needed iwd
  sudo systemctl enable --now iwd.service
fi

# Remove networkmanager daemon
sudo systemctl disable networkmanager.service
