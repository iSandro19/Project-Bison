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

%%

line:
    STRING COMMA STRING COMMA INT COMMA INT COMMA FLOAT COMMA STRING COMMA FLOAT COMMA STRING COMMA FLOAT COMMA INT COMMA INT COMMA FLOAT COMMA INT COMMA FLOAT COMMA INT COMMA
    {printf("Sintaxis XML correcta (1).\n\n");}
  | STRING COMMA STRING COMMA INT COMMA INT COMMA FLOAT COMMA STRING COMMA FLOAT COMMA STRING COMMA FLOAT COMMA INT COMMA INT COMMA INT COMMA INT COMMA FLOAT COMMA INT COMMA FLOAT COMMA INT COMMA
    {printf("Sintaxis XML correcta (2).\n\n");}
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
		default: printf("ERROR: Demasiados argumentos.\nSintaxis: %s [fichero_entrada]\n\n", argv[0]);
	}

	return 0;
}

extern int yylineno;
void yyerror(char *s) {fprintf (stderr, "Sintaxis XML incorrecta en línea %d. %s\n\n", yylineno, s);}