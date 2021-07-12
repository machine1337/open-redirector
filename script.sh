#!/bin/bash
NC='\033[0m'
RED='\033[1;38;5;196m'
GREEN='\033[1;38;5;040m'
ORANGE='\033[1;38;5;202m'
BLUE='\033[1;38;5;012m'
BLUE2='\033[1;38;5;032m'
PINK='\033[1;38;5;013m'
GRAY='\033[1;38;5;004m'
NEW='\033[1;38;5;154m'
YELLOW='\033[1;38;5;214m'
CG='\033[1;38;5;087m'
CP='\033[1;38;5;221m'
CPO='\033[1;38;5;205m'
CN='\033[1;38;5;247m'
CNC='\033[1;38;5;051m'

function banner(){
echo -e ${RED}"##############################################################################"
echo -e ${CP}"        _   _       ____          _ _               _                        #"
echo -e ${CP}"       | | | |     |  _ \ ___  __| / |_ __ ___  ___| |_ ___  _ __            #"
echo -e ${CP}"       | | | |_____| |_) / _ \/ _  | | '__/ _ \/ __| __/ _ \|  __|           #"
echo -e ${CP}"       | |_| |_____|  _ <  __/ (_| | | | |  __/ (__| || (_) | |              #"
echo -e ${CP}"        \___/      |_| \_\___|\__,_|_|_|  \___|\___|\__\___/|_|              #"
echo -e  ${PINK}"                 A FrameWork For Scanning Open Redirection                   #"
echo -e ${BLUE}"                 https://facebook.com/unknownclay                            #"
echo -e ${YELLOW}"                 Coded By: Machine404                                        #"
echo -e ${CP}"                 https://github.com/machine1337                              #"
echo -e ${RED}"###############################################################################"
            
}
sleep 1
echo -e ${CP}"[+] Checking Internet Connectivity"
if [[ "$(ping -c 1 8.8.8.8 | grep '100% packet loss' )" != "" ]]; then
  echo "No Internet Connection"
  exit 1
  else
  echo "Internet is present"
  
fi

function red_url(){
clear
banner
echo -e -n ${BLUE}"\n[+] Enter domain name (e.g https://target.com/) : "
read domain
echo -e -n ${BLUE}"\n[+] Enter path of payloads list:  "
read list
sleep 1
echo -e ${CNC}"\n[+] Searching For Open Redirection"
for i in $(cat $list); do
file=$(curl -s -m5 -I $domain$i)
echo -n -e ${YELLOW}"\nURL: $domain" >> output.txt
echo "$file" >> output.txt
if grep -q 302   <<<"$file"
  then
  echo -n -e ${RED}"\nURL: $domain ${CP}"[Payload $i]" ${RED}[Vulnerable]\n"
  cat output.txt | grep   -e  URL  -e evil | sed 's/\=.*/=/'  >> vulnerable_url.txt
  rm output.txt
  else
  echo -n -e ${GREEN}"\nURL: $domain  [Not Vulnerable]\n"
   rm output.txt
 fi
 done
}
function red_mass(){
clear
banner
echo -n -e ${PINK}"\n[+]Enter target urls list (e.g https://target.com) : "
read urls
echo -n -e ${PINK}"\n[+]Enter path of payloads list : "
read pay
sleep 1
echo -e ${CNC}"\n[+] Searching For Open redirection"

for i in $(cat $urls ); do
for j in $(cat $pay); do
     file=$(curl  -s -m5 -I  $i$j)  
     
    echo -n -e ${YELLOW}"URL: $i" >> output.txt
    echo "$file" >> output.txt
    
    if grep -q  302  <<<"$file"
  then
  
  echo  -e ${RED}"\nURL: $i ${CP}"[Payload $j]"${RED}[Vulnerable]\n"
  cat output.txt | grep -e URL -e evil | sed 's/\=.*/=/'  >> vulnerable_urls.txt
  rm output.txt
  else
  echo -n -e ${GREEN}"\nURL: $i  [Not Vulnerable]"
   rm output.txt
 
fi
done
done
}
trap ctrl_c INT
ctrl_c() {
clear
echo -e ${RED}"[*] (Ctrl + C ) Detected, Trying To Exit... "
echo -e ${RED}"[*] Stopping Services... "
sleep 1
echo ""
echo -e ${YELLOW}"[*] Thanks For Using Open Redirector  :)"
exit
}
menu()
{
clear
banner
echo -e ${YELLOW}"\n[*] Which Type of Scan u want to Perform\n "
echo -e "  ${NC}[${CG}"1"${NC}]${CNC} Single domain Scan"
echo -e "  ${NC}[${CG}"2"${NC}]${CNC} List of domains"
echo -e "  ${NC}[${CG}"3"${NC}]${CNC} Exit"

echo -n -e ${YELLOW}"\n[+] Select: "
        read redi_play
                if [ $redi_play -eq 1 ]; then
                        red_url
                elif [ $redi_play -eq 2 ]; then
                        red_mass
                elif [ $redi_play -eq 3 ]; then
                      exit
                fi
}
menu
#coded By Machine404, Don't copy this code without giving me credit.
