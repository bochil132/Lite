#!/bin/bash
GREEN='\033[0;32m'
NC='\e[0m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m'
yl='\e[32;1m'
bl='\e[36;1m'
gl='\e[32;1m'
rd='\e[31;1m'
mg='\e[0;95m'
blu='\e[34m'
op='\e[35m'
or='\033[1;33m'
bd='\e[1m'
color1='\e[031;1m'
color2='\e[34;1m'
color3='\e[0m'
clear

echo -e ""
echo -e "${CYAN}╒══════════════════════════════════════════════════╕${NC}"
echo -e " \E[45;1;39m                 [ MENU LAYANAN ]                 \E[0m"
echo -e "${CYAN}╘══════════════════════════════════════════════════╛${NC}"
echo -e " ${rd}×1.${NC} Membuat Akun SSH & OpenVPN"
echo -e " ${rd}×2.${NC} Perpanjang Akun SSH & OpenVPN"
echo -e " ${rd}×3.${NC} Daftar Member SSH & OpenVPN"
echo -e " ${rd}×4.${NC} Cek Pengguna Login SSH & OpenVPN"
echo -e " ${rd}×5.${NC} Hapus Pengguna SSH & OpenVPN"
echo -e " ${rd}×6.${NC} Membuat Akun Trial SSH & OpenVPN"
echo -e " ${rd}×7.${NC} Hapus Akun Expired SSH & OpenVPN"
echo -e " ${rd}×8.${NC} Membuat Akun Xray/Vmess"
echo -e " ${rd}×9.${NC} Perpanjang Akun Vmess"
echo -e " ${rd}10.${NC} Hapus Akun Xray/Vmess"
echo -e " ${rd}11.${NC} Cek Vmess User Login"
echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" | lolcat
echo -e ""
echo -e "${CYAN}╒══════════════════════════════════════════════════╕${NC}"
echo -e " \E[45;1;39m                  [ OTHER MENU ]                  \E[0m"
echo -e "${CYAN}╘══════════════════════════════════════════════════╛${NC}"
echo -e " ${rd}12.${NC} Add New Domain"
echo -e " ${rd}13.${NC} Running Service"
echo -e " ${rd}14.${NC} Restart All Service"
echo -e " ${rd}15.${NC} Vps Info"
echo -e " ${rd}16.${NC} Reboot Server"
echo -e " ${rd}17.${NC} Renew Certificate"
echo -e " ${rd}18.${NC} Show Ram Usage"
echo -e " ${rd}19.${NC} Speedtest VPS"
echo -e " ${rd}20.${NC} About"
echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" | lolcat
echo -e ""
 read -p " Input Your Choose : " menu
echo -e   ""
case $menu in
1 | 01)
addssh
;;
2 | 02)
renewssh
;;
3 | 03)
member
;;
4 | 04)
cekssh
;;
5 | 05)
delssh
;;
6 | 06)
trialssh
;;
7 | 07)
delexp
;;
8 | 08)
addvmess
;;
9 | 09)
renewvmess
;;
10)
delvmess
;;
11)
cekvmess
;;
12)
addhost
;;
13)
running
;;
14)
restart
;;
15)
system
;;
16)
echo -e "${GREEN}Prosess Reboot Segera Dimulai${NC}"
sleep 3
reboot
;;
17)
certv2ray
;;
18)
ram
;;
19)
speedtest
;;
20)
about
;;
21)
about
;;
0 | 00)
menu
;;
*)
exit
;;
esac
