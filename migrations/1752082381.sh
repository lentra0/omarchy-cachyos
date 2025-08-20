echo "Adding gnome-keyring because it's aight"

if ! command -v gnome-keyring &>/dev/null; then
  yay -S --noconfirm --needed gnome-keyring
fi
