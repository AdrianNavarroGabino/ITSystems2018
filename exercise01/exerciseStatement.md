# Excercise Statement

1. Realiza un script llamado figuras.sh que reciba un carácter por parámetro (debes comprobar que recibe un parámetro y que la longitud del mismo es de 1 caracter). El programa te mostrará un menú donde tendrás que escoger la figura geométrica a dibujar con el carácter recibido por parámetro. El programa dibujará la figura y volverá a mostrar el menú hasta que elijamos la de salir del programa. Habrá una opción que será 0. Salir. El resto de las opciones serán:

           1. Rectángulo - Te pedirá un ancho y un alto, que deben ser mayores que 0

    *****
    *****
    *****
           2. Cuadrado vacío - Igual que el anterior pero sólo dibujamos los bordes

    *****
    \*   *
    *****
           3. Escalera de bajada - Pedirá un número, que será la base de la escalera.

    *
    **
    ***
    ****
           4. Escalera de subida - Igual que la anterior pero de subida

       *
      **
     ***
    ****
           5. Pirámide - Pedirá el tamaño de la base de la pirámide (la altura no), que deberá ser un número impar

       *
      ***
     *****
    *******
           6. Pirámide vacía - Igual que la anterior pero dibujaremos sólo los bordes

       *
      \* *
     \*   *
    *******
           7. Rombo - Básicamente son casi 2 pirámides, una normal y una invertida, así que pediremos el ancho del rombo (un número impar que será equivalente a la base de la pirámide anterior).

       *
      ***
     *****
    *******
     *****
      ***
       *
2. A partir del archivo fechas.txt,  realiza un script llamado recorrefechas.sh que recorra todas las líneas, y para cada línea:

Comprueba si tiene el formato de una fecha (todas las fechas están en formato dd/mm/aaaa) con una expresión regular. Si tiene un formato de fecha, utiliza el comando expr para extraer el día, mes y año, y muestra la fecha en formato (por ejemplo):
Dia: 05, Mes: 12, Año: 2015
Si no tiene el formato de fecha comprueba la longitud de la cadena (usa expr también) y muestra:
La cadena 'cadena de ejemplo' no es una fecha, y tiene una longitud de 17 caracteres.
Como puedes ver en los apuntes, las líneas de un archivo se recorren de esta forma:

while read linea
do
   # Instrucciones
done < "archivo.txt"