#!/bin/bash

## Adrián Navarro Gabino

if [[ $1 ]]
then
    clear

    declare -a datos
    usuarioExiste=-1
    declare -i siguienteId
    siguienteId=1

    set -f; OLDIFS=$IFS; IFS=";"
    while read datos[0] datos[1] datos[2] datos[3]
    do
        if [ ${datos[1]} == $1 ]
        then
            usuarioExiste=${datos[0]}
            nombreUsuario=${datos[1]}
            passEncriptada=${datos[2]}
        fi

        echo "${datos[0]};${datos[1]};${datos[2]};${datos[3]}" >> cuentasTemporales.txt

        siguienteId="$siguienteId + 1"
    done < cuentas.txt
    set +f; IFS=$OLDIFS

    if (( $usuarioExiste == -1 ))
    then
        echo "El usuario no existe"
        read -sp "Introduce nueva contraseña: " pass
        echo ""
        read -sp "Vuelve a introducirla: " pass2
        echo ""

        if [ $pass == $pass2 ]
        then
            passCifrada=$(echo "$pass" | sha256sum | cut -d " " -f 1)
            fecha=$(date +"%d/%m/%Y-%H:%M:%S")
            echo "$siguienteId;$1;$passCifrada;$fecha" >> cuentas.txt
            echo -e "\033[1;0f\033[2JUsuario creado."
        else
            rm cuentasTemporales.txt
            echo -e "\033[1;0f\033[2JLas contraseñas no coinciden."
            echo "Usuario no creado."
            exit 1
        fi
    else
        read -sp "Introduce contraseña: " pass
        echo ""

        declare -i fallos
        fallos=0

        while [[ ( $(echo "$pass" | sha256sum | cut -d " " -f 1) != $passEncriptada && $fallos < 2 ) ]]
        do
            fallos="$fallos + 1"
            declare -i intentos
            intentos="3 - $fallos"
            echo -e "\033[1;0f\033[KContraseña incorrecta. Te quedan $intentos intentos."
            read -sp "Introduce contraseña: " pass
            echo ""
        done

        if [ $(echo "$pass" | sha256sum | cut -d " " -f 1) != $passEncriptada ]
        then
            echo -e "\033[1;0f\033[2JAcceso bloqueado."
            rm cuentasTemporales.txt
            exit 1
        else
            rm cuentas.txt
            set -f; OLDIFS=$IFS; IFS=";"
            while read datos[0] datos[1] datos[2] datos[3]
            do
                cadenaUsuario="${datos[0]};${datos[1]};${datos[2]}"
                if [ $usuarioExiste == ${datos[0]} ]
                then
                    fecha=$(date +"%d/%m/%Y-%H:%M:%S")
                    cadenaUsuario="$cadenaUsuario;$fecha";
                else
                    cadenaUsuario="$cadenaUsuario;${datos[3]}";
                fi
                echo "$cadenaUsuario" >> cuentas.txt
                echo -e "\033[1;0f\033[2JAcceso permitido"
            done < cuentasTemporales.txt
        fi
    fi

    rm cuentasTemporales.txt

    exit 0
else
    echo "login.sh: falta un usuario como argumento"
    exit 2
fi