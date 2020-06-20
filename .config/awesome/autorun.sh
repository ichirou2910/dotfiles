#!/usr/bin/env sh

function run {
  if ! pgrep -f $1 ;
  then
    $@&
  fi
}

run sh $HOME/.config/polybar/launch.sh

run picom --config $HOME/.config/picom/picom.conf

run python3 $HOME/.config/wallpaper/walltext.py

run redshift-gtk
