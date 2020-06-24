#!/usr/bin/env sh

function run {
  if ! pgrep -f $1 ;
  then
    $@&
  fi
}

run notify-send "Welcome to Awesome WM"
