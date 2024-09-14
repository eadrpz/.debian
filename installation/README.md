Ok, let's go, first of all, install Debian, just selecting Standard Minimal

> [!NOTE]
> There's a script in scripts/ folder than can automate almost all this process, 
> just install git and run ./first.install

Log in as root
If you don't have ethernet, let's connect to a network...
```sh
systemctl enable wpa_supplicant
systemctl start wpa_supplicant
```

Then, run
```sh
wpa_cli
```

For adding a home network
```sh
add_network
> 0
set_network 0 ssid "YourSSID"
> OK
set_network 0 psk "YourPASSWORD"
> OK
set_network 0 key_mgmt WPA-PSK
> OK
enable_network 0
> OK
```

And for adding an enterprise network
```sh
add_network
> 0
set_network 0 ssid "NAME"
> OK
set_network 0 identity "myname@example.com"
> OK
set_network 0 password "password"
> OK
set_network 0 key_mgmt WPA-EAP
> OK
enable_netwrok 0
> OK
```

Nice, you are connected to internet, check for updates.
```sh
apt update & apt upgrade
```

Install sudo and add your user to sudo group
```sh
apt install sudo
usermod -aG sudo,video,audio "YourUSERNAME"
```

Now install Network Manager and disable wpa_supplicant
```sh
apt install network-manager
systemctl enable NetworkManager
systemctl disable wpa_supplicant
```

Reboot
```sh
reboot
```

Log in with your user and use nmcli to connect to a network
```sh
nmcli device wifi connect "SSID" password "PASSWORD"
```
Install some basic packages.
```sh
sudo apt install sway xwayland waybar rofi alacritty firefox-esr wl-clipboard
thunar thunar-archive-plugin pipewire pipewire-jack pipewire-audio
pavucontrol blueman gvfs gvfs-backends gvfs-fuse libsmbclient fish
ffmpegthumbnailer tumbler xdg-desktop-portal-gtk policykit-1-gnome
materia-gtk-theme materia-kde papirus-icon-theme qt5-style-kvantum
network-manager-gnome btop neofetch mpv swayimg gnome-keyring grim
slurp ranger exa bat inxi vainfo alsa-tools alsa-utils lxappearance
brightnessctl x11-xserver-utils udisks2 swaylock swayidle
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
