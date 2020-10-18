#!/bin/bash

# install and config gnome
source /opt/ArchEvo/modules/update/gnome/before_check.sh
source /opt/ArchEvo/modules/update/gnome/work.sh
source /opt/ArchEvo/modules/update/gnome/after_check.sh

# install and config networkmanager
source /opt/ArchEvo/modules/update/networkmanager/before_check.sh
source /opt/ArchEvo/modules/update/networkmanager/work.sh
source /opt/ArchEvo/modules/update/networkmanager/after_check.sh

# install and config ntp
source /opt/ArchEvo/modules/update/ntp/before_check.sh
source /opt/ArchEvo/modules/update/ntp/work.sh
source /opt/ArchEvo/modules/update/ntp/after_check.sh

# install and config snapper
source /opt/ArchEvo/modules/update/snapper/before_check.sh
source /opt/ArchEvo/modules/update/snapper/work.sh
source /opt/ArchEvo/modules/update/snapper/after_check.sh


# install font and ttf
source /opt/ArchEvo/modules/update/font/work.sh
