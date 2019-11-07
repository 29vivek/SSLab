%{
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
int line=0,valid=0,no=0;
struct opcode
{
	char operand[10];
	char opcode[10];
};
struct opcode ref[4]={{"add ","0C"},{"sub ","0D"},{"lda ","AB"},{"sta ","18"}};

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
ST :  INST ST {valid=1;}
    |
INST : LABEL INSTRUCTION SYM{line++;
				if(findkey($2))
				{	
					for(int i=0;i<4;i++)
					{
						if(strcmp(ref[i].operand,$2)==0)
						{
							strcpy(s[no].res_opcode,ref[i].opcode);
							strcpy(s[no].res_operand,$2);
							s[no].line = line;
							break;
						}
					}
					no++;
				} 
			    }
     | INSTRUCTION SYM{line++;
				if(findkey($1))
				{
					
					for(int i=0;i<4;i++)
					{
						if(strcmp(ref[i].operand,$1)==0)
						{
							strcpy(s[no].res_opcode,ref[i].opcode);
							strcpy(s[no].res_operand,$1);
							s[no].line = line;
							break;
						}
					}
					no++;
				} 
				}
     
LABEL : SYMBOL{;}
SYM : SYMBOL{;}
    | CONSTANT{;};
%%
int yyerror()
{
	printf("ERROR in CODE\n");
	exit(0);
}
extern FILE *yyin;
int main()
{
	FILE *fp;
	fp=fopen("sic.asm","r");
	yyrestart(fp);
	yyparse();
	if(valid==1)
		printf("VALID INSTRUCTION\n");
	printf("\n\n----OPTAB CONTENTS\n");
	printf("INSTRUCTION\tLINE_NO\tOPCODE\n");
	for(int i=0; i<no; i++)
	{
		printf("\n%s\t\t%d\t\t%s",s[i].res_operand,s[i].line,s[i].res_opcode);
	}
	printf("\n");
	printf("%d",no);
	return 0;
}

