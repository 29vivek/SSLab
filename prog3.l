%{
#include<stdio.h>
#include "y.tab.h"
extern int yylval;
%}

%option noyywrap

%%
[0-9]+ 	{
          yylval=atoi(yytext);
          return NUMBER;
       	}
[ \t] 	;
[\n] 	return TERM;
. 		return yytext[0];
%%


/*	lex prog3.l
	yacc -d prog3.y
	gcc lex.yy.c y.tab.c
	./a.out
*/
