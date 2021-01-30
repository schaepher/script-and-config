#!/bin/bash

curl -L -o tool-kits.zip https://github.com/schaepher/tool-kits/archive/main.zip 
unzip tool-kits.zip
rm tool-kits.zip
cd tool-kits-main
chmod -R +x *.sh