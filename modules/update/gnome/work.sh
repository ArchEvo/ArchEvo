#!/bin/bash

pacman -Syy
pacman -S gnome gdm nautilus-share --noconfirm

#-->Service
systemctl enable gdm

#-->Config
pkexec
su $INPUT_USER_NAME -c "dbus-launch --exit-with-session gsettings set org.gnome.desktop.input-sources sources \"[('xkb', 'de')]\""
su $INPUT_USER_NAME -c "dbus-launch --exit-with-session gsettings set org.gnome.software download-updates false"
su $INPUT_USER_NAME -c "dbus-launch --exit-with-session gsettings set org.gnome.settings-daemon.peripherals.keyboard numlock-state on"
