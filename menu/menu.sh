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

function subdomain(){
clear
MYIP=$(wget -qO- ipinfo.io/ip);
clear
read -rp "Domain/Host : " -e domain
echo "$domain" > /var/lib/fsidvpn/ipvps.conf
rm -rf /etc/xray/domain
echo $domain > /etc/xray/domain
certxray
restart
}

function certxray(){
clear
echo -e "${R}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━$nc"
echo -e "${G}               • RENEW DOMAIN SSL •               $nc"
echo -e "${R}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━$nc"
echo -e ""
echo -e "[ ${green}INFO${NC} ] Start " 
sleep 0.5
systemctl stop nginx
domain=$(cat /var/lib/fsidvpn/ipvps.conf | cut -d'=' -f2)
Cek=$(lsof -i:80 | cut -d' ' -f1 | awk 'NR==2 {print $1}')
if [[ ! -z "$Cek" ]]; then
sleep 1
echo -e "[ ${red}WARNING${NC} ] Detected port 80 used by $Cek " 
systemctl stop $Cek
sleep 2
echo -e "[ ${green}INFO${NC} ] Processing to stop $Cek " 
sleep 1
fi
echo -e "[ ${green}INFO${NC} ] Starting renew cert... " 
sleep 2
/root/.acme.sh/acme.sh --set-default-ca --server letsencrypt
/root/.acme.sh/acme.sh --issue -d $domain --force --standalone -k ec-256
~/.acme.sh/acme.sh --installcert -d $domain --fullchainpath /etc/xray/xray.crt --keypath /etc/xray/xray.key --ecc
echo -e "[ ${green}INFO${NC} ] Renew cert done... " 
sleep 2
echo -e "[ ${green}INFO${NC} ] Starting service $Cek " 
sleep 2
echo $domain > /etc/xray/domain
systemctl restart $Cek
systemctl restart nginx
echo -e "[ ${green}INFO${NC} ] All finished... " 
sleep 0.5
echo ""
echo -e "${red}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━$NC"
}

function restart(){
clear
echo -e ""
echo -e "Starting Restart All Service"
sleep 2
systemctl restart ws-tls
systemctl restart ws-nontls
systemctl restart xray
systemctl restart ws-ovpn
systemctl restart ssh-ohp
systemctl restart dropbear-ohp
systemctl restart openvpn-ohp
/etc/init.d/ssh restart
/etc/init.d/dropbear restart
/etc/init.d/sslh restart
/etc/init.d/stunnel5 restart
/etc/init.d/openvpn restart
/etc/init.d/fail2ban restart
/etc/init.d/cron restart
/etc/init.d/nginx restart
/etc/init.d/squid restart
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7100 --max-clients 1000
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7200 --max-clients 1000
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300 --max-clients 1000
echo -e "Restart All Service Berhasil"
echo -e ""
read -n 1 -s -r -p "Press any key to back on menu"
menu
}

