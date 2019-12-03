%{
    #include <iostream>
    #include <stdio.h>
    using namespace std;
    #include "prog1.h"
    int sflag = 0,adflag=0,symflag=0,oflag=0;
    string s;
    string temp;   
    int locctr = 0;
%}
%option noyywrap

%%
[ ]  { }

"START" {
            sflag = 1;
}

"END"   {
            display_table();
}

"LDA"|"STA"|"ADD"|"SUB" {
            oflag = 1;
} 

"RESW"|"WORD"|"BYTE"    {
            adflag = 1;
}

[a-zA-Z]+   {
                if(!oflag) {
                    s.assign(yytext,yyleng);
                    symflag = 1;
                    temp = s;
                }
}

[0-9]+  {
            s.assign(yytext,yyleng);
            if(sflag==1) {
                locctr = todec(s);
                locctr+=3;
            }
            if(adflag==1 && symflag==1)
                symbol_table.push_back(symtab(temp,tohex(locctr),stoi(s)));
            if(adflag==1) {
                locctr+=3*(stoi(s));
            }
}

[\n]    {
        if(oflag==1 && symflag==1) {
            symbol_table.push_back(symtab(temp,tohex(locctr),0));
        }
        if(oflag==1) {
            locctr+=3;
        }
        adflag=0;sflag=0;oflag=0;symflag=0;
}
%%
int main() {
    cout<<"Scanning assembly code..."<<endl;
    yyin = fopen("input.txt","r");
    yylex();
    return 0;
}