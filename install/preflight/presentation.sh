#!/bin/bash

if paru -Q python-terminaltexteffects-git >/dev/null 2>&1; then
  paru -S --noconfirm --needed gum python-terminaltexteffects-git
fi
