#!/bin/bash

## Adrián Navarro Gabino

declare -r prefijoIP="192.168.0."

for (( i = 1; $i <= 254; i++ ))
do
    ip="${prefijoIP}${i}"
    if ping -c 1 -W 1 $ip>/dev/null
    then
        echo "$ip está activo"
    else
        echo "$ip no responde"
    fi
done