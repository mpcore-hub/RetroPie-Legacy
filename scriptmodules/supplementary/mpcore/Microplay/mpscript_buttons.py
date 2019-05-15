#!/usr/bin/env python

import os
import sys
import subprocess

if not os.getegid() == 0:
    sys.exit('Script must be run as root')

from time import sleep
from subprocess import *
from pyA20.gpio import gpio
from pyA20.gpio import connector
from pyA20.gpio import port

button_reset = port.PA9  #PIN 33  Orange PI
button_shutdown = port.PA7  #PIN 29  Orange PI

#Init gpio module
gpio.init()

#Set directions
gpio.setcfg(button_reset, gpio.INPUT)
gpio.setcfg(button_shutdown, gpio.INPUT)

#Enable pullup resistor
gpio.pullup(button_reset, gpio.PULLUP)
gpio.pullup(button_shutdown, gpio.PULLUP)

def delay_milliseconds(milliseconds):  
    seconds = milliseconds / float(1000)
    sleep(seconds)  

def run_cmd(cmd):  
   p = Popen(cmd, shell=True, stdout=PIPE, stderr=STDOUT)  
   output = p.communicate()[0]  
   return output  

reset_pressed = 1
shutdown_pressed = 1
while True:
   reset_pressed = gpio.input(button_reset)
   shutdown_pressed = gpio.input(button_shutdown)

   if (reset_pressed == 0):
      run_cmd("reboot")

   if (shutdown_pressed == 0):
      run_cmd("shutdown now")

   delay_milliseconds(100)
