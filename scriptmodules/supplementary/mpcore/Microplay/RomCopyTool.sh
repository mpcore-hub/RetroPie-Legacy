#!/bin/bash

# MPCORE RomCopyTool v1.0 
# set permissions - chmod +x RomCopyTool.sh

mainfunc() {
	menufunc
}

mountfunc() {
	/usr/bin/sudo /bin/umount /media > /dev/null 2>&1

	MOUNT=$(/usr/bin/sudo /bin/mount /dev/sda1 /media -o uid=pi,gid=pi> /dev/null 2>&1)
	MOUNTEC=$?

	if [ $MOUNTEC -eq 0 ]; then
		dialog --keep-tite --no-shadow --cr-wrap --keep-window --infobox "Successfully mounted the USB drive \n\n...Please wait" 5 40
		sleep 4
		return
	else
		dialog --keep-tite --no-shadow --cr-wrap --keep-window --infobox "Unable to mount USB drive \n\n...Exiting" 5 40
		sleep 4
		exit 1
	fi
}

umountfunc() {
	UMOUNT=$(/usr/bin/sudo /bin/umount /media > /dev/null 2>&1)
	UMOUNTEC=$?

	if [ $UMOUNTEC -eq 0 ]; then
		dialog --keep-tite --no-shadow --cr-wrap --keep-window --infobox "Successfully unmounted the USB drive \n\n...Please wait" 5 40
		sleep 4
		return
	else
		dialog --keep-tite --no-shadow --cr-wrap --keep-window --infobox "Unable to unmount USB drive \n\n...Exiting" 5 40
		sleep 4
		exit 1
	fi
}

