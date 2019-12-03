%{
#include "y.tab.h"
%}

alpha [a-zA-Z]
digit [0-9]

%option noyywrap

%%

"<="	return LE;
">="	return GE;
"=="	return EQ;
"!="	return NE;
"||"	return OR;
"&&"	return AND;
"=" return EQUALS;
"++" return PP;
"--" return MM;
"+" return PLS;
"-" return MIN;
"*" return MUL;
"/" return DIV;
">" return GREAT;
"<" return LESS;
"(" return OPEN;
")" return CLOSE;
"{" return FLO;
"}" return FLC;
";" return TERM;

[\t \n] ;
"for"	return FOR;
{digit}+	return NUM;
{alpha}({alpha}|{digit})*   return ID;

.	; // ignore other parts of the file

%%

/*
	lex prog5.l
	yacc -d prog5.y
	gcc y.tab.c lex.yy.c
	./a.out < anyfilewhichhasforloops
*/
