#!/bin/bash

# Replace yay with paru
sudo pacman -R --noconfirm yay
sudo pacman -S --noconfirm --needed paru

# Install deps
paru -S --noconfirm --needed yazi fzf bat eza feh \
zsh zsh-autosuggestions zsh-history-substring-search zsh-syntax-highlighting

