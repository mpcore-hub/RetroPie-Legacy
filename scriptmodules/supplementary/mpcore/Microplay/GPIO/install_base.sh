#!/bin/bash

#module GPIO for Orangepi

red=`tput setaf 1`
green=`tput setaf 2`
yellow=`tput setaf 3`
reset=`tput sgr0`
fundo=`tput setab 7`

echo "${green} ${fundo} ## ${welcome_message} ## ${reset}"

echo "${yellow}Installing python-dev python-pip gcc...${reset}"
sudo apt-get -y install python-dev python-pip gcc

echo "${yellow}Installing evdev...${reset}"
sudo pip install evdev

echo "${yellow}Installing uinput...${reset}"
sudo pip install python-uinput

if [ -f /lib/systemd/system/tz_gpio.service ]; then
	echo "${yellow} SERVICE Found ${reset}"
	echo "${yellow} Removing the service... ${reset}"

	sudo systemctl stop tz_gpio.service
	sudo systemctl disable tz_gpio.service
	sudo rm /lib/systemd/system/tz_gpio.service
	sudo systemctl daemon-reload
	sudo systemctl reset-failed
fi

echo "${green} copying files... ${reset}"

sudo cp -avr /home/pi/RetroPie/retropiemenu/Microplay/GPIO/tz_gpio.service /lib/systemd/system
sudo sed -i "s/DRIVER_NAME/${driver_name}/g" /lib/systemd/system/tz_gpio.service
sudo chmod 644 /lib/systemd/system/tz_gpio.service
sudo systemctl enable tz_gpio.service

echo "${yellow}Installing GPIO for OrangePi...${reset}"
pushd /home/pi/RetroPie/retropiemenu/Microplay/GPIO/orangepi_PC_gpio_pyH3-master
sudo python setup.py install
popd

#check uinput
File=/etc/modules
if grep -q "uinput" "$File"; then
	echo "${green} uinput OK ${reset}"
else
	echo "${red} ${fundo} ADD the line uinput in the /etc/modules ${reset}"
fi

if grep -q "#uinput" "$File"; then
	echo "${red} ${fundo} UNCOMENT the line uinput in the /etc/modules ${reset}"
fi

echo "${green} ALL OK, reboot and enjoy ${reset}"
