#!/bin/bash

## Adrián Navarro Gabino

if [[ -e notas.txt ]]
then
    declare -a curso
    declare -a asignatura
    declare -a notas
    declare -i indice
    indice=0

    set -f; OLDIFS=$IFS; IFS=";"

    while read -r a b c
    do
        curso[$indice]=$a
        asignatura[$indice]=$b
        nota[$indice]=$c
        indice="$indice + 1"
    done < notas.txt
    set +f; IFS=$OLDIFS

    declare -i notaMasBaja
    declare -i notaMasAlta
    declare -i sumaNotasPrimero
    declare -i sumaNotasSegundo
    declare -i cantidadAsignaturasPrimero
    declare -i cantidadAsignaturasSegundo
    notaMasBaja=0
    notaMasAlta=0
    cantidadAsignaturasPrimero=0
    cantidadAsignaturasSegundo=0

    for (( i=0; $i < $indice; i++ ))
    do
        if (( ${nota[$i]} < ${nota[$notaMasBaja]} ))
        then
            notaMasBaja=$i
        fi

        if (( ${nota[$i]} > ${nota[$notaMasAlta]} ))
        then
            notaMasAlta=$i
        fi

        if (( ${curso[$i]} == 1 ))
        then
            sumaNotasPrimero="$sumaNotasPrimero + ${nota[$i]}"
            cantidadAsignaturasPrimero="$cantidadAsignaturasPrimero + 1"
        fi

        if (( ${curso[$i]} == 2 ))
        then
            sumaNotasSegundo="$sumaNotasSegundo + ${nota[$i]}"
            cantidadAsignaturasSegundo="$cantidadAsignaturasSegundo + 1"
        fi
    done

    mediaPrimero=$(echo "scale=2; $sumaNotasPrimero / $cantidadAsignaturasPrimero" | bc -l)
    mediaSegundo=$(echo "scale=2; $sumaNotasSegundo / $cantidadAsignaturasSegundo" | bc -l)
    mediaTotal=$(echo "scale=2; ($mediaPrimero + $mediaSegundo) / 2" | bc -l)

    echo "Asignatura con la nota más baja: ${asignatura[$notaMasBaja]}"
    echo "Asignatura con la nota más alta: ${asignatura[$notaMasAlta]}"
    echo ""
    echo "Asignaturas suspendidas:"

    for (( i=0; $i < $indice; i++ ))
    do
        if (( ${nota[i]} < 5 ))
        then
            echo "${asignatura[i]} - ${nota[i]}"
        fi
    done
    echo ""

    echo "Nota media de primero: $mediaPrimero"
    echo "Nota media de segundo: $mediaSegundo"
    echo "Nota media global: $mediaTotal"
else
    echo "notas.sh: el archivo \"notas.txt\" no existe"
fi