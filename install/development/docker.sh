#!/bin/bash

# Ask about Docker
read -p "Do you want to install Docker? [y/N]: " docker_response
case "${docker_response,,}" in
y | yes)
  echo "Docker will be installed."

  paru -S --noconfirm --needed docker docker-compose docker-buildx

  # Limit log size to avoid running out of disk
  sudo mkdir -p /etc/docker
  echo '{"log-driver":"json-file","log-opts":{"max-size":"10m","max-file":"5"}}' | sudo tee /etc/docker/daemon.json

  # Start Docker automatically
  sudo systemctl enable docker

  # Give this user privileged Docker access
  sudo usermod -aG docker ${USER}

  # Prevent Docker from preventing boot for network-online.target
  sudo mkdir -p /etc/systemd/system/docker.service.d
  sudo tee /etc/systemd/system/docker.service.d/no-block-boot.conf <<'EOF'
[Unit]
DefaultDependencies=no
EOF

  sudo systemctl daemon-reload

  ;;
*)
  echo "Skipping Docker installation."
  ;;
esac
