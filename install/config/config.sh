#!/bin/bash

# Copy over Omarchy configs
cp -R ~/.local/share/omarchy/config/* ~/.config/

# Use default bashrc from Omarchy
cp ~/.local/share/omarchy/default/bash/bashrc ~/.bashrc
cp ~/.local/share/omarchy/default/bash/inputrc ~/.inputrc

# Ensure application directory exists for update-desktop-database
mkdir -p ~/.local/share/applications

# Increase lockout limit to 10 and decrease timeout to 2 minutes
sudo sed -i 's|^\(auth\s\+required\s\+pam_faillock.so\)\s\+preauth.*$|\1 preauth silent deny=10 unlock_time=60|' "/etc/pam.d/system-auth"
sudo sed -i 's|^\(auth\s\+\[default=die\]\s\+pam_faillock.so\)\s\+authfail.*$|\1 authfail deny=10 unlock_time=60|' "/etc/pam.d/system-auth"

# Set Cloudflare as primary DNS (with Google as backup)
sudo cp ~/.local/share/omarchy/default/systemd/resolved.conf /etc/systemd/

# Solve common flakiness with SSH
#echo "net.ipv4.tcp_mtu_probing=1" | sudo tee -a /etc/sysctl.d/99-sysctl.conf

# Set common git aliases
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.st status
git config --global pull.rebase true
git config --global init.defaultBranch master

