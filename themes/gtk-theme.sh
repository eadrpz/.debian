#!/bin/bash
#
#
# GTK Theme
gsettings set org.gnome.desktop.interface gtk-theme $1
# 
#
# Window Theme
gsettings set org.gnome.desktop.wm.preferences theme $1
