#!/bin/bash

if yay -Q python-terminaltexteffects-git >/dev/null 2>&1; then
    yay -S --noconfirm --needed gum python-terminaltexteffects-git
fi
