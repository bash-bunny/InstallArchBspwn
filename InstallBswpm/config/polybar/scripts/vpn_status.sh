#!/bin/sh

IFACE=$(/usr/bin/ifconfig | grep tun0 | awk '{print $1}' | tr -d ':')

if [ "$IFACE" = "tun0" ]
then
    echo "{F#11d929} %{F#e2ee6a}$(/usr/bin/ifconfig tun0 | grep "inet " | awk '{print $2}')"
else
    echo "%{F#11d929}"
fi
