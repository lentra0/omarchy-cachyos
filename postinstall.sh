#!bin/bash

echo "Do not run again if fails because I did not add any checks"
sleep 5

# Set default QT theme to MateriaDark
yay -S --noconfirm kvantum-theme-materia
kvantummanager --set MateriaDark

# Bind CAPS to F13 (configure input keybind in fcitx5-configtool afterwards)
paru -S --noconfirm xremap-hypr-bin
cp -r ~/.local/share/omarchy/default/xremap ~/.config

# To use without sudo
echo uinput | sudo tee /etc/modules-load.d/uinput.conf
echo 'KERNEL=="uinput", GROUP="input", TAG+="uaccess"' | sudo tee /etc/udev/rules.d/99-input.rules
echo 'KERNEL=="event*", GROUP="input", TAG+="uaccess"' | sudo tee /etc/udev/rules.d/99-event.rules

# Add to autostart
echo "exec-once = xremap ~/.config/xremap/config.yml" >>~/.config/hypr/autostart.conf

# Install additional packages
paru -S gnome-disk-utility ntfs-3g celluloid \
  telegram-desktop-bin qbittorrent-enhanced \
  portproton gamemode gamescope vkbasalt

# Make ZFS snapshots visible if used
if command -v zfs >/dev/null 2>&1; then
  sudo zfs set snapdir=visible zpcachyos
fi

echo "Done"
sleep 5
reboot
