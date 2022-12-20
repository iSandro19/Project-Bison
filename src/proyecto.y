%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

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

struct car car;

int num_cars = 0;
int total_engine_displacement = 0;

void yyerror(char *s);
char buffer[1024];
%}

%union{
	char * val;
}
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

line: /*vacio */
  	| name_car fuel_type engine_displacement number_cylinder seating_capacity transmission_type fuel_tank_capacity body_type rating starting_price ending_price max_torque_nm max_torque_rpm max_power_bhp max_power_rpm line {
		printf("Nombre del coche: %s\n", car.name_car);
    	printf("Tipo de combustible: %s\n", car.fuel_type);
    	printf("Cilindrada: %d\n", car.engine_displacement);
    	printf("Número de cilindros: %d\n", car.number_cylinder);
    	printf("Capacidad de asientos: %f\n", car.seating_capacity);
    	printf("Tipo de transmisión: %s\n", car.transmission_type);
    	printf("Capacidad del depósito de combustible: %f\n", car.fuel_tank_capacity);
    	printf("Tipo de carrocería: %s\n", car.body_type);
    	printf("Puntuación: %f\n", car.rating);
    	printf("Precio de inicio: %d\n", car.starting_price);
    	printf("Precio final: %d\n", car.ending_price);
    	printf("Par máximo (Nm): %f\n", car.max_torque_nm);
    	printf("Par máximo (rpm): %d\n", car.max_torque_rpm);
    	printf("Potencia máxima (bhp): %f\n", car.max_power_bhp);
    	printf("Potencia máxima (rpm): %d\n\n", car.max_power_rpm);
	}
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