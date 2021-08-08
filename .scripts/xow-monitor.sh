#!/bin/bash

journalctl -o cat -fn0 -u xow.service -b | while read line ; do
  # notify-send.py "Xbox" "${line}"
  echo "${line}" | egrep -w "Controller|Battery" > /dev/null
  if [ $? = 0 ] ; then
    parse() {
      echo "${line}" | awk -F "-" '{print substr($NF, 2)}'
    }
    notify-send -a "Xbox wireless dongle" "Xbox Controller" "$(parse)" --hint string:image-path:"file://$HOME/.icons/xbox.png"
  fi
done
