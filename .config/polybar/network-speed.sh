#!/bin/env sh

case "$1" in
    --eth)
        INTERFACE="enp2s0"
        ;;
    --wlan)
        INTERFACE="wlp5s0"
        ;;
esac

print_bytes() {
    if [ "$1" -eq 0 ] || [ "$1" -lt 1000 ]; then
        bytes="0 kB/s"
    elif [ "$1" -lt 1000000 ]; then
        bytes="$(echo "scale=0;$1/1000" | bc -l ) kB/s"
    else
        bytes="$(echo "scale=1;$1/1000000" | bc -l ) MB/s"
    fi

    echo "$bytes"
}

print_bit() {
    if [ "$1" -eq 0 ] || [ "$1" -lt 10 ]; then
        bit="0 B"
    elif [ "$1" -lt 100 ]; then
        bit="$(echo "scale=0;$1*8" | bc -l ) B"
    elif [ "$1" -lt 100000 ]; then
        bit="$(echo "scale=0;$1*8/1000" | bc -l ) K"
    else
        bit="$(echo "scale=1;$1*8/1000000" | bc -l ) M"
    fi

    echo "$bit"
}

INTERVAL=10

declare -A bytes

bytes[past_rx_$INTERFACE]="$(cat /sys/class/net/"$INTERFACE"/statistics/rx_bytes)"
bytes[past_tx_$INTERFACE]="$(cat /sys/class/net/"$INTERFACE"/statistics/tx_bytes)"
down = 0
up = 0

while true; do
    bytes[now_rx_$INTERFACE]="$(cat /sys/class/net/"$INTERFACE"/statistics/rx_bytes)"
    bytes[now_tx_$INTERFACE]="$(cat /sys/class/net/"$INTERFACE"/statistics/tx_bytes)"

    bytes_down=$((((${bytes[now_rx_$INTERFACE]} - ${bytes[past_rx_$INTERFACE]})) / INTERVAL))
    bytes_up=$((((${bytes[now_tx_$INTERFACE]} - ${bytes[past_tx_$INTERFACE]})) / INTERVAL))

    down=$(((( "$down" + "$bytes_down" ))))
    up=$(((( "$up" + "$bytes_up" ))))

    export network_downspeed=$down
    export network_upspeed=$up

    bytes[past_rx_$INTERFACE]=${bytes[now_rx_$INTERFACE]}
    bytes[past_tx_$INTERFACE]=${bytes[now_tx_$INTERFACE]}

    sleep $INTERVAL
done

# notify-send -a Polybar "Network" "Download: $(print_bytes $down) / Upload: $(print_bytes $up)"
