#include <iostream>
#include <vector>
#include <sstream>
using namespace std;
struct symtab {
    string name;
    string address;
    int value;
    symtab(string a,string b,int c) {
        name = a;
        address = b;
        value = c;
    }
};

vector<symtab> symbol_table;

void display_table() {
    cout<<"....SYMBOL TABLE.... "<<endl;
    cout<<endl;
    cout<<"SYMBOL"<<"\t"<<"ADDRESS"<<"\t"<<"VALUE"<<endl;
    for(int i=0;i<symbol_table.size();i++) {
        cout<<symbol_table[i].name<<"\t"<<symbol_table[i].address<<"\t"<<symbol_table[i].value<<endl;
    }
}

string tohex(int d) {
    stringstream ss;
    ss << hex << d;
    string res = ss.str();
    return res;
}

int todec(string s) {
    int y;
    stringstream ss;
    ss << s;
    ss >> hex >> y;
    return y;
}