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
echo -e "---------------------------------------------------" | lolcat
echo -e "${BLUE}USERNAME          EXP DATE          STATUS${NC}"
echo -e "---------------------------------------------------" | lolcat
while read expired
do
AKUN="$(echo $expired | cut -d: -f1)"
ID="$(echo $expired | grep -v nobody | cut -d: -f3)"
exp="$(chage -l $AKUN | grep "Account expires" | awk -F": " '{print $2}')"
status="$(passwd -S $AKUN | awk '{print $2}' )"
if [[ $ID -ge 1000 ]]; then
if [[ "$status" = "L" ]]; then
printf "%-17s %2s %-17s %2s \n" "$AKUN" "$exp     " "User Locked"
else
printf "%-17s %2s %-17s %2s \n" "$AKUN" "$exp     " "User Unlocked"
fi
fi
done < /etc/passwd
JUMLAH="$(awk -F: '$3 >= 1000 && $1 != "nobody" {print $1}' /etc/passwd | wc -l)"
echo -e "---------------------------------------------------" | lolcat
echo -e "${BLUE}Jumlah User Ssh & OpenVpn : $JUMLAH User${NC}"
echo -e "---------------------------------------------------" | lolcat
echo -e ""
read -n 1 -s -r -p "Press any key to back on menu"

menu
