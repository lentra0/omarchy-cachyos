#!/bin/bash

if [ -z "$OMARCHY_BARE" ]; then
  yay -S --noconfirm --needed \
    gnome-keyring signal-desktop \
    obsidian-bin kdenlive \
    xournalpp localsend-bin
fi

yay -S portproton yazi caffeine-ng antimicrox gparted firefox qbittorrent-enhanced

  # Packages known to be flaky or having key signing issues are run one-by-one
  for pkg in pinta typora zoom; do
    yay -S --noconfirm --needed "$pkg" ||
      echo -e "\e[31mFailed to install $pkg. Continuing without!\e[0m"
  done

  yay -S --noconfirm --needed 1password-beta 1password-cli ||
    echo -e "\e[31mFailed to install 1password. Continuing without!\e[0m"
fi

# Copy over Omarchy applications
source omarchy-refresh-applications || true
