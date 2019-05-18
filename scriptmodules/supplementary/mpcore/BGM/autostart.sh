#!/bin/bash
stty -echo
SERVICE='fbi'
      if ps ax | grep $SERVICE > /dev/null
  then
      sudo killall -q $SERVICE
      fi
while pgrep mpv &>/dev/null;
do sleep 1;
done
python /home/pi/RetroPie/retropiemenu/Microplay/BGM/bgmusic.py & LD_LIBRARY_PATH=/usr/local/lib /opt/retropie/supplementary/emulationstation/emulationstation.sh;stty echo;sudo pkill -f bgmusic.py

