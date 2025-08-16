#!/bin/bash

# Setting the performance profile can make a big difference. By default, most systems seem to start in balanced mode,
# even if they're not running off a battery. So let's make sure that's changed to performance.
#yay -S --noconfirm power-profiles-daemon



#if ls /sys/class/power_supply/BAT* &>/dev/null; then
#  # This computer runs on a battery
#  powerprofilesctl set balanced || true
#
#  # Enable battery monitoring timer for low battery notifications
#  systemctl --user enable --now omarchy-battery-monitor.timer || true
#else
#  # This computer runs on power outlet
#  powerprofilesctl set performance || true
#fi

# Установка auto-cpufreq
mkdir -p ~/github
git clone https://github.com/AdnanHodzic/auto-cpufreq.git ~/github/auto-cpufreq
sudo ~/github/auto-cpufreq/auto-cpufreq-installer
echo "auto-cpufreq installed"

# Установка MControlCenter
wget https://github.com/dmitry-s93/MControlCenter/releases/download/0.4.1/MControlCenter-0.4.1-bin.tar.gz -P ~/github/
tar -xzf ~/github/MControlCenter-0.4.1-bin.tar.gz -C ~/github/
cd ~/github/MControlCenter-0.4.1-bin
sudo ./install.sh
echo "MControlCenter installed"
