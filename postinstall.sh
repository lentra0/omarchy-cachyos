#!bin/bash

echo "Do not run again if fails because I did not add any checks"
sleep 5

# Disable Network Manager
sudo systemctl disable NetworkManager --now
sudo systemctl enable iwd

# Bind CAPS to F13 (configure input keybind in fcitx5-configtool afterwards)
paru -S --noconfirm xremap-hypr-bin

cp -r ~/.local/share/omarchy/default/xremap ~/.config

# To use without sudo
echo uinput | sudo tee /etc/modules-load.d/uinput.conf
echo 'KERNEL=="uinput", GROUP="input", TAG+="uaccess"' | sudo tee /etc/udev/rules.d/99-input.rules
echo 'KERNEL=="event*", GROUP="input", TAG+="uaccess"' | sudo tee /etc/udev/rules.d/99-event.rules

# Add to autostart
echo "exec-once = xremap ~/.config/xremap/config.yml" >>~/.config/hypr/autostart.conf

echo "Done"
sleep 5
reboot
