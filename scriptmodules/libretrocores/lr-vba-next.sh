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

rp_module_id="lr-vba-next"
rp_module_desc="GBA emulator - VBA-M (optimised) port for libretro"
rp_module_help="ROM Extensions: .gba .zip\n\nCopy your Game Boy Advance roms to $romdir/gba\n\nCopy the required BIOS file gba_bios.bin to $biosdir"
rp_module_licence="GPL2"
rp_module_section="main"
rp_module_flags="!armv6"

function sources_lr-vba-next() {
    gitPullOrClone "$md_build" https://github.com/libretro/vba-next.git
}

function build_lr-vba-next() {
    if isPlatform "sun8i"; then
        make -f Makefile.libretro clean
        make -f Makefile.libretro platform=classic_armv7_a7 ARCH=arm
    elif isPlatform "sun50i"; then
        make -f Makefile.libretro clean
        make -f Makefile.libretro platform=sun50i
    else
        make -f Makefile.libretro clean
        make -f Makefile.libretro
    fi
    md_ret_require="$md_build/vba_next_libretro.so"
}

function install_lr-vba-next() {
    md_ret_files=(
        'vba_next_libretro.so'
    )
}

function configure_lr-vba-next() {
    mkRomDir "gba"
    ensureSystemretroconfig "gba"

    addEmulator 0 "$md_id" "gba" "$md_inst/vba_next_libretro.so"
    addSystem "gba"
}
