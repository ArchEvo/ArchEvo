#!/bin/bash

all_checks=ok

if [[ $(ping -c 2 google.de &> /dev/null ; echo $?) != 0 ]] ; then
    echo -e "\e[1m\e[31mThe internet connection does not work.\e[0m"
    kill 0
fi

if [[ ! $(cat /proc/cpuinfo | grep flags | grep aes) ]] ; then
    echo -e "\e[1m\e[31mYour CPU does not support AES.
The installation can continue.
However, your system may be slow.\e[0m"
    sleep 10
fi

if [ ! -d "/sys/firmware/efi/" ]; then
    echo -e "\e[1m\e[31mThis script is only designed for efi systems.\e[0m"
    kill 0
fi


#if [ ! -f "/bin/dialog" ]; then
#    echo -e "\e[1m\e[31mPlease install 'dialog' first before the script can be started."
#    echo -e "pacman -Sy dialog\e[0m"
#    kill 0
#fi

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

# start check ISO version
release_year=$(cat /version | tr "." " " | awk '{print $1;}')
release_month=$(cat /version | tr "." " " | awk '{print $2;}')
release_day=$(cat /version | tr "." " " | awk '{print $3;}')

last_tested_version="2021.02.01"

tested_year=$(echo $last_tested_version | tr "." " " | awk '{print $1;}')
tested_month=$(echo $last_tested_version | tr "." " " | awk '{print $2;}')
tested_day=$(echo $last_tested_version | tr "." " " | awk '{print $3;}')


release_checks=ok

if [ $release_year -lt $tested_year ]; then
  check_year=bad
else
  check_year=ok
fi

if [ $release_month -lt $tested_month ]; then
  check_month=bad
else
  check_month=ok
fi


if [[ "$check_year" == "ok" ]]; then
  if [[ "$check_month" != "ok" ]]; then
    release_checks=bad
  fi
else
  release_checks=bad
fi

if [[ "$release_checks" == "bad" ]]; then
    all_checks=bad
    echo -e "\e[31mYour ISO version is too old." 
    echo "Please use a more recent version."
    echo "Last tested version is from:"
    echo $last_tested_version
    echo ""
    echo "The installation will continue in 10 seconds."
    echo -e "\e[32mmay God be with you :-)="
    echo -e "\e[39m"

    for i in {10..01}
    do
      sleep 1
    done
fi
# end check ISO version


if [[ "$all_checks" == "ok" ]]; then
  echo -e '\e[32mAll initial tests were successfully completed\e[39m'
fi

sleep 3
