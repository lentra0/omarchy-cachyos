#!/bin/bash

# Ask about firewall
read -p "Do you want to enable firewall? [y/N]: " firewall_response
case "${firewall_response,,}" in
    y|yes)
        echo "Firewall will be enabled."

        if ! command -v ufw &>/dev/null; then
          yay -S --noconfirm --needed ufw ufw-docker

          # Allow nothing in, everything out
          sudo ufw default deny incoming
          sudo ufw default allow outgoing

          # Allow ports for LocalSend
          sudo ufw allow 53317/udp
          sudo ufw allow 53317/tcp

          # Allow SSH in
          sudo ufw allow 22/tcp

          # Allow Docker containers to use DNS on host
          sudo ufw allow in on docker0 to any port 53

          # Turn on the firewall
          sudo ufw enable
        fi

        ;;
    *)
        echo "Skipping firewall setup."
        ;;
esac
