#!/bin/bash

# Install bluetooth controls
yay -S --noconfirm --needed bluetui

# Turn on bluetooth by default
sudo systemctl enable --now bluetooth.service
sudo rfkill unblock bluetooth 
