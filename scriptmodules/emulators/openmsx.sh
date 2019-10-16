#!/usr/bin/env bash

# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="openmsx"
rp_module_desc="MSX emulator OpenMSX"
rp_module_help="ROM Extensions: .rom .mx1 .mx2 .col .dsk .zip\n\nCopy your MSX/MSX2 games to $romdir/msx"
rp_module_licence="GPL2 https://raw.githubusercontent.com/openMSX/openMSX/master/doc/GPL.txt"
rp_module_section="opt"
rp_module_flags=""

function depends_openmsx() {
    getDepends libsdl1.2-dev libsdl-ttf2.0-dev libglew-dev libao-dev libogg-dev libtheora-dev libxml2-dev libvorbis-dev tcl-dev
}

function sources_openmsx() {
    gitPullOrClone "$md_build" https://github.com/openMSX/openMSX.git
    sed -i "s|INSTALL_BASE:=/opt/openMSX|INSTALL_BASE:=$md_inst|" build/custom.mk
    sed -i "s|SYMLINK_FOR_BINARY:=true|SYMLINK_FOR_BINARY:=false|" build/custom.mk
}

function build_openmsx() {
    rpSwap on  2000
    ./configure
    make clean
    make -j2
    rpSwap off
    md_ret_require="$md_build/derived/openmsx"
}

function install_openmsx() {
    make install
    mkdir -p "$md_inst/share/systemroms/"
    downloadAndExtract "$__archive_url/openmsxroms.tar.gz" "$md_inst/share/systemroms/"
}

function configure_openmsx() {
    mkRomDir "msx"
    mkRomDir "msx2"
	mkRomDir "msx2p"
	mkRomDir "msxtr"
	mkRomDir "spectravideo"
    mkRomDir "coleco"
    
    # copy basic QJOYPAD layout - enable gamepad support
    cp -p $md_data/openmsx.lyt /home/pi/.qjoypad3/

    # copy run script with needed parameters + Qjoypad support
    cp -p $md_data/openmsx.sh $md_conf_root/msx/
    addEmulator 0 "$md_id" "msx" "$md_inst/bin/openmsx %ROM%"
    addSystem "msx"
    addEmulator 0 "$md_id" "msx2" "$md_inst/bin/openmsx %ROM%"
    addSystem "msx2"
	addEmulator 0 "$md_id" "msx2p" "$md_inst/bin/openmsx %ROM%"
    addSystem "msx2p"
	addEmulator 0 "$md_id" "msxtr" "$md_inst/bin/openmsx %ROM%"
    addSystem "msxtr"
	addEmulator 0 "$md_id" "spectravideo" "$md_inst/bin/openmsx %ROM%"
    addSystem "spectravideo"
    addEmulator 0 "$md_id" "coleco" "$md_inst/bin/openmsx -machine ColecoVision_SGM %ROM%"
    addSystem "coleco"
    ln -sfn "$biosdir/COLECO.ROM" "$md_inst/share/systemroms/COLECO.ROM"
}
