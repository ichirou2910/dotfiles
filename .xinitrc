#!/usr/bin/env sh

[ -f ~/.xprofile ] && . ~/.xprofile

# numlockx &
# eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
# export SSH_AUTH_SOCK
# dbus-update-activation-environment --systemd DISPLAY
xrandr --output DisplayPort-1 --primary --right-of HDMI-A-1
exec openbox-session
