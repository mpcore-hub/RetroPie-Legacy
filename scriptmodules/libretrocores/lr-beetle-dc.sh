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

rp_module_id="lr-beetle-dc"
rp_module_desc="Dreamcast emu - beetle-dc for libretro"
rp_module_help="Dreamcast ROM Extensions: .cdi .gdi .chd (chdman v5)\nAtomiswave/Naomi ROM Extensions: .bin .dat .zip (Mame 0.198+)\n\nCopy ROM files to:\n$romdir/dreamcast\n$romdir/atomiswave\n$romdir/naomi\n\nCopy BIOS files to: $biosdir/dc\ndc_boot.bin, dc_flash.bin, airlbios.zip, awbios.zip, f355bios.zip, f355dlx.zip, hod2bios.zip, naomi.zip\n\nCheck http://bit.do/lr-beetle-dc for more information."
rp_module_licence="GPL2 https://raw.githubusercontent.com/libretro/beetle-dc/master/LICENSE"
rp_module_section="exp"

#function _update_hook_lr-beetle-dc() {
    # move from old location and update emulators.cfg
#    renameModule "lr-reicast" "lr-beetle-dc"
#}

function sources_lr-beetle-dc() {
    gitPullOrClone "$md_build" https://github.com/libretro/beetle-dc.git
}

function build_lr-beetle-dc() {
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
    md_ret_require="$md_build/beetledc_libretro.so"
}

function install_lr-beetle-dc() {
    md_ret_files=(
        'beetledc_libretro.so'
    )
}


