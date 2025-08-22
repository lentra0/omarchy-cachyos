#!/bin/bash

# Install paru
sudo pacman -S --noconfirm --needed paru

# Install packages
paru -S --noconfirm --needed firefox yazi fzf bat eza feh \
  zsh zsh-autosuggestions zsh-history-substring-search zsh-syntax-highlighting

paru -S --noconfirm --needed zip 7zip tar gzip xz zstd bzip3 cpio arj xar

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

# Handle Firefox theme
while :; do
  printf "%b" "${BLD}${CYE}Do you want to use gh0stzk's Firefox theme? ${CNC}[y/N]: "
  read -r try_firefox
  case "$try_firefox" in
  [Yy])
    try_firefox="y"
    break
    ;;
  [Nn])
    try_firefox="n"
    break
    ;;
  *) printf " %b%bError:%b write 'y' or 'n'\n" "${BLD}" "${CRE}" "${CNC}" ;;
  esac
done

if [ "$try_firefox" = "y" ]; then
  firefox_profile=$(find "$HOME/.mozilla/firefox" -maxdepth 1 -type d -name '*.default-release' 2>/dev/null | head -n1)

  if [ -n "$firefox_profile" ]; then
    mkdir -p "$firefox_profile/chrome" 2>>"$ERROR_LOG"

    for item in "$HOME/.local/share/omarchy/default/firefox/"*; do
      if [ -e "$item" ]; then
        item_name=$(basename "$item")
        target="$firefox_profile"

        if [ "$item_name" = "chrome" ]; then
          for chrome_item in "$item"/*; do
            copy_files "$chrome_item" "$firefox_profile/chrome/"
          done
        else
          copy_files "$item" "$target/"
        fi
      fi
    done

    # Update settings
    user_js="$firefox_profile/user.js"
    startup_cfg="$HOME/.local/share/startup-page/config.js"

  else
    log_error "Firefox profile not found"
    printf "%s%sFirefox profile not found!%s\n" "$BLD" "$CRE" "$CNC"
  fi
fi

# Set GTK interface and icon theme to Yaru (sometimes fixes mismatches)

paru -S --noconfirm --needed yaru-icon-theme yaru-gtk-theme

gsettings set org.gnome.desktop.interface gtk-theme "Yaru-dark"
gsettings set org.gnome.desktop.interface icon-theme "Yaru-red" # Use whatever color you want
