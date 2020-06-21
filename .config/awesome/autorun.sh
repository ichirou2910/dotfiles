#!/usr/bin/env sh

function run {
  if ! pgrep -f $1 ;
  then
    $@&
  fi
}

run ~/.fehbg

run dunst

run picom --config ~/.config/picom/picom.conf

run python3 ~/.config/wallpaper/walltext.py

run redshift-gtk
