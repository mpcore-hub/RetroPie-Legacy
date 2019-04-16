#!/usr/bin/env bash

# This file is only for sun8i (like Allwinner H2+/H3)
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="lr-mupen64plus-nx"
rp_module_desc="N64 emu - Highly modified Mupen64Plus port for libretro"
rp_module_help="ROM Extensions: .z64 .n64 .v64\n\nCopy your N64 roms to $romdir/n64"
rp_module_licence="GPL3 https://raw.githubusercontent.com/libretro/mupen64plus-libretro-nx/mupen_next/LICENSE"
rp_module_section="exp"
rp_module_flags=""

function sources_lr-mupen64plus-nx() {
	gitPullOrClone "$md_build" https://github.com/libretro/mupen64plus-libretro-nx.git GLideN64
}

function build_lr-mupen64plus-nx() {
    rpSwap on 1000
    make clean
    local params=()
    if isPlatform "H3-mali"; then
        params+=(CPUFLAGS="-DNO_ASM -DARM -D__arm__ -DARM_ASM -D__NEON_OPT -DNOSSE")
        params+=(GLES=1 HAVE_NEON=1 WITH_DYNAREC=arm)
        params+=(GL_LIB:=-lGLESv2)
    else
        exit
    fi
    make -j2 "${params[@]}"
    rpSwap off
    md_ret_require="$md_build/mupen64plus_next_libretro.so"
}

function install_lr-mupen64plus-nx() {
    md_ret_files=(
        'mupen64plus_next_libretro.so'
        'README.md'
    )
}

#function install_bin_lr-mupen64plus-nx() {
#    downloadAndExtract "$__gitbins_url/lr-mupen64plus-nx.tar.gz" "$md_inst" 1
#}

function configure_lr-mupen64plus-nx() {
    mkRomDir "n64"
    ensureSystemretroconfig "n64"

    addEmulator 0 "$md_id" "n64" "$md_inst/mupen64plus_next_libretro.so"
    addSystem "n64"
}
