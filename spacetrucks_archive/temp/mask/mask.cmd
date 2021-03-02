echo Usage: mask [mask] [dest] [out_file]
magick composite -compose Dst_In %1 %2 -alpha Set %3