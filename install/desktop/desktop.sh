#!/bin/bash

# Ensure Vulkan packages are present
paru -S --noconfirm --needed vulkan-headers vulkan-icd-loader vulkan-validation-layers

paru -S --noconfirm --needed \
  brightnessctl playerctl pamixer wiremix wireplumber \
  fcitx5 fcitx5-gtk fcitx5-qt fcitx5-configtool wl-clip-persist \
  nautilus sushi ffmpegthumbnailer gvfs-mtp \
  slurp satty \
  mpv evince imv \
  libva-utils feh qt5-tools localsend

# Add screen recorder based on GPU
if lspci | grep -qi 'nvidia'; then
  paru -S --noconfirm --needed wf-recorder
else
  paru -S --noconfirm --needed wl-screenrec
fi
