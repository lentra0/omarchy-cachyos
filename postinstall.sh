#!bin/bash

# Disable Network Manager
sudo systemctl disable NetworkManager --now

# Bind CAPS to F13 (configure input keybind in fcitx5-configtool afterwards)
paru -S --noconfirm xremap-hypr-bin

cp ~/.local/share/omarchy/xremap ~/.config

# To use without sudo
echo 'KERNEL=="uinput", GROUP="input", TAG+="uaccess"' | sudo tee /etc/udev/rules.d/99-input.rules

# Add to autostart
echo "exec-once = xremap ~/.config/xremap/config.yml" >>~/.config/hypr/autostart.conf

echo "Done"
sleep 5
reboot
