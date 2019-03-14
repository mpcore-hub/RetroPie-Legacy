#!/usr/bin/env bash

# This file is only for sun8i (like Allwinner H2+/H3)
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="lr-yabasanshiro"
rp_module_desc="Sega Saturn Emulator"
rp_module_help="ROM Extensions: .iso .bin .zip\n\nCopy your Sega Saturn roms to $romdir/saturn\n\nCopy the required BIOS file saturn_bios_us.bin and saturn_bios_jp.bin to $biosdir"
rp_module_licence="https://github.com/devmiyax/yabause/blob/minimum_linux/yabause/COPYING"
rp_module_section="exp"
rp_module_flags="!armv6"

function sources_lr-yabasanshiro() {
    gitPullOrClone "$md_build" https://github.com/microplay/yabause.git libretro
    cd "$md_build/yabause"
}

function build_lr-yabasanshiro() {
    make -C yabause/src/libretro generate-files
    make -j2 -C yabause/src/libretro platform=sun8i

    md_ret_require="$md_build/yabause/src/libretro/yabasanshiro_libretro.so"
}

function install_lr-yabasanshiro() {
    md_ret_files=(
        'yabause/src/libretro/yabasanshiro_libretro.so'
    )
}


function configure_lr-yabasanshiro() {    
    mkRomDir "saturn"
    ensureSystemretroconfig "saturn"
    addEmulator 1 "$md_id" "saturn" "$md_inst/yabasanshiro_libretro.so"
    addSystem "saturn"
}
