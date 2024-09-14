#!/bin/bash

    echo "Spanish Debian Babe..."

    cd $HOME/Documentos/.debian/
    git pull
    cd
    mkdir -p $HOME/.config

    cp -rf $HOME/Documentos/.debian/apps/* $HOME/.config/
    cp -f $HOME/Documentos/.debian/apps/.bashrc $HOME/

    read -p "RESOLUTION (1080 or 768): " res
    sh $HOME/Documentos/.debian/scripts/resolution $res

else 
    echo "No english or spanish detected..."

fi
