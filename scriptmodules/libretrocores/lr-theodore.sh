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

rp_module_id="lr-theodore"
rp_module_desc="Libretro core for Thomson MO/TO emulation / Core Libretro pour l'émulation des ordinateurs Thomson MO/TO."
rp_module_help="Place roms in $romdir/thomson/"
rp_module_licence="GPL3 https://raw.githubusercontent.com/Zlika/theodore/master/LICENSE"
rp_module_section="exp"

function sources_lr-theodore() {
    gitPullOrClone "$md_build" https://github.com/Zlika/theodore.git
}

function build_lr-theodore() {
    make clean
	make
    md_ret_require="$md_build/theodore_libretro.so"
} 	
	
function install_lr-theodore() {
    md_ret_files=(
        'theodore_libretro.so'
         )
}

function configure_lr-theodore() {
    mkRomDir "thomson"
    ensureSystemretroconfig "thomson"

    addEmulator 1 "$md_id" "thomson" "$md_inst/theodore_libretro.so"
    addSystem "thomson"
}