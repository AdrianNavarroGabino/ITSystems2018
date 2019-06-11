#!/bin/bash

## Adrián Navarro Gabino

declare -a numeros

for (( i=0; $i < 20; i++ ))
do
    let "numeros[$i]=$RANDOM%300+1"
    echo -n "${numeros[$i]} "
done

echo ""

echo -n "Introduce un número entre el 2 y el 20: "
read divisor

while (( $divisor < 2 || $divisor > 20 ))
do
    echo "Número incorrecto"
    echo -n "Introduce un número entre el 2 y el 20: "
    read divisor
done

for (( i=0; $i < 20; i++ ))
do
    if (( ${numeros[$i]} % $divisor == 0 ))
    then
        echo -n "${numeros[$i]} "
    fi
done

echo ""