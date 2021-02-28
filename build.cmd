echo off

goto(){
# Linux code here
# https://nastytester.com/posts/script-that-works-in-windows-and-linux.html
uname -o
echo cleaning build dir
rm -f -r build/*
echo reading version
source version.cmd
echo zipping to lutro
zip -r build/spacetrucks_$(openssl rand -hex 2).lutro conf.lua main.lua intro.lua menu.lua space.lua splash.lua mission01.lua gfx sfx
}

goto $@
exit

:(){
rem Windows script here
echo %OS%
CALL version.cmd
cd build
RD . /S /Q
cd ..
echo cleaning build dir
7z a -r build/spacetrucks-%__version__%.zip conf.lua main.lua intro.lua menu.lua space.lua splash.lua mission01.lua gfx sfx
copy build\spacetrucks-%__version__%.zip build\spacetrucks-%__version__%.lutro
echo zipping to lutro
goto :eof
