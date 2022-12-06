#!/bin/bash
# ==========================================
# Color
RED='\033[0;31m'
NC='\033[0m'
#GREEN='\033[0;32m'
#ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
#CYAN='\033[0;36m'
LIGHT='\033[0;37m'
off='\x1b[m'
# ==========================================
# Getting

clear
read -p "Username : " user
read -p "Alasan : " tos

if getent passwd $user > /dev/null 2>&1; then
        userdel $user

echo -e "====================================="
echo -e "   Account SSH & OpenVPN Deleted"
echo -e "====================================="
echo -e "Username : $user"
echo -e "Alasan : $tos"
echo -e "====================================="
else
echo -e "Failure: Username $user Tidak Ada"
fi
