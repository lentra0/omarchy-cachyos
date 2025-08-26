#!/bin/bash

# Install bluetooth controls
paru -S --noconfirm --needed blueberry

# Turn on bluetooth by default
sudo systemctl enable --now bluetooth.service
sudo rfkill unblock bluetooth
