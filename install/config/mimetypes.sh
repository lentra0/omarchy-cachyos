#!/bin/bash

omarchy-refresh-applications
update-desktop-database ~/.local/share/applications

# Open all images with feh
xdg-mime default feh.desktop image/png
xdg-mime default feh.desktop image/jpeg
xdg-mime default feh.desktop image/gif
xdg-mime default feh.desktop image/webp
xdg-mime default feh.desktop image/bmp
xdg-mime default feh.desktop image/tiff

# Open PDFs with the Document Viewer
xdg-mime default org.gnome.Evince.desktop application/pdf

# Open video files with mpv
xdg-mime default mpv.desktop video/mp4
xdg-mime default mpv.desktop video/x-msvideo
xdg-mime default mpv.desktop video/x-matroska
xdg-mime default mpv.desktop video/x-flv
xdg-mime default mpv.desktop video/x-ms-wmv
xdg-mime default mpv.desktop video/mpeg
xdg-mime default mpv.desktop video/ogg
xdg-mime default mpv.desktop video/webm
xdg-mime default mpv.desktop video/quicktime
xdg-mime default mpv.desktop video/3gpp
xdg-mime default mpv.desktop video/3gpp2
xdg-mime default mpv.desktop video/x-ms-asf
xdg-mime default mpv.desktop video/x-ogm+ogg
xdg-mime default mpv.desktop video/x-theora+ogg
xdg-mime default mpv.desktop application/ogg

# Ensure .desktop files with proper exec and mimetype fields are in use
cp ~/.local/share/omarchy/applications/*.desktop ~/.local/share/applications
cp ~/.local/share/omarchy/applications/hidden/*.desktop ~/.local/share/applications

# Fix missing icons in walker
cp -r ~/.local/share/omarchy/applications/icons ~/.local/share/
#sudo rm $(locate pavucontrol.desktop)
