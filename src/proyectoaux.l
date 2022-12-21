%{
#include <stdlib.h>
#include "proyecto.tab.h"
%}

%option yylineno

command [A-Z]+[_]+[A-Z]+
key [a-z]+[_]+[a-z]+
int [0-9]+
float [0-9.0-9]+
string [a-zA-Z0-9 -]+
comma [,]+
equal [=]+
colon [:]+

%%

{command} {printf("command (%s) | ", yytext);}
{key} {printf("key (%s) | ", yytext);}
{int} {printf("int (%s) | ", yytext);}
{float} {printf("float (%s) | ", yytext);}
{string} {printf("string (%s) | ", yytext);}
{equal} {printf("equal ");}
{comma} {printf("comma ");}
{colon} {printf("colon ");}
\n {printf("\n");}

%%

int main() {
	yylex();
}