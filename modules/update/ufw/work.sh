#!/bin/bash

pacman -S ufw gufw 

systemctl enable ufw

ufw enable 
