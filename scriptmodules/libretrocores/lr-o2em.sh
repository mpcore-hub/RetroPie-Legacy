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

rp_module_id="lr-o2em"
rp_module_desc="Odyssey 2 / Videopac emu - O2EM port for libretro"
rp_module_help="ROM Extensions: .bin .zip\n\nCopy your Odyssey 2 / Videopac roms to $romdir/videopac\n\nCopy the required BIOS file o2rom.bin to $biosdir"
rp_module_licence="OTHER"
rp_module_section="opt"

function sources_lr-o2em() {
    gitPullOrClone "$md_build" https://github.com/libretro/libretro-o2em
}

function build_lr-o2em() {
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
    md_ret_require="$md_build/o2em_libretro.so"
}

function install_lr-o2em() {
    md_ret_files=(
        'o2em_libretro.so'
        'README.md'
    )
}

function configure_lr-o2em() {
    mkRomDir "videopac"
    ensureSystemretroconfig "videopac"

    addEmulator 1 "$md_id" "videopac" "$md_inst/o2em_libretro.so"
    addSystem "videopac"
}
