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

{int} {yylval.val = strdup(yytext); return INT;}
{float} {yylval.val = strdup(yytext); return FLOAT;}
{string} {yylval.val = strdup(yytext); return STRING;}
{command} {yylval.val = strdup(yytext); return COMMAND;}
{key} {yylval.val = strdup(yytext); return KEY;}
{equal} {return EQUAL;}
{comma} {return COMMA;}
{colon} {return COLON;}
\n {return END;}

%%