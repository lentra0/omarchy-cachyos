#!/bin/bash

# Colors
CRE=$(tput setaf 1)    # Red
CYE=$(tput setaf 3)    # Yellow
CGR=$(tput setaf 2)    # Green
CBL=$(tput setaf 4)    # Blue
BLD=$(tput bold)       # Bold
CNC=$(tput sgr0)       # Reset colors

# Global vars
ERROR_LOG="$HOME/omarchy-errors.log"

# Handle errors
log_error() {
    error_msg=$1
    timestamp=$(date +"%Y-%m-%d %H:%M:%S")

    printf "%s" "[${timestamp}] ERROR: ${error_msg}\n" >> "$ERROR_LOG"
    printf "%s%sERROR:%s %s\n" "${CRE}" "${BLD}" "${CNC}" "${error_msg}" >&2
}

add_chaotic_repo() {
    repo_name="chaotic-aur"
    key_id="3056513887B78AEB"
    sleep 2

    printf "%b\n" "${BLD}${CYE}Installing ${CBL}${repo_name}${CYE} repository...${CNC}"

    if grep -q "\[${repo_name}\]" /etc/pacman.conf; then
        printf "%b\n" "\n${BLD}${CYE}Repository already exists in pacman.conf${CNC}"
        sleep 3
        return 0
    fi

    if ! pacman-key -l | grep -q "$key_id"; then
        printf "%b\n" "${BLD}${CYE}Adding GPG key...${CNC}"
        if ! sudo pacman-key --recv-key "$key_id" --keyserver keyserver.ubuntu.com 2>&1 | tee -a "$ERROR_LOG" >/dev/null; then
            log_error "Failed to receive GPG key"
            return 1
        fi

        printf "%b\n" "${BLD}${CYE}Signing key locally...${CNC}"
        if ! sudo pacman-key --lsign-key "$key_id" 2>&1 | tee -a "$ERROR_LOG" >/dev/null; then
            log_error "Failed to sign GPG key"
            return 1
        fi
    else
        printf "\n%b\n" "${BLD}${CYE}GPG key already exists in keyring${CNC}"
    fi

    chaotic_pkgs="chaotic-keyring chaotic-mirrorlist"
    for pkg in $chaotic_pkgs; do
        if ! pacman -Qq "$pkg" >/dev/null 2>&1; then
            printf "%b\n" "${BLD}${CYE}Installing ${CBL}${pkg}${CNC}"
            if ! sudo pacman -U --noconfirm "https://cdn-mirror.chaotic.cx/chaotic-aur/${pkg}.pkg.tar.zst" 2>&1 | tee -a "$ERROR_LOG" >/dev/null; then
                log_error "Failed to install ${pkg}"
                return 1
            fi
        else
            printf "%b\n" "${BLD}${CYE}${pkg} is already installed${CNC}"
        fi
    done

    printf "\n%b\n" "${BLD}${CYE}Adding repository to pacman.conf...${CNC}"
    if ! printf "\n[%s]\nInclude = /etc/pacman.d/chaotic-mirrorlist\n" "$repo_name" \
       | sudo tee -a /etc/pacman.conf >/dev/null 2>> "$ERROR_LOG"; then
        log_error "Failed to add repository configuration"
        return 1
    fi

    printf "%b\n" "\n${BLD}${CBL}${repo_name} ${CGR}Repository configured successfully!${CNC}"
    sleep 3
}

# Update mirrors
sudo pacman -Sy --noconfirm --needed cachyos-rate-mirrors rate-mirrors
sudo cachyos-rate-mirrors

# Install yay and chaotic-aur repo
sudo pacman -S yay
add_chaotic_repo
sudo pacman -Sy

# Add fun and color to the pacman installer
if ! grep -q "ILoveCandy" /etc/pacman.conf; then
  sudo sed -i '/^\[options\]/a Color\nILoveCandy' /etc/pacman.conf
fi
