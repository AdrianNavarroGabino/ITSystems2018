#!/bin/bash

## Adrián Navarro Gabino

Color_Off='\e[0m'
Red='\e[0;31m'
Green='\e[0;32m'

if [[ $1 ]]
then
    usuario=$1
else
    echo -n "Introduce usuario: "
    read usuario
fi

nombreCuenta="$usuario.txt"

if [[ -e $nombreCuenta ]]
then
    while read linea
    do
        saldo=$(echo "scale=2; $linea" | bc -l)
    done < $nombreCuenta
else
    saldo=0
    echo "$saldo" > $nombreCuenta
fi

clear
echo "Bienvenido $usuario"
echo -n "Saldo: "
if [[ $(echo "$saldo >= 0" |bc -l) -eq 1 ]]
then
    echo -e "${Green}$saldo${Color_Off}"
else
    echo -e "${Red}$saldo${Color_Off}"
fi
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
            saldo=$(echo "scale=2; $saldo + $ingreso" | bc -l);;
        2)
            echo -n "¿Cuánto dinero quieres sacar? "
            read efectivo
            if [[ $(echo "$saldo - $efectivo >= -5000" |bc -l) -eq 1 ]]
            then
                saldo=$(echo "scale=2; $saldo - $efectivo" | bc -l)
            else
                echo "No puedes tener un saldo menor que -5000"
                echo -n "Pulsa una tecla para continuar: "
                read -n 1
            fi;;
        3)
            if [[ $(echo "$saldo >= 0" |bc -l) -eq 1 ]]
            then
                echo -n "Introduce un número del 1 al 100: "
                read interes

                if [[ $(echo "$interes >= 1 && $interes <= 100" |bc -l) -eq 1 ]]
                then
                    saldo=$(echo "scale=2; $saldo + $saldo * $interes / 100" | bc -l)
                else
                    echo "El interés debe ser un número entre 1 y 100"
                    echo -n "Pulsa una tecla para continuar: "
                    read -n 1
                fi
            else
                echo "No puedes sumar interés si tu saldo no es positivo"
                echo -n "Pulsa una tecla para continuar: "
                read -n 1
            fi;;
    esac

    if (( $opcion != 0 ))
    then
        echo -e "\033[8;0f\033[K"
        echo -e "\033[9;0f\033[K"
        echo -e "\033[10;0f\033[K"
        if [[ $(echo "$saldo >= 0" |bc -l) -eq 1 ]]
        then
            echo -en "\033[2;8f\033[K${Green}$saldo${Color_Off}"
        else
            echo -en "\033[2;8f\033[K${Red}$saldo${Color_Off}"
        fi
        echo -en "\033[7;19f\033[K"
        read -n 1 opcion
        echo ""
    fi
    
done

echo "$saldo" > $nombreCuenta