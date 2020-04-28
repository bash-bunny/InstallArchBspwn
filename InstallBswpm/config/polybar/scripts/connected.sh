#!/usr/bin/sh

wifi=$(ip link show | grep -i "wl" | grep 'state UP')

if [ ! -z "$wifi" ]
then
    echo "%{F#cc0433} %{F#e2ee6a}"
else
    echo "%{F#07dbcd} %{F#e2ee6a}"
fi
