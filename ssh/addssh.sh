#!/bin/bash

# ==========================================
# Color
RED='\033[0;31m'
NC='\033[0m'
green='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LIGHT='\033[0;37m'
# ==========================================
# Getting
#!/bin/bash
# ==========================================
# Color
RED='\033[0;31m'
NC='\033[0m'
GREEN='\033[0;32m'
#ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
#CYAN='\033[0;36m'
LIGHT='\033[0;37m'
off='\x1b[m'
# ==========================================
# Getting
clear

domain=$(cat /etc/xray/domain)
clear
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "\E[41;1;39m            ⇱ CREATE SSH ACCOUNT ⇲           \E[0m"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
read -p "$( echo -e " ${green}»${NC} Username : " )" Login
read -p "$( echo -e " ${green}»${NC} Password : " )" Pass
read -p "$( echo -e " ${green}»${NC} Expired : " )" masaaktif

IP=$(wget -qO- ipinfo.io/ip);
ws="$(cat ~/log-install.txt | grep -w "Websocket TLS" | cut -d: -f2|sed 's/ //g')"
ws2="$(cat ~/log-install.txt | grep -w "Websocket HTTP" | cut -d: -f2|sed 's/ //g')"

ssl="$(cat ~/log-install.txt | grep -w "Stunnel5" | cut -d: -f2)"
sqd="$(cat ~/log-install.txt | grep -w "Squid" | cut -d: -f2)"
ovpn="$(netstat -nlpt | grep -i openvpn | grep -i 0.0.0.0 | awk '{print $4}' | cut -d: -f2)"
ovpn2="$(netstat -nlpu | grep -i openvpn | grep -i 0.0.0.0 | awk '{print $4}' | cut -d: -f2)"
clear
systemctl restart ws-tls
systemctl restart ws-nontls
systemctl restart ssh-ohp
systemctl restart dropbear-ohp
systemctl restart openvpn-ohp
useradd -e `date -d "$masaaktif days" +"%Y-%m-%d"` -s /bin/false -M $Login
expi="$(chage -l $Login | grep "Account expires" | awk -F": " '{print $2}')"
echo -e "$Pass\n$Pass\n"|passwd $Login &> /dev/null
hariini=`date -d "0 days" +"%Y-%m-%d"`
expi=`date -d "$masaaktif days" +"%Y-%m-%d"`
clear
echo -e ""
echo -e "•──────────────────•"
echo -e "🔰ACCOUNT SSH & OVPN🔰"
echo -e "•──────────────────•"
echo -e "Username : $Login"
echo -e "Password : $Pass"
echo -e "Created On : $hariini"
echo -e "Expired On : $expi"
echo -e "•──────────────────•"
echo -e "» Port Information :"
echo -e "» IP/Host : $IP"
echo -e "» Domain : ${domain}"
echo -e "» Websocket : $ws, $ws2"
echo -e "» Dropbear : 143, 109"
echo -e "» SSL/TLS :$ssl"
echo -e "» Squid :$sqd"
echo -e "» OpenVPN WS : 2086"
echo -e "» Ohp SSH : 8181"
echo -e "» Ohp Dropbear : 8282"
echo -e "» Ohp OpenVPN : 8383"
echo -e "» OpenVPN SSL : 990"
echo -e "» UDPGW : 7100 - 7300"
echo -e "•──────────────────•"
echo -e " ✅Link Config OpenVPN✅"
echo -e "TCP: http://${domain}:89/tcp.ovpn"
echo -e "UDP: http://${domain}:89/udp.ovpn"
echo -e "SSL: http://${domain}:89/ssl.ovpn"
echo -e "•──────────────────•"
echo -e ""
read -n 1 -s -r -p "Enter To Back Menu"

menu
