%option noyywrap
%{
#include<stdio.h>
#include<string.h>
char svalue[10],saddress[10],sname[10],num_words[10];
int val=0,add=0,n_words=0,line=0,symsize=0;

struct symtab
{
	char name[10];
	int value;
	int address;
}s[10];

void extract_tail(char src[10],char dest[10],int from)
{
	int i=0;
	for(int j=from;j<yyleng;j++)
	{
		dest[i++]=src[j];
	}
	dest[i]='\0';
}

int st_check(char sn[10])
{
	int i,j;
	for(i=0;i<symsize;i++)
	{
		if(strcmp(s[i].name,sn)==0)
			return 1;
	}
	return 0;
}

void st_insert(char sn[10], int *valu,int *addr)
{
	if(valu!=NULL && addr!=NULL)
	{
		for(int i=0;i<symsize;i++)
		{
			if(strcmp(sn,s[i].name)==0)
			{
				s[i].value=*valu;
				s[i].address=*addr;
			}
		}
		return;
	}
	
		s[symsize].value=(int)NULL;
		s[symsize].address=(int)NULL;
		strcpy(s[symsize].name,sn);
		symsize++;
	
	return ;
}

void display()
{
	int i;
	printf("SYMBOL\tVALUE\tADDRESS\n");
	for(i=0;i<symsize;i++)
	{
		printf("%s\t%d\t%x\n",s[i].name,s[i].value,s[i].address);
	}
}

%}
%%
"start "[0-9]+ {extract_tail(yytext,saddress,6); add=(int)strtol(saddress,NULL,16);}
"end" {;}
"lda"|"sta"|"add"|"sub" {st_insert(sname,&val,&add); add=add+0x3;}
"word "[0-9]+ {extract_tail(yytext,svalue,5); val=atoi(svalue); st_insert(sname,&val,&add); add=add+0x3;}
"resw "[0-9]+ {extract_tail(yytext,num_words,5); n_words=atoi(num_words); val=0; st_insert(sname,&val,&add); add=(n_words*0x3)+add;}
[a-zA-Z]* {extract_tail(yytext,sname,0); val=0; if(!st_check(sname)){st_insert(sname,NULL,NULL);} }
. ;
%%

int main()
{
	yyin=fopen("sic.asm","r");
	yylex();
	display();
	return 0;
}

/* 	lex prog1.l
	gcc lex.yy.c 
	./a.out
*/

