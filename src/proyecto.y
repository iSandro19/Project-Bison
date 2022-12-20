%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

/*
 * To-do:
 * - Complicar la entrada para aumentar la complejidad del parser/bison.
 * - Añadir una simulación de base de datos con structs de structs.
 * - Función para acceder a datos y estadísticas.
 * - Entradas para modificación/consulta de datos.
 * - Tratamentos de erros!
 */

// Definición de la estructura
struct car {
    char *name_car;
    char *fuel_type;
    int engine_displacement;
    int number_cylinder;
    float seating_capacity;
    char *transmission_type;
    float fuel_tank_capacity;
    char *body_type;
    float rating;
    int starting_price;
    int ending_price;
    float max_torque_nm;
    int max_torque_rpm;
    float max_power_bhp;
    int max_power_rpm;
};

// Vector de estructuras que simula la BBDD y una estructura temporal
struct car cars[500];
struct car car;

// Variables para guardar estadísticas globales
int num_cars = 0;
int total_engine_displacement = 0;

// Variables para gestión de errores
void yyerror(char *s);
char buffer[1024];

// Función de print
void show(int i) {
		printf("Nombre del coche: %s\n", cars[i].name_car);
		printf("Tipo de combustible: %s\n", cars[i].fuel_type);
		printf("Cilindrada: %d\n", cars[i].engine_displacement);
		printf("Número de cilindros: %d\n", cars[i].number_cylinder);
		printf("Capacidad de asientos: %f\n", cars[i].seating_capacity);
		printf("Tipo de transmisión: %s\n", cars[i].transmission_type);
		printf("Capacidad del depósito de combustible: %f\n", cars[i].fuel_tank_capacity);
		printf("Tipo de carrocería: %s\n", cars[i].body_type);
		printf("Puntuación: %f\n", cars[i].rating);
		printf("Precio de inicio: %d\n", cars[i].starting_price);
		printf("Precio final: %d\n", cars[i].ending_price);
		printf("Par máximo (Nm): %f\n", cars[i].max_torque_nm);
		printf("Par máximo (rpm): %d\n", cars[i].max_torque_rpm);
		printf("Potencia máxima (bhp): %f\n", cars[i].max_power_bhp);
		printf("Potencia máxima (rpm): %d\n", cars[i].max_power_rpm);
}

// Función para mostrar todos los datos
void show_all() {
	for(int i = 0; i < num_cars; i++) {
		show(i);
	}
}

%}

%union{
	char * val;
}
%token <val> COMMAND
%token <val> STRING
%token <val> INT
%token <val> FLOAT
%token COMMA
%token END

%%

file: line {
		printf("Final del archivo \n");
	}
;

line: /* empty */
	| COMMAND data line {
		if (strcmp($1, "ADD_CAR") == 0) {
			printf("Añadiendo coche...\n");
			cars[num_cars] = car;
			show(num_cars);
			num_cars++;
		}
		else if (strcmp($1, "DEL_CAR") == 0) {
			printf("Eliminando coche...\n");
			show(num_cars);
		}
		else if (strcmp($1, "STATS") == 0) {
			printf("Estadísticas...\n");
		}
		else if (strcmp($1, "HELP") == 0) {
			printf("Operaciones disponibles:\n\tADD_CAR\n\tDEL_CAR\n\tSTATS\n\tSEARCH\n\tHELP\n\tEXIT\n");
		}
		else if (strcmp($1, "SHOW_ALL") == 0) {
			show_all();
		}
		else if(strcmp($1, "EXIT") == 0) {

		}
		else {
			printf("Comando no reconocido.\n");
			printf("Operaciones disponibles:\n\tADD_CAR\n\tDEL_CAR\n\tSTATS\n\tSEARCH\n\tHELP\n\tEXIT\n");
		}
	}
;

data: /* empty */
	| name_car 
	  fuel_type
	  engine_displacement
	  number_cylinder
	  seating_capacity
	  transmission_type
	  fuel_tank_capacity
	  body_type rating
	  starting_price
	  ending_price
	  max_torque_nm
	  max_torque_rpm
	  max_power_bhp
	  max_power_rpm {num_cars++;}
;

name_car: STRING COMMA {car.name_car = $1;};
fuel_type: STRING COMMA {car.fuel_type = $1;};
engine_displacement: INT COMMA {car.engine_displacement = atoi($1);};
number_cylinder: INT COMMA {car.number_cylinder = atoi($1);};
seating_capacity: FLOAT COMMA {car.seating_capacity = atof($1);};
transmission_type: STRING COMMA {car.transmission_type = $1;};
fuel_tank_capacity: FLOAT COMMA {car.fuel_tank_capacity = atof($1);};
body_type: STRING COMMA {car.body_type = $1;} ;
rating: FLOAT COMMA {car.rating = atof($1);};
starting_price: INT COMMA {car.starting_price = atoi($1);};
ending_price: INT COMMA {car.ending_price = atoi($1);};
max_torque_nm: FLOAT COMMA {car.max_torque_nm = atof($1);};
max_torque_rpm: INT COMMA {car.max_torque_rpm = atoi($1);};
max_power_bhp: FLOAT COMMA {car.max_power_bhp = atof($1);};
max_power_rpm: INT END {car.max_power_rpm = atoi($1);};

%%

int main(int argc, char *argv[]) {
extern FILE *yyin;
	switch (argc) {
		case 1:	yyin=stdin;
			yyparse();
			break;
		case 2: yyin = fopen(argv[1], "r");
			if (yyin == NULL) {
				printf("ERROR: No se ha podido abrir el fichero.\n");
			}
			else {
				yyparse();
				fclose(yyin);
			}
			break;
		default: printf("ERROR: Demasiados argumentos.\nSintaxis: %s\n [fichero_entrada]\n\n", argv[0]);
	}

	return 0;
}

extern int yylineno;
void yyerror(char *s) {fprintf (stderr, "Sintaxis incorrecta en línea %d: %s\n\n\n", yylineno, s);}