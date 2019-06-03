#!/bin/bash

## Adrián Navarro Gabino

if [[ -e $1 ]]
then
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

    while [[ "$palabra" != "$palabraOculta" && $fallos < 9 ]]
    do
        echo "Palabra: $palabraOculta"
        echo -n "Dime letra: "
        read -n 1 letra
        echo ""

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
            echo "Fallos: $fallos"
        fi
    done

    echo "Palabra: ${palabraOculta[@]}"

    if (( $fallos < 9 ))
    then
        echo "Enhorabuena, has acertado"
    else
        echo "Has perdido. La palabra correcta es: $palabra"
    fi
else
    echo "adivina.sh: falta un archivo como argumento"
fi