function status(){
MYIP=$(curl -sS ipv4.icanhazip.com)
#########################
# GETTING OS INFORMATION
source /etc/os-release
Versi_OS=$VERSION
ver=$VERSION_ID
Tipe=$NAME
URL_SUPPORT=$HOME_URL
basedong=$ID

# VPS ISP INFORMATION
#ITAM='\033[0;30m'
echo -e "$ITAM"
#REGION=$( curl -s ipinfo.io/region )
#clear
#COUNTRY=$( curl -s ipinfo.io/country )
#clear
#WAKTU=$( curl -s ipinfo.ip/timezone )
#clear
CITY=$( curl -s ipinfo.io/city )
#clear
#REGION=$( curl -s ipinfo.io/region )
#clear

# CHEK STATUS 
openvpn_service="$(systemctl show openvpn.service --no-page)"
oovpn=$(echo "${openvpn_service}" | grep 'ActiveState=' | cut -f2 -d=)
#status_openvp=$(/etc/init.d/openvpn status | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
#status_ss_tls="$(systemctl show shadowsocks-libev-server@tls.service --no-page)"
#ss_tls=$(echo "${status_ss_tls}" | grep 'ActiveState=' | cut -f2 -d=)
#status_ss_http="$(systemctl show shadowsocks-libev-server@http.service --no-page)"
#ss_http=$(echo "${status_ss_http}" | grep 'ActiveState=' | cut -f2 -d=)
#sssohtt=$(systemctl status shadowsocks-libev-server@*-http | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
#status="$(systemctl show shadowsocks-libev.service --no-page)"
#status_text=$(echo "${status}" | grep 'ActiveState=' | cut -f2 -d=)
tls_v2ray_status=$(systemctl status xray | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
nontls_v2ray_status=$(systemctl status xray | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
trojan_server=$(systemctl status xray | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
dropbear_status=$(/etc/init.d/dropbear status | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
stunnel_service=$(/etc/init.d/stunnel5 status | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
squid_service=$(/etc/init.d/squid status | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
ssh_service=$(/etc/init.d/ssh status | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
vnstat_service=$(/etc/init.d/vnstat status | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
cron_service=$(/etc/init.d/cron status | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
fail2ban_service=$(/etc/init.d/fail2ban status | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
wstls=$(systemctl status ws-tls | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
wsdrop=$(systemctl status ws-nontls | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
shd=$(systemctl status sshd | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
udp=$(systemctl status rc-local | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
wsovpn=$(systemctl status ws-ovpn | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
cron=$(systemctl status cron | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
sqd=$(systemctl status squid | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
nginx=$(systemctl status nginx | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
#wsopen=$(systemctl status ws-openssh | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
osslh=$(systemctl status sslh | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
ohp=$(systemctl status dropbear-ohp | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
ohq=$(systemctl status openvpn-ohp | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
ohr=$(systemctl status ssh-ohp | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)

# COLOR VALIDATION
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'
green='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LIGHT='\033[0;37m'
clear

# STATUS SERVICE Shadowsocks HTTPS
if [[ $sst_status == "running" ]]; then
  status_sst=" ${GREEN}Running ${NC}( No Error )"
else
  status_sst="${RED}  Not Running ${NC}  ( Error )"
fi

# STATUS SERVICE Shadowsocks HTTP
if [[ $ssh_status == "running" ]]; then 
   status_ssh="${GREEN}Online [ Aktif ]${NC}"
else
   status_ssh="${RED}Offline [ Error ]${NC}"
fi

# STATUS SERVICE OPENVPN
if [[ $oovpn == "active" ]]; then
  status_openvpn="${GREEN}Online [ Aktif ]${NC}"
else
  status_openvpn="${RED}Offline [ Error ]${NC}"
fi

# STATUS SERVICE  SSH 
if [[ $ssh_service == "running" ]]; then 
   status_ssh="${GREEN}Online [ Aktif ]${NC}"
else
   status_ssh="${RED}Offline [ Error ]${NC}"
fi

# STATUS SERVICE  SQUID 
if [[ $squid_service == "running" ]]; then 
   status_squid=" ${GREEN}Running ${NC}( No Error )"
else
   status_squid="${RED}  Not Running"
fi

# STATUS SERVICE  VNSTAT 
if [[ $vnstat_service == "running" ]]; then 
   status_vnstat="${GREEN}Online [ Aktif ]${NC}"
else
   status_vnstat="${RED}Offline [ Error ]${NC}"
fi

# STATUS SERVICE  CRONS 
if [[ $cron_service == "running" ]]; then 
   status_cron=" ${GREEN}Running ${NC}( No Error )"
else
   status_cron="${RED}  Not Running ${NC}  ( Error )"
fi

# STATUS SERVICE  FAIL2BAN 
if [[ $fail2ban_service == "running" ]]; then 
   status_fail2ban="${GREEN}Online [ Aktif ]${NC}"
else
   status_fail2ban="${RED}Offline [ Error ]${NC}"
fi

# STATUS SERVICE  TLS 
if [[ $tls_v2ray_status == "running" ]]; then 
   status_tls_v2ray="${GREEN}Online [ Aktif ]${NC}"
else
   status_tls_v2ray="${RED}Offline [ Error ]${NC}"
fi

# STATUS SERVICE NON TLS V2RAY
if [[ $nontls_v2ray_status == "running" ]]; then 
   status_nontls_v2ray="${GREEN}Online [ Aktif ]${NC}"
else
   status_nontls_v2ray="${RED}Offline [ Error ]${NC}"
fi

# STATUS SERVICE VLESS HTTPS
if [[ $vless_tls_v2ray_status == "running" ]]; then
  status_tls_vless=" ${GREEN}Running${NC} ( No Error )"
else
  status_tls_vless="${RED}  Not Running ${NC}  ( Error )${NC}"
fi

# STATUS SERVICE VLESS HTTP
if [[ $vless_nontls_v2ray_status == "running" ]]; then
  status_nontls_vless=" ${GREEN}Running${NC}"
else
  status_nontls_vless="${RED}  Not Running ${NC}"
fi

# SHADOWSOCKSR STATUS
if [[ $ssr_status == "running" ]] ; then
  status_ssr=" ${GREEN}Running${NC} ( No Error )${NC}"
else
  status_ssr="${RED}  Not Running ${NC}  ( Error )${NC}"
fi

# SODOSOK
if [[ $status_text == "active" ]] ; then
  status_sodosok=" ${GREEN}Running${NC} ( No Error )${NC}"
else
  status_sodosok="${RED}  Not Running ${NC}  ( Error )${NC}"
fi

# STATUS SERVICE TROJAN
if [[ $trojan_server == "running" ]]; then 
   status_virus_trojan=" ${GREEN}Running ${NC}( No Error )${NC}"
else
   status_virus_trojan="${RED}  Not Running ${NC}  ( Error )${NC}"
fi

# STATUS SERVICE WIREGUARD
if [[ $swg == "active" ]]; then
  status_wg=" ${GREEN}Running ${NC}( No Error )${NC}"
else
  status_wg="${RED}  Not Running ${NC}  ( Error )${NC}"
fi

# Status Service Trojan GO
if [[ $strgo == "active" ]]; then
  status_trgo=" ${GREEN}Running ${NC}( No Error )${NC}"
else
  status_trgo="${RED}  Not Running ${NC}  ( Error )${NC}"
fi

# STATUS SERVICE L2TP
if [[ $l2tp_status == "running" ]]; then 
   status_l2tp=" ${GREEN}Running${NC} ( No Error )${NC}"
else
   status_l2tp="${RED}  Not Running${NC}  ( Error )${NC}"
fi

# STATUS SERVICE DROPBEAR
if [[ $dropbear_status == "running" ]]; then 
   status_beruangjatuh="${GREEN}Online [ Aktif ]${NC}"
else
   status_beruangjatuh="${RED}Offline [ Error ]${NC}"
fi

# STATUS SERVICE STUNNEL
if [[ $stunnel_service == "running" ]]; then 
   status_stunnel="${GREEN}Online [ Aktif ]${NC}"
else
   status_stunnel="${RED}Offline [ Error ]${NC}"
fi

# STATUS SERVICE SSTP
if [[ $sstp_service == "running" ]]; then 
   status_sstp=" ${GREEN}Running ${NC}( No Error )"
else
   status_sstp="${RED}  Not Running ${NC}  ( Error )"
fi

# STATUS SERVICE WEBSOCKET TLS
if [[ $wstls == "running" ]]; then 
   swstls="${GREEN}Online [ Aktif ]${NC}"
else
   swstls="${RED}Offline [ Error ]${NC}"
fi

# STATUS SERVICE WEBSOCKET DROPBEAR
if [[ $wsdrop == "running" ]]; then 
   swsdrop="${GREEN}Online [ Aktif ]${NC}"
else
   swsdrop="${RED}Offline [ Error ]${NC}"
fi

# STATUS SERVICE WEBSOCKET OPEN OVPN
if [[ $wsovpn == "running" ]]; then 
   swsovpn="${GREEN}Online [ Aktif ]${NC}"
else
   swsovpn="${RED}Offline [ Error ]${NC}"
fi

# STATUS SERVICE SSLH / SSH
if [[ $osslh == "running" ]]; then 
   sosslh="${GREEN}Online [ Aktif ]${NC}"
else
   sosslh="${RED}Offline [ Error ]${NC}"
fi

# STATUS OHP DROPBEAR
if [[ $ohp == "running" ]]; then 
   sohp="${GREEN}Online [ Aktif ]${NC}"
else
   sohp="${RED}Offline [ Error ]${NC}"
fi

# STATUS OHP OpenVPN
if [[ $ohq == "running" ]]; then 
   sohq="${GREEN}Online [ Aktif ]${NC}"
else
   sohq="${RED}Offline [ Error ]${NC}"
fi

# STATUS OHP SSH
if [[ $ohr == "running" ]]; then 
   sohr="${GREEN}Online [ Aktif ]${NC}"
else
   sohr="${RED}Offline [ Error ]${NC}"
fi

# STATUS SERVICE WEBSOCKET OPENSSH
if [[ $wsopen == "running" ]]; then 
   swsopen="${GREEN}Online [ Aktif ]${NC}" 
else
   swsopen="${RED}Offline [ Error ]${NC}"
fi

# STATUS SERVICE SSHD
if [[ $shd == "running" ]]; then 
   shdd="${GREEN}Online [ Aktif ]${NC}" 
else
   shdd="${RED}Offline [ Error ]${NC}"
fi

# STATUS SERVICE BADVPN
if [[ $udp == "running" ]]; then 
   udpw="${GREEN}Online [ Aktif ]${NC}" 
else
   udpw="${RED}Offline [ Error ]${NC}"
fi

# STATUS SERVICE CRON
if [[ $cron == "running" ]]; then 
   cr="${GREEN}Online [ Aktif ]${NC}" 
else
   cr="${RED}Offline [ Error ]${NC}"
fi

# STATUS SERVICE SQUID
if [[ $sqd == "running" ]]; then 
   sq="${GREEN}Online [ Aktif ]${NC}" 
else
   sq="${RED}Offline [ Error ]${NC}"
fi

# STATUS SERVICE NGINX
if [[ $nginx == "running" ]]; then 
   nx="${GREEN}Online [ Aktif ]${NC}" 
else
   nx="${RED}Offline [ Error ]${NC}"
fi
clear

echo -e ""
clear
up="$(uptime -p | cut -d " " -f 2-10)"
cpu=$( awk -F: '/model name/ {name=$2} END {print name}' /proc/cpuinfo )
core=$( awk -F: '/model name/ {core++} END {print core}' /proc/cpuinfo )
ct=$(curl -s ipinfo.io/city )
sp=$(curl -s ipinfo.io/org | cut -d " " -f 2-10 )
tram=$( free -m | awk 'NR==2 {print $2}' )
uram=$( free -m | awk 'NR==2 {print $3}' )
IPVPS=$(curl -s ipinfo.io/ip )
DOMAIN=$(cat /etc/xray/domain)
echo -e ""
echo -e " Current Domain      => $DOMAIN"
echo -e " Current IP VPS      => $IPVPS"
echo -e " Your Isp Vps        => $sp"
echo -e " Your City Vps       => $ct"
echo -e " OS Version          => "`hostnamectl | grep "Operating System" | cut -d ' ' -f5-`
echo -e " Number Of Cores     => $core Core"
echo -e " System Uptime       => $up"
echo -e " Cpu Model           =>$cpu"
echo -e " Total Ram           => $tram MB / Used $uram MB"
echo -e " Available Storage   => $(df -h / | awk '{print $4}' | tail -n1 | sed 's/G//g' | sed 's/ //g') GB"
echo -e " Total Storage       => $(df -h / | awk '{print $2}' | tail -n1 | sed 's/G//g' | sed 's/ //g') GB"
echo -e " Used Storage        => $(df -h / | awk '{print $3}' | tail -n1 | sed 's/G//g' | sed 's/ //g') GB"
echo -e "╒══════════════════════════════════════════════════╕" | lolcat
echo -e " \E[41;1;39m                 [ STATUS LAYANAN ]               \E[0m"
echo -e "╘══════════════════════════════════════════════════╛" | lolcat
echo -e " ${green}•${NC} SSH / TUN       => $status_ssh"
echo -e " ${green}•${NC} OVPN WS         => $swsovpn"
echo -e " ${green}•${NC} DROPBEAR        => $status_beruangjatuh"
echo -e " ${green}•${NC} VNSTAT          => $status_vnstat"
echo -e " ${green}•${NC} WS STUNNEL      => $swstls"
echo -e " ${green}•${NC} WS DROPBEAR     => $swsdrop"
echo -e " ${green}•${NC} STUNNEL         => $status_stunnel"
echo -e " ${green}•${NC} VMESS TLS       => $status_tls_v2ray"
echo -e " ${green}•${NC} VMESS HTTP      => $status_nontls_v2ray"
echo -e " ${green}•${NC} SSLH            => $sosslh"
echo -e " ${green}•${NC} FAIL2BAN        => $status_fail2ban"
echo -e " ${green}•${NC} OHP SSH         => $sohr"
echo -e " ${green}•${NC} OHP DROPBEAR    => $sohp"
echo -e " ${green}•${NC} SSHD            => $shdd"
echo -e " ${green}•${NC} BADVPN UDPGW    => $udpw"
echo -e " ${green}•${NC} CRONTAB         => $cr"
echo -e " ${green}•${NC} SQUID PROXY     => $sq"
echo -e " ${green}•${NC} NGINX           => $nx"
echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" | lolcat
echo -e ""
read -n 1 -s -r -p "Press Enter To Display Menu"
menu
}

function about(){
clear
echo -e "================================================="
echo -e "#              Dev/Main By Horassss             #"
echo -e "================================================="
echo -e "# For Debian 10 64 bit                          #"
echo -e "# For Ubuntu 18.04 & Ubuntu 20.04 64 bit        #"
echo -e "# For VPS with KVM and VMWare virtualization    #"
echo -e "# Recode By WaanStores                          #"
echo -e "================================================="
echo -e "# Thanks To                                     #"
echo -e "================================================="
echo -e "# Allah SWT                                     #"
echo -e "# My Family                                     #"
echo -e "# Horasss                                       #"
echo -e "================================================="
echo -e ""
read -n 1 -s -r -p "Press Enter To Display Menu"
menu
}

#Tampilan Menu Script

echo -e ""
clear
ipnya=$(curl -sS ipv4.icanhazip.com)
data=$(curl -sS https://raw.githubusercontent.com/bochil132/permission/main/ipmini | grep $ipnya | awk '{print $3}')
name=$(curl -sS https://raw.githubusercontent.com/bochil132/permission/main/ipmini | grep $ipnya | awk '{print $2}')
up="$(uptime -p | cut -d " " -f 2-10)"
cpu=$( awk -F: '/model name/ {name=$2} END {print name}' /proc/cpuinfo )
core=$( awk -F: '/model name/ {core++} END {print core}' /proc/cpuinfo )
ct=$(curl -s ipinfo.io/city )
sp=$(curl -s ipinfo.io/org | cut -d " " -f 2-10 )
tram=$( free -m | awk 'NR==2 {print $2}' )
uram=$( free -m | awk 'NR==2 {print $3}' )
IPVPS=$(curl -s ipinfo.io/ip )
DOMAIN=$(cat /etc/xray/domain)
echo -e ""
echo -e " Current Domain      => $DOMAIN"
echo -e " Current IP VPS      => $IPVPS"
echo -e " Your Isp Vps        => $sp"
echo -e " Your City Vps       => $ct"
echo -e " OS Version          => "`hostnamectl | grep "Operating System" | cut -d ' ' -f5-`
echo -e " Number Of Cores     => $core Core"
echo -e " System Uptime       => $up"
echo -e " Cpu Model           =>$cpu"
echo -e " Total Ram           => $tram MB / Used $uram MB"
echo -e " Available Storage   => $(df -h / | awk '{print $4}' | tail -n1 | sed 's/G//g' | sed 's/ //g') GB"
echo -e " Total Storage       => $(df -h / | awk '{print $2}' | tail -n1 | sed 's/G//g' | sed 's/ //g') GB"
echo -e " Used Storage        => $(df -h / | awk '{print $3}' | tail -n1 | sed 's/G//g' | sed 's/ //g') GB"
echo -e "${C}╒══════════════════════════════════════════════════╕${nc}"
echo -e " \E[41;1;39m              [ DISPLAY MENU SCRIPT ]             \E[0m"
echo -e "${C}╘══════════════════════════════════════════════════╛${nc}"
echo -e "  ${R}1.${nc} Show Panel Menu SSH & OpenVPN"
echo -e "  ${R}2.${nc} Show Panel Menu Xray Vmess"
echo -e "  ${R}3.${nc} Add New Subdomain"
echo -e "  ${R}4.${nc} Check Running Service"
echo -e "  ${R}5.${nc} Restart All Service"
echo -e "  ${R}6.${nc} Renew Certificate SSL"
echo -e "  ${R}7.${nc} Speedtest Server"
echo -e "  ${R}8.${nc} Check Usage Ram Server"
echo -e "  ${R}9.${nc} Bandwidth Monitoring"
echo -e " ${R}10.${nc} Reboot VPS"
echo -e " ${R}11.${nc} About"
echo -e " ${R}12.${nc} Update Script"
echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" | lolcat
echo -e " Base ${G}Official${NC} Script By ${C}@Horass${nc}"
echo -e " ${G}Modded${nc} And Update By ${C}@WanEuy${nc}"
echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" | lolcat
echo -e " ${P}Enjoy The Access Premium Autoscript${nc} ${G}SSH & VMESS${nc}"
echo -e " Pengguna Script ${G}=>${nc} $name"
echo -e " Expired Script  ${G}=>${nc} $data"
echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" | lolcat
echo -e ""
 read -p " Select 1 - 10 or X => " menu
echo -e   ""
case $menu in
1 | 01)
style-ssh
;;
2 | 02)
style-vmess
;;
3 | 03)
subdomain
;;
4 | 04)
status
;;
5 | 05)
restart
;;
6 | 06)
certxray
;;
7 | 07)
speedtest
;;
8 | 08)
ram
;;
9 | 09)
style-bw
;;
10)
reboot
;;
11)
about
;;
12)
wget autosc.mybochil.me/menu/update.sh && bash update.sh
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











