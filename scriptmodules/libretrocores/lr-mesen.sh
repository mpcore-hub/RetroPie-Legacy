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

rp_module_id="lr-mesen"
rp_module_desc="NES and Famicom emulator - Mesen Port for libretro"
rp_module_help="ROM Extensions: .nes .zip\n\nCopy your NES roms to $romdir/nes and your Famicon roms to $romdir/fds"
rp_module_licence="GPL3"
rp_module_section="exp"
rp_module_flags=""

function depends_lr-mesen() {
    local depends=()
    getDepends "${depends[@]}"
}

function sources_lr-mesen() {
    gitPullOrClone "$md_build" "https://github.com/retrontology/Mesen" "platform_armv7"
}

function build_lr-mesen() {
    make clean
    MESENPLATFORM=armv7 make libretro -j2

    md_ret_require="$md_build/mesen_libretro.so"
}

function install_lr-mesen() {
    md_ret_files=(
        'mesen_libretro.so'
    )
}


function configure_lr-mesen() {
    mkRomDir "nes"
    mkRomDir "fds"
    mkRomDir "famicom"
    ensureSystemretroconfig "nes"
    ensureSystemretroconfig "fds"
    ensureSystemretroconfig "famicom"

    addEmulator 1 "$md_id" "fds" "$md_inst/mesen_libretro.so"
    addEmulator 1 "$md_id" "famicom" "$md_inst/mesen_libretro.so"
    addEmulator 0 "$md_id" "nes" "$md_inst/mesen_libretro.so"
    addSystem "nes"
    addSystem "fds"
    addSystem "famicom"
}

