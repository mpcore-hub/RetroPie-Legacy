#!/bin/bash
rm /home/pi/RetroPie/retropiemenu/Microplay/BGM/DisableMusic 2> /dev/null
sudo sed -i -e 's/touch/python/g' /opt/retropie/configs/all/autostart.sh 2> /dev/null
python /home/pi/RetroPie/retropiemenu/Microplay/BGM/bgmusic.py &


