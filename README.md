# Project-Bison

## Autores

Óscar Alejandro Manteiga Seoane y Antonio Vila Leis

## Descripción

El objetivo de este proyecto es el parseo y procesado de datos de ficheros de entrada. Estos ficheros tendrán datos e información sobre vehículos, que serán recogidos para cargarlos en memoria. Esto lo haremos con un struct en C para poder acceder a ellos de forma cómoda y realizar estadísticas sobre los datos.

## Ficheros de entrada

Los ficheros de entrada tendrán la siguiente estructura por cada línea:

```txt
car_name, fuel_type, engine_displacement, number_cylinder, seating_capacity, transmission_type, fuel_tank_capacity, body_type, rating, starting_price, ending_price, max_torque_nm, max_torque_rpm, max_power_bhp, max_power_rp
```

Como se puede ver, por cada línea tendremos el nombre de la marca y modelo del vehículo, la cilindrada, número de cilindos... Como se ha mecionado ya, estos datos serán parseados y guardados en memoria para poder realizar operaciones sobre los datos.

## Desarrollo, funcionamiento y peculiaridades

### Desarrollo en 3 etapas

La primera de ellas será la composición del archivo flex de la práctica. En esta parte se edita el fichero proyecto.l para lograr que se identifiquen todos los elementos del .csv.

La segunda parte de la prácticas será la composición del archivo bison/yacc de la práctica correspondiente a la gramática. En esta parte se edita el fichero proyecto.y.

### Funcionamiento

Con el programa en FLEX detectamos todos los caracteres de una cadena de texto o fichero, que se pasan a BISON para que comprobemos con nuestras reglas si coincide con cómo tienen que ser un XML. En caso de que no sea así mostraremos un mensaje de error. Para ejecutarla basta con ejecutar `make all` (compilará y ejecutará los 10 tests con el mensaje explictivo de cada uno) o `make compile` y `make runX` (siendo X el número de test).

### Contenido

- proyecto.l: programa en flex.
- proyecto.y: programa en bison.
- README.md: memoria (este archivo).
- Makefile: archivo para compilar el programa y ejecutarlo
- test.csv: archivos XML para testear el programa.

---

Antonio Vila Leis | Óscar Alejandro Manteiga Seoane | PL 2022/2023
