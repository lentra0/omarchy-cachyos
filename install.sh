#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -eE

export PATH="$HOME/.local/share/omarchy/bin:$PATH"
OMARCHY_INSTALL=~/.local/share/omarchy/install

# Preparation
source $OMARCHY_INSTALL/preflight/show-env.sh
source $OMARCHY_INSTALL/preflight/trap-errors.sh
source $OMARCHY_INSTALL/preflight/guard.sh
source $OMARCHY_INSTALL/preflight/chroot.sh
source $OMARCHY_INSTALL/preflight/repositories.sh
source $OMARCHY_INSTALL/preflight/migrations.sh
source $OMARCHY_INSTALL/preflight/first-run-mode.sh

# Packaging
source $OMARCHY_INSTALL/packages.sh
source $OMARCHY_INSTALL/packaging/asdcontrol.sh
source $OMARCHY_INSTALL/packaging/fonts.sh
source $OMARCHY_INSTALL/packaging/lazyvim.sh
source $OMARCHY_INSTALL/packaging/webapps.sh
source $OMARCHY_INSTALL/packaging/tuis.sh

# Configuration
show_logo beams 240
show_subtext "Let's install Omarchy! [1/5]"
#source $OMARCHY_INSTALL/config/identification.sh
source $OMARCHY_INSTALL/config/config.sh
source $OMARCHY_INSTALL/config/detect-keyboard-layout.sh
source $OMARCHY_INSTALL/config/network.sh
source $OMARCHY_INSTALL/config/power.sh
source $OMARCHY_INSTALL/config/timezones.sh
source $OMARCHY_INSTALL/config/increase-sudo-tries.sh
source $OMARCHY_INSTALL/config/increase-lockout-limit.sh
source $OMARCHY_INSTALL/config/ssh-flakiness.sh
source $OMARCHY_INSTALL/config/detect-keyboard-layout.sh
source $OMARCHY_INSTALL/config/xcompose.sh
source $OMARCHY_INSTALL/config/mise-ruby.sh
source $OMARCHY_INSTALL/config/docker.sh
source $OMARCHY_INSTALL/config/mimetypes.sh
source $OMARCHY_INSTALL/config/hardware/network.sh
source $OMARCHY_INSTALL/config/hardware/fix-fkeys.sh
source $OMARCHY_INSTALL/config/hardware/bluetooth.sh
source $OMARCHY_INSTALL/config/hardware/printer.sh
source $OMARCHY_INSTALL/config/hardware/usb-autosuspend.sh
source $OMARCHY_INSTALL/config/hardware/ignore-power-button.sh
source $OMARCHY_INSTALL/config/hardware/nvidia.sh

# Development
show_logo decrypt 920
show_subtext "Installing terminal tools [2/5]"
source $OMARCHY_INSTALL/development/terminal.sh
source $OMARCHY_INSTALL/development/development.sh
source $OMARCHY_INSTALL/development/nvim.sh
source $OMARCHY_INSTALL/development/ruby.sh
source $OMARCHY_INSTALL/development/docker.sh
source $OMARCHY_INSTALL/development/firewall.sh

# Desktop
show_logo slice 60
show_subtext "Installing desktop tools [3/5]"
source $OMARCHY_INSTALL/desktop/desktop.sh
source $OMARCHY_INSTALL/desktop/hyprlandia.sh
source $OMARCHY_INSTALL/desktop/theme.sh
source $OMARCHY_INSTALL/desktop/bluetooth.sh
source $OMARCHY_INSTALL/desktop/fonts.sh
source $OMARCHY_INSTALL/desktop/printer.sh

# Apps
show_logo expand
show_subtext "Installing default applications [4/5]"
source $OMARCHY_INSTALL/apps/mimetypes.sh

# Updates
sudo updatedb
yay -Syu --noconfirm

# Extra
show_logo expand
show_subtext "Installing extra configs [6/5]"
source $OMARCHY_INSTALL/extra/gh0stzk.sh
#source $OMARCHY_INSTALL/extra/mechabar.sh # optional

# Finish
show_logo laseretch 920

# Just to be sure nothing breaks
#if [ "$USE_LIMINE" = true ]; then
#  sudo limine-update
#  sudo limine-mkinitcpio
#else
#  sudo mkinitcpio -P
#fi

show_subtext "You're done!"
sleep 2
reboot
