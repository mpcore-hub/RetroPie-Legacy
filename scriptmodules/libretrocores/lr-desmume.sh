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

rp_module_id="lr-desmume"
rp_module_desc="NDS emu - DESMUME"
rp_module_help="ROM Extensions: .nds .zip\n\nCopy your Nintendo DS roms to $romdir/nds"
rp_module_licence="GPL2 https://raw.githubusercontent.com/libretro/desmume/master/desmume/COPYING"
rp_module_section="exp"

function depends_lr-desmume() {
    getDepends libpcap-dev
}

function sources_lr-desmume() {
    gitPullOrClone "$md_build" https://github.com/libretro/desmume.git
}

function build_lr-desmume() {
    cd desmume/src/frontend/libretro
    if isPlatform "sun8i"; then
        make -f Makefile.libretro clean
        make -f Makefile.libretro platform=armvhardfloat
    elif isPlatform "sun50i"; then
        make -f Makefile.libretro clean
        make -f Makefile.libretro platform=armvhardfloat
    else
        make -f Makefile.libretro clean
        make -f Makefile.libretro
    fi
    md_ret_require="$md_build/desmume/src/frontend/libretro/desmume_libretro.so"
}

function install_lr-desmume() {
    md_ret_files=(
        'desmume/src/frontend/libretro/desmume_libretro.so'
    )
}

function configure_lr-desmume() {
    mkRomDir "nds"
    ensureSystemretroconfig "nds"

    addEmulator 0 "$md_id" "nds" "$md_inst/desmume_libretro.so"
    addSystem "nds"
}
