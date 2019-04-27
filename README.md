MPCORE-NXT - RetroPie-Setup
========================


## General Usage


Shell script to setup Allwinner H2+/H3 SBC on Armbian/Debian with many emulators and games, using EmulationStation as the graphical front end. Based on the RetroPie Basic Script see on GitHub (RetroPie) or via website at https://retropie.org.uk

This script is optimized for use on Armbian/Debian with Orange PI Lite/One/PC/PC Plus/Zero, Tritium H2/H3, Banana Pi M2+/Zero SBC

To run the RetroPie Setup Script make sure that your APT repositories are up-to-date and that Git is installed:

```shell
sudo apt-get update
sudo apt-get dist-upgrade
sudo apt-get install git
```

Then you can download the latest mpcore2 RetroPie setup script with

```shell
cd
git clone --depth=1 https://github.com/mpcore-nxt/RetroPie-Setup.git
```

The script is executed with 

```shell
cd RetroPie-Setup
sudo ./retropie_setup.sh
```

When you first run the script it may install some additional packages that are needed.


# Basic Wiki


You can find useful information about several components or for several frequently asked questions in the [wiki](https://github.com/RetroPie/RetroPie-Setup/wiki) of the RetroPie Script. If you think that there is something missing, you are invited to add it to the wiki.
