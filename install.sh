#!/bin/bash

set -e
set -u
set -o pipefail

# optionen:
# -d, --debug: Debug install with default config
# -D, --debugLanguage: Debug installation with standard configuration, special language setting, locales and time zone. Example: -D de

DEBUG=false
DEBUGLANGUAGE=false

TEMP=$(getopt -o dD: --long debug,debugLanguage: -n 'ArchEvo' -- "$@")
eval set -- "$TEMP"

while true; do
    case "$1" in
        -d | --debug ) DEBUG=true; shift ;;
        -D | --debugLanguage ) DEBUGLANGUAGE="$2"; shift 2 ;;
        * ) break ;;
    esac
done


#init checks
source ./modules/install/checks/init_check.sh

# init tools in before
source ./modules/interface/before.sh

if [ "$DEBUG" == "true" ] && [ "$DEBUGLANGUAGE" == "false" ]; then
    # debug install
    source ./modules/interface/init_debug.sh
elif [ "$DEBUGLANGUAGE" == "false" ]; then
    # init interface / default
    source ./modules/interface/init_default.sh
fi

if [ "$DEBUGLANGUAGE" != "false" ]; then
    echo "-D or --debugLanguage is not implemented :-)="
    exit 1
fi


#install archlinux 
source ./modules/install/init/before.sh
source ./modules/install/init/work.sh

# start update script; install/config packages 
arch-chroot /mnt/ sh /opt/ArchEvo/update.sh

# umount partition
source ./modules/install/init/after.sh
