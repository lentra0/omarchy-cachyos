#!/bin/bash

# Install packages
paru -S --noconfirm --needed yazi fzf bat eza feh \
  zsh zsh-autosuggestions zsh-history-substring-search zsh-syntax-highlighting

paru -S --noconfirm --needed zip 7zip tar gzip xz zstd bzip3 cpio arj

sudo git clone https://GitHub.com/Aloxaf/fzf-tab /usr/share/zsh/plugins/fzf-tab-git

# Copy zshrc
cp ~/.local/share/omarchy/default/zsh/zshrc ~/.zshrc

# Make zsh default shell
change_default_shell() {
  zsh_path=$(command -v zsh)
  sleep 3

  if [ -z "$zsh_path" ]; then
    log_error "Zsh binary not found"
    printf "%b\n\n" "${BLD}${CRE}Zsh is not installed! Cannot change shell${CNC}"
    return 1
  fi

  if [ "$SHELL" != "$zsh_path" ]; then
    printf "%b\n" "${BLD}${CYE}Changing your shell to Zsh...${CNC}"

    if chsh -s "$zsh_path"; then
      printf "%b\n" "\n${BLD}${CGR}Shell changed successfully!${CNC}"
    else
      printf "%b\n\n" "\n${BLD}${CRE}Error changing shell!{CNC}"
    fi
  else
    printf "%b\n\n" "${BLD}${CGR}Zsh is already your default shell!${CNC}"
  fi

  sleep 3
}

change_default_shell

# Set GTK interface and icon theme to Yaru (sometimes fixes mismatches)

paru -S --noconfirm --needed yaru-icon-theme yaru-gtk-theme

gsettings set org.gnome.desktop.interface gtk-theme "Yaru-dark"
gsettings set org.gnome.desktop.interface icon-theme "Yaru"

# Remove iwd
if ! command -v iwctl &>/dev/null; then
  paru -R --noconfirm iwd
fi
