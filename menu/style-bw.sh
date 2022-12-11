#!/bin/bash

#=============================================
# Thanks You
# Credit Script By : Horass
# Modified By : WaanStore
# 2022-12 -09
# SSH & VMESS ONLY
#=============================================

#Main color code
export G='\033[0;32m'
export P='\033[0;35m'
export C='\033[0;36m'
export Y='\e[32;1m'
export R='\e[31;1m'
export B='\e[34m'
export M='\e[0;95m'
export nc='\e[0m'

function 1days(){
clear
vnstat -d
echo -e ""
read -n 1 -s -r -p "Press any key to back on menu"
style-bw
}

function 1jam(){
clear
vnstat -h
echo -e ""
read -n 1 -s -r -p "Press any key to back on menu"
style-bw
}

function 5mint(){
clear
vnstat -5
echo -e ""
read -n 1 -s -r -p "Press any key to back on menu"
style-bw
}

function 1month(){
clear
vnstat -m
echo -e ""
read -n 1 -s -r -p "Press any key to back on menu"
style-bw
}

clear
echo -e "
 ${C}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${nc}
${C}|${nc}           ${P}[ BANDWIDTH MONITORING  ]${nc}            ${C}|${nc}
 ${C}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${nc}
  ${R}1.${nc} Bandwith Usage 1 Days
  ${R}2.${nc} Bandwidth Usage 1 Hours
  ${R}3.${nc} Bandwidth Usage 5 Minutes
  ${R}4.${nc} Bandwidth Usage 1 Month
 ${C}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${nc}
 Type ${R}X${nc} to back to main ${G}menu${nc}
 ${C}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${nc}"
echo -e ""
 read -p " Select 1 - 4 => " menu
echo -e   ""
case $menu in
1 )
1days
;;
2 )
1jam
;;
3 )
5mint
;;
4 )
1month
;;
X | x )
menu
;;
esac
