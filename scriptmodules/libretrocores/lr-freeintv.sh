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

rp_module_id="lr-freeintv"
rp_module_desc="Intellivision emulator for libretro"
rp_module_help="ROM Extensions: .int .bin\n\nCopy your Intellivision roms to $romdir/intellivision\n\nCopy the required BIOS files exec.bin and grom.bin to $biosdir"
rp_module_licence="GPL3 https://raw.githubusercontent.com/libretro/FreeIntv/master/LICENSE"
rp_module_section="opt"

function sources_lr-freeintv() {
    gitPullOrClone "$md_build" https://github.com/libretro/FreeIntv.git
}

function build_lr-freeintv() {
    if isPlatform "sun8i"; then
        make clean
        make platform=classic_armv7_a7 ARCH=arm
    elif isPlatform "sun50i"; then
        make clean
        make platform=sun50i
    else
        make clean
        make
    fi
    md_ret_require="$md_build/freeintv_libretro.so"
}

function install_lr-freeintv() {
    md_ret_files=(
        'freeintv_libretro.so'
        'LICENSE'
        'README.md'
    )
}

function configure_lr-freeintv() {
    mkRomDir "intellivision"
    ensureSystemretroconfig "intellivision"

    addEmulator 1 "$md_id" "intellivision" "$md_inst/freeintv_libretro.so"
    addSystem "intellivision"
}
