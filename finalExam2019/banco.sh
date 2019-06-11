#!/bin/bash

## Adrián Navarro Gabino

if [[ $1 ]]
then
    usuario=$1
else
    echo -n "Introduce usuario: "
    read usuario
fi

nombreCuenta="$usuario.txt"
declare -i saldo

if [[ -e $nombreCuenta ]]
then
    while read linea
    do
        saldo=linea
    done < $nombreCuenta
else
    saldo=0
    echo "$saldo" > $nombreCuenta
fi

clear
echo "Bienvenido $usuario"
echo "Saldo: $saldo"
echo "1. Ingresar dinero"
echo "2. Sacar dinero"
echo "3. Aplicar interés"
echo "0. Salir"
echo -n "Elige una opción: "
read -n 1 opcion
echo ""

while (( $opcion != 0 ))
do
    case $opcion in
        1)
            echo -n "¿Cuánto dinero quieres ingresar? "
            read ingreso
            saldo="$saldo + $ingreso";;
        2)
            echo -n "¿Cuánto dinero quieres sacar? "
            read efectivo
            saldo="$saldo - $efectivo";;
        3)
            echo -n "Introduce un número del 1 al 100: "
            read interes
            
            if (( $interes < 1 || $interes > 100 ))
            then
                echo "Interés no válido"
            else
                saldo="$saldo + $saldo * $interes / 100"
            fi;;
        *)
            echo "Opción incorrecta";;
    esac

    if (( $opcion != 0 ))
    then
        clear
        echo "Bienvenido $usuario"
        echo "Saldo: $saldo"
        echo "1. Ingresar dinero"
        echo "2. Sacar dinero"
        echo "3. Aplicar interés"
        echo "0. Salir"
        echo -n "Elige una opción: "
        read -n 1 opcion
        echo ""
    fi
    
done

echo "$saldo" > $nombreCuenta