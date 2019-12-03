%{
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
int line=0,valid=0,no=0;
int yylex();
int yyerror();
struct opcode
{
	char operand[10];
	char opcode[10];
};
struct opcode ref[4]={{"ADD ","0C"},{"SUB ","0D"},{"LDA ","AB"},{"STA ","18"}};

struct optable
{
 	char res_operand[10];
 	int line;
 	char res_opcode[10];
}s[10];

int findkey(char *name)
{
	int i;
	for(i=0;i<4;i++)
		if(strcmp(name,ref[i].operand)==0)
			return 1;
	return 0;
}

%}
%union
{
	char *string;
	int number;
}
%token <number> CONSTANT
%token <string> INSTRUCTION
%token <string> SYMBOL
%%
ST: INST ST { valid=1; }
  	|
  	;
INST: LABEL INSTRUCTION SYM { 
		line++;
		if(findkey($2)) {	
			for(int i=0;i<4;i++) {
				if(strcmp(ref[i].operand,$2)==0) {
					strcpy(s[no].res_opcode,ref[i].opcode);
					strcpy(s[no].res_operand,$2);
					s[no].line = line;
					break;
				}
			}
			no++;
		} 
	}
    | INSTRUCTION SYM {
    	line++;
		if(findkey($1)) {
			for(int i=0;i<4;i++) {
				if(strcmp(ref[i].operand,$1)==0){
					strcpy(s[no].res_opcode,ref[i].opcode);
					strcpy(s[no].res_operand,$1);
					s[no].line = line;
					break;
				}
			}
			no++;
		} 
	}
    ; 
LABEL: SYMBOL;
SYM: SYMBOL
    | CONSTANT
    ;
%%

int yyerror()
{
	printf("error\n");
	return 1;
}

extern FILE *yyin;
int main()
{
	FILE *fp;
	fp=fopen("input.txt","r");
	yyin=fp;
	yyparse();
	if(valid==1)
		printf("valid instruction\n");
	
	printf("optable has: \n");
	printf("instr\tline\topcode\n");
	for(int i=0; i<no; i++)
		printf("\n%s\t%d\t%s",s[i].res_operand,s[i].line,s[i].res_opcode);
	
	printf("\n");
	return 0;
}

