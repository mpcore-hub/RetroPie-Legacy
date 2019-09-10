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

rp_module_id="lr-flycast"
rp_module_desc="Dreamcast emulator - Reicast port for libretro"
rp_module_help="Previously named lr-reicast then lr-beetle-dc\n\nDreamcast ROM Extensions: .cdi .gdi .chd, Naomi/Atomiswave ROM Extension: .zip\n\nCopy your Dreamcast/Naomi roms to $romdir/dreamcast\n\nCopy the required Dreamcast BIOS files dc_boot.bin and dc_flash.bin to $biosdir/dc\n\nCopy the required Naomi/Atomiswave BIOS files naomi.zip and awbios.zip to $biosdir/dc"
rp_module_licence="GPL2 https://raw.githubusercontent.com/libretro/flycast/master/LICENSE"
rp_module_section="exp"

function _update_hook_lr-flycast() {
    renameModule "lr-reicast" "lr-beetle-dc"
    renameModule "lr-beetle-dc" "lr-flycast"
}

function sources_lr-flycast() {
    gitPullOrClone "$md_build" https://github.com/libretro/flycast.git
    # don't override our C/CXXFLAGS
sed -i "/^C.*FLAGS.*:=/d" Makefile
}

function build_lr-flycast() {
    if isPlatform "sun8i"; then
        make clean
        make platform=sun8i ARCH=arm
    elif isPlatform "sun50i"; then
        make clean
        make platform=sun50i ARCH=arm
    else
        make clean
        make
    fi
    md_ret_require="$md_build/flycast_libretro.so"
}

function install_lr-flycast() {
    md_ret_files=(
        'flycast_libretro.so'
        'LICENSE'
    )
}


