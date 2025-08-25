#!/bin/bash

yay -S --noconfirm --needed ttf-font-awesome ttf-cascadia-mono-nerd ttf-ia-writer noto-fonts noto-fonts-emoji

if [ -z "$OMARCHY_BARE" ]; then
  yay -S --noconfirm --needed ttf-jetbrains-mono noto-fonts-cjk noto-fonts-extra
fi

# Omarchy logo in a font for Waybar use
mkdir -p ~/.local/share/fonts
cp ~/.local/share/omarchy/default/omarchy.ttf ~/.local/share/fonts/
fc-cache
