#!/bin/bash

# Adrián Navarro Gabino

if [[ -e operaciones.txt ]]
then
    set -f; OLDIFS=$IFS; IFS=";"
    while read -r operacion n1 n2
    do
        case $operacion in
            suma)
                resultado=$(echo "scale=2; $n1 + $n2" | bc -l)
                echo "$n1 + $n2 = $resultado";;
            resta)
                resultado=$(echo "scale=2; $n1 - $n2" | bc -l)
                echo "$n1 - $n2 = $resultado";;
            multiplica)
                resultado=$(echo "scale=2; $n1 * $n2" | bc -l)
                echo "$n1 x $n2 = $resultado";;
            divide)
                resultado=$(echo "scale=2; $n1 / $n2" | bc -l)
                echo "$n1 / $n2 = $resultado";;
            *) echo "Operación incorrecta"
        esac
    done < operaciones.txt
    set +f; IFS=$OLDIFS
else
    echo "operaciones.sh: El archivo operaciones.txt no existe"
fi