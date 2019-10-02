MPCORE-HUB (RetroPie-Setup)
========================

<img src="https://raw.githubusercontent.com/mpcore-hub/RetroPie-Setup/nxt-legacy/scriptmodules/supplementary/mpcore/splashscreens/mpnxt-splashscreen.png" width="320" height="180"><img src="https://raw.githubusercontent.com/mpcore-hub/RetroPie-Setup/nxt-legacy/scriptmodules/supplementary/retropiemenu/icons_nes/mpcore.png" width="180" height="180"><img src="https://raw.githubusercontent.com/mpcore-hub/RetroPie-Setup/nxt-legacy/scriptmodules/supplementary/mpcore/tekcommand_png/configs/nes/launching.png" width="300" height="160">

This complet custom RetroPie fork for MPCORE(Microplay-Core) is optimized for use on Armbian/Debian legacy 32Bit with Microplay AlphaCore2 One/Two/Plus SBC or the most Allwinner sun7i, sun8i, sun50i SBCs like Orange PIs, Banana PIs, Tritium H3

## General Usage


Shell script to setup Allwinner A20/A64/H2+/H3/H5 SBC on Armbian/Debian with many emulators and games, using EmulationStation as the graphical front end. Based on the RetroPie Basic Script see on GitHub (RetroPie) or via website at https://retropie.org.uk


To run the RetroPie Setup Script make sure that your APT repositories are up-to-date and that Git is installed:

```shell
sudo apt-get update
sudo apt-get dist-upgrade
sudo apt-get install git
```

Then you can download the latest mpcore-nxt RetroPie setup script with

```shell
cd
git clone --depth=1 https://github.com/mpcore-hub/RetroPie-Setup.git
```

The script is executed with 

```shell
cd RetroPie-Setup
sudo ./retropie_setup.sh
```

When you first run the script it may install some additional packages that are needed.


# Microplay Guides


You can find useful information and guides on the mpcore-library(https://github.com/mpcore-hub/mpcore-library/tree/nxt-legacy/Guides)
