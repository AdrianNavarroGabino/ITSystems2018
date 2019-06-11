#!/bin/bash

## Adrián Navarro Gabino

## INSTRUCCIONES
## Mover la ficha -> Teclas "a" y "d"
## Dejar caer la ficha -> Teclas SPACE o ENTER

function comprobarResultado () {
    comprobarVertical $1 $2 $3
    if (( $? == 1 ))
    then
        return 1
    fi
    comprobarHorizontal $1 $2 $3
    if (( $? == 1 ))
    then
        return 1
    fi
    comprobarDiagonal1 $1 $2 $3
    if (( $? == 1 ))
    then
        return 1
    fi
    comprobarDiagonal2 $1 $2 $3
    if (( $? == 1 ))
    then
        return 1
    fi
}

function comprobarVertical () {
    declare -i consecutivos
    consecutivos=1
    declare -i indice
    indice="$1 - 1"
    declare -i aux
    aux="a$2[$indice]"
    
    while (( $indice >= 0 && $aux == $3 ))
    do
        consecutivos="$consecutivos + 1"
        indice="$indice - 1"
        aux="a$1[$indice]"
    done
    
    if (( $consecutivos >= 4 ))
    then
        return 1
    fi
}

function comprobarHorizontal () {
    declare -i consecutivos
    consecutivos=1
    declare -i indice
    indice="$2 - 1"
    declare -i aux
    if (( $indice >= 0 ))
    then
        aux="a$indice[$1]"
    else
        indice=-1
        aux=3
    fi

    while (( $indice >= 0 && $aux == $3 ))
    do
        consecutivos="$consecutivos + 1"
        indice="$indice - 1"
        if (( $indice >= 0 ))
        then
            aux="a$indice[$1]"
        else
            indice=-1
        fi
    done

    indice="$2 + 1"
    if (( $indice <= 8 ))
    then
        aux="a$indice[$1]"
    else
        indice=9
        aux=3
    fi

    while (( $indice <= 8 && $aux == $3 ))
    do
        consecutivos="$consecutivos + 1"
        indice="$indice + 1"
        if (( $indice <= 8 ))
        then
            aux="a$indice[$1]"
        else
            indice=9
        fi
    done

    if (( $consecutivos >= 4 ))
    then
        return 1
    fi
}

function comprobarDiagonal1 () {
    declare -i consecutivos
    consecutivos=1
    declare -i indice1
    indice1="$2 - 1"
    declare -i indice2
    indice2="$1 - 1"
    declare -i aux

    if (( $indice1 >= 0 && $indice2 >= 0 ))
    then
        aux="a$indice1[$indice2]"
    else
        indice1=-1
        aux=3
    fi

    while (( $indice1 >= 0 && $indice2 >= 0 && $aux == $3 ))
    do
        consecutivos="$consecutivos + 1"
        indice1="$indice1 - 1"
        indice2="$indice2 - 1"
        if (( $indice1 >= 0 && $indice1 >= 0 ))
        then
            aux="a$indice1[$indice2]"
        else
            indice1=-1
            indice2=-1
            aux=3
        fi
    done

    indice1="$2 + 1"
    indice2="$1 + 1"
    if (( $indice1 <= 8 && $indice2 <= 5 ))
    then
        aux="a$indice1[$indice2]"
    else
        indice1=9
        indice2=6
        aux=3
    fi

    while (( $indice1 <= 8 && $indice2 <= 5 && $aux == $3 ))
    do
        consecutivos="$consecutivos + 1"
        indice1="$indice1 + 1"
        indice2="$indice2 + 1"
        if (( $indice1 <= 8 && $indice2 <= 5 ))
        then
            aux="a$indice1[$indice2]"
        else
            indice1=9
        fi
    done

    if (( $consecutivos >= 4 ))
    then
        return 1
    fi
}

function comprobarDiagonal2 () {
    declare -i consecutivos
    consecutivos=1
    declare -i indice1
    indice1="$2 + 1"
    declare -i indice2
    indice2="$1 - 1"
    declare -i aux

    if (( $indice1 <= 8 && $indice2 >= 0 ))
    then
        aux="a$indice1[$indice2]"
    else
        indice1=9
        indice2=-1
        aux=3
    fi

    while (( $indice1 <= 8 && $indice2 >= 0 && $aux == $3 ))
    do
        consecutivos="$consecutivos + 1"
        indice1="$indice1 + 1"
        indice2="$indice2 - 1"
        if (( $indice1 <= 8 && $indice2 >= 0 ))
        then
            aux="a$indice1[$indice2]"
        else
            indice1=9
            indice2=-1
            aux=3
        fi
    done

    indice1="$2 - 1"
    indice2="$1 + 1"
    if (( $indice1 >= 0 && $indice2 <= 5 ))
    then
        aux="a$indice1[$indice2]"
    else
        indice1=-1
        indice2=6
        aux=3
    fi

    while (( $indice1 >= 0 && $indice2 <= 5 && $aux == $3 ))
    do
        consecutivos="$consecutivos + 1"
        indice1="$indice1 - 1"
        indice2="$indice2 + 1"
        if (( $indice1 >= 0 && $indice2 <= 5 ))
        then
            aux="a$indice1[$indice2]"
        else
            indice1=-1
            indice2=6
        fi
    done

    if (( $consecutivos >= 4 ))
    then
        return 1
    fi
}

