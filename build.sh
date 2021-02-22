#!/bin/bash

function clean()
{
  echo cleaning build dir
  rm -f -r build/*
}

function lutro()
{
  echo zipping to lutro
  zip -r build/spacetrucks_$(openssl rand -hex 2).lutro conf.lua main.lua space_menu.lua space.lua gfx sfx
}

function run()
{
  flatpak run org.libretro.RetroArch
}

build() {
    if [ "$1" = "clean" ]; then
        clean
    elif [ "$1" = "lutro" ]; then
        lutro
    elif [ "$1" = "run" ]; then
        run
    else
        clean
        lutro
        # run
    fi
}

build "$@"
