#!/bin/bash

## Adrián Navarro Gabino

if [[ -e fechas.txt ]]
then
    set -f; OLDIFS=$IFS; IFS="/"

    cat fechas.txt | while read -r dia mes anyo
    do
        if [[ $dia =~ ^[0-9]{2}$ && $mes =~ ^[0-9]{2}$ && $anyo =~ ^[0-9]{4}$ ]]
        then
            printf "Dia: %s, Mes: %s, Año: %s\n" "$dia" "$mes" "$anyo"
        else
            printf "La cadena \"%s\" no es una fecha y tiene una longitud de %d caracteres\n" "$dia" "${#dia}"
        fi
    done
    set +f; IFS=$OLDIFS
else
    echo "El fichero no existe"
fi