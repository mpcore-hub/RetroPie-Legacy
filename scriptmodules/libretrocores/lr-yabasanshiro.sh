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


function install_bin_lr-yabasanshiro() {
    downloadAndExtract "https://github.com/mpcore2/archiv/raw/master/libretro/lr-yabasanshiro.tar.gz" "$md_inst" 1
}

function configure_lr-yabasanshiro() {    
    mkRomDir "saturn"
    ensureSystemretroconfig "saturn"
    addEmulator 1 "$md_id" "saturn" "$md_inst/yabasanshiro_libretro.so"
    addSystem "saturn"
    
    # set core options
    setRetroArchCoreOption "${dir_name}yabasanshiro_addon_cart" "4M_extended_ram"
    setRetroArchCoreOption "${dir_name}yabasanshiro_force_hle_bios" "disabled"
    setRetroArchCoreOption "${dir_name}yabasanshiro_frameskip" "enabled"
    setRetroArchCoreOption "${dir_name}yabasanshiro_multitap_port1" "disabled"
    setRetroArchCoreOption "${dir_name}yabasanshiro_multitap_port2" "disabled"
    setRetroArchCoreOption "${dir_name}yabasanshiro_resolution_mode" "2x"
    setRetroArchCoreOption "${dir_name}yabasanshiro_videoformattype" "NTSC"
}
