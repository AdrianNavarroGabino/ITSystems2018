#!/bin/bash

## Adrián Navarro Gabino

if [[ -e numeros.txt ]]
then
    declare -i indice
    indice=1

    set -f; OLDIFS=$IFS; IFS=";"
    while read -r n1 n2 n3 n4
    do
        declare -i mayor
        mayor=$n1
        for (( i=2; $i <= 4; i++ ))
        do
            var="n$i"
            if (( ${var} > $mayor ))
            then
                mayor=${var}
            fi
        done

        echo "Linea $indice: El mayor es $mayor"
        indice="$indice+1"
    done < numeros.txt
    set +f; IFS=$OLDIFS
else
    echo "compara_num.sh: El archivo numeros.txt no existe"
fi