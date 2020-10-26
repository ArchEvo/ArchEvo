#!/bin/bash

if [ ! -d "/sys/firmware/efi/" ]; then
    echo -e "\e[1m\e[31mThis script is only designed for efi systems.\e[0m"
    kill 0
fi


if [ ! -f "/bin/dialog" ]; then
    echo -e "\e[1m\e[31mPlease install 'dialog' first before the script can be started."
    echo -e "pacman -Sy dialog\e[0m"
    kill 0
fi

if [ ! -f "/bin/git" ]; then
    echo -e "\e[1m\e[31mPlease install 'git' first before the script can be started."
    echo -e "pacman -Sy git\e[0m"
    kill 0
fi

if [[ "$(uname -m)" != "x86_64" ]]; then
    echo -e "\e[1m\e[31mThis script only works with 64 bit systems."
    echo -e "\e[0m"
    kill 0
fi

if [[ "$(cat /etc/issue)" != *"Arch Linux"* ]]; then
    echo -e "\e[1m\e[31mThis script is written purely for 'Arch Linux'."
    echo -e "\e[0m"
    kill 0
fi


echo -e '\e[32mAll initial tests were successfully completed\e[39m'
sleep 3