#!/bin/bash

if [[ -d "$HOME/.local/share/fonts/SourceCodePro/" ]]; then
    echo "Fonts already installed, but refreshing them, just in case..." 
    rm -R $HOME/.local/share/fonts/SourceCodePro/
    echo "Spanish..."
    cp -R $HOME/Documentos/.debian/fonts/* $HOME/.local/share/fonts/
    echo "Fonts Installed succesfully."

else
    echo "Error: Fonts not installed... Installing right now..."
    if [[ -d "$HOME/.local/share/fonts/" ]]; then
        echo "Fonts directory already exists..." 
        cp -R $HOME/Documentos/.debian/fonts/* $HOME/.local/share/fonts/
        echo "Fonts Installed succesfully."
    else
        echo "Creating fonts directory.."
        mkdir -p $HOME/.local/share/fonts
        echo "Spanish..."
        cp -R $HOME/Documentos/.debian/fonts/* $HOME/.local/share/fonts/
        echo "Fonts Installed succesfully."
    fi
fi
