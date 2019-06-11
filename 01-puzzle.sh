#!/bin/bash

## Adrián Navarro Gabino

mover () {
    declare -i intAuxiliar

    case $letra in
        s)
            if (( $indiceEspacio > 2 ))
            then
                intAuxiliar="$indiceEspacio - 3"
                array[$indiceEspacio]=${array[$intAuxiliar]}
                array[$intAuxiliar]=" "
                
            fi;;
        w)
            if (( $indiceEspacio < 6 ))
            then
                intAuxiliar="$indiceEspacio + 3"
                array[$indiceEspacio]=${array[$intAuxiliar]}
                array[$intAuxiliar]=" "
            fi;;
        d)
            if (( $indiceEspacio % 3 != 0 ))
            then
                intAuxiliar="$indiceEspacio - 1"
                array[$indiceEspacio]=${array[$intAuxiliar]}
                array[$intAuxiliar]=" "
            fi;;
        a)
            if (( ($indiceEspacio + 1) % 3 != 0 ))
            then
                intAuxiliar="$indiceEspacio + 1"
                array[$indiceEspacio]=${array[$intAuxiliar]}
                array[$intAuxiliar]=" "
            fi;;
    esac
}

clear

declare -a array
declare -i i
indice=0

for number in $(shuf -i 1-8)
do
    array[$indice]=$number
    indice="$indice + 1"
done

array[8]=" "

declare -i hasGanado
hasGanado=0

echo "┌─┬─┬─┐"
echo "│ │ │ │"
echo "├─┼─┼─┤"
echo "│ │ │ │"
echo "├─┼─┼─┤"
echo "│ │ │ │"
echo "└─┴─┴─┘"

declare -i indiceEspacio
declare -i estaOrdenado
estaOrdenado=0

while (( $hasGanado == 0 ))
do
    indice=0
    
    for (( i=0; $i < 3; i++))
    do
        declare -i fila
        fila="$i * 2 + 2"
        for (( j=0; $j < 3; j++))
        do
            declare -i columna
            columna="$j * 2 + 2"
            echo -e "\033[${fila};${columna}f${array[$indice]}"

            if [[ ${array[$indice]} == " " ]]
            then
                indiceEspacio=$indice
            fi

            indice="$indice + 1"
        done
    done

    if (( $estaOrdenado == 1 ))
    then
        echo -e "\033[8;0fEnhorabuena! Has ganado!"
        hasGanado=1
    else
        echo -en "\033[8;0f"
        read -s -n 1 letra

        mover

        estaOrdenado=1
        for (( i=0; $i < 8; i++ ))
        do
            intAuxiliar="$i + 1"
            if [[ ${array[$i]} != $intAuxiliar ]]
            then
                estaOrdenado=0
            fi
        done
    fi
done