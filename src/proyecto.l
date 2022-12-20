%{
#include <stdlib.h>
#include "proyecto.tab.h"
%}

%option yylineno

int [0-9]+
float [0-9.0-9]+
string [a-zA-Z0-9 \-()]+
comma [, ]+

%%

{int} {yylval.val = strdup(yytext); return INT;}
{float} {yylval.val = strdup(yytext); return FLOAT;}
{string} {yylval.val = strdup(yytext); return STRING;}
{comma} {return COMMA;}
\n {return END;}

%%