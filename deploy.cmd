

goto(){
# Linux code here
# https://nastytester.com/posts/script-that-works-in-windows-and-linux.html
sshpass -p 'recalboxroot' -v scp build/spacetrucks-$(./version.cmd).lutro root@192.168.178.30:/recalbox/share/roms/lutro/
}

goto $@
exit

:(){
rem Windows script here
echo TODO
goto :eof
