%{
    #include<stdio.h>
    int flag=0;
    void yyerror();
    int yylex();
%}
%token NUMBER TERM

%left '+' '-'
%left '*' '/' '%'
%left '(' ')'
%%
EXPRN: E TERM {
         printf("\nResult=%d\n",$$);
         flag=0;
        }
        ;
E:E'+'E {$$=$1+$3;}
 |E'-'E {$$=$1-$3;}
 |E'*'E {$$=$1*$3;}
 |E'/'E {$$=$1/$3;}
 |E'%'E {$$=$1%$3;}
 |'('E')' {$$=$2;}
 | NUMBER {$$=$1;}
;
%%

int main()
{
 	printf("\nEnter expression:\n");
    yyparse();
 	if(flag==0)
   		printf("\nEntered arithmetic expression is Valid\n\n");
   	flag=0;
}
void yyerror()
{
    printf("\nEntered arithmetic expression is Invalid\n\n");
    flag=1;
}
