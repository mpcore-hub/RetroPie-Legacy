#!/bin/bash

# MPCORE Resolution-Changer v1.0
# powered by microplay.eu

mainfunc() {
	menufunc
}


menufunc() {
	rec_cmd=(dialog --keep-tite --no-shadow --cr-wrap --keep-window --menu "Resolution-Changer Menu" 22 101 16)

	rec_options=(
	1 "HDMI 720p_50Hz"
	2 "HDMI 720p_60Hz"
	3 "HDMI 1080i_50Hz"
	4 "HDMI 1080i_60Hz"
	5 "HDMI 1080p_50Hz"
	6 "HDMI 1080p_60Hz"
	7 "DVI 480p"	
	8 "DVI 720p_60Hz"
	9 "DVI 1080p_60Hz"
	99 "Reboot System"
	100 "Exit"
	)

#	rec_choices=$("${rec_cmd[@]}" "${rec_options[@]}" 2>&1 >/dev/tty)
	rec_choices=$("${rec_cmd[@]}" "${rec_options[@]}")

for rec_choice in $rec_choices
do
	case $rec_choice in
        1)
			#HDMI 720p_50Hz
			echo "change Display-Resolution... this will only take a minute."
			sudo h3disp -m 720p50
			dialog --keep-tite --no-shadow --cr-wrap --keep-window --infobox "Resolution HDMI_720p_50Hz is active\nPlease reboot the System!" 5 40
			sleep 4
			mainfunc
			;;
        2)
			#HDMI 720p_60Hz
			echo "change Display-Resolution... this will only take a minute."
			sudo h3disp -m 720p60
			dialog --keep-tite --no-shadow --cr-wrap --keep-window --infobox "Resolution HDMI_720p_60Hz is active\nPlease reboot the System!" 5 40
			sleep 4
			mainfunc
			;;
        3)
			#HDMI 1080i_50Hz
			echo "change Display-Resolution... this will only take a minute."
			sudo h3disp -m 1080i50
			dialog --keep-tite --no-shadow --cr-wrap --keep-window --infobox "Resolution HDMI_1080i_50Hz is active\nPlease reboot the System!" 5 40
			sleep 4
			mainfunc
			;;
        4)
			#HDMI 1080i_60Hz
			echo "change Display-Resolution... this will only take a minute."
			sudo h3disp -m 1080i60
			dialog --keep-tite --no-shadow --cr-wrap --keep-window --infobox "Resolution HDMI_1080i_60Hz is active\nPlease reboot the System!" 5 40
			sleep 4
			mainfunc
			;;
        5)
			#HDMI 1080p_50Hz
			echo "change Display-Resolution... this will only take a minute."
			sudo h3disp -m 1080p50
			dialog --keep-tite --no-shadow --cr-wrap --keep-window --infobox "Resolution HDMI_1080p_50Hz is active\nPlease reboot the System!" 5 40
			sleep 4
			mainfunc
			;;
        6)
			#HDMI 1080p_60Hz
			echo "change Display-Resolution... this will only take a minute."
			sudo h3disp -m 1080p60
			dialog --keep-tite --no-shadow --cr-wrap --keep-window --infobox "Resolution HDMI_1080p_60Hz is active\nPlease reboot the System!" 5 40
			sleep 4
			mainfunc
			;;
        7)
			#DVI 480p
			echo "change Display-Resolution... this will only take a minute."
			sudo h3disp -m 480p -d
			dialog --keep-tite --no-shadow --cr-wrap --keep-window --infobox "Resolution DVI_480p is active\nPlease reboot the System!" 5 40
			sleep 4
			mainfunc
			;;
        8)
			#DVI 720p_60Hz
			echo "change Display-Resolution... this will only take a minute."
			sudo h3disp -m 720p60 -d
			dialog --keep-tite --no-shadow --cr-wrap --keep-window --infobox "Resolution DVI_720p_60Hz is active\nPlease reboot the System!" 5 40
			sleep 4
			mainfunc
			;;
        9)
			#DVI 1080p_60Hz
			echo "change Display-Resolution... this will only take a minute."
			sudo h3disp -m 1080p60 -d
			dialog --keep-tite --no-shadow --cr-wrap --keep-window --infobox "Resolution DVI_1080p_60Hz is active\nPlease reboot the System!" 5 40
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