function configure_lr-beetle-dc() {    
    # bios
    mkUserDir "$biosdir/dc"
    
    local system
    for system in atomiswave dreamcast naomi; do
        mkRomDir "$system"
        ensureSystemretroconfig "$system"
        iniConfig " = " "" "$configdir/$system/retroarch.cfg"
        iniSet "video_shared_context" "true"
        iniSet "video_smooth" "true"
        addEmulator 1 "$md_id" "$system" "$md_inst/beetledc_libretro.so"
        addSystem "$system"
    done
    
    # temp fix
    sed -i -e 's:/opt/retropie/emulators/retroarch/bin/retroarch:/opt/retropie/emulators/retroarch/bin/retroarch < /dev/null :g' "$configdir/atomiswave/emulators.cfg"
    sed -i -e 's:/opt/retropie/emulators/retroarch/bin/retroarch:/opt/retropie/emulators/retroarch/bin/retroarch < /dev/null :g' "$configdir/dreamcast/emulators.cfg"
    sed -i -e 's:/opt/retropie/emulators/retroarch/bin/retroarch:/opt/retropie/emulators/retroarch/bin/retroarch < /dev/null :g' "$configdir/naomi/emulators.cfg"

    # set core options
    setRetroArchCoreOption "${dir_name}beetledc_allow_service_buttons" "enabled"
    setRetroArchCoreOption "${dir_name}beetledc_alpha_sorting" "per-triangle (normal)"
    setRetroArchCoreOption "${dir_name}beetledc_analog_stick_deadzone" "15%"
    setRetroArchCoreOption "${dir_name}beetledc_audio_buffer_size" "1024"
    setRetroArchCoreOption "${dir_name}beetledc_boot_to_bios" "disabled"
    setRetroArchCoreOption "${dir_name}beetledc_broadcast" "NTSC"
    setRetroArchCoreOption "${dir_name}beetledc_cable_type" "TV (RGB)"
    setRetroArchCoreOption "${dir_name}beetledc_cpu_mode" "dynamic_recompiler"
    setRetroArchCoreOption "${dir_name}beetledc_digital_triggers" "disabled"
    setRetroArchCoreOption "${dir_name}beetledc_div_matching" "auto"
    setRetroArchCoreOption "${dir_name}beetledc_enable_dsp" "disabled"
    setRetroArchCoreOption "${dir_name}beetledc_enable_purupuru" "enabled"
    setRetroArchCoreOption "${dir_name}beetledc_enable_rtt" "disabled"
    setRetroArchCoreOption "${dir_name}beetledc_enable_rttb" "disabled"
    setRetroArchCoreOption "${dir_name}beetledc_extra_depth_scale" "disabled"
    setRetroArchCoreOption "${dir_name}beetledc_framerate" "fullspeed"
    setRetroArchCoreOption "${dir_name}beetledc_gdrom_fast_loading" "disabled"
    setRetroArchCoreOption "${dir_name}beetledc_internal_resolution" "640x480"
    setRetroArchCoreOption "${dir_name}beetledc_mipmapping" "disabled"
    setRetroArchCoreOption "${dir_name}beetledc_region" "USA"
    setRetroArchCoreOption "${dir_name}beetledc_render_to_texture_upscaling" "1x"
    setRetroArchCoreOption "${dir_name}beetledc_screen_rotation" "horizontal"
    setRetroArchCoreOption "${dir_name}beetledc_synchronous_rendering" "enabled"
    setRetroArchCoreOption "${dir_name}beetledc_system" "auto"
    setRetroArchCoreOption "${dir_name}beetledc_texupscale" "off"
    setRetroArchCoreOption "${dir_name}beetledc_texupscale_max_filtered_texture_size" "256"
    setRetroArchCoreOption "${dir_name}beetledc_threaded_rendering" "enabled"
    setRetroArchCoreOption "${dir_name}beetledc_trigger_deadzone" "0%"
    setRetroArchCoreOption "${dir_name}beetledc_vmu1_pixel_off_color" "DEFAULT_OFF 01"
    setRetroArchCoreOption "${dir_name}beetledc_vmu1_pixel_on_color" "DEFAULT_ON 00"
    setRetroArchCoreOption "${dir_name}beetledc_vmu1_screen_display" "disabled"
    setRetroArchCoreOption "${dir_name}beetledc_vmu1_screen_opacity" "100%"
    setRetroArchCoreOption "${dir_name}beetledc_vmu1_screen_position" "Upper Left"
    setRetroArchCoreOption "${dir_name}beetledc_vmu1_screen_size_mult" "1x"
    setRetroArchCoreOption "${dir_name}beetledc_vmu2_pixel_off_color" "DEFAULT_OFF 01"
    setRetroArchCoreOption "${dir_name}beetledc_vmu2_pixel_on_color" "DEFAULT_ON 00"
    setRetroArchCoreOption "${dir_name}beetledc_vmu2_screen_display" "disabled"
    setRetroArchCoreOption "${dir_name}beetledc_vmu2_screen_opacity" "100%"
    setRetroArchCoreOption "${dir_name}beetledc_vmu2_screen_position" "Upper Left"
    setRetroArchCoreOption "${dir_name}beetledc_vmu2_screen_size_mult" "1x"
    setRetroArchCoreOption "${dir_name}beetledc_vmu3_pixel_off_color" "DEFAULT_OFF 01"
    setRetroArchCoreOption "${dir_name}beetledc_vmu3_pixel_on_color" "DEFAULT_ON 00"
    setRetroArchCoreOption "${dir_name}beetledc_vmu3_screen_display" "disabled"
    setRetroArchCoreOption "${dir_name}beetledc_vmu3_screen_opacity" "100%"
    setRetroArchCoreOption "${dir_name}beetledc_vmu3_screen_position" "Upper Left"
    setRetroArchCoreOption "${dir_name}beetledc_vmu3_screen_size_mult" "1x"
    setRetroArchCoreOption "${dir_name}beetledc_vmu4_pixel_off_color" "DEFAULT_OFF 01"
    setRetroArchCoreOption "${dir_name}beetledc_vmu4_pixel_on_color" "DEFAULT_ON 00"
    setRetroArchCoreOption "${dir_name}beetledc_vmu4_screen_display" "disabled"
    setRetroArchCoreOption "${dir_name}beetledc_vmu4_screen_opacity" "100%"
    setRetroArchCoreOption "${dir_name}beetledc_vmu4_screen_position" "Upper Left"
    setRetroArchCoreOption "${dir_name}beetledc_vmu4_screen_size_mult" "1x"
    setRetroArchCoreOption "${dir_name}beetledc_volume_modifier_enable" "enabled"
    setRetroArchCoreOption "${dir_name}beetledc_widescreen_hack" "disabled"
}
