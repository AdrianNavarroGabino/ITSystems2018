#!/bin/bash

## Adrián Navarro Gabino

if [[ $1 && ${#1} -eq 1 ]]
then
    caracter=$1
    opcionFigura=-1

    while [[ $opcionFigura != 0 ]]
    do
        echo "1. Rectángulo"
        echo "2. Cuadrado vacío"
        echo "3. Escalera de bajada"
        echo "4. Escalera de subida"
        echo "5. Pirámide"
        echo "6. Pirámide vacía"
        echo "7. Rombo"
        echo "0. Salir"
        echo ""

        read -p "Elige una opción: " opcionFigura
        echo ""

        case $opcionFigura in
            1)
                echo -n "Introduce ancho: "
                read ancho

                while [[ $ancho -le 0 ]]
                do
                    echo "Ancho incorrecto"
                    echo -n "Introduce ancho: "
                    read ancho
                done

                echo -n "Introduce alto: "
                read alto

                while [[ $alto -le 0 ]]
                do
                    echo "Alto incorrecto"
                    echo -n "Introduce alto: "
                    read alto
                done

                for (( i = 0; $i < $alto; i++ ))
                do
                    for (( j = 0; $j < $ancho; j++ ))
                    do
                        echo -n "$caracter"
                    done

                    echo ""
                done;;
            2)
                echo -n "Introduce ancho: "
                read ancho

                while [[ $ancho -le 0 ]]
                do
                    echo "Ancho incorrecto"
                    echo -n "Introduce ancho: "
                    read ancho
                done

                echo -n "Introduce alto: "
                read alto

                while [[ $alto -le 0 ]]
                do
                    echo "Alto incorrecto"
                    echo -n "Introduce alto: "
                    read alto
                done

                for (( j = 0; $j < $ancho; j++ ))
                do
                    echo -n "$caracter"
                done
                echo ""

                for (( i = 2; $i < $alto; i++ ))
                do
                    echo -n "$caracter"
                    for (( j = 2; j < $ancho; j++ ))
                    do
                        echo -n " "
                    done

                    echo "$caracter"
                done

                for (( j = 0; $j < $ancho; j++ ))
                do
                    echo -n "$caracter"
                done
                echo "";;
            3)
                echo -n "Introduce base de la escalera: "
                read base

                while [[ $base -le 0 ]]
                do
                    echo "Base incorrecta"
                    echo -n "Introduce base de la escalera: "
                    read base
                done

                for (( i = 1; $i <= $base; i++ ))
                do
                    for (( j = 1; $j <= i; j++ ))
                    do
                        echo -n "$caracter"
                    done

                    echo ""
                done;;
            4)
                echo -n "Introduce base de la escalera: "
                read base

                while [[ $base -le 0 ]]
                do
                    echo "Base incorrecta"
                    echo -n "Introduce base de la escalera: "
                    read base
                done

                for (( i = 1; $i <= $base; i++ ))
                do
                    for (( j = 1; $j <= $base - $i; j++ ))
                    do
                        echo -n " "
                    done

                    for (( j = 1; $j <= $i; j++ ))
                    do
                        echo -n "$caracter"
                    done

                    echo ""
                done;;
            5)
                echo -n "Introduce base de la escalera: "
                read base

                while [[ $base -le 0 || $(expr $base % 2) -eq 0 ]]
                do
                    echo "Base incorrecta"
                    echo -n "Introduce base de la escalera: "
                    read base
                done

                for (( i = 0; i < $base / 2 + 1; i++ ))
                do
                    for (( j = $base / 2 - $i; $j > 0; j-- ))
                    do
                        echo -n " "
                    done

                    for (( j = 0; $j < $i * 2 + 1; j++ ))
                    do
                        echo -n "$caracter"
                    done

                    echo ""
                done;;
            6)
                echo -n "Introduce base de la escalera: "
                read base

                while [[ $base -le 0 || $(expr $base % 2) -eq 0 ]] ## Falta condicion impar
                do
                    echo "Base incorrecta"
                    echo -n "Introduce base de la escalera: "
                    read base
                done

                for (( i = 0; $i < $base / 2; i++))
                do
                    echo -n " "
                done
                echo "$caracter"

                for (( i = 1; $i < $base / 2; i++ ))
                do
                    for (( j = $base / 2 - $i; $j > 0; j-- ))
                    do
                        echo -n " "
                    done

                    echo -n "$caracter"
                    for (( j = 2; $j < $i * 2 + 1; j++ ))
                    do
                        echo -n " "
                    done
                    echo "$caracter"
                done

                for (( i = 0; $i < $base; i++ ))
                do
                    echo -n "$caracter"
                done

                echo "";;
            7)
                echo -n "Introduce base de la escalera: "
                read base

                while [[ $base -le 0 || $(expr $base % 2) -eq 0 ]]
                do
                    echo "Base incorrecta"
                    echo -n "Introduce base de la escalera: "
                    read base
                done

                for (( i = 0; $i < $base / 2 + 1; i++ ))
                do
                    for (( j = $base / 2 - $i; $j > 0; j-- ))
                    do
                        echo -n " "
                    done

                    for (( j = 0; $j < $i * 2 + 1; j++ ))
                    do
                        echo -n "$caracter"
                    done

                    echo ""
                done

                for (( i = 0; $i < $base / 2; i++ ))
                do
                    for (( j = 0; $j <= $i; j++ ))
                    do
                        echo -n " "
                    done

                    for (( j = $base - 2 - $i * 2; $j >= 1; j-- ))
                    do
                        echo -n "$caracter"
                    done

                    echo ""
                done;;
            0)
                echo "¡Hasta otra!";;
            *)
                echo "Opción incorrecta";;
        esac

        echo ""
    done
else
    echo "Parámetro incorrecto"
fi
