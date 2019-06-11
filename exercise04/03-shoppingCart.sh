#!/bin/bash

## Adrián Navarro Gabino

nuevoPedido () {
    echo -e "\033[1;0f\033[2J1 - Añadir producto"
    echo "2 - Borrar producto"
    echo "3 - Realizar pedido"
    echo "4 - Cancelar"
    echo -n "Elige una opción: "
    read -n 1 opcion2;

    while (( $opcion2 != 4 ))
    do
        case $opcion2 in
            1) anyadirProducto;;
            2) borrarProducto;;
            3)
                if [[ -e pedidoTemporal.txt ]]
                then
                    realizarPedido $1
                    opcion=4
                fi;;
            4) rm pedidoTemporal.txt;;
            *) echo "Opción incorrecta";;
        esac

        if (( $opcion2 != 4 ))
        then
            echo -e "\033[1;0f\033[2J1 - Añadir producto"
            echo "2 - Borrar producto"
            echo "3 - Realizar pedido"
            echo "4 - Cancelar"
            echo -n "Elige una opción: "
            read -n 1 opcion2;
        fi
    done
}

mostrarProductos () {
    echo -e "\033[1;0f\033[2JLista de productos"
    declare -i indice
    indice=1

    set -f; OLDIFS=$IFS; IFS=";"
    while read codigo nombre precio
    do
        echo "$indice - $nombre: $precio€"
        indice="$indice + 1"
    done < productos.txt
    set +f; IFS=$OLDIFS
    indice="$indice - 1"
    return $indice
}

anyadirProducto () {
    mostrarProductos
    indice=$?

    echo -n "Elige la línea del producto que quieres añadir: "
    read producto
    echo -n "Cantidad: "
    read cantidad

    if (( $producto > 0 && $producto <= $indice && $cantidad > 0 ))
    then
        echo "$producto;$cantidad" >> pedidoTemporal.txt
    fi
}

realizarPedido () {
    declare -i indice
    indice=1
    declare -a pedido
    fecha=$(date +"%d-%m-%Y-%H:%M")

    set -f; OLDIFS=$IFS; IFS=";"
    while read codigo nombre precio
    do
        pedido[$indice]=0

        while read producto cantidad
        do
            if (( $indice == $producto ))
            then
                let "pedido[$indice]=${pedido[$indice]} + $cantidad"
            fi
        done < pedidoTemporal.txt

        echo "$indice;${pedido[$indice]}" >> "$1-$fecha.txt"
        indice="$indice + 1"
    done < productos.txt
    set +f; IFS=$OLDIFS

    rm pedidoTemporal.txt
}

borrarProducto () {
    mostrarProductos

    echo -n "Elige la línea del producto que quieres borrar: "
    read producto

    set -f; OLDIFS=$IFS; IFS=";"
    while read linea cantidad
    do
        if (( $linea != $producto ))
        then
            echo "$linea;$cantidad" >> pedidoTemporal2.txt
        fi
    done < pedidoTemporal.txt
    set +f; IFS=$OLDIFS

    rm pedidoTemporal.txt

    while read linea
    do
        echo "$linea;$cantidad" >> pedidoTemporal.txt
    done < pedidoTemporal2.txt

    rm pedidoTemporal2.txt
}

verPedido () {
    echo -e "\033[1;0f\033[2JPedidos"

    ls $1-*

    echo -n "¿Qué pedido quieres ver? "
    read pedido

    if [[ -e $pedido ]]
    then
        mostrarPedido $pedido
    else
        echo "El pedido no existe"
        echo -n "Pulsa una tecla para continuar: "
        read -r
    fi
}

mostrarPedido () {
    declare -i maxProducto
    declare -i maxCant
    declare -i maxPrecioU
    declare -i maxTotal
    maxProducto=0
    maxCant=0
    maxPrecioU=0
    maxTotal=0

    set -f; OLDIFS=$IFS; IFS=";"
    while read codigo nombre precio
    do
        if (( ${#nombre} > $maxProducto ))
        then
            maxProducto=${#nombre}
        fi

        if (( ${#precio} > $maxPrecioU ))
        then
            maxPrecioU=${#precio}
        fi
    done < productos.txt

    echo ""
    echo "Producto             Cant    Precio.U       Total"
    for (( i=0; $i < 49; i++ ))
    do
        echo -n "-"
    done
    echo ""

    declare -i indice
    indice=1
    precioTotal=0
    declare -i espacios

    set -f; OLDIFS=$IFS; IFS=";"
    while read codigo nombre precio
    do
        while read producto cantidad
        do
            if (( $indice == $producto && $cantidad > 0 ))
            then
                precioCantidad=$(echo "scale=2; $cantidad * $precio" | bc -l)
                echo -n "$nombre"
                espacios="25 - ${#nombre} - ${#cantidad}"
                for (( i=0; $i < $espacios; i++ ))
                do
                    echo -n " "
                done
                echo -n "$cantidad"
                espacios="11 - ${#precio}"
                for (( i=0; $i < $espacios; i++ ))
                do
                    echo -n " "
                done
                echo -n "$precio€"
                espacios="11 - ${#precioCantidad}"
                for (( i=0; $i < $espacios; i++ ))
                do
                    echo -n " "
                done
                echo "$precioCantidad€"
                precioTotal=$(echo "scale=2; $precioTotal + $precioCantidad" | bc -l)
            fi
        done < $1

        indice="$indice + 1"
    done < productos.txt
    set +f; IFS=$OLDIFS

    for (( i=0; $i < 49; i++ ))
    do
        echo -n "-"
    done
    echo ""

    for (( i=0; $i < 25; i++ ))
    do
        echo -n " "
    done
    echo -n "Total pedido:"

    espacios="10 - ${#precioTotal}"
    for (( i=0; $i < $espacios; i++ ))
    do
        echo -n " "
    done
    echo "$precioTotal€"

    echo ""
    echo -n "Pulsa una tecla para continuar: "
    read -n 1 seguir
}

clear

read -p "Introduce usuario: " usuario

bash login.sh $usuario

if (( $? == 0 ))
then
    echo -e "\033[1;0f\033[2J1 - Nuevo pedido"
    echo "2 - Ver pedido"
    echo "3 - Salir"
    echo -n "Elige una opción: "
    read -n 1 opcion

    clear

    while (( $opcion != 3 ))
    do
        case $opcion in
            1) nuevoPedido $usuario;;
            2) verPedido $usuario;;
        esac

        if (( $opcion != 3 ))
        then
            clear

            echo -e "\033[1;0f\033[2J1 - Nuevo pedido"
            echo "2 - Ver pedido"
            echo "3 - Salir"
            echo -n "Elige una opción: "
            read -n 1 opcion
        fi
    done
    
    echo -e "\033[1;0f\033[2J¡Hasta otra!"
fi