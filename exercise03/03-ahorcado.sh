#!/bin/bash

## Adrián Navarro Gabino

if [[ -e $1 ]]
then
    clear

    declare -a palabras
    declare -i indice

    indice=0

    while read linea
    do
        palabras[$indice]=$linea
        indice=$indice+1;
    done < "$1"

    palabra=${palabras[$(($RANDOM%indice))]}
    palabraOculta=""
    indice=0

    while (( $indice < ${#palabra} ))
    do
        palabraOculta=$palabraOculta"*"
        let "indice = $indice + 1"
    done

    declare -i fallos
    fallos=0

    echo "____"
    echo "|  |"
    echo "|"
    echo "|"
    echo "|"
    echo "Palabra:"
    echo "Dime letra:"

    while [[ "$palabra" != "$palabraOculta" && $fallos < 6 ]]
    do
        echo -e "\033[6;10f$palabraOculta"
        echo -ne "\033[7;13f\033[K"
        read -n 1 letra

        declare -i haFallado
        haFallado=0

        for (( j=0; $j < ${#palabra}; j++ ))
        do
            if [ "${palabra:j:1}" = "$letra" ] && [ "${palabraOculta:j:1}" != "$letra" ]
            then
                palabraOculta=${palabraOculta:0:j}$letra${palabraOculta:j+1}
                haFallado=1
            fi
        done

        if (( $haFallado == 0 ))
        then
            let "fallos = $fallos + 1"
            
            case $fallos in
                1) echo -ne "\033[3;4f0";;
                2) echo -ne "\033[4;4f|";;
                3) echo -ne "\033[4;3f/";;
                4) echo -ne "\033[4;5f\\";;
                5) echo -ne "\033[5;3f/";;
                6) echo -ne "\033[5;5f\\";;
            esac
        fi
    done

    echo -e "\033[6;10f$palabraOculta"
    echo -ne "\033[7;0f"
    if (( $fallos < 6 ))
    then
        echo "Enhorabuena, has acertado"
    else
        echo "Has perdido. La palabra correcta era: $palabra"
    fi
else
    echo "ahorcado.sh: falta un archivo como argumento"
fi