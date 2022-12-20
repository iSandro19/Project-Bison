%{
#include <stdio.h>
#include <string.h>

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
	}
;

name_car:
	STRING COMMA {
		char * str = $1;
		printf("Nombre del coche: %s\n", str);
	}
;

fuel_type:
	STRING COMMA {
		char * str = $1;
		printf("Tipo de combustible: %s\n", str);
	}
;

engine_displacement:
	INT COMMA {
		char * str = $1;
		printf("Cilindrada: %s\n", str);
	}
;

number_cylinder:
	INT COMMA {
		char * str = $1;
		printf("Número de cilindros: %s\n", str);
	}
;

seating_capacity:
	FLOAT COMMA {
		char * str = $1;
		printf("Capacidad de asientos: %s\n", str);
	}
;

transmission_type:
	STRING COMMA {
		char * str = $1;
		printf("Tipo de transmisión: %s\n", str);
	}
;

fuel_tank_capacity:
	FLOAT COMMA {
		char * str = $1;
		printf("Capacidad del depósito de combustible: %s\n", str);
	}
;

body_type:
	STRING COMMA {
		char * str = $1;
		printf("Tipo de carrocería: %s\n", str);
	}
;

rating:
	FLOAT COMMA {
		char * str = $1;
		printf("Puntuación: %s\n", str);
	}
;

starting_price:
	INT COMMA {
		char * str = $1;
		printf("Precio de inicio: %s\n", str);
	}
;

ending_price:
	INT COMMA {
		char * str = $1;
		printf("Precio final: %s\n", str);
	}
;

max_torque_nm:
	FLOAT COMMA {
		char * str = $1;
		printf("Par máximo (Nm): %s\n", str);
	}
;

max_torque_rpm:
	INT COMMA {
		char * str = $1;
		printf("Par máximo (rpm): %s\n", str);
	}
;

max_power_bhp:
	FLOAT COMMA {
		char * str = $1;
		printf("Potencia máxima (bhp): %s\n", str);
	}
;

max_power_rpm:
	INT END {
		char * str = $1;
		printf("Potencia máxima (rpm): %s\n\n", str);
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
void yyerror(char *s) {fprintf (stderr, "Sintaxis incorrecta en línea %d: %s\n\n\n", yylineno, s);}