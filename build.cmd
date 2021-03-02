echo off

goto(){
# Linux code here
# https://nastytester.com/posts/script-that-works-in-windows-and-linux.html
uname -o
echo cleaning build dir
rm -f -r build/*
echo reading version & zipping to lutro
zip -r build/spacetrucks-$(./version.cmd).lutro conf.lua main.lua intro.lua menu.lua space.lua splash.lua mission01.lua driving.lua maf.lua spaceroad.lua gfx sfx
}

goto $@
exit

:(){
rem Windows script here
echo %OS%
echo reading version
CALL version.cmd
echo cleaning build dir
cd build
RD . /S /Q
cd ..
7z a -r build/spacetrucks-%__version__%.zip conf.lua main.lua intro.lua menu.lua space.lua splash.lua mission01.lua driving.lua maf.lua spaceroad.lua gfx sfx
copy build\spacetrucks-%__version__%.zip build\spacetrucks-%__version__%.lutro
echo zipping to lutro
goto :eof
