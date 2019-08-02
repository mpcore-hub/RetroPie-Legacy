#!/bin/bash

# MPCORE Board-Overlay-Changer v1.0
# powered by microplay.eu

mainfunc() {
	menufunc
}


menufunc() {
	boycmd=(dialog --keep-tite --no-shadow --cr-wrap --keep-window --menu "Board-Overlay-Changer Menu" 22 101 16)

	boyoptions=(
	10 "Alphacore2 One"
	11 "Alphacore2 Two"
	12 "Alphacore2 Plus"
	20 "Orange PI One"
	21 "Orange PI Lite"
	22 "Orange PI PC"
	30 "BPI-M2 ZERO"
	31 "Tritium-H3-1GB"
	32 "R69-H3-1GB"
	99 "Reboot System"
	100 "Exit"
	)

#	boychoices=$("${boycmd[@]}" "${boyoptions[@]}" 2>&1 >/dev/tty)
	boychoices=$("${boycmd[@]}" "${boyoptions[@]}")

for boychoice in $boychoices
do
	case $boychoice in
        10)
			#Alphacore2 One H3-1200Mhz/512MB/Mali-400MP2-600Mhz/LAN
			echo "change Overlay for the Board... this will only take a minute."
			sudo fex2bin /boot/bin/orangepione_p.fex /boot/script.bin
			dialog --keep-tite --no-shadow --cr-wrap --keep-window --infobox "Alphacore2 One is active\nPlease reboot the System!" 5 40
			sleep 4
			mainfunc
			;;
        11)
			#Alphacore2 Two H3-1200Mhz/512MB/Mali-400MP2-600Mhz/WLAN
			echo "change Overlay for the Board... this will only take a minute."
			sudo fex2bin /boot/bin/orangepilite_p.fex /boot/script.bin
			dialog --keep-tite --no-shadow --cr-wrap --keep-window --infobox "Alphacore2 Two is active\nPlease reboot the System!" 5 40
			sleep 4
			mainfunc
			;;
        12)
			#Alphacore2 Plus H3-1536Mhz/1024MB/Mali-400MP2-600Mhz/LAN
			echo "change Overlay for the Board... this will only take a minute."
			sudo fex2bin /boot/bin/orangepipc_p.fex /boot/script.bin
			dialog --keep-tite --no-shadow --cr-wrap --keep-window --infobox "Alphacore2 Plus is active\nPlease reboot the System!" 5 40
			sleep 4
			mainfunc
			;;
        20)
			#Orange PI One H3-1200Mhz/512MB/Mali-400MP2-600Mhz/LAN
			echo "change Overlay for the Board... this will only take a minute."
			sudo fex2bin /boot/bin/orangepione_p.fex /boot/script.bin
			dialog --keep-tite --no-shadow --cr-wrap --keep-window --infobox "Orange PI One is active\nPlease reboot the System!" 5 40
			sleep 4
			mainfunc
			;;
        21)
			#Orange PI Lite H3-1200Mhz/512MB/Mali-400MP2-600Mhz/WLAN
			echo "change Overlay for the Board... this will only take a minute."
			sudo fex2bin /boot/bin/orangepilite_p.fex /boot/script.bin
			dialog --keep-tite --no-shadow --cr-wrap --keep-window --infobox "Orange PI Lite is active\nPlease reboot the System!" 5 40
			sleep 4
			mainfunc
			;;
        22)
			#Orange PI PC H3-1536Mhz/1024MB/Mali-400MP2-600Mhz/LAN
			echo "change Overlay for the Board... this will only take a minute."
			sudo fex2bin /boot/bin/orangepipc_p.fex /boot/script.bin
			dialog --keep-tite --no-shadow --cr-wrap --keep-window --infobox "Orange PI PC is active\nPlease reboot the System!" 5 40
			sleep 4
			mainfunc
			;;
        30)
			#BPI-M2 ZERO H2-1200Mhz/512MB/Mali-400MP2/WLAN
			echo "change Overlay for the Board... this will only take a minute."
			sudo fex2bin /boot/bin/bananapim2zero.fex /boot/script.bin
			dialog --keep-tite --no-shadow --cr-wrap --keep-window --infobox "Orange PI One is active\nPlease reboot the System!" 5 40
			sleep 4
			mainfunc
			;;
        31)
			#Tritium-H3-1GB H3-1296Mhz/1024MB/eMMCx/Mali-400MP2-600Mhz/LAN
			echo "change Overlay for the Board... this will only take a minute."
			sudo fex2bin /boot/bin/tritium-h3.fex /boot/script.bin
			dialog --keep-tite --no-shadow --cr-wrap --keep-window --infobox "Tritium-H3-1GB is active\nPlease reboot the System!" 5 40
			sleep 4
			mainfunc
			;;
        32)
			#R69-H3-1GB H3-1296Mhz/1024MB/8GB-eMMC/Mali-400MP2-600Mhz/LAN/WLAN
			echo "change Overlay for the Board... this will only take a minute."
			sudo fex2bin /boot/bin/r69-h3-1gb.fex /boot/script.bin
			dialog --keep-tite --no-shadow --cr-wrap --keep-window --infobox "R69-H3-1GB is active\nPlease reboot the System!" 5 40
			sleep 4
			mainfunc
			;;
		99)
			echo "...Rebooting System"
			/usr/bin/sudo /sbin/reboot
			;;
		100)
			echo "...Exiting from Board-Overlay-Changer"
			exit 0
			;;
	esac
done

}

mainfunc
