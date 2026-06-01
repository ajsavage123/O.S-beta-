#!/bin/bash
# create_bootanim.sh
# Combines desc.txt and parts into a bootanimation.zip

cd gravityos/branding/bootanimation
zip -0rn .txt:.png ../bootanimation.zip desc.txt part0/*.png part1/*.png
cd ../../../
echo "bootanimation.zip created in gravityos/branding/"