clear

Blue='\e[0;34m'
Red='\e[0;31m'
Color_Off='\e[0m'
On_Green='\e[42m'

echo "  __     ____  _  _    ____    __   _  _   __   "
echo " /. |   ( ___)( \( )  (  _ \  /__\ ( \/ ) /__\  "
echo "(_  _)   )__)  )  (    )   / /(__)\ \  / /(__)\ "
echo "  (_)   (____)(_)\_)  (_)\_)(__)(__)(__)(__)(__)"
echo -e "\033[8;18fINSTRUCCIONES"
echo -e "\033[9;11fMover la ficha -> Teclas A y D"
echo -e "\033[10;9fDejar caer la ficha -> Tecla ENTER"
echo -e "\033[11;16fSalir -> Tecla Q"
echo -en "\033[16;12f${On_Green}Pulsa una tecla para empezar${Color_Off}"
read -r -n 1 -s
clear

for (( i=0; $i < 9; i++))
do
    declare -a a$i

    for (( j=0; j < 6; j++))
    do
        let "a$i[$j]=-1"
    done
done

echo ""
echo "┌──┬──┬──┬──┬──┬──┬──┬──┬──┐"
echo "│  │  │  │  │  │  │  │  │  │"
echo "├──┼──┼──┼──┼──┼──┼──┼──┼──┤"
echo "│  │  │  │  │  │  │  │  │  │"
echo "├──┼──┼──┼──┼──┼──┼──┼──┼──┤"
echo "│  │  │  │  │  │  │  │  │  │"
echo "├──┼──┼──┼──┼──┼──┼──┼──┼──┤"
echo "│  │  │  │  │  │  │  │  │  │"
echo "├──┼──┼──┼──┼──┼──┼──┼──┼──┤"
echo "│  │  │  │  │  │  │  │  │  │"
echo "├──┼──┼──┼──┼──┼──┼──┼──┼──┤"
echo "│  │  │  │  │  │  │  │  │  │"
echo "└──┴──┴──┴──┴──┴──┴──┴──┴──┘"
echo "Jugador 1"

declare tecla
declare -i turno
declare -i posicion
turno=0
posicion=2

while [[ $tecla != "q" ]]
do
    if (( $turno == 0 ))
    then
        echo -ne "$Blue"
    else
        echo -ne "$Red"
    fi
    echo -e "\033[1;0f\033[K"
    echo -ne "\033[1;${posicion}f⏺"
    echo -ne "\033[16;0f"
    read -r -n 1 -s tecla

    if [[ $tecla == "d" ]]
    then
        if (( $posicion < 24 ))
        then
            posicion="$posicion + 3"
        fi
    elif [[ $tecla == "a" ]]
    then
        if (( $posicion > 2 ))
        then
            posicion="$posicion - 3"
        fi
    elif [[ $tecla == "" ]]
    then
        declare -i posX
        declare -i posY
        posX="a$posY[5]"
        posY="$posicion / 3"
        
        if (( $posX == -1 ))
        then
            declare -i indice
            indice=0
            posX="a$posY[$indice]"
            while (( $posX != -1 ))
            do
                indice="$indice + 1"
                posX="a$posY[$indice]"
            done
            let "a$posY[$indice]=$turno"
            indice="13 - $indice * 2"
            declare -i bajada
            bajada=1
            while (( $bajada < $indice ))
            do
                echo -e "\033[${bajada};${posicion}f "
                bajada="$bajada + 2"
                echo -e "\033[${bajada};${posicion}f⏺"
                sleep 0.2
            done
            indice="(13 - $indice) / 2"
            comprobarResultado $indice $posY $turno
            if (( $? == 1 ))
            then
                echo -e "\033[15;0f\033[K${Color_Off}Ha ganado el jugador $jugador"
                tecla="q"
            else
                turno="($turno + 1) % 2"
                posicion=2
                declare -i jugador
                jugador="$turno + 1"
                echo -ne "\033[15;8f\033[K$Color_Off $jugador"
            fi
        fi
    fi
done