#!/bin/bash

if [ -d "$HOME/Documentos/" ]; then
    echo "Spanish..."

    cd $HOME/Documentos/.debian/
    git pull
    cd
    rm -r $HOME/Documentos/.debian/apps/*
    # 
    # Bash
    cp -f $HOME/.bashrc $HOME/Documentos/.debian/apps/
    # 
    # Alacritty
    cp -rf $HOME/.config/alacritty/ $HOME/Documentos/.debian/apps/
    #
    # Dunst
    cp -rf $HOME/.config/dunst/ $HOME/Documentos/.debian/apps/
    #
    # Rofi
    cp -rf $HOME/.config/rofi/ $HOME/Documentos/.debian/apps/
    #
    # Sway
    cp -rf $HOME/.config/sway/ $HOME/Documentos/.debian/apps/
    #
    # Waybar
    cp -rf $HOME/.config/waybar/ $HOME/Documentos/.debian/apps/
    #
    # Swaylock
    cp -rf $HOME/.config/swaylock $HOME/Documentos/.debian/apps/

    cd $HOME/Documentos/.debian/
    git add -A
    git commit -m "$1"
    git push

else 
    echo "No se encontró la carpeta del repositorio en #HOME/Documentos..."

fi
