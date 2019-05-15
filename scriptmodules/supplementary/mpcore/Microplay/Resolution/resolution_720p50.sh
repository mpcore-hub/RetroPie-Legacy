#!/bin/bash
if (dialog --title "Changing resolution"  --backtitle "RetrOrangePi Resolution script" --yes-button "yes" --no-button "no"  --yesno "\nA Changing resolution too 720p 50Hz. Do you want to proceed?" 10 70) then
	echo "Changing resolution... this will only take a minute."
	sleep 3
	sudo h3disp -m 720p50
	dialog --title "resolution changed" --yes-button "ok" --yesno "\nPlease click OK to reboot the system." 10 70
        sudo reboot
    else
        exit
fi
