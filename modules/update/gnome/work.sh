#!/bin/bash

pacman -S --noconfirm --needed gnome gnome-tweaks gdm archlinux-wallpaper gnome-backgrounds libopenraw ffmpegthumbnailer tumbler android-udev dconf-editor xdg-desktop-portal xdg-desktop-portal-gtk xdg-user-dirs

#-->Service
systemctl enable gdm

#-->Config
#keyboard
su $INPUT_USER_NAME -c "dbus-launch --exit-with-session gsettings set org.gnome.desktop.peripherals.keyboard remember-numlock-state true"
su $INPUT_USER_NAME -c "dbus-launch --exit-with-session gsettings set org.gnome.desktop.peripherals.keyboard numlock-state true"


#mouse
su $INPUT_USER_NAME -c "gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true"


#user interface
su $INPUT_USER_NAME -c "gsettings set org.gnome.desktop.interface show-battery-percentage true"
su $INPUT_USER_NAME -c "dbus-launch --exit-with-session gsettings set org.gnome.desktop.screensaver picture-uri 'file:///usr/share/backgrounds/archlinux/simple.png'"
su $INPUT_USER_NAME -c "dbus-launch --exit-with-session gsettings set org.gnome.desktop.screensaver picture-opacity 100"
su $INPUT_USER_NAME -c "dbus-launch --exit-with-session gsettings set org.gnome.desktop.screensaver picture-options 'zoom'"
su $INPUT_USER_NAME -c "dbus-launch --exit-with-session gsettings set org.gnome.desktop.background picture-uri 'file:///usr/share/backgrounds/archlinux/simple.png'"
su $INPUT_USER_NAME -c "dbus-launch --exit-with-session gsettings set org.gnome.desktop.background picture-options 'zoom'"
su $INPUT_USER_NAME -c "dbus-launch --exit-with-session gsettings set org.gnome.desktop.background picture-opacity 100"


#functions
su $INPUT_USER_NAME -c "dbus-launch --exit-with-session gsettings set org.gnome.desktop.input-sources sources \"[('xkb', 'de')]\""
su $INPUT_USER_NAME -c "dbus-launch --exit-with-session gsettings set org.gnome.software download-updates false"
