#!/bin/bash

if [ $# -ne 1 ]; then
    echo "[!] Use: $0 <ip_address>"
    exit 1
fi

function get_ttl {
    ttl=$(ping -c 1 $1 | awk '/ttl/{print $6}' | cut -d "=" -f 2)
    echo $ttl
}

function get_os {
    ttl=$1

    if (( $ttl >= 0 && $ttl <= 64 )); then
        echo "Linux"
    elif (( $ttl >= 65 && $ttl <= 128 )); then
        echo "Windows"
    else
        echo "Can't determine system, ip address or incorrect TTL."
    fi
}

ip_address=$1
ttl=$(get_ttl $ip_address)
os_name=$(get_os $ttl)

echo "$ip_address (ttl -> $ttl): $os_name"
