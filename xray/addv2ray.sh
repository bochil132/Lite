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
IP=$(wget -qO- ipinfo.io/ip);
domain=$(cat /etc/xray/domain)
tls="$(cat ~/log-install.txt | grep -w "Vmess TLS" | cut -d: -f2|sed 's/ //g')"
nontls="$(cat ~/log-install.txt | grep -w "Vmess HTTP" | cut -d: -f2|sed 's/ //g')"
until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${CLIENT_EXISTS} == '0' ]]; do
                echo -e "${GREEN}--------------------------------------${NC}"
		read -rp "Username : " -e user
                echo -e "${GREEN}--------------------------------------${NC}"
		CLIENT_EXISTS=$(grep -w $user /etc/xray/config.json | wc -l)

		if [[ ${CLIENT_EXISTS} == '1' ]]; then
			echo ""
			echo -e "Username ${RED}${CLIENT_NAME}${NC} Already On VPS Please Choose Another"
			exit 1
		fi
	done
uuid=$(cat /proc/sys/kernel/random/uuid)
echo -e "${GREEN}--------------------------------------${NC}"
read -p "Expired (Days) : " masaaktif
echo -e "${GREEN}--------------------------------------${NC}"
hariini=`date -d "0 days" +"%Y-%m-%d"`
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
sed -i '/#xray-vmess-tls$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'"' /etc/xray/config.json
sed -i '/#xray-vmess-nontls$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'"' /etc/xray/config.json
cat>/etc/xray/vmess-$user-tls.json<<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "${domain}",
      "port": "${tls}",
      "id": "${uuid}",
      "aid": "0",
      "net": "ws",
      "path": "/worryfree",
      "type": "none",
      "host": "${domain}",
      "tls": "tls"
}
EOF
cat>/etc/xray/vmess-$user-nontls.json<<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "${domain}",
      "port": "${nontls}",
      "id": "${uuid}",
      "aid": "0",
      "net": "ws",
      "path": "/worryfree",
      "type": "none",
      "host": "${domain}",
      "tls": "none"
}
EOF
vmess_base641=$( base64 -w 0 <<< $vmess_json1)
vmess_base642=$( base64 -w 0 <<< $vmess_json2)
xrayv2ray1="vmess://$(base64 -w 0 /etc/xray/vmess-$user-tls.json)"
xrayv2ray2="vmess://$(base64 -w 0 /etc/xray/vmess-$user-nontls.json)"
rm -rf /etc/xray/vmess-$user-tls.json
rm -rf /etc/xray/vmess-$user-nontls.json
systemctl restart xray.service
service cron restart
clear
echo -e ""
echo -e "•──────────────────•"
echo -e "🔰XRAY VMESS ACCOUNT🔰"
echo -e "•──────────────────•"
echo -e "Remarks : ${user}"
echo -e "IP/Host : ${IP}"
echo -e "Domain : ${domain}"
echo -e "Port TLS : ${tls}"
echo -e "Port HTTP : ${nontls}"
echo -e "User ID : ${uuid}"
echo -e "Alter ID : 0"
echo -e "Scurity : Auto"
echo -e "Network : Ws"
echo -e "Path : /worryfree"
echo -e "Created On : $hariini"
echo -e "Expired On : $exp"
echo -e "•──────────────────•"
echo -e "Vmess Link TLS :"
echo -e "${xrayv2ray1}"
echo -e "•──────────────────•"
echo -e "Vmess Link HTTP :"
echo -e "${xrayv2ray2}"
echo -e "•──────────────────•"
echo -e ""
read -n 1 -s -r -p "Press any key to back on menu"
menu

