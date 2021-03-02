
goto(){
# Linux code here
# https://nastytester.com/posts/script-that-works-in-windows-and-linux.html
# https://semver.org/
echo "0.0.9"
}

goto $@
exit

:(){
rem Windows script here
SET __version__="0.0.9"
goto :eof