menufunc() {
	rcbkup="/media/rcbackup"
	rcmcmd=(dialog --keep-tite --no-shadow --cr-wrap --keep-window --menu "RomCopyTool Menu System (Insert USB Drive Now)" 22 101 16)

	rcmoptions=(
	1 "Create Rom-folders on USB"
	2 "Copy Roms from USB to PI"
	3 "Backup your roms to USB"
	4 "Restore Roms backup from USB"
	99 "Reboot System"
	100 "Exit"
	)

	rcmchoices=$("${rcmcmd[@]}" "${rcmoptions[@]}" 2>&1 >/dev/tty)

for rcmchoice in $rcmchoices
do
	case $rcmchoice in
                1)
                        mountfunc
			dialog --keep-tite --no-shadow --cr-wrap --keep-window --infobox "Creating Rom-folder structure\n\n...Please wait" 5 40
			sleep 4
			ARRROMDIR=($(/bin/ls -1 /home/pi/RetroPie/roms))
			/bin/mkdir -p /media/retropie/roms &>/dev/null
			/bin/mkdir /media/retropie/BIOS &>/dev/null
			for romdir in "${ARRROMDIR[@]}"
			do
				/bin/mkdir /media/retropie/roms/$romdir &>/dev/null
			done
			umountfunc
			dialog --keep-tite --no-shadow --cr-wrap --keep-window --infobox "Creation of rom folder structure is complete\n\nPlug the USB drive into your PC\n\nYou will see retropie/roms and retropie/BIOS\n\ncopy your roms and bios files to these locations and then reinsert and choose option 2" 10 80
			sleep 12
			mainfunc
			;;
		2)
			mountfunc
			if [ ! -d "/media/retropie/roms" ] && [ ! -d "/media/retropie/BIOS" ]; then
				umountfunc
                                dialog --keep-tite --no-shadow --cr-wrap --keep-window --infobox "ERROR: retropie/rom retropie/BIOS folders not fonund on USB drive\n\nRun option 1 first\n\n...Exiting" 10 80
                                sleep 8
                                mainfunc
			fi
			ARRROMSRC=(/media/retropie/roms/*/*)
			ROMDST="/home/pi/RetroPie/roms/"
			BIOSDST="/home/pi/RetroPie/BIOS/"
			dialog --keep-tite --no-shadow --cr-wrap --title "Rom copy" --gauge "Copying rom files..." 15 80 < <(
				nr=${#ARRROMSRC[*]};
				ir=0
				for fromsrc in "${ARRROMSRC[@]}"
				do
					fromdst=$(echo $fromsrc | sed s+media/retropie+home/pi/RetroPie+)
					PCTROM=$(( 100*(++ir)/nr ))
cat <<EOF
XXX
$PCTROM
Copying rom \
\n\nSRC: "$fromsrc" \
\n\nDST: "$fromdst"
XXX
EOF
					/bin/cp "$fromsrc" "$fromdst" &>/dev/null
				done
			)
			/bin/chown -R pi.pi $ROMDST
			dialog --keep-tite --no-shadow --cr-wrap --keep-window --infobox "Rom copy complete.\n\n...Please wait" 5 40
			sleep 4

                        ARRBIOSSRC=(/media/retropie/BIOS/*)
                        BIOSDST="/home/pi/RetroPie/BIOS/"
                        dialog --keep-tite --no-shadow --cr-wrap --title "BIOS-Files copy" --gauge "Copying BIOS files..." 15 80 < <(
                                nb=${#ARRBIOSSRC[*]};
                                ib=0

                                for fbiossrc in "${ARRBIOSSRC[@]}"
                                do
                                        fbiosdst=$(echo $fbiossrc | sed s+media/retropie+home/pi/RetroPie+)
                                        PCTBIOS=$(( 100*(++ib)/nb ))
cat <<EOF
XXX
$PCTBIOS
Copying bios \
\n\nSRC: "$fbiossrc" \
\n\nDST: "$fbiosdst"
XXX
EOF
                                        /bin/cp -R "$fbiossrc" "$fbiosdst" &>/dev/null
                                done
                        )

                        /bin/chown -R pi.pi $BIOSDST
                        umountfunc
                        dialog --keep-tite --no-shadow --cr-wrap --keep-window --infobox "BIOS-Files copy complete.\n\n...Please wait" 5 40
                        sleep 4
			dialog --keep-tite --no-shadow --cr-wrap --keep-window --infobox "It is recommended you reboot your device from the RomCopyTool menu\nfor the new roms to become available" 5 40
			sleep 8
			mainfunc
			;;
		3)
			mountfunc
			/bin/mkdir "$rcbkup" > /dev/null 2>&1
			dialog --keep-tite --no-shadow --cr-wrap --keep-window --infobox "Backing up data to USB\n\n...Please wait" 10 80
			echo "0" | dialog --keep-tite --no-shadow --cr-wrap --keep-window --gauge "Backup in progress \n\n/home/pi/RetroPie/roms\n\n...Please wait" 10 80 0
			cd /home/pi/RetroPie/
			/bin/tar cfz "$rcbkup"/roms.tar.gz ./roms
			echo "33" | dialog --keep-tite --no-shadow --cr-wrap --keep-window --gauge "Backup in progress \n\n/home/pi/RetroPie/BIOS\n\n...Please wait" 10 80 0
			cd /home/pi/RetroPie/
			/bin/tar cfz "$rcbkup"/bios.tar.gz ./BIOS
                        echo "75" | dialog --keep-tite --no-shadow --cr-wrap --keep-window --gauge "Backup in progress \n\n/opt/retropie/configs/all/emulationstation/downloaded)images\n\n...Please wait" 10 80 0
			cd /opt/retropie/configs/all/emulationstation/
			/bin/tar cfz "$rcbkup"/downloaded_images.tar.gz ./downloaded_images
			echo "99" | dialog --keep-tite --no-shadow --cr-wrap --keep-window --gauge "Backup in progress \n\n/opt/retropie/configs/all/emulationstation/gamelists\n\n...Please wait" 10 80 0
			cd /opt/retropie/configs/all/emulationstation/
			/bin/tar cfz "$rcbkup"/gamelists.tar.gz ./gamelists
			if [ -f "$rcbkup"/roms.tar.gz ] && [ -f "$rcbkup"/downloaded_images.tar.gz ] && [ -f "$rcbkup"/gamelists.tar.gz ] && [ -f "$rcbkup"/bios.tar.gz ]; then
				umountfunc
	            		echo "100" | dialog --keep-tite --no-shadow --cr-wrap --keep-window --gauge "Backup roms to USB complete" 10 80 0
				sleep 4
				mainfunc
			else
				umountfunc
				dialog --keep-tite --no-shadow --cr-wrap --keep-window --infobox "ERROR: Backup to USB failed" 10 80 0
				sleep 4
				mainfunc
			fi
			;;
		4)
			mountfunc
			if [ -f "$rcbkup"/roms.tar.gz ] && [ -f "$rcbkup"/downloaded_images.tar.gz ] && [ -f "$rcbkup"/gamelists.tar.gz ] && [ -f "$rcbkup"/bios.tar.gz ]; then
				(pv -n "$rcbkup"/roms.tar.gz | tar xzf - -C /home/pi/RetroPie/ ) 2>&1 | dialog --keep-tite --no-shadow --cr-wrap --keep-window --gauge "Restore in progress \n\n/home/pi/RetroPie/roms\n\n...Please wait" 10 80 0
				(pv -n "$rcbkup"/bios.tar.gz | tar xzf - -C /home/pi/RetroPie/ ) 2>&1 | dialog --keep-tite --no-shadow --cr-wrap --keep-window --gauge "Restore in progress \n\n/home/pi/RetroPie/BIOS\n\n...Please wait" 10 80 0
				(pv -n "$rcbkup"/downloaded_images.tar.gz | tar xzf - -C /opt/retropie/configs/all/emulationstation/ ) 2>&1 | dialog --keep-tite --no-shadow --cr-wrap --keep-window --gauge "Restore in progress \n\n/opt/retropie/configs/all/emulationstation/downloaded)images\n\n...Please wait" 10 80 0
				(pv -n "$rcbkup"/gamelists.tar.gz | tar xzf - -C /opt/retropie/configs/all/emulationstation/ ) 2>&1 | dialog --keep-tite --no-shadow --cr-wrap --keep-window --gauge "Restore in progress \n\n/opt/retropie/configs/all/emulationstation/gamelists\n\n...Please wait" 10 80 0
				umountfunc
				dialog --keep-tite --no-shadow --cr-wrap --keep-window --infobox "Restore of Rom-Data successful\n\nReboot to complete\n\n...Exiting" 10 80
				sleep 4
				mainfunc
			else
				umountfunc
				dialog --keep-tite --no-shadow --cr-wrap --keep-window --infobox "ERROR: Backup rom data does not exist on USB drive\n\n...Exiting" 10 80
				sleep 4
				mainfunc
			fi
			;;
		99)
			echo "...Rebooting System"
			/usr/bin/sudo /sbin/reboot
			;;
		100)
			echo "...Exit"
			exit 0
			;;
	esac
done

}

mainfunc
