#!/bin/bash

curl -L -o scripts.zip https://github.com/schaepher/script-and-config/archive/main.zip 
unzip scripts.zip
rm scripts.zip
mv script-and-config-main sac
cd sac/scripts
chmod +x *

#./termux-init.sh
#./termux-npc.sh