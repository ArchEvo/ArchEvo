#!/bin/bash

pacman -S --noconfirm --needed gnome gdm archlinux-wallpaper libopenraw ffmpegthumbnailer tumbler android-udev

#-->Service
systemctl enable gdm

#-->Config
su $INPUT_USER_NAME -c "dbus-launch --exit-with-session gsettings set org.gnome.desktop.input-sources sources \"[('xkb', 'de')]\""
su $INPUT_USER_NAME -c "dbus-launch --exit-with-session gsettings set org.gnome.software download-updates false"
su $INPUT_USER_NAME -c "dbus-launch --exit-with-session gsettings set org.gnome.desktop.peripherals.keyboard remember-numlock-state true"
su $INPUT_USER_NAME -c "dbus-launch --exit-with-session gsettings set org.gnome.desktop.peripherals.keyboard numlock-state true"
su $INPUT_USER_NAME -c "dbus-launch --exit-with-session gsettings set org.gnome.desktop.screensaver picture-uri 'file:///usr/share/backgrounds/archlinux/simple.png'"
su $INPUT_USER_NAME -c "dbus-launch --exit-with-session gsettings set org.gnome.desktop.screensaver picture-opacity 100"
su $INPUT_USER_NAME -c "dbus-launch --exit-with-session gsettings set org.gnome.desktop.screensaver picture-options 'zoom'"
su $INPUT_USER_NAME -c "dbus-launch --exit-with-session gsettings set org.gnome.desktop.background picture-uri 'file:///usr/share/backgrounds/archlinux/simple.png'"
su $INPUT_USER_NAME -c "dbus-launch --exit-with-session gsettings set org.gnome.desktop.background picture-options 'zoom'"
su $INPUT_USER_NAME -c "dbus-launch --exit-with-session gsettings set org.gnome.desktop.background picture-opacity 100"
