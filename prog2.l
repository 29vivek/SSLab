%option noyywrap
%{
#include "y.tab.h"
#include<stdio.h>
#include<string.h>
%}
%%
"LDA "|"STA "|"ADD "|"SUB "|"START "|"END "|"WORD "|"RESW " {
		yylval.string=strdup(yytext); 
		return INSTRUCTION;
	}
[a-zA-Z]* { yylval.string=strdup(yytext); return SYMBOL; }
[0-9]+ { yylval.number=atoi(yytext); return CONSTANT; }
[\n] ;
. ;
%%

/*	lex prog2.l
	yacc -d prog2.y
	gcc lex.yy.c y.tab.c
	./a.out
*/
