%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

/*
 * To-do:
 * - Función para acceder a datos.
 * - Entradas para modificación/consulta de datos.
 * - Tratamiento de errores.
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
int num_diesel = 0;
int num_petrol = 0;
int num_cng = 0;
int num_electric = 0;
int sum_engine_displacement = 0;
int sum_number_cylinder = 0;
int sum_seating_capacity = 0;
int num_automatic = 0;
int num_manual = 0;
int sum_fuel_tank_capacity = 0;
int sum_rating = 0;
int sum_starting_price = 0;
int sum_ending_price = 0;
int sum_max_torque_nm = 0;
int sum_max_torque_rpm = 0;
int sum_max_power_bhp = 0;
int sum_max_power_rpm = 0;

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
	printf("Potencia máxima (rpm): %d\n\n", cars[i].max_power_rpm);
}

// Función para mostrar todos los datos
void show_all() {
	for(int i = 0; i < num_cars; i++) {
		printf("Mostrando coche %d...\n", i+1);
		show(i);
	}
}

void add_car(struct car) {
	printf("Añadiendo coche...\n");
	cars[num_cars] = car;
	show(num_cars);
	num_cars++;
}

void del_car(struct car) {
	printf("Eliminando coche...\n");
	for(int i = 0; i < num_cars; i++) {
		if(strcmp(cars[i].name_car, car.name_car) == 0) {
			show(i);
			for(int j = i; j < num_cars; j++) {
				cars[j] = cars[j+1];
			}
			num_cars--;
			break;
		}
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
	| car line
;

car: COMMAND data END {
		if (strcmp($1, "ADD_CAR") == 0) {
			add_car(car);
		}
		else if (strcmp($1, "DEL_CAR") == 0) {
			del_car(car);
		}
		else if (strcmp($1, "USAGE_HELP") == 0) {
			printf("Operaciones disponibles:\n ADD_CAR\n DEL_CAR\n SHOW_ALL\n STATS\n SEARCH\n HELP\n EXIT\n");
		}
		else if (strcmp($1, "SHOW_ALL") == 0) {
			show_all();
		}
		else if(strcmp($1, "EXIT_APP") == 0) {
			printf("Final de la ejecución \n");
			exit(0);
		}
		else if (strcmp($1, "CARS_STATS") == 0) {
			printf("Estadísticas...\n");
			printf("Número de coches registrados: %d\n", num_cars);
			printf("Número de coches diesel: %d\n", num_diesel);
			printf("Número de coches gasolina: %d\n", num_petrol);
			printf("Número de coches a gas: %d\n", num_cng);
			printf("Número de coches eléctricos: %d\n", num_electric);
			printf("Media de cilindrada: %d\n", sum_engine_displacement/num_cars);
			printf("Media de número de cilindros: %d\n", sum_number_cylinder/num_cars);
			printf("Media de capacidad de asientos: %d\n", sum_seating_capacity/num_cars);
			printf("Número de coches con cambio manual: %d\n", num_manual);
			printf("Número de coches con cambio automático %d\n", num_automatic);
			printf("Media de capacidad del depósito de combustible: %d\n", sum_fuel_tank_capacity/num_cars);
			printf("Media de valoración de los vehículos: %d\n", sum_rating/num_cars);
			printf("Coste medio: %d\n", ((sum_starting_price + sum_ending_price)/2)/num_cars);
			printf("Media de par máximo (Nm): %d\n", sum_max_torque_nm/num_cars);
			printf("Media de par máximo (rpm): %d\n", sum_max_torque_rpm/num_cars);
			printf("Media de potencia (bhp): %d\n", sum_max_power_bhp/num_cars);
			printf("Media de potencia (rpm): %d\n\n", sum_max_power_rpm/num_cars);
		}
		else {
			printf("Comando no reconocido.\n");
			printf("Operaciones disponibles:\n ADD_CAR\n DEL_CAR\n SHOW_ALL\n STATS\n SEARCH\n HELP\n EXIT\n");
		}
	}

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
	  max_power_rpm
;

name_car: STRING COMMA {car.name_car = $1;};

fuel_type: STRING COMMA {
	car.fuel_type = $1;
	if(strcmp("Diesel", car.fuel_type) == 0) num_diesel++;
	else if(strcmp("Petrol", car.fuel_type) == 0) num_petrol++;
	else if(strcmp("CNG", car.fuel_type) == 0) num_cng++;
	else if(strcmp("Electric", car.fuel_type) == 0) num_electric++;
};

engine_displacement: INT COMMA {
	car.engine_displacement = atoi($1);
	sum_engine_displacement += car.engine_displacement;
};

number_cylinder: INT COMMA {
	car.number_cylinder = atoi($1);
	sum_number_cylinder += car.number_cylinder;
};

seating_capacity: FLOAT COMMA {
	car.seating_capacity = atof($1);
	sum_seating_capacity += car.seating_capacity;
};

transmission_type: STRING COMMA {
	car.transmission_type = $1;
	if(strcmp("Manual", car.transmission_type) == 0) num_manual++;
	else if(strcmp("Automatic", car.transmission_type) == 0) num_automatic++;
};

fuel_tank_capacity: FLOAT COMMA {
	car.fuel_tank_capacity = atof($1);
	sum_fuel_tank_capacity += car.fuel_tank_capacity;
};

body_type: STRING COMMA {car.body_type = $1;};

rating: FLOAT COMMA {
	car.rating = atof($1);
	sum_rating += car.rating;
};

starting_price: INT COMMA {
	car.starting_price = atoi($1);
	sum_starting_price += car.starting_price;
};

ending_price: INT COMMA {
	car.ending_price = atoi($1);
	sum_ending_price += car.ending_price;
};

max_torque_nm: FLOAT COMMA {
	car.max_torque_nm = atof($1);
	sum_max_torque_nm += car.max_torque_nm;
};

max_torque_rpm: INT COMMA {
	car.max_torque_rpm = atoi($1);
	sum_max_torque_rpm += car.max_torque_rpm;
};

max_power_bhp: FLOAT COMMA {
	car.max_power_bhp = atof($1);
	sum_max_power_bhp += car.max_power_bhp;
};

max_power_rpm: INT {
	car.max_power_rpm = atoi($1);
	sum_max_power_rpm += car.max_power_rpm;
};

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