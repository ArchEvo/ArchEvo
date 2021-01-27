#!/bin/bash

pacman -S --noconfirm --needed cups cups-pdf ghostscript gsfonts hplip system-config-printer foomatic-db foomatic-db-nonfree foomatic-db-nonfree-ppds foomatic-db-ppds foomatic-db-engine gutenprint foomatic-db-gutenprint-ppds gsfonts bluez-cups xsane simple-scan python-notify2 python-pillow python-reportlab python-pyqt5

systemctl enable cups.service
