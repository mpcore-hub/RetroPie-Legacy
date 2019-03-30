#!/usr/bin/env bash

# This file is only for sun8i (like Allwinner H2+/H3)
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="yabause"
rp_module_desc="Sega Saturn Emulator"
rp_module_help="ROM Extensions: .iso .bin .zip\n\nCopy your Sega Saturn roms to $romdir/saturn\n\nCopy the required BIOS file saturn_bios_us.bin and saturn_bios_jp.bin to $biosdir"
rp_module_licence="https://github.com/devmiyax/yabause/blob/minimum_linux/yabause/COPYING"
rp_module_section="exp"

function depends_yabause() {
    local depends=(libboost-filesystem-dev libboost-system-dev libboost-locale-dev libboost-date-time-dev)
    getDepends "${depends[@]}"
}

function install_bin_yabause() {
    downloadAndExtract "https://github.com/mpcore2/archiv/raw/master/emulators/yabause.tar.gz" "$md_inst" 1
}

function configure_yabause() {
    mkRomDir "saturn"
    addEmulator 1 "${md_id}-1x" "saturn" "$md_inst/yabasanshiro -a -nf -r 3 -b /home/pigaming/RetroArena/BIOS/saturn_bios.bin -i %ROM%"
    addEmulator 1 "${md_id}-2x" "saturn" "$md_inst/yabasanshiro -a -nf -r 2 -b /home/pigaming/RetroArena/BIOS/saturn_bios.bin -i %ROM%"
    addEmulator 1 "${md_id}-3x" "saturn" "$md_inst/yabasanshiro -a -nf -r 1 -b /home/pigaming/RetroArena/BIOS/saturn_bios.bin -i %ROM%"
    addSystem "saturn"
}
