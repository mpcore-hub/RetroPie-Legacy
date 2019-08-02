#!/bin/bash

# MPCORE Bugfixer v1.0
# powered by microplay.eu

mainfunc() {
	menufunc
}


menufunc() {
	bfx_cmd=(dialog --keep-tite --no-shadow --cr-wrap --keep-window --menu "Bugfixer Menu" 22 101 16)

	bfx_options=(
	1 "Reicast Systemmanager bugfix"
	2 "Reicast Date-Time bugfix"
	99 "Reboot System"
	100 "Exit"
	)

	bfx_choices=$("${bfx_cmd[@]}" "${bfx_options[@]}" 2>&1 >/dev/tty)

for bfx_choice in $bfx_choices
do
	case $bfx_choice in
        1)
			#Reicast Systemmanager bugfix
			echo "fixing the Bug... this will only take a minute."
			sleep 3
			sudo ln -sv fileThatDoesNotExist ~/RetroPie/roms/dreamcast/systemManager.cdi
			dialog --keep-tite --no-shadow --cr-wrap --keep-window --infobox "Reicast Systemmanager bug fixed\nPlease reboot the System!" 5 40
			sleep 4
			mainfunc
			;;
        2)
			#Reicast Date-Time bugfix
			echo "fixing the Bug... this will only take a minute."
			sleep 3
			sudo rm /opt/retropie/configs/dreamcast/data/dc_nvmem.bin
			dialog --keep-tite --no-shadow --cr-wrap --keep-window --infobox "Reicast Date-Time bug fixed\nPlease reboot the System!" 5 40
			sleep 4
			mainfunc
			;;
		99)
			echo "...Rebooting System"
			/usr/bin/sudo /sbin/reboot
			;;
		100)
			echo "...Exiting from Bugfixer-Tool"
			exit 0
			;;
	esac
done

}

mainfunc