function configure_lr-flycast() {    
    # bios
    mkUserDir "$biosdir/dc"
    
    local system
        for system in atomiswave dreamcast naomi; do
            mkRomDir "$system"
            ensureSystemretroconfig "$system"
            iniConfig " = " "" "$configdir/$system/retroarch.cfg"
            iniSet "video_shared_context" "true"
            addEmulator 1 "$md_id" "$system" "$md_inst/flycast_libretro.so </dev/null"
            addSystem "$system"
    done
    
#    # temp fix
#    sed -i -e 's:/opt/retropie/emulators/retroarch/bin/retroarch:/opt/retropie/emulators/retroarch/bin/retroarch < /dev/null :g' "$configdir/atomiswave/emulators.cfg"
#    sed -i -e 's:/opt/retropie/emulators/retroarch/bin/retroarch:/opt/retropie/emulators/retroarch/bin/retroarch < /dev/null :g' "$configdir/dreamcast/emulators.cfg"
#    sed -i -e 's:/opt/retropie/emulators/retroarch/bin/retroarch:/opt/retropie/emulators/retroarch/bin/retroarch < /dev/null :g' "$configdir/naomi/emulators.cfg"

    # set core options
    setRetroArchCoreOption "${dir_name}reicast_allow_service_buttons" "enabled"
    setRetroArchCoreOption "${dir_name}reicast_alpha_sorting" "per-triangle (normal)"
    setRetroArchCoreOption "${dir_name}reicast_analog_stick_deadzone" "15%"
    setRetroArchCoreOption "${dir_name}reicast_boot_to_bios" "disabled"
    setRetroArchCoreOption "${dir_name}reicast_broadcast" "NTSC"
    setRetroArchCoreOption "${dir_name}reicast_cable_type" "TV (RGB)"
    setRetroArchCoreOption "${dir_name}reicast_cpu_mode" "dynamic_recompiler"
    setRetroArchCoreOption "${dir_name}reicast_delay_frame_swapping" "disabled"
    setRetroArchCoreOption "${dir_name}reicast_digital_triggers" "disabled"
    setRetroArchCoreOption "${dir_name}reicast_div_matching" "auto"
    setRetroArchCoreOption "${dir_name}reicast_enable_dsp" "disabled"
    setRetroArchCoreOption "${dir_name}reicast_enable_purupuru" "enabled"
    setRetroArchCoreOption "${dir_name}reicast_enable_rtt" "disabled"
    setRetroArchCoreOption "${dir_name}reicast_enable_rttb" "disabled"
    setRetroArchCoreOption "${dir_name}reicast_framerate" "fullspeed"
    setRetroArchCoreOption "${dir_name}reicast_gdrom_fast_loading" "disabled"
    setRetroArchCoreOption "${dir_name}reicast_hle_bios" "disabled"
    setRetroArchCoreOption "${dir_name}reicast_internal_resolution" "640x480"
    setRetroArchCoreOption "${dir_name}reicast_mipmapping" "enabled"
    setRetroArchCoreOption "${dir_name}reicast_region" "USA"
    setRetroArchCoreOption "${dir_name}reicast_render_to_texture_upscaling" "1x"
    setRetroArchCoreOption "${dir_name}reicast_screen_rotation" "horizontal"
    setRetroArchCoreOption "${dir_name}reicast_synchronous_rendering" "enabled"
    setRetroArchCoreOption "${dir_name}reicast_system" "auto"
    setRetroArchCoreOption "${dir_name}reicast_texupscale" "off"
    setRetroArchCoreOption "${dir_name}reicast_texupscale_max_filtered_texture_size" "1024"
    setRetroArchCoreOption "${dir_name}reicast_threaded_rendering" "enabled"
    setRetroArchCoreOption "${dir_name}reicast_trigger_deadzone" "0%"
    setRetroArchCoreOption "${dir_name}reicast_vmu1_pixel_off_color" "DEFAULT_OFF 01"
    setRetroArchCoreOption "${dir_name}reicast_vmu1_pixel_on_color" "DEFAULT_ON 00"
    setRetroArchCoreOption "${dir_name}reicast_vmu1_screen_display" "disabled"
    setRetroArchCoreOption "${dir_name}reicast_vmu1_screen_opacity" "100%"
    setRetroArchCoreOption "${dir_name}reicast_vmu1_screen_position" "Upper Left"
    setRetroArchCoreOption "${dir_name}reicast_vmu1_screen_size_mult" "1x"
    setRetroArchCoreOption "${dir_name}reicast_vmu2_pixel_off_color" "DEFAULT_OFF 01"
    setRetroArchCoreOption "${dir_name}reicast_vmu2_pixel_on_color" "DEFAULT_ON 00"
    setRetroArchCoreOption "${dir_name}reicast_vmu2_screen_display" "disabled"
    setRetroArchCoreOption "${dir_name}reicast_vmu2_screen_opacity" "100%"
    setRetroArchCoreOption "${dir_name}reicast_vmu2_screen_position" "Upper Left"
    setRetroArchCoreOption "${dir_name}reicast_vmu2_screen_size_mult" "1x"
    setRetroArchCoreOption "${dir_name}reicast_vmu3_pixel_off_color" "DEFAULT_OFF 01"
    setRetroArchCoreOption "${dir_name}reicast_vmu3_pixel_on_color" "DEFAULT_ON 00"
    setRetroArchCoreOption "${dir_name}reicast_vmu3_screen_display" "disabled"
    setRetroArchCoreOption "${dir_name}reicast_vmu3_screen_opacity" "100%"
    setRetroArchCoreOption "${dir_name}reicast_vmu3_screen_position" "Upper Left"
    setRetroArchCoreOption "${dir_name}reicast_vmu3_screen_size_mult" "1x"
    setRetroArchCoreOption "${dir_name}reicast_vmu4_pixel_off_color" "DEFAULT_OFF 01"
    setRetroArchCoreOption "${dir_name}reicast_vmu4_pixel_on_color" "DEFAULT_ON 00"
    setRetroArchCoreOption "${dir_name}reicast_vmu4_screen_display" "disabled"
    setRetroArchCoreOption "${dir_name}reicast_vmu4_screen_opacity" "100%"
    setRetroArchCoreOption "${dir_name}reicast_vmu4_screen_position" "Upper Left"
    setRetroArchCoreOption "${dir_name}reicast_vmu4_screen_size_mult" "1x"
    setRetroArchCoreOption "${dir_name}reicast_volume_modifier_enable" "enabled"
    setRetroArchCoreOption "${dir_name}reicast_widescreen_hack" "disabled"
}
