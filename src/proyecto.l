%{
#include <stdlib.h>
#include "proyecto.tab.h"
%}

%option yylineno

string [a-zA-Z ]+
int [0-9]+
float [0-9]+\.[0-9]+
comma [, ]+

%%

{string} {yylval.val = strdup(yytext); return STRING;}
{int} {yylval.val = strdup(yytext); return INT;}
{float} {yylval.val = strdup(yytext); return FLOAT;}
{comma} {return COMMA;}
. {}

%%