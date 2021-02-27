echo off

goto(){
# Linux code here
uname -o
echo cleaning build dir
rm -f -r build/*
echo zipping to lutro
zip -r build/spacetrucks_$(openssl rand -hex 2).lutro conf.lua main.lua intro.lua menu.lua space.lua splash.lua gfx sfx
}

goto $@
exit

:(){
rem Windows script here
echo %OS%
cd build
RD . /S /Q
cd ..
echo cleaning build dir
7z a -r build/spacetrucks.zip conf.lua main.lua intro.lua menu.lua space.lua splash.lua gfx sfx
echo zipping to lutro
copy build\spacetrucks.zip build\spacetrucks.lutro
goto :eof
