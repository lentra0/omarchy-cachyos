# Omarchy for CachyOS

A streamlined fork of the DHH's Omarchy project, specifically optimized for CachyOS with crucial improvements and fixes for CachyOS compatibility.

## Overview

This fork addresses several pain points encountered in the upstream Omarchy project on CachyOS while maintaining its elegant Hyprland workflow. Key improvements include better hardware support, reduced bloat, more sensible defaults for CachyOS users and some of my personal preferences.

## Differences from Upstream

### Core Improvements
- **Distro Compatibility**: Removed Arch Linux checks
- **Package Management**: 
  - Replaced yay with paru as default AUR helper
  - Source yay from CachyOS repositories instead of Chaotic-AUR
  - Improved Chaotic-AUR database setup process
- **Hardware Support**:
  - Added Intel + NVIDIA hybrid graphics setup option
  - Added ec_sys module for MSI laptop fan control
  - Added limine support for initramfs generation
- **Service Management**: 
  - Disabled NetworkManager in favor of iwd for wireless management
  - Configured iwd to handle DHCP client functionality directly

### User Experience Enhancements
- **Default Applications**: Replaced Chromium with Firefox as default browser
- **File Management**: Added yazi - an awesome modern terminal file manager
- **Bluetooth**: Replaced blueberry with bluetui for better aesthetics
- **Input Methods**: Added fcitx-configtool for improved input method change support
- **Security**: Decreased unlock timeout from 120 to 60 seconds
- **Shell Environment**: Changed default shell to zsh with custom configurations

### Configuration Improvements
- **Unified Structure**: Consolidated all Hyprland configs to standard `~/.config/hypr/` location
- **Screensaver Workaround**: Proper screensaver functionality out of the box
- **Display Settings**: Updated default screen configuration to FullHD/QuadHD values
- **NVIDIA Flexibility**: Commented out NVIDIA environment variables for optional use
- **GP Configuration**: Updated GPG setup process

### Bloat Reduction & Optional Components
- **Removed Unnecessary Packages**: 
  - Removed all Apple-specific workarounds
  - Removed Plymouth boot screen
  - Removed abysmal webapps and unnecessary packages like Zoom
  - Removed unnecessary .desktop entries
  - Eliminated XCompose <CAPS> shortcut that inserted GitHub username/email
- **Optional Services**:
  - Made UFW firewall settings optional during installation
  - Made CUPS printer support optional
  - Removed Docker from installation (most users don't need it) 

### Development Environment
- **Build Tools**: Added more common development and build tools to default installation
- **Extended customzations**: Added gh0stzk's awesome dotfiles for zsh, Firefox, and yazi

## Installation

**Prerequisite:** Before installing these dotfiles, you must first install CachyOS using the following configuration in Calamares:

1. Choose your locales, timezone, and keyboard layout

2.  **Partitioning**
    *   Select **"Erase disk"** option
    *   Choose any filesystem you want
    *   **Tick the 'Encrypt system' checkbox**

3. Choose **"No Desktop"** option

4.  **Additional Packages**
    *   **Untick** 'cachyos shell configuration'
    *   **Untick** 'firefox and language package'

5. Set your credentials

### Post-Installation
After completing the CachyOS installation, reboot, decrypt your system when prompted, and proceed with Omarchy installation:

```bash
git clone https://github.com/lentra0/omarchy-cachyos.git ~/.local/share/omarchy
chmod +x ~/.local/share/omarchy/install.sh
~/.local/share/omarchy/install.sh
```

## Contributing

While this is a personal fork, constructive issues and pull requests are welcome for:
- CachyOS-specific enhancements
- Hardware compatibility expansions
- Sensible feature additions that aren't accepted upstream

## Special Thanks

This project incorporates excellent scripts and dotfiles from [gh0stzk's bspwm dotfiles](https://github.com/gh0stzk/dotfiles). If you're interested in trying a bspwm setup, I highly recommend checking out his repository - I consider it to be one of the best bspwm configs available!

## Upstream

This project is a fork of the original [Omarchy](https://github.com/basecamp/omarchy) project. I acknowledge and appreciate the foundational work done by DHH and the upstream developers while creating a version better suited for CachyOS users.

## License

Omarchy-cachyos is released under the [MIT License](https://opensource.org/licenses/MIT).

