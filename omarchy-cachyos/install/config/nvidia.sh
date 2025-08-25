#!/bin/bash

# ==============================================================================
# Hyprland NVIDIA Setup Script for Arch Linux
# ==============================================================================
# This script automates the installation and configuration of NVIDIA drivers
# for use with Hyprland on Arch Linux, following the official Hyprland wiki.
#
# Author: https://github.com/Kn0ax
#
# ==============================================================================

# --- GPU Detection ---
if [ -n "$(lspci | grep -i 'nvidia')" ]; then
  show_logo
  show_subtext "Install NVIDIA drivers..."

  # Configure modprobe for early KMS
  echo "options nvidia_drm modeset=1" | sudo tee /etc/modprobe.d/nvidia.conf >/dev/null

  # Configure mkinitcpio for early loading
  MKINITCPIO_CONF="/etc/mkinitcpio.conf"

  # Define modules
  NVIDIA_MODULES="nvidia nvidia_modeset nvidia_uvm nvidia_drm"

  # Try to detect Intel graphics
  if lspci | grep -qi "Intel.*UHD\|Intel.*HD Graphics"; then
    read -p "Do you have an Intel UHD + NVIDIA hybrid system? [Y/n]: " response
    case "${response,,}" in
    n | no)
      NVIDIA_MODULES="nvidia nvidia_modeset nvidia_uvm nvidia_drm"
      ;;
    *)
      NVIDIA_MODULES="i915 nvidia nvidia_modeset nvidia_uvm nvidia_drm"
      ;;
    esac
  else
    echo "No Intel graphics detected, using NVIDIA-only configuration. If u have amd + nvidia do it yourself."
    NVIDIA_MODULES="nvidia nvidia_modeset nvidia_uvm nvidia_drm"
  fi

  echo "Modules set to: $NVIDIA_MODULES"

  # Remove any old nvidia modules to prevent duplicates
  sudo sed -i -E 's/ i915//g; s/ nvidia_drm//g; s/ nvidia_uvm//g; s/ nvidia_modeset//g; s/ nvidia//g;' "$MKINITCPIO_CONF"
  # Add the new modules at the start of the MODULES array
  sudo sed -i -E "s/^(MODULES=\\()/\\1${NVIDIA_MODULES} /" "$MKINITCPIO_CONF"
  # Clean up potential double spaces
  sudo sed -i -E 's/  +/ /g' "$MKINITCPIO_CONF"

  # force package database refresh
  sudo pacman -Syy

  # Install some packages
  PACKAGES_TO_INSTALL=(
    "nvidia-utils"
    "lib32-nvidia-utils"
    "egl-wayland"
    "libva-nvidia-driver" # For VA-API hardware acceleration
    "libva-utils"
    "qt5-wayland"
    "qt6-wayland"
  )

  yay -S --needed --noconfirm "${PACKAGES_TO_INSTALL[@]}"

  # Ask about Limine
  read -p "Are you using the Limine bootloader? [y/N]: " limine_response
  case "${limine_response,,}" in
  y | yes)
    USE_LIMINE=true
    echo "Will use 'sudo limine-mkinitcpio'"
    ;;
  *)
    USE_LIMINE=false
    echo "Using standard 'sudo mkinitcpio -P'"
    ;;
  esac

  if [ "$USE_LIMINE" = true ]; then
    sudo limine-update
    sudo limine-mkinitcpio
  else
    sudo mkinitcpio -P
  fi

  # Add NVIDIA environment variables to hyprland.conf
  HYPRLAND_CONF="$HOME/.config/hypr/hyprland.conf"
  if [ -f "$HYPRLAND_CONF" ]; then
    cat >>"$HYPRLAND_CONF" <<'EOF'

# NVIDIA environment variables (not great for hybrid so commented out)
#env = NVD_BACKEND,direct
#env = LIBVA_DRIVER_NAME,nvidia
#env = __GLX_VENDOR_LIBRARY_NAME,nvidia
EOF
  fi
fi
