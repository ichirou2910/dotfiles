#!/bin/env sh

case "$1" in
    --mem)
        info=($(grep " kB" /proc/meminfo | rev | cut -d " " -f2 | rev | head -n 3))
        mem_total=($(expr ${info[0]} / 1024))
        mem_free=${info[1]}
        mem_avail=($(expr ${info[2]} / 1024))
        mem_used=($(expr ${mem_total} - ${mem_avail}))
        mem_noti="Total: ${mem_total}MB\nUsed: ${mem_used}MB\nAvailable: ${mem_avail}MB"
        notify-send -i $HOME/.config/home/icons/ram.png -a Polybar "RAM" "$mem_noti"
        ;;
    --cpu)
        notify-send -a Polybar "CPU"
        ;;
    --gpu)
        notify-send -a Polybar "GPU"
        ;;
esac
