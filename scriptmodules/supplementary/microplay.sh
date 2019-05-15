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
rp_module_desc="Microplay base script"
rp_module_section="config"

function depends_microplay() {
    getDepends mc
}

function gui_microplay() {
    while true; do
        local options=(
            1 "update mpcore base"
        )
        local cmd=(dialog --default-item "$default" --backtitle "$__backtitle" --menu "Choose an option" 22 76 16)
        local choice=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
        default="$choice"
        [[ -z "$choice" ]] && break
        case "$choice" in
            1)
				#change access
                chown -cR pi:pi "/etc/emulationstation"
                chown -cR pi:pi "/opt/retropie"
                chown -cR pi:pi "/home/pi/RetroPie"
                chown -cR pi:pi "/home/pi/RetroPie-Setup"
				#remove old System
                rm -rf "$datadir/retropiemenu/icons"
		        rm -rf "/home/pi/RetrOrangePi"
		        rm -rf "/home/pi/RetroPie/retropiemenu/RetrOrangePi"
				#install retropiemenu iconset
                cp -rf "$scriptdir/scriptmodules/supplementary/retropiemenu/icons_nes" "$datadir/retropiemenu/icons"
                chown -R pi:pi "$datadir/retropiemenu/icons"
				#install retropiemenu gamelist
                cp -rf "$scriptdir/scriptmodules/supplementary/mpcore/retropiemenu_gamelist/*" "/opt/retropie/configs/all/emulationstation/gamelists/retropie"		
				#install mpcore data
                cp -rf "$scriptdir/scriptmodules/supplementary/mpcore/Microplay/*" "$datadir/retropiemenu/Microplay"
                chown -R pi:pi "$datadir/retropiemenu/Microplay"


                printMsgs "dialog" "Microplay-Core Base updated\n\nRestart System to apply."
                ;;
        esac
    done
}
