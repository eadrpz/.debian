Install some basic packages.
```sh
sudo apt install sway xwayland waybar rofi alacritty firefox-esr wl-clipboard 
nemo nemo-fileroller pipewire pipewire-jack pipewire-audio
pavucontrol blueman gvfs gvfs-backends gvfs-fuse libsmbclient fish
ffmpegthumbnailer tumbler xdg-desktop-portal-gtk policykit-1-gnome
materia-gtk-theme materia-kde papirus-icon-theme qt5-style-kvantum
network-manager-gnome btop neofetch mpv swayimg gnome-keyring grim
slurp ranger exa bat inxi vainfo alsa-tools alsa-utils lxappearance
brightnessctl x11-xserver-utils udisks2 swaylock swayidle imv
fonts-noto-color-emoji fonts-open-sans gammastep libglib2.0-bin dunst
```

Enable some services.
```sh
systemctl enable --user wireplumber
systemctl enable --user pipewire
sudo systemctl enable bluetooth
```

Run some basic commands.
```sh
# This replaces dmenu with rofi, useful for some scripts.
sudo rm -r /usr/bin/dmenu
sudo ln -s /usr/bin/rofi /usr/bin/dmenu

gsettings set org.gnome.desktop.default-applications.terminal exec alacritty
gsettings set org.cinnamon.desktop.default-applications.terminal exec alacritty

xdg-mime default imv.desktop image/jpeg
xdg-mime default imv.desktop image/jpg
xdg-mime default imv.desktop image/png

xdg-mime default nemo.desktop inode/directory
```

- Change a config setting to enable power menu
```sh
sudo nano /etc/systemd/logind.conf
# Add this line
HandlePowerKey=ignore
# Run this command
sudo systemctl kill -s HUP systemd-logind
```

Run some basic scripts from scripts/ folder
```sh
./fonts.sh
./config.sh
```

Add some variables to /etc/environment file.
```sh
QT_STYLE_OVERRIDE=kvantum
MOZ_ENABLE_WAYLAND=1
```

Reboot
