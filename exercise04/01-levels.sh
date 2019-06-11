#!/bin/bash

## Adrián Navarro Gabino

clear

Green='\e[0;32m'
Red='\e[0;31m'
Yellow='\e[0;33m'
Color_Off='\e[0m'

declare -a numeros

for (( i=0; $i < 6; i++ ))
do
    numeros[$i]=$(( $RANDOM % 9 + 1 ))

    if (( ${numeros[$i]} >= 1 && ${numeros[$i]} <= 3 ))
    then
        echo -en "${Red}"
    elif (( ${numeros[$i]} >= 4 && ${numeros[$i]} <= 6 ))
    then
        echo -en "${Yellow}"
    else
        echo -en "${Green}"
    fi

    echo -n "${numeros[$i]} "

    for (( j=0; $j < ${numeros[$i]}; j++ ))
    do
        echo -n "*"
    done

    echo -e "${Color_Off}"
done

lineaCambiar=-1
while (( $lineaCambiar != 0 ))
do
    echo -ne "\033[7;0f\033[K"
    read -p "¿Qué fila quieres cambiar? (1-6) (0 para salir): " lineaCambiar

    if (( $lineaCambiar >= 1 && $lineaCambiar <= 6 ))
    then
        read -p "Introduce un número del 1 al 9: " numeroElegido
        echo -e "\033[8;0f\033[K"
        if (( $numeroElegido >= 1 && $numeroElegido <= 9 ))
        then
            if (( $numeroElegido >= 1 && $numeroElegido <= 3 ))
            then
                echo -en "${Red}"
            elif (( $numeroElegido >= 4 && $numeroElegido <= 6 ))
            then
                echo -en "${Yellow}"
            else
                echo -en "${Green}"
            fi

            echo -en "\033[$lineaCambiar;0f\033[K$numeroElegido "

            for (( i=0; $i < $numeroElegido; i++))
            do
                echo -n "*"
            done

            echo -e "${Color_Off}"
        fi
    fi
done

