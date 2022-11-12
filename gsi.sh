#!/bin/sh
sudo apt install git -y
git clone https://github.com/ProjectSuzu/treble_build_miku -b snowland
cd treble_build_miku
bash build.sh
