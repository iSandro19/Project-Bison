# Project-Bison

## Autores

Óscar Alejandro Manteiga Seoane y Antonio Vila Leis

## Descripción

El objetivo de este proyecto es el parseo y procesado de datos de ficheros de entrada. Estos ficheros tendrán datos e información sobre vehículos u operaciones sobre lo que tenemos almacenado en memoria. Podremos especificar si queremos añadir esos datos a una base de datos simulada en C a base de structs, eliminarlos, hacer búsquedas, estadísticas...

## Ficheros de entrada

Los ficheros de entrada tendrán la siguiente estructura por cada línea. En primer lugar, para añadir un vehícuo se realizará de la siguiente manera:

```txt
ADD_CAR:car_name,fuel_type,engine_displacement,number_cylinder,seating_capacity,transmission_type,fuel_tank_capacity,body_type,rating,starting_price,ending_price,max_torque_nm,max_torque_rpm,max_power_bhp,max_power_rp
```

Para eliminar un vehículo se realizará así (tenemos que especificar todos los datos para evitar borrar modelos indeseados):

```txt
DEL_CAR:car_name,fuel_type,engine_displacement,number_cylinder,seating_capacity,transmission_type,fuel_tank_capacity,body_type,rating,starting_price,ending_price,max_torque_nm,max_torque_rpm,max_power_bhp,max_power_rp
```

Si queremos obtener estadísticas globales de todos los vehículos de nuestra base de datos podemos escribir lo siguiente:

```txt
CARS_STATS
```

Si queremos que se muestre por pantalla todos los vehículos:
  
```txt
SHOW_CARS
```

Podemos buscar coches en la base de datos con las características que necesitemos de la siguiente manera:

```txt
SEARCH_BY:fuel_type=Diesel,seating_capacity=5.0
SEARCH_BY:transmission_type=Automatic
```

Para ver todos los comandos en le ejecución podemos hacer:

```txt
USAGE_HELP
```

Finalmente para salir:

```txt
EXIT_APP
```

Resumen:

- Añadir coche (ADD_CAR).
- Eliminar coche (DEL_CAR).
- Visualización de todos los datos (SHOW_CARS).
- Búsqueda (SEARCH_BY)
- Estadísticas globales (CARS_STATS).
- Ayuda (USAGE_HELP).
- Salir (EXIT_APP).

## Desarrollo, funcionamiento y peculiaridades

### Desarrollo en 3 etapas

La primera de ellas será la composición del archivo flex de la práctica. En esta parte se edita el fichero proyecto.l para lograr que se identifiquen todos los elementos que componen a los .car (ficheros de entrada). Estos elementos son los commandos (palabras en mayúscula con barra baja), las claves (palabras en minúscula con barra baja), los strings (palabras con minúsculas/mayúsculas/enteros/espacios/guiones), enteros, flotantes, la coma, los dos puntos y el signo igual. A mayores identificamos el retorno de carro (para detectar el final de linea) y el resto de caracteres (para detección de fallos).

La segunda parte de la prácticas será la composición del archivo bison/yacc de la práctica correspondiente a la gramática. En esta parte se edita el fichero proyecto.y. Añadimos a la gramática todas las combinaciones que acepta, procurando recoger todos los errores posibles.

La tercera etapa, la construcción de los tests, la fuimos desarrollando a lo largo de las 2 anteriores para ir comprobando que todo lo que realizábamos seguía funcionando correctamente.

### Funcionamiento

Con el programa en FLEX detectamos todos los caracteres de una cadena de texto o fichero, que se pasan a BISON para que comprobemos con nuestras reglas si coincide con cómo tienen que ser. En caso de que no sea así mostraremos un mensaje de error. Para ejecutarla basta con ejecutar `make all` (compilará y ejecutará los 6 tests con el mensaje explictivo de cada uno) o `make compile` y `make runX` (siendo X el número de test). Los runs del 1 al 5 son para comprobar funcionalidades, siendo el run6 el que se encarga de comprobar errores varios.

### Contenido

- proyecto.l: programa en flex.
- proyecto.y: programa en bison.
- README.md: memoria (este archivo).
- Makefile: archivo para compilar el programa y ejecutarlo.
- test.car: archivo de entrada para comprobar el funcionamiento.

---

Antonio Vila Leis | Óscar Alejandro Manteiga Seoane | PL 2022/2023
