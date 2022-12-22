%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <stdbool.h>

// Definición de la estructura
struct car {
    char *car_name;
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
void show_car(int i) {
	printf("Nombre del coche: %s\n", cars[i].car_name);
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
void show_cars() {
	printf("----------------------------------\n");
	printf("MOSTRANDO TODOS LOS COCHES...\n");
	printf("----------------------------------\n\n");
	if(num_cars <= 0) {
		printf("No hay ningún coche en la base de datos.\n\n");
	} else {
		for(int i = 0; i < num_cars; i++) {
			show_car(i);
		}
	}
}

void empty_car() {
	car.car_name = NULL;
	car.fuel_type = NULL;
	car.engine_displacement = 0;
	car.number_cylinder = 0;
	car.seating_capacity = 0.0;
	car.transmission_type = NULL;
	car.fuel_tank_capacity = 0.0;
	car.body_type = NULL;
	car.rating = 0.0;
	car.starting_price = 0;
	car.ending_price = 0;
	car.max_torque_nm = 0.0;
	car.max_torque_rpm = 0;
	car.max_power_bhp = 0.0;
	car.max_power_rpm = 0;
}

// Función para añadir un coche
void add_car(struct car) {
	printf("---------------------\n");
	printf("AÑADIENDO COCHE...\n");
	printf("---------------------\n\n");
	cars[num_cars] = car;
	show_car(num_cars);
	num_cars++;
	empty_car();
}

// Función para eliminar un coche
void del_car(struct car) {
	printf("---------------------\n");
	printf("ELIMINANDO COCHE...\n");
	printf("---------------------\n\n");
	for(int i = 0; i < num_cars; i++) {
		if(strcmp(cars[i].car_name, car.car_name) == 0) {
			show_car(i);
			for(int j = i; j < num_cars; j++) {
				cars[j] = cars[j+1];
			}
			num_cars--;
			return;
		}
	}
	empty_car();
	printf("No se ha encontrado ningún vehículo con dichos datos.\n\n");
}

// Función para mostrar las estadísticas globales
void cars_stats() {
	if(num_cars <= 0) {
		printf("---------------------------\n");
		printf("ESTADÍSTICAS GLOBALES...\n");
		printf("---------------------------\n\n");
		printf("No hay coches registrados.\n\n");
		return;
	} else {
		printf("---------------------------\n");
		printf("ESTADÍSTICAS GLOBALES...\n");
		printf("---------------------------\n\n");
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
}

void search_by() {
	printf("------------------------------------------------------------\n");
	printf("BUSCANDO VEHÍCULOS QUE CUMPLAN DICHAS CARACTERÍSTICAS...\n");
	printf("------------------------------------------------------------\n\n");
	for(int i = 0; i < num_cars; i++) {
		bool matches = true;
		if (car.car_name != NULL && strcmp(cars[i].car_name, car.car_name) != 0) {
			matches = false;
		}
		if (car.fuel_type != NULL && strcmp(cars[i].fuel_type, car.fuel_type) != 0) {
			matches = false;
		}
		if (car.engine_displacement != 0 && cars[i].engine_displacement != car.engine_displacement) {
			matches = false;
		}
		if (car.number_cylinder != 0 && cars[i].number_cylinder != car.number_cylinder) {
			matches = false;
		}
		if (car.seating_capacity != 0.0 && cars[i].seating_capacity != car.seating_capacity) {
			matches = false;
		}
		if (car.transmission_type != NULL && strcmp(cars[i].transmission_type, car.transmission_type) != 0) {
			matches = false;
		}
		if (car.fuel_tank_capacity != 0.0 && cars[i].fuel_tank_capacity != car.fuel_tank_capacity) {
			matches = false;
		}
		if (car.body_type != NULL && strcmp(cars[i].body_type, car.body_type) != 0) {
			matches = false;
		}
		if (car.rating != 0.0 && cars[i].rating != car.rating) {
			matches = false;
		}
		if (car.starting_price != 0 && cars[i].starting_price != car.starting_price) {
			matches = false;
		}
		if (car.ending_price != 0 && cars[i].ending_price != car.ending_price) {
			matches = false;
		}
		if (car.max_torque_nm != 0 && cars[i].max_torque_nm != car.max_torque_nm) {
			matches = false;
		}
		if (car.max_torque_rpm != 0 && cars[i].max_torque_rpm != car.max_torque_rpm) {
			matches = false;
		}
		if (car.max_power_bhp != 0 && cars[i].max_power_bhp != car.max_power_bhp) {
			matches = false;
		}
		if (car.max_power_rpm != 0 && cars[i].max_power_rpm != car.max_power_rpm) {
			matches = false;
		}
		if (matches) {
			show_car(i);
		}
	}
	empty_car();
}

%}

%union{
	char * val;
}
%token <val> COMMAND
%token <val> KEY
%token <val> STRING
%token <val> INT
%token <val> FLOAT
%token <val> INVALID
%token EQUAL
%token COMMA
%token COLON
%token END
%start S

%%

S: line {
	printf("Final del archivo \n");
}
;

line: /* empty */
	| content line
	| END line {
		printf("Operaciones disponibles:\n ADD_CAR\n DEL_CAR\n SHOW_ALL\n CARS_STATS\n SEARCH_BY\n USAGE_HELP\n EXIT_APP\n");
	}
	| invalid {
		snprintf(buffer, sizeof(buffer), "Archivo de entrada no válido");
		yyerror(buffer); YYERROR;
	}
;

invalid: INVALID END
	| INVALID invalid
;

content: COMMAND COLON data END {
		if (strcmp($1, "ADD_CAR") == 0) {
			add_car(car);
		}
		else if (strcmp($1, "DEL_CAR") == 0) {
			del_car(car);
		}
		else {
			snprintf(buffer, sizeof(buffer), "Comando no reconocido: %s.", $1);
			yyerror(buffer); YYERROR;
		}
	}
	| COMMAND COLON search END {
		if (strcmp($1, "SEARCH_BY") == 0) {
			search_by();
		}
		else {
			snprintf(buffer, sizeof(buffer), "Comando no reconocido: %s.", $1);
			yyerror(buffer); YYERROR;
		}
	}
	| COMMAND END {
		if (strcmp($1, "SHOW_CARS") == 0) {
			show_cars();
		}
		else if (strcmp($1, "CARS_STATS") == 0) {
			cars_stats();
		}
		else if (strcmp($1, "USAGE_HELP") == 0) {
			printf("Operaciones disponibles:\n ADD_CAR\n DEL_CAR\n SHOW_ALL\n CARS_STATS\n SEARCH_BY\n USAGE_HELP\n EXIT_APP\n");
		}
		else if(strcmp($1, "EXIT_APP") == 0) {
			printf("Final de la ejecución \n");
			exit(0);
		}
		else {
			snprintf(buffer, sizeof(buffer), "Comando no reconocido: %s.", $1);
			yyerror(buffer); YYERROR;
		}
	}
	| STRING {
		snprintf(buffer, sizeof(buffer), "Secuencia de contenido no válida: STRING");
		yyerror(buffer); YYERROR;
	}
	| INT {
		snprintf(buffer, sizeof(buffer), "Secuencia de contenido no válida: INT");
		yyerror(buffer); YYERROR;
	}
	| FLOAT {
		snprintf(buffer, sizeof(buffer), "Secuencia de contenido no válida: FLOAT");
		yyerror(buffer); YYERROR;
	}
	| EQUAL {
		snprintf(buffer, sizeof(buffer), "Secuencia de contenido no válida: EQUAL");
		yyerror(buffer); YYERROR;
	}
	| COMMA {
		snprintf(buffer, sizeof(buffer), "Secuencia de contenido no válida: COMMA");
		yyerror(buffer); YYERROR;
	}
	| COLON {
		snprintf(buffer, sizeof(buffer), "Secuencia de contenido no válida: COLON");
		yyerror(buffer); YYERROR;
	}
;

search: /* empty */
	| KEY EQUAL STRING comma search {
		if (strcmp($1, "car_name") == 0) {
			car.car_name = $3;
		}
		else if (strcmp($1, "fuel_type") == 0) {
			car.fuel_type = $3;
		}
		else if (strcmp($1, "transmission_type") == 0) {
			car.transmission_type = $3;
		}
		else if (strcmp($1, "body_type") == 0) {
			car.body_type = $3;
		}
		else {
			printf("Error en la búsqueda, clave %s no existente.\n", $1);
		}
	}
	| KEY EQUAL INT comma search {
		if (strcmp($1, "engine_displacement") == 0) {
			car.engine_displacement = atoi($3);
		}
		else if (strcmp($1, "number_cylinder") == 0) {
			car.number_cylinder = atoi($3);
		}
		else if (strcmp($1, "starting_price") == 0) {
			car.starting_price = atoi($3);
		}
		else if (strcmp($1, "ending_price") == 0) {
			car.ending_price = atoi($3);
		}
		else if (strcmp($1, "max_torque_rpm") == 0) {
			car.max_torque_rpm = atoi($3);
		}
		else if (strcmp($1, "max_power_rpm") == 0) {
			car.max_power_rpm = atoi($3);
		}
		else {
			printf("Error en la búsqueda, clave %s no existente.\n", $1);
		}
	}
	| KEY EQUAL FLOAT comma search {
		if (strcmp($1, "seating_capacity") == 0) {
			car.seating_capacity = atof($3);
		}
		else if (strcmp($1, "fuel_tank_capacity") == 0) {
			car.fuel_tank_capacity = atof($3);
		}
		else if (strcmp($1, "rating") == 0) {
			car.rating = atof($3);
		}
		else if (strcmp($1, "max_torque_nm") == 0) {
			car.max_torque_nm = atof($3);
		}
		else if (strcmp($1, "max_power_bhp") == 0) {
			car.max_power_bhp = atof($3);
		}
	}
;

comma: /* empty */
	| COMMA
;

data: car_name 
	  fuel_type
	  engine_displacement
	  number_cylinder
	  seating_capacity
	  transmission_type
	  fuel_tank_capacity
	  body_type
	  rating
	  starting_price
	  ending_price
	  max_torque_nm
	  max_torque_rpm
	  max_power_bhp
	  max_power_rpm
;

car_name: STRING COMMA {car.car_name = $1;}
	| COMMA {
		snprintf(buffer, sizeof(buffer), "car_name cannot be empty");
		yyerror(buffer); YYERROR;
	}
;

fuel_type: STRING COMMA {
		car.fuel_type = $1;
		if(strcmp("Diesel", car.fuel_type) == 0) num_diesel++;
		else if(strcmp("Petrol", car.fuel_type) == 0) num_petrol++;
		else if(strcmp("CNG", car.fuel_type) == 0) num_cng++;
		else if(strcmp("Electric", car.fuel_type) == 0) num_electric++;
		else {
			snprintf(buffer, sizeof(buffer), "fuel_type could only be: Diesel, Petrol, CNG or Electric");
			yyerror(buffer); YYERROR;
		}
	}
	| COMMA {
		snprintf(buffer, sizeof(buffer), "fuel_type cannot be empty");
		yyerror(buffer); YYERROR;
	}
;

engine_displacement: INT COMMA {
		car.engine_displacement = atoi($1);
		sum_engine_displacement += car.engine_displacement;
	}
	| COMMA {
		snprintf(buffer, sizeof(buffer), "engine_displacement cannot be empty");
		yyerror(buffer); YYERROR;
	}
;

number_cylinder: INT COMMA {
		car.number_cylinder = atoi($1);
		sum_number_cylinder += car.number_cylinder;
	}
	| COMMA {
		snprintf(buffer, sizeof(buffer), "number_cylinder cannot be empty");
		yyerror(buffer); YYERROR;
	}
;

seating_capacity: FLOAT COMMA {
		car.seating_capacity = atof($1);
		sum_seating_capacity += car.seating_capacity;
	}
	| COMMA {
		snprintf(buffer, sizeof(buffer), "seating_capacity cannot be empty");
		yyerror(buffer); YYERROR;
	}
;

transmission_type: STRING COMMA {
		car.transmission_type = $1;
		if(strcmp("Manual", car.transmission_type) == 0) num_manual++;
		else if(strcmp("Automatic", car.transmission_type) == 0) num_automatic++;
		else {
			snprintf(buffer, sizeof(buffer), "transmission_type could only be: Manual or Automatic");
			yyerror(buffer); YYERROR;
		}
	}
	| COMMA {
		snprintf(buffer, sizeof(buffer), "transmission_type cannot be empty");
		yyerror(buffer); YYERROR;
	}
;

fuel_tank_capacity: FLOAT COMMA {
		car.fuel_tank_capacity = atof($1);
		sum_fuel_tank_capacity += car.fuel_tank_capacity;
	}
	| COMMA {
		snprintf(buffer, sizeof(buffer), "fuel_tank_capacity cannot be empty");
		yyerror(buffer); YYERROR;
	}
;

body_type: STRING COMMA {
		car.body_type = $1;
	}
	| COMMA {
		snprintf(buffer, sizeof(buffer), "body_type cannot be empty");
		yyerror(buffer); YYERROR;
	}
;

rating: FLOAT COMMA {
		car.rating = atof($1);
		sum_rating += car.rating;
	}
	| COMMA {
		snprintf(buffer, sizeof(buffer), "rating cannot be empty");
		yyerror(buffer); YYERROR;
	}
;

starting_price: INT COMMA {
		car.starting_price = atoi($1);
		sum_starting_price += car.starting_price;
	}
	| COMMA {
		snprintf(buffer, sizeof(buffer), "starting_price cannot be empty");
		yyerror(buffer); YYERROR;
	}
;

ending_price: INT COMMA {
		car.ending_price = atoi($1);
		sum_ending_price += car.ending_price;
	}
	| COMMA {
		snprintf(buffer, sizeof(buffer), "ending_price cannot be empty");
		yyerror(buffer); YYERROR;
	}
;

max_torque_nm: FLOAT COMMA {
		car.max_torque_nm = atof($1);
		sum_max_torque_nm += car.max_torque_nm;
	}
	| COMMA {
		snprintf(buffer, sizeof(buffer), "max_torque_nm cannot be empty");
		yyerror(buffer); YYERROR;
	}
;

max_torque_rpm: INT COMMA {
		car.max_torque_rpm = atoi($1);
		sum_max_torque_rpm += car.max_torque_rpm;
	}
	| COMMA {
		snprintf(buffer, sizeof(buffer), "max_torque_rpm cannot be empty");
		yyerror(buffer); YYERROR;
	}
;

max_power_bhp: FLOAT COMMA {
		car.max_power_bhp = atof($1);
		sum_max_power_bhp += car.max_power_bhp;
	}
	| COMMA {
		snprintf(buffer, sizeof(buffer), "max_power_bhp cannot be empty");
		yyerror(buffer); YYERROR;
	}
;

max_power_rpm: INT {
		car.max_power_rpm = atoi($1);
		sum_max_power_rpm += car.max_power_rpm;
	}
	| COMMA {
		snprintf(buffer, sizeof(buffer), "max_power_rpm cannot be empty");
		yyerror(buffer); YYERROR;
	}
;

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
void yyerror(char *s) {fprintf (stderr, "Sintaxis incorrecta en línea %d: %s\n", yylineno, s);}