# Omarchy for CachyOS

> I have decided to step away from the fork network of the original Omarchy project. This decision stems from the challenges of managing hundreds of upstream commits that either duplicate features I have already implemented or introduce changes that do not align with this fork's goals. Moving forward, **omarchy-cachyos** will be maintained independently, with updates and features curated based on what I believe is most valuable for a streamlined experience. This includes selectively merging only those upstream changes that are deemed essential.  

## Overview

This fork addresses several pain points encountered in the upstream Omarchy project on CachyOS while maintaining its elegant Hyprland workflow. Key improvements include better hardware support, reduced bloat, more sensible defaults for CachyOS users, and a suite of personal refinements for productivity and aesthetics.

## Differences from Upstream

### Core Improvements
- Changed shell to `zsh` with useful plugins preconfigured
- Set Firefox as default browser (`firefox-pure` package from CachyOS)
- Overhauled waybar for convenience and efficiency
- Set workspaces amount to 8 and added cycling (SUPER + ←/→)
- Consolidated all Hyprland configs to standard location (~/.config/hypr/)
- Added `nm-gui` as an applet to configure networks using NetworkManager
- Modified default keybinds to my personal preference
- Removed all Apple-specific workarounds and tweaks
- Removed unnecessary .desktop entries and XCompose
- Removed those awful webapps
- Made Docker setup optional
- Made CUPS printer support optional
- Made UFW config optional
- Removed Plymouth boot screen
- Added `postinstall` script with personalized tweaks

### Other Tweaks
- Added Intel + NVIDIA hybrid graphics setup option
- Excluded setup of NVIDIA envs
- Added limine support for initramfs generation
- Removed some guard checks
- Tweaked GPG setup process
- Improved Chaotic-AUR setup process
- Sourced `paru` from CachyOS repositories instead of `yay` from Chaotic-AUR
- Changed default prompt
- Increased default terminal text size
- Set default screen config for 1080p/1440p monitors
- Restored screensaver functionality out of the box
- Decreased unlock timeout from 120 to 60 seconds
- Added some extra windowrules
- Set default QT theme to MateriaDark
- Fixed some icons-related issues
- Added customized Yazi file manager
- Added suda.vim neovim plugin
- Changed default image viewer to `feh`
- Added `libva-utils` for VA-API management
- Added common development and build tools
- Replaced fastfetch config with minimalistic one
- Integrated gh0stzk's dotfiles

### Prerequisite
Before installing these dotfiles, you must first install CachyOS using the following configuration in Calamares:

1. Choose any bootloader (I recommend Limine)

2. Set your locales, timezone, and keyboard layout

3.  **Partitioning**
    *   Select **"Erase disk"** option
    *   Choose any filesystem you want
    *   **Tick** the **"Encrypt system"** checkbox

4. Choose **"No Desktop"** option

5.  **Additional Packages**
    *   **Untick** "cachyos shell configuration"
    *   **Untick** "firefox and language package"

6. Set your credentials

### Installation
After completing the CachyOS installation, reboot, decrypt your system when prompted, and proceed with Omarchy installation:

```bash
git clone https://github.com/lentra0/omarchy-cachyos.git ~/.local/share/omarchy

~/.local/share/omarchy/install.sh
```

### Final Touches
This repository includes an additional **`postinstall.sh`** script containing a set of my personal tweaks.
> **Inspect the contents** of this script before executing it to understand the changes it will make to your system.


**Note on Input Methods:** Use `fcitx5-configtool` to add keyboard layouts and change keybindings. This ensures the fcitx5 tray icon properly syncs and displays your current layout. Avoid modifying input methods directly through Hyprland configuration files.

## Contributing

While this is a personal fork, constructive issues and pull requests are welcome for:
- CachyOS-specific enhancements
- Hardware compatibility expansions
- Sensible feature additions

## Special Thanks

This project incorporates excellent scripts and dotfiles from [gh0stzk's bspwm dotfiles](https://github.com/gh0stzk/dotfiles). If you're interested in trying a bspwm setup, I highly recommend checking out his repository!

## Upstream

This project is a fork of the original [Omarchy](https://github.com/basecamp/omarchy) project. The foundational work done by DHH and the upstream developers is appreciated.

## License

Omarchy-cachyos is released under the [MIT License](https://opensource.org/licenses/MIT).pensource.org/licenses/MIT).
