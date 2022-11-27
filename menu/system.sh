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
cpu_usage1="$(ps aux | awk 'BEGIN {sum=0} {sum+=$3}; END {print sum}')"
cpu_usage+=" %"
uram=$( free -m | awk 'NR==2 {print $3}' )
ISP=$(curl -s ipinfo.io/org | cut -d " " -f 2-10 )
IPVPS=$(curl -s ipinfo.io/ip )
DOMAIN=$(cat /etc/xray/domain)
ISP=$(curl -s ipinfo.io/org | cut -d " " -f 2-10 )
CITY=$(curl -s ipinfo.io/city )
WKT=$(curl -s ipinfo.io/timezone )
IPVPS=$(curl -s ipinfo.io/ip )
jam=$(date +"%T")
hari=$(date +"%A")
tnggl=$(date +"%d-%B-%Y")
cname=$( awk -F: '/model name/ {name=$2} END {print name}' /proc/cpuinfo )
cores=$( awk -F: '/model name/ {core++} END {print core}' /proc/cpuinfo )
freq=$( awk -F: ' /cpu MHz/ {freq=$2} END {print freq}' /proc/cpuinfo )
tram=$( free -m | awk 'NR==2 {print $2}' )
swap=$( free -m | awk 'NR==4 {print $2}' )
up=$(uptime|awk '{ $1=$2=$(NF-6)=$(NF-5)=$(NF-4)=$(NF-3)=$(NF-2)=$(NF-1)=$NF=""; print }')
echo -e ""
echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" | lolcat
echo -e "\E[45;1;39m                  ⇱ SPESIFIKASI YOUR VPS ⇲                   \E[0m"
echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" | lolcat
echo -e "❄️CPU Model           \033[0;32m•\033[0m$cname"
echo -e "❄️Kernel              \033[0;32m•\033[0m `uname -r`"
echo -e "❄️ISP Name            \033[0;32m•\033[0m $ISP"
echo -e "❄️City                \033[0;32m•\033[0m $CITY"
echo -e "❄️Operating System    \033[0;32m•\033[0m "`hostnamectl | grep "Operating System" | cut -d ' ' -f5-`
echo -e "❄️Number Of Cores     \033[0;32m•\033[0m $cores Cores"
echo -e "❄️CPU Usage           \033[0;32m•\033[0m $cpu_usage1 %"
echo -e "❄️Total Ram           \033[0;32m•\033[0m $tram MB (Used Ram : $uram MB)"
echo -e "❄️CPU Frequency       \033[0;32m•\033[0m$freq MHz"
echo -e "❄️Waktu               \033[0;32m•\033[0m $jam"
echo -e "❄️Hari                \033[0;32m•\033[0m $hari"
echo -e "❄️Tanggal             \033[0;32m•\033[0m $tnggl"
echo -e "❄️IP VPS              \033[0;32m•\033[0m $IPVPS"
echo -e "❄️TimeZone            \033[0;32m•\033[0m $WKT"
echo -e "❄️Domain              \033[0;32m•\033[0m $DOMAIN"
echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" | lolcat
echo ""
read -n 1 -s -r -p "Press enter to return to menu"

menu
