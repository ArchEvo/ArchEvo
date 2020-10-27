#!/bin/bash

if [[ $(ping -c 2 google.de &> /dev/null ; echo $?) != 0 ]] ; then
    echo -e "\e[1m\e[31mThe internet connection does not work.\e[0m"
    kill 0
fi

if [[ $(grep aes /proc/cpuinfo | grep flags | grep -q aes; echo $?) != 1 ]] ; then
    echo -e "\e[1m\e[31mYour CPU does not support AES.
The installation can continue.
However, your system may be slow.\e[0m"
    sleep 10
fi

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
