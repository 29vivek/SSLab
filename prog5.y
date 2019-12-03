%{
#include <stdio.h>
#include <stdlib.h>

int yyerror();
int yylex();

%}

%token ID NUM FOR LE GE EQ NE OR AND LESS GREAT PLS MIN MUL DIV EQUALS PP MM TERM OPEN CLOSE FLO FLC
%right EQUALS
%left AND OR
%left LESS GREAT LE GE EQ NE
%left PLS MIN
%left MUL DIV
%left PP MM
%%
   
S: STMT S 
    |
    ;
STMT: FOR OPEN E TERM E2 TERM E CLOSE DEF { printf("Input accepted\n"); }
    ;
DEF: FLO BODY FLC
    | E TERM
    | STMT 
    | TERM
    ;
NRML: E TERM NRML
    |
    ;
BODY: STMT
    | NRML
    ;
E: ID EQUALS E
    | E PLS E
    | E MIN E
    | E MUL E
    | E DIV E
    | E LESS E
    | E GREAT E
    | E LE E
    | E GE E
    | E EQ E
    | E NE E
    | E OR E
    | E AND E
    | E PP
    | E MM
    | ID 
    | NUM
    ;
E2: E LESS E
    | E GREAT E
    | E LE E
    | E GE E
    | E EQ E
    | E NE E
    | E OR E
    | E AND E
    ;   

%%

int yyerror(const char *s) 
{
	printf("Wrong!\n");
	return 0;
}

int main() { 
    yyparse();
    return 0;
}
