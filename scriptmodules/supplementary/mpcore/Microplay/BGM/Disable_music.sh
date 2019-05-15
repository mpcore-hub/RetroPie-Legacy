#!/bin/bash
sudo pkill -f bgmusic.py
touch /home/pi/RetroPie/retropiemenu/Microplay/BGM/DisableMusic
sudo sed -i -e 's/python/touch/g' /opt/retropie/configs/all/autostart.sh 2> /dev/null

