#!/bin/bash

read -p "Do you want to install mechabar (cool waybar rice)? (y/N): " answer

case $answer in
y | Y | yes | Yes | YES)

  echo "Installing mechabar..."

  # Downgrade waybar to 0.13.0-3
  sudo pacman -U --noconfirm https://archive.archlinux.org/packages/w/waybar/waybar-0.13.0-3-x86_64.pkg.tar.zst

  # Install deps
  paru -S --noconfirm --needed fzf wireplumber brightnessctl bluez-utils networkmanager ttf-0xproto-nerd

  # Copy config files
  cp -r ~/.local/share/omarchy/default/mechabar/* ~/.config/waybar

  # Reset Network Manager wifi scanning ability
  CONF_FILE="/etc/NetworkManager/conf.d/10-ignore-wifi.conf"

  if [ -f "$CONF_FILE" ]; then
    sudo rm -f "$CONF_FILE"
    echo "$CONF_FILE deleted."
  else
    echo "$CONF_FILE does not exist."
  fi

  # Set up scripts
  echo -e "\n${blue}Setting up scripts...${reset}"
  chmod +x ~/.config/waybar/scripts/*.sh

  # Get username
  if [ -n "$SUDO_USER" ]; then
    USERNAME="$SUDO_USER"
  else
    USERNAME=$(whoami)
  fi

  # Check if user exists
  if ! id "$USERNAME" &>/dev/null; then
    echo "User'$USERNAME' does not exist!"
    exit 1
  fi

  # Create udev rule
  echo "Creating udev rule for: $USERNAME"
  cat <<EOF | sudo tee /etc/udev/rules.d/60-power.rules >/dev/null
ACTION=="change", SUBSYSTEM=="power_supply", ATTR{type}=="Mains", ATTR{online}=="1", RUN+="/usr/bin/su $USERNAME --command '~/.config/waybar/scripts/battery-state.sh charging'"
ACTION=="change", SUBSYSTEM=="power_supply", ATTR{type}=="Mains", ATTR{online}=="0", RUN+="/usr/bin/su $USERNAME --command '~/.config/waybar/scripts/battery-state.sh discharging'"
EOF

  # Apply udev rule
  sudo udevadm control --reload-rules
  sudo udevadm trigger --subsystem-match=power_supply
  echo "Rule created in /etc/udev/rules.d/60-power.rules"

  echo "Mechabar was set successfully."
  sleep 4
  ;;
*)
  echo "Skipping mechabar installation..."
  ;;
esac

# Downgrade waybar to 0.13.0-3
sudo pacman -U --noconfirm https://archive.archlinux.org/packages/w/waybar/waybar-0.13.0-3-x86_64.pkg.tar.zst

# Install deps
paru -S --noconfirm --needed fzf wireplumber brightnessctl bluez-utils networkmanager ttf-0xproto-nerd

# Copy config files
cp -r ~/.local/share/omarchy/default/mechabar/* ~/.config/waybar

# Reset Network Manager wifi scanning ability
CONF_FILE="/etc/NetworkManager/conf.d/10-ignore-wifi.conf"

if [ -f "$CONF_FILE" ]; then
  sudo rm -f "$CONF_FILE"
  echo "$CONF_FILE deleted."
else
  echo "$CONF_FILE does not exist."
fi

# Set up scripts
echo -e "\n${blue}Setting up scripts...${reset}"
chmod +x ~/.config/waybar/scripts/*.sh

# Get username
if [ -n "$SUDO_USER" ]; then
  USERNAME="$SUDO_USER"
else
  USERNAME=$(whoami)
fi

# Check if user exists
if ! id "$USERNAME" &>/dev/null; then
  echo "User'$USERNAME' does not exist!"
  exit 1
fi

# Create udev rule
echo "Creating udev rule for: $USERNAME"
cat <<EOF | sudo tee /etc/udev/rules.d/60-power.rules >/dev/null
ACTION=="change", SUBSYSTEM=="power_supply", ATTR{type}=="Mains", ATTR{online}=="1", RUN+="/usr/bin/su $USERNAME --command '~/.config/waybar/scripts/battery-state.sh charging'"
ACTION=="change", SUBSYSTEM=="power_supply", ATTR{type}=="Mains", ATTR{online}=="0", RUN+="/usr/bin/su $USERNAME --command '~/.config/waybar/scripts/battery-state.sh discharging'"
EOF

# Apply udev rule
sudo udevadm control --reload-rules
sudo udevadm trigger --subsystem-match=power_supply
echo "Rule created in /etc/udev/rules.d/60-power.rules"

echo "Mechabar was set successfully."
sleep 2
