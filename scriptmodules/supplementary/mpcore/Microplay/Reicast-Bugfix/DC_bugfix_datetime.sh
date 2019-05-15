#!/bin/bash
if (dialog --title "Dreamcast Date & Time bugfix"  --backtitle "Dreamcast bugfix script" --yes-button "yes" --no-button "no"  --yesno "\nA fix date and time bug. Do you want to proceed?" 10 70) then
	echo "fix bug... this will only take a minute."
	sleep 3
	sudo rm /opt/retropie/configs/dreamcast/data/dc_nvmem.bin
	dialog --title "Dreamcast Date & Time bug fixed" --yes-button "ok" --yesno "\nPlease click OK to reboot the system." 10 70
        sudo reboot
    else
        exit
fi
