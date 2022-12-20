%{
#include <stdlib.h>
#include "proyecto.tab.h"
%}

%option yylineno

command [A-Z_]+
int [0-9]+
float [0-9.0-9]+
string [a-zA-Z0-9 \-()]+
comma [, ]+

%%

{int} {yylval.val = strdup(yytext); return INT;}
{float} {yylval.val = strdup(yytext); return FLOAT;}
{string} {yylval.val = strdup(yytext); return STRING;}
{command} {yylval.val = strdup(yytext); return COMMAND;}
{comma} {return COMMA;}
\n {return END;}

%%