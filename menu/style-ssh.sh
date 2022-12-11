#!/bin/bash
dateFromServer=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
biji=`date +"%Y-%m-%d" -d "$dateFromServer"`
###########- COLOR CODE -##############
NC="\e[0m"
green="\033[0;32m"
red="\033[0;31m"
###########- END COLOR CODE -##########

BURIQ () {
    curl -sS https://raw.githubusercontent.com/bochil132/permission/main/ipmini > /root/tmp
    data=( `cat /root/tmp | grep -E "^### " | awk '{print $2}'` )
    for user in "${data[@]}"
    do
    exp=( `grep -E "^### $user" "/root/tmp" | awk '{print $3}'` )
    d1=(`date -d "$exp" +%s`)
    d2=(`date -d "$biji" +%s`)
    exp2=$(( (d1 - d2) / 86400 ))
    if [[ "$exp2" -le "0" ]]; then
    echo $user > /etc/.$user.ini
    else
    rm -f /etc/.$user.ini > /dev/null 2>&1
    fi
    done
    rm -f /root/tmp
}

MYIP=$(curl -sS ipv4.icanhazip.com)
Name=$(curl -sS https://raw.githubusercontent.com/bochil132/permission/main/ipmini | grep $MYIP | awk '{print $2}')
echo $Name > /usr/local/etc/.$Name.ini
CekOne=$(cat /usr/local/etc/.$Name.ini)

Bloman () {
if [ -f "/etc/.$Name.ini" ]; then
CekTwo=$(cat /etc/.$Name.ini)
    if [ "$CekOne" = "$CekTwo" ]; then
        res="Expired"
    fi
else
res="Permission Accepted..."
fi
}

PERMISSION () {
    MYIP=$(curl -sS ipv4.icanhazip.com)
    IZIN=$(curl -sS https://raw.githubusercontent.com/bochil132/permission/main/ipmini | awk '{print $4}' | grep $MYIP)
    if [ "$MYIP" = "$IZIN" ]; then
    Bloman
    else
    res="Permission Denied!"
    fi
    BURIQ
}
red='\e[1;31m'
green='\e[1;32m'
NC='\e[0m'
green() { echo -e "\\033[32;1m${*}\\033[0m"; }
red() { echo -e "\\033[31;1m${*}\\033[0m"; }
PERMISSION
if [ -f /home/needupdate ]; then
red "Your script need to update first !"
exit 0
elif [ "$res" = "Permission Accepted..." ]; then
echo -ne
else
red "Permission Denied!"
exit 0
fi
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


#Create Akun SSH & OpenVPN
function buatssh(){
clear
domain=$(cat /etc/xray/domain)
clear
read -p "Username : " Login
read -p "Password : " Pass
read -p "Expired (Days): " masaaktif

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
read -n 1 -s -r -p "Press any key to back on menu"
style-ssh
}

#Renew User SSH & OpenVPN
function renssh(){
clear
read -p "Username : " User
egrep "^$User" /etc/passwd >/dev/null
if [ $? -eq 0 ]; then
read -p "Day Extend : " Days
Today=`date +%s`
Days_Detailed=$(( $Days * 86400 ))
Expire_On=$(($Today + $Days_Detailed))
Expiration=$(date -u --date="1970-01-01 $Expire_On sec GMT" +%Y/%m/%d)
Expiration_Display=$(date -u --date="1970-01-01 $Expire_On sec GMT" '+%d %b %Y')
passwd -u $User
usermod -e  $Expiration $User
egrep "^$User" /etc/passwd >/dev/null
echo -e "$Pass\n$Pass\n"|passwd $User &> /dev/null
clear
echo -e ""
echo -e "========================================"
echo -e "    Username        :  $User"
echo -e "    Days Added      :  $Days Days"
echo -e "    Expires on      :  $Expiration_Display"
echo -e "========================================"
else
clear
echo -e ""
echo -e "======================================"
echo -e "        Username Doesnt Exist        "
echo -e "======================================"
fi
read -n 1 -s -r -p "Press any key to back on menu"
style-ssh
}

#list Member SSH & OpenVPN
function listssh(){
clear
echo -e "---------------------------------------------------"
echo -e "${BLUE}USERNAME          EXP DATE          STATUS${NC}"
echo -e "---------------------------------------------------"
while read expired
do
AKUN="$(echo $expired | cut -d: -f1)"
ID="$(echo $expired | grep -v nobody | cut -d: -f3)"
exp="$(chage -l $AKUN | grep "Account expires" | awk -F": " '{print $2}')"
status="$(passwd -S $AKUN | awk '{print $2}' )"
if [[ $ID -ge 1000 ]]; then
if [[ "$status" = "L" ]]; then
printf "%-17s %2s %-17s %2s \n" "=> $AKUN" "$exp     " "LOCKED"
else
printf "%-17s %2s %-17s %2s \n" "=> $AKUN" "$exp     " "UNLOCKED"
fi
fi
done < /etc/passwd
ttl="$(awk -F: '$3 >= 1000 && $1 != "nobody" {print $1}' /etc/passwd | wc -l)"
echo -e "---------------------------------------------------"
echo -e " Total Account SSH & OpenVPN => $ttl"
echo -e "---------------------------------------------------"
echo -e ""
read -n 1 -s -r -p "Press any key to back on menu"
style-ssh
}

#Cek User Login SSH & OpenVPN
function cekssh(){
clear
echo " "
echo " "

if [ -e "/var/log/auth.log" ]; then
        LOG="/var/log/auth.log";
fi
if [ -e "/var/log/secure" ]; then
        LOG="/var/log/secure";
fi
                
data=( `ps aux | grep -i dropbear | awk '{print $2}'`);
echo "----------=[ Dropbear User Login ]=-----------";
echo "ID  |  Username  |  IP Address";
echo "----------------------------------------------";
cat $LOG | grep -i dropbear | grep -i "Password auth succeeded" > /tmp/login-db.txt;
for PID in "${data[@]}"
do
        cat /tmp/login-db.txt | grep "dropbear\[$PID\]" > /tmp/login-db-pid.txt;
        NUM=`cat /tmp/login-db-pid.txt | wc -l`;
        USER=`cat /tmp/login-db-pid.txt | awk '{print $10}'`;
        IP=`cat /tmp/login-db-pid.txt | awk '{print $12}'`;
        if [ $NUM -eq 1 ]; then
                echo -e "${G}=>${nc} $PID - $USER - $IP";
                fi
done
echo " "
echo "----------=[ OpenSSH User Login ]=------------";
echo "ID  |  Username  |  IP Address";
echo "----------------------------------------------";
cat $LOG | grep -i sshd | grep -i "Accepted password for" > /tmp/login-db.txt
data=( `ps aux | grep "\[priv\]" | sort -k 72 | awk '{print $2}'`);

for PID in "${data[@]}"
do
        cat /tmp/login-db.txt | grep "sshd\[$PID\]" > /tmp/login-db-pid.txt;
        NUM=`cat /tmp/login-db-pid.txt | wc -l`;
        USER=`cat /tmp/login-db-pid.txt | awk '{print $9}'`;
        IP=`cat /tmp/login-db-pid.txt | awk '{print $11}'`;
        if [ $NUM -eq 1 ]; then
                echo -e "${G}=>${nc} $PID - $USER - $IP";
        fi
done
if [ -f "/etc/openvpn/server/openvpn-tcp.log" ]; then
echo ""
echo "---------=[ OpenVPN TCP User Login ]=---------";
echo "Username  |  IP Address  |  Connected";
echo "----------------------------------------------";
        cat /etc/openvpn/server/openvpn-tcp.log | grep -w "^CLIENT_LIST" | cut -d ',' -f 2,3,8 | sed -e 's/,/      /g' > /tmp/vpn-login-tcp.txt
        cat /tmp/vpn-login-tcp.txt
fi
echo "----------------------------------------------";

if [ -f "/etc/openvpn/server/openvpn-udp.log" ]; then
echo " "
echo "---------=[ OpenVPN UDP User Login ]=---------";
echo "Username  |  IP Address  |  Connected";
echo "----------------------------------------------";
        cat /etc/openvpn/server/openvpn-udp.log | grep -w "^CLIENT_LIST" | cut -d ',' -f 2,3,8 | sed -e 's/,/      /g' > /tmp/vpn-login-udp.txt
        cat /tmp/vpn-login-udp.txt
fi
echo "----------------------------------------------";
echo "";
echo -e ""
read -n 1 -s -r -p "Press any key to back on menu"
style-ssh
}

#Ban/Hapus User SSH & OpenVPN
function banssh(){
clear
read -p "Username : " Pengguna

if getent passwd $Pengguna > /dev/null 2>&1; then
        userdel $Pengguna
        echo -e "Username $Pengguna Telah Di Hapus"
else
        echo -e "Failure: Username $Pengguna Tidak Ada"
fi
read -n 1 -s -r -p "Press any key to back on menu"
style-ssh
}

#Create Trial SSH & OpenVPN
function kangtrial(){
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
read -n 1 -s -r -p "Press any key to back on menu"
style-ssh
}

#Hapus All Akun Exp SSH & OpenVPN
function expired(){
clear
               hariini=`date +%d-%m-%Y`
               echo "Thank You For Removing The Expired User"
               echo "--------------------------------------"
               cat /etc/shadow | cut -d: -f1,8 | sed /:$/d > /tmp/expirelist.txt
               totalaccounts=`cat /tmp/expirelist.txt | wc -l`
               for((i=1; i<=$totalaccounts; i++ ))
               do
               tuserval=`head -n $i /tmp/expirelist.txt | tail -n 1`
               username=`echo $tuserval | cut -f1 -d:`
               userexp=`echo $tuserval | cut -f2 -d:`
               userexpireinseconds=$(( $userexp * 86400 ))
               tglexp=`date -d @$userexpireinseconds`             
               tgl=`echo $tglexp |awk -F" " '{print $3}'`
               while [ ${#tgl} -lt 2 ]
               do
               tgl="0"$tgl
               done
               while [ ${#username} -lt 15 ]
               do
               username=$username" " 
               done
               bulantahun=`echo $tglexp |awk -F" " '{print $2,$6}'`
               echo "echo "Expired- User : $username Expire at : $tgl $bulantahun"" >> /usr/local/bin/alluser
               todaystime=`date +%s`
               if [ $userexpireinseconds -ge $todaystime ] ;
               then
		    	:
               else
echo -e "Username   => $username"
echo -e "Expired    => $tgl $bulantahun"
echo -e "Deleted On => $hariini"
               userdel $username
               fi
               done
               echo " "
               echo "--------------------------------------"
               echo "Script Are Succesfully Run"
               echo -e ""
               read -n 1 -s -r -p "Press any key to back on menu"
               style-ssh
}

#MENU SSH & OPENVPN
clear
echo -e "
 ${C}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${nc}
${C}|${nc}           ${P}[ LAYANAN SSH & OPENVPN ]${nc}            ${C}|${nc}
 ${C}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${nc}
  ${R}1.${nc} Create Account Ssh & OpenVPN
  ${R}2.${nc} Renew User Ssh & OpenVPN
  ${R}3.${nc} List Of Member Ssh & OpenVPN
  ${R}4.${nc} Check User Login Ssh & OpenVPN
  ${R}5.${nc} Delete User Ssh & OpenVPN
  ${R}6.${nc} Generate Trial Ssh & OpenVPN
  ${R}7.${nc} Delete User Exp Ssh & OpenVPN
 ${C}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${nc}
 Type ${R}X${nc} to back to main ${G}menu${nc}
 ${C}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${nc}"
echo -e ""
 read -p " Select 1 - 7 => " menu
echo -e   ""
case $menu in
1 )
buatssh
;;
2 )
renssh
;;
3 )
listssh
;;
4 )
cekssh
;;
5 )
banssh
;;
6 )
kangtrial
;;
7 )
expired
;;
X | x )
menu
;;
esac
