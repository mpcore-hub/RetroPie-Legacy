#!/usr/bin/env bash

# This file is part of The Microplay Project 
# based on The RetroPie Project
#
# only for sun8i, sun50i (like Allwinner H2+/H3/A64/H5)
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="microplay"
rp_module_desc="Microplay NXT-Base"
rp_module_section="config"

function depends_microplay() {
    getDepends mc
}

function gui_microplay() {
    while true; do
        local options=(
            1 "update mpcore-nxt base"
            2 "reset BG-Music to default"
            3 "update OS"
            4 "activate ES-Systems fullview"
        )
        local cmd=(dialog --default-item "$default" --backtitle "$__backtitle" --menu "Choose an option" 22 76 16)
        local choice=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
        default="$choice"
        [[ -z "$choice" ]] && break
        case "$choice" in
            1)
				#mpcore-nxt base v1.4	
				echo "install & update mpcore-nxt base"
				echo "#################################"
				echo "*check the packages"
				echo "*starting the installation"
				echo "#################################"
				#remove old System for upgrade
				echo "remove old System for upgrade"
                rm -rf "$datadir/retropiemenu/icons"
		        rm -rf "/home/pi/RetrOrangePi"
		        rm -rf "/etc/splash-full.png"
		        rm -rf "/etc/splash-slim.png"
				#install retropiemenu iconset
				echo "install retropiemenu iconset"
                cp -rf "$scriptdir/scriptmodules/supplementary/retropiemenu/icons_nes" "$datadir/retropiemenu/icons"
				#install retropiemenu gamelist
				echo "install retropiemenu gamelist"
                cp -rf "$scriptdir/scriptmodules/supplementary/mpcore/retropiemenu_gamelist/." "/opt/retropie/configs/all/emulationstation/gamelists/retropie"		
				#install mpcore data
				echo "install mpcore data"
                cp -rf "$scriptdir/scriptmodules/supplementary/mpcore/Microplay/." "$datadir/retropiemenu/Microplay"
				#install tekcommand_png runcommand images
				echo "install tekcommand_png runcommand images"
                cp -rf "$scriptdir/scriptmodules/supplementary/mpcore/tekcommand_png/." "/opt/retropie/"
				#install Screensaver images
				echo "#install Screensaver images"
                cp -rf "$scriptdir/scriptmodules/supplementary/mpcore/Screensaver/." "/opt/retropie/configs/all/emulationstation"
				#install Splashscreens images and sounds
				echo "#install Splashscreens images and sounds"
                cp -rf "$scriptdir/scriptmodules/supplementary/mpcore/splashscreens/." "/home/pi/RetroPie/splashscreens"
				chmod 755 /home/pi/RetroPie/splashscreens/*
				#install Splashscreen list
				echo "#install Splashscreen list"
                cp -rf "$scriptdir/scriptmodules/supplementary/mpcore/splashscreenlist/splashscreen.list" "/etc/splashscreen.list"
				chmod 755 "/etc/splashscreen.list"
				#install update and backup es-systems config
				echo "install update and backup es-systems config"
				mv -f "/etc/emulationstation/es_systems.cfg" "/etc/emulationstation/es_systems.bkup"
                cp -rf "$scriptdir/scriptmodules/supplementary/mpcore/es_systems/." "/etc/emulationstation"
				chmod 755 "/etc/emulationstation/es_systems.cfg"
				#install Emulationstation system logo
				echo "install Emulationstation system logo"
				mv -f "/opt/retropie/supplementary/emulationstation/resources/splash.svg" "/opt/retropie/supplementary/emulationstation/resources/splash.svg.bkup"
                cp -rf "$scriptdir/scriptmodules/supplementary/mpcore/ES-Splashscreen/splash.svg" "/opt/retropie/supplementary/emulationstation/resources/splash.svg"
				chmod 755 "/opt/retropie/supplementary/emulationstation/resources/splash.svg"
				#install ES Audio-Fix
				echo "install ES Audio-Fix"
				mv -f "/opt/retropie/configs/all/emulationstation/es_settings.cfg" "/opt/retropie/configs/all/emulationstation/es_settings.cfg.bkup"
                cp -rf "$scriptdir/scriptmodules/supplementary/mpcore/ES-Audiofix/." "/opt/retropie/configs/all/emulationstation/"
				chmod 755 "/opt/retropie/configs/all/emulationstation/es_settings.cfg"
				#install BGM-Script in Autostart
				echo "install BGM-Script in Autostart"
				mv -f "/opt/retropie/configs/all/autostart.sh" "/opt/retropie/configs/all/autostart.sh.bkup"
                cp -rf "$scriptdir/scriptmodules/supplementary/mpcore/BGM/autostart.sh" "/opt/retropie/configs/all/autostart.sh"
				chmod 755 "/opt/retropie/configs/all/autostart.sh"
				#copy boot and bios files
				echo "copy boot and bios files"
                cp -rf "$scriptdir/scriptmodules/supplementary/mpcore/boot/." "/boot"
				#install motd logo file
				echo "install motd logo file"
                cp -rf "$scriptdir/scriptmodules/supplementary/mpcore/motd_logo/." "/etc/update-motd.d"
				#install system UpdateSource
				echo "install system UpdateSource"
                cp -rf "$scriptdir/scriptmodules/supplementary/mpcore/system_source/." "/etc/apt"
				#change access
				echo "change access"
                chown -cR pi:pi "/etc/emulationstation"
                chown -cR pi:pi "/opt/retropie"
                chown -cR pi:pi "/home/pi/RetroPie"
                chown -cR pi:pi "/home/pi/RetroPie-Setup"
				#finish
				echo "mpcore-nxt installation successful"

                printMsgs "dialog" "mpcore-nxt base updated\n\nRestart System to apply."
                ;;
            2)
				#set BGM to default
				echo "set BGM to default"
                rm -r /home/pi/RetroPie/music/*
                cp -rf "$scriptdir/scriptmodules/supplementary/mpcore/music/." "/home/pi/RetroPie/music"
                chown -cR pi:pi "/home/pi/RetroPie/music"
				chmod 755 /home/pi/RetroPie/music/*
                printMsgs "dialog" "Background-Music set to default-set."
                ;;
            3)
				#update OS
				echo "update OS"
				apt-get update && apt-get upgrade -y
                printMsgs "dialog" "OS updated\n\nRestart System to apply."
                ;;
            4)
				#install es_systems full list
				echo "install es_systems full list"
				mv -f "/etc/emulationstation/es_systems.cfg" "/etc/emulationstation/es_systems.bkup"
                cp -rf "$scriptdir/scriptmodules/supplementary/mpcore/es_systems/Full/." "/etc/emulationstation"
				chmod 755 "/etc/emulationstation/es_systems.cfg"
                printMsgs "dialog" "ES-Systems list updated\n\nRestart System to apply."
                ;;
        esac
    done
}
