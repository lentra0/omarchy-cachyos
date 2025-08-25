#!/bin/bash

if yay -Q python-terminaltexteffects >/dev/null 2>&1; then
    yay -S --noconfirm --needed gum python-terminaltexteffects
fi
