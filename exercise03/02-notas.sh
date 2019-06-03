#!/bin/bash

## Adrián Navarro Gabino

if [[ -e notas2.txt ]]
then
    declare -a alumnos
    declare -a medias
    declare -i indice
    White='\e[0;37m'
    Green='\e[0;32m'
    Red='\e[0;31m'
    Color_Off='\e[0m'

    alumnos[0]="MEDIA"
    sumaDeNotasMedias=0

    indice=1

    set -f; OLDIFS=$IFS; IFS=";"

    while read -r nombre nota1 nota2 nota3 nota4 nota5
    do
        alumnos[$indice]=$nombre
        medias[$indice]=$(echo "scale=2; ($nota1 + $nota2 + $nota3 + $nota4 + $nota5) / 5" | bc -l)
        sumaDeNotasMedias=$(echo "scale=2; $sumaDeNotasMedias + ${medias[$indice]}" | bc -l)
        indice="$indice + 1"
    done < notas2.txt
    set +f; IFS=$OLDIFS

    medias[0]=$(echo "scale=2; $sumaDeNotasMedias / ($indice - 1)" | bc -l)

    for (( i=0; $i < $indice - 1; i++ ))
    do
        for (( j=$i + 1; $j < $indice; j++ ))
        do
            if [[ $(echo "${medias[$i]} < ${medias[$j]}" | bc -l) = 1 ]]
            then
                aux=${medias[$i]}
                medias[$i]=${medias[$j]}
                medias[$j]=$aux
                aux2=${alumnos[$i]}
                alumnos[$i]=${alumnos[$j]}
                alumnos[$j]=$aux2
            fi
        done
    done

    declare -i indiceMedia
    declare -i mayorLongitudNombre
    mayorLongitudNombre=0

    for (( i=0; $i < ${#alumnos[@]}; i++ ))
    do
        if [ ${alumnos[$i]} == "MEDIA" ]
        then
            indiceMedia=$i
        fi

        if [[ $(echo -n ${alumnos[$i]} | wc -m) > $mayorLongitudNombre ]]
        then
            mayorLongitudNombre=$(echo -n ${alumnos[$i]} | wc -m)
        fi
    done
    
    for (( i=0; i < ${#alumnos[@]}; i++ ))
    do
        for (( j=0; $j < $mayorLongitudNombre - $(echo -n ${alumnos[$i]} | wc -m) + 3; j++ ))
        do
            echo -n " "
        done

        echo -n "${alumnos[$i]} |"

        declare -i numeroDeCaracteres
        numeroDeCaracteres=$(echo "scale=0; ${medias[$i]} * 10 / ${medias[$indiceMedia]}" | bc -l)

        if (( $i < $indiceMedia ))
        then
            echo -en "${Green}"
        elif (( $i > $indiceMedia ))
        then
            echo -en "${Red}"
        elif (( $i == $indiceMedia ))
        then
            echo -en "${White}"
        fi
        
        for (( j=0; $j < $numeroDeCaracteres; j++ ))
        do
            echo -n "▇"
        done

        echo -e "${Color_Off}  ${medias[$i]}"
    done
else
    echo "notas.sh: el archivo \"notas2.txt\" no existe"
fi