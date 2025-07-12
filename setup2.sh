#!/usr/bin/bash

####################
### Highlighting ###
####################

RESET="\033[0m"

BLACK="\033[0;30m"
RED="\033[0;31m"
GREEN="\033[0;32m"
YELLOW="\033[0;33m"
BLUE="\033[0;34m"
PURPLE="\033[0;35m"
CYAN="\033[0;36m"
WHITE="\033[0;37m"

BOLD_BLACK="\033[1;30m"
BOLD_RED="\033[1;31m"
BOLD_GREEN="\033[1;32m"
BOLD_YELLOW="\033[1;33m"
BOLD_BLUE="\033[1;34m"
BOLD_PURPLE="\033[1;35m"
BOLD_CYAN="\033[1;36m"
BOLD_WHITE="\033[1;37m"

BG_BLACK="\033[40m"
BG_RED="\033[41m"
BG_GREEN="\033[42m"
BG_YELLOW="\033[43m"
BG_BLUE="\033[44m"
BG_PURPLE="\033[45m"
BG_CYAN="\033[46m"
BG_WHITE="\033[47m"

#######################
### Local variables ###
#######################

FEDORA_VERSION=$(sudo cat /etc/fedora-release)

########################
### Helper functions ###
########################

# Function for spinner, the first arguement is the pid of the previous command
spinner() {
    local i=0
    local spin=('⠋' '⠙' '⠹' '⠸' '⠼' '⠴' '⠦' '⠧' '⠇' '⠏')
    local spin_charset_length=${#spin[@]}
    while kill -0 $1 2>/dev/null
    do
        i=$(( (i+1)%spin_charset_length))
        printf "\r${spin[$i]}"
        sleep .05
    done
}


#######################
### Welcome message ###
#######################

echo -e "\n${CYAN}Welcome to leminhohoho's Asahi linux minimal setup!\nVersion:${FEDORA_VERSION}${RESET}\n"
echo -e "\n${YELLOW}This script is intented for myself at first, so there might be things that won't work for your cases, so please read the source code for this script first before executing it${RESET}\n"
echo -e "\n${YELLOW}WARNING: this script is not intended for production environment, only for personal stuff${RESET}\n"

enter=" "
count=0

while [ "$enter" != "" ]
do
    if [[ $count -lt 5 ]]; then
        echo -e "${GREEN}Please press enter to continue${RESET}"
    elif [[ $count -lt 10 ]]; then
        echo -e "${GREEN}Please please why don't you press enter ?${RESET}"
    elif [[ $count -lt 15 ]]; then
        echo -e "${GREEN}For god sake press the GOD DAMN ENTER !!!${RESET}"
    elif [[ $count -lt 20 ]]; then
        echo -e "${GREEN}Just press Ctrl-C if you don't want to proceed please ${RESET}"
    else
        echo -e "${GREEN}Fuck you ${RESET}"
        exit 1
    fi

    read -n 1 -s -r -p "" enter </dev/tty
    ((count++))
done

###################
### Wifi set up ###
###################

function choose_wifi() {
    echo "List of available network"
    sleep 0.1s &
    nmcli device wifi list &
    spinner $!
    read -p "Enter the name of the wifi to connect to: " wifi </dev/tty
	nmcli device wifi connect "$wifi" --ask
}

echo -e "${PURPLE}Setting up wifi${RESET}"

wifi_setup() {
    # Checking if network is connected 
    if ping -c1 -w1 1.1.1.1 >/dev/null 2>&1; then
        echo "Already connected to the internet, do you want to continue or manually setup the wifi again ?"
        echo -e "c: continue\ne: go to wifi setup"
        while [ "$command" != "c" ] && [ "$command" != "e" ]
        do
            read -p "[c/e]: " command </dev/tty
        done

        if [ "$command" == "e" ]; then
            choose_wifi
        fi
    else
        choose_wifi
    fi
}

wifi_setup
