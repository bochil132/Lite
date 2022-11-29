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
source /var/lib/fsidvpn/ipvps.conf
if [[ "$IP2" = "" ]]; then
domain=$(cat /etc/xray/domain)
else
domain=$IP2
fi
clear
IP=$(wget -qO- ipinfo.io/ip);
ws="$(cat ~/log-install.txt | grep -w "Websocket TLS" | cut -d: -f2|sed 's/ //g')"
ws2="$(cat ~/log-install.txt | grep -w "Websocket HTTP" | cut -d: -f2|sed 's/ //g')"

ssl="$(cat ~/log-install.txt | grep -w "Stunnel5" | cut -d: -f2)"
sqd="$(cat ~/log-install.txt | grep -w "Squid" | cut -d: -f2)"
ovpn="$(netstat -nlpt | grep -i openvpn | grep -i 0.0.0.0 | awk '{print $4}' | cut -d: -f2)"
ovpn2="$(netstat -nlpu | grep -i openvpn | grep -i 0.0.0.0 | awk '{print $4}' | cut -d: -f2)"
Login=Trial`</dev/urandom tr -dc X-Z0-9 | head -c4`
hari="1"
Pass=1
clear
systemctl restart ws-tls
systemctl restart ws-nontls
systemctl restart ssh-ohp
systemctl restart dropbear-ohp
systemctl restart openvpn-ohp
useradd -e `date -d "$masaaktif days" +"%Y-%m-%d"` -s /bin/false -M $Login
exp="$(chage -l $Login | grep "Account expires" | awk -F": " '{print $2}')"
hariini=`date -d "0 days" +"%Y-%m-%d"`
expi=`date -d "$masaaktif days" +"%Y-%m-%d"`
echo -e "$Pass\n$Pass\n"|passwd $Login &> /dev/null
echo -e ""
TEXT="
Thank You For Using Our Service
Informasi SSH OpenVPN
==============================
Username : $Login
Password : $Pass
Created On : $hariini
Expired On : $expi
==============================
✓Detail Port SSH OpenVPN✓
==============================
Domain SSH : ${domain}
IP Host : $IP
Ssh Websocket TLS : $ws
Ssh Websocket NTLS : $ws2
Dropbear : 109, 143
SSL TLS :$ssl
Port Squid :$sqd
OHP SSH : 8181
OHP Dropbear : 8282
OHP OpenVPN : 8383
OpenVPN Websocket : 2086
OpenVPN SSL : 990
BadVpn UDPGW : 7100-7200-7300
==============================
✓Link Config OpenVPN✓
==============================
TCP : http://${domain}:89/tcp.ovpn
UDP : http://${domain}:89/udp.ovpn
SSL : http://${domain}:89/ssl.ovpn
==============================
• Payload Websocket TLS :
GET wss://who.int/ HTTP/1.1 [crlf]Host: ${domain}[crlf]Upgrade: websocekt[crlf][crlf]
• Payload Websocket NTLS :
GET / HTTP/1.1 [crlf]Host: ${domain}[crlf]Upgrade: websocekt[crlf][crlf]
==============================
"
curl -s --max-time 10 -d "chat_id=1668998643&disable_web_page_preview=1&text=${TEXT}&parse_mode=html" https://api.telegram.org/bot5972770394:AAFz8aRmieB4Q3U_r3EuCg-NhjJSdiqsppA/sendMessage >/dev/null
clear
echo -e "[ ${GREEN}OKEY${NC} ] • Ssh Trial Success Created"
echo -e "[ ${RED}NOTE${NC} ] • Please Check Bot Telegram"
echo -e ""
read -n 1 -s -r -p "Press any key to back on menu"

menu
