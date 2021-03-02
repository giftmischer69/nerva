@echo off
rem convert sprite to monitor glow sprite
echo usage c2mg.bat [input.png] [output.png]
magick convert %1 -monochrome -fill "#222323" -opaque black -fill "#f0f6f0" -opaque white temp_mg.png
echo Usage: mask [mask] [dest] [out_file]
magick composite -compose Dst_In %1 temp_mg.png -alpha Set %2
del temp_mg.png
