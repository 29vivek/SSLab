%{
#include <stdio.h>
#include <stdlib.h>

int yyerror();
int yylex();

%}
%token ID NUM FOR LE GE EQ NE OR AND
%right '='
%left AND OR
%left '>' '<' LE GE EQ NE
%left '+' '-'
%left '*' '/'
%right UMINUS
%left '!'

%%
   
S        : ST S  | DEF S |
ST       : FOR '(' E ';' E2 ';' E ')' DEF {printf("Input accepted\n");}
		   | FOR ')' E ';' E2 ';' E ')' DEF {printf("Input not accepted\n");} 
		   | FOR '(' E ';' E2 ';' E '(' DEF {printf("Input not accepted\n");} 
   		   | FOR ')' E ';' E2 ';' E '(' DEF {printf("Input not accepted\n");} 
   		   | FOR '(' E ';' E ')' DEF {printf("Input not accepted\n");} 
           ;
DEF    : '{' BODY '}'
           | E';'
           | ST
           |
           ;
BODY  : BODY BODY
           | E ';'       
           | ST
           |            
           ;
       
E        : ID '=' E
          | E '+' E
          | E '-' E
          | E '*' E
          | E '/' E
          | E '<' E
          | E '>' E
          | E LE E
          | E GE E
          | E EQ E
          | E NE E
          | E OR E
          | E AND E
          | E '+' '+'
          | E '-' '-'
          | ID 
          | NUM
          ;

   
E2     : E'<'E
         | E'>'E
         | E LE E
         | E GE E
         | E EQ E
         | E NE E
         | E OR E
         | E AND E
         ;   
%%

int yyerror(const char *s) {
	printf("Wrong!\n");
	return 1;
}

int main() {
    yyparse();
    return 0;
}
