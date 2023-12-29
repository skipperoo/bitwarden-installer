#!/bin/bash

RED="\x1b[31m"
GREEN="\x1b[32m"
YELLOW="\x1b[33m"
BLUE="\x1b[34m"
MAGENTA="\x1b[35m"
CYAN="\x1b[36m"
RESET="\x1b[0m"
RESET_N="\x1b[0m\n"
SCREEN="\033[2J\033[H"

dir=$(pwd)
atexit() {
	cd $dir
	echo "Done!"
	echo -e "\nTotal time elapsed -> ${CYAN}${TIME_ELAPSED}s${RESET}"

}
TIME_ELAPSED=0

calc() { awk "BEGIN{ printf \"%.2f\n\", $* }"; }

spin() {
    PID=$!
    i=1

    # sp="|/-\\"
    # the animation below is fancier but not univerally supported
    sp="⣷⣯⣟⡿⢿⣻⣽⣾"
    echo -n ' '
    START=$(date +"%s.%2N")
    NOW=$(date +"%s.%2N")
    DELTA=$(calc $NOW-$START)
    printf "\b${sp:i++%${#sp}:1} ${CYAN}${DELTA}${RESET}s"
    while [ -d /proc/$PID ]
    do
        DELETE_STR="${DELTA}s"
    	for j in $(seq 0 ${#DELETE_STR})
        do
            echo -ne "\b"
        done
        NOW=$(date +"%s.%2N")
        DELTA=$(calc $NOW-$START)
        printf "\b${sp:i++%${#sp}:1} ${CYAN}${DELTA}s${RESET}"
        sleep 0.06
    done
    DELETE_STR="${DELTA}s"
    for j in $(seq 0 ${#DELETE_STR})
    do
        echo -ne "\b"
    done
    echo -ne "\b"

    wait $PID
    if [[ "$?" == "0" ]]
    then
        echo -e "${GREEN}ok$RESET ${CYAN}${DELTA}s${RESET}"
    else
        echo -e "${RED}error$RESET"
    fi
    TIME_ELAPSED=$(calc $TIME_ELAPSED + $DELTA)
}

if [[ "${EUID}" != 0 ]]
then
	SUDO=sudo
	echo "Running as sudo..."
fi

trap atexit EXIT
set -e
$SUDO mkdir -p /opt/bitwarden
cd /opt/bitwarden
echo -ne "Downloading icon...\t\t"
$SUDO wget 'https://raw.githubusercontent.com/bitwarden/brand/e755957e1ae5b84521a4a2491b791e743936af1a/icons/128x128.png' -O bitwarden.png &> /dev/null &
spin
echo -ne "Downloading ${MAGENTA}AppImage${RESET}...\t\t"
$SUDO wget 'https://vault.bitwarden.com/download/?app=desktop&platform=linux' -O bitwarden.AppImage &> /dev/null &
spin
echo -ne "Setting permissions...\t\t"
$SUDO chmod 755 /opt/bitwarden/bitwarden.AppImage && $SUDO chmod 744 /opt/bitwarden/bitwarden.png &> /dev/null &
spin
echo -ne "Creating ${YELLOW}.desktop${RESET} launcher...\t"

cat << EOF | sudo tee /usr/share/applications/Bitwarden.desktop &> /dev/null &
[Desktop Entry]
Version=1.0
Icon=/opt/bitwarden/bitwarden.png
Terminal=false
Type=Application
Name=Bitwarden
Exec=/opt/bitwarden/bitwarden.AppImage

EOF
spin
$SUDO chmod 744 /usr/share/applications/Bitwarden.desktop

