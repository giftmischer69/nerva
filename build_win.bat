@echo off
echo cleaning build dir
cd build
RD . /S /Q
cd ..
echo zipping to lutro
7z a -r build/spacetrucks.zip conf.lua main.lua intro.lua menu.lua space.lua splash.lua gfx sfx
copy build\spacetrucks.zip build\spacetrucks.lutro
