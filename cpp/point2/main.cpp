#include <stdio.h>
#include <stdlib.h>
#include <conio.h>
#include <iostream>
#include <iomanip>
#include <string.h>

using namespace std;

char *space(int x, char c=32);
int nlen(char *p[]);
int nlen(char *p);
int main2();
void mat(char *a)
{
    int i,j;

    cout << sizeof(&a[0]) << endl;
    cout << sizeof(a) / sizeof(a[0]) <<endl;
    for(i = 0; i < 3; i++) {
        for(j = 0; j < 2; j++)
            printf("%3c ", *(a + (i * 2) + j));
        printf("\n");
    }
}

int main(){
    string cnome = "VILMAR";
    cnome       += " CATAFESTA";

    char a[] = "Hello";
    char *p  = "Hello";

    cout << sizeof(a) << endl;
    cout << sizeof(p) / sizeof(p[0]) <<endl;
    nlen(p);


    char b[3][2] = { {'k','8'}, {'h','f'}, {'a','b'}};
    cout << sizeof(b) << endl;
    cout << sizeof(b) / sizeof(b[0]) <<endl;

    mat(&b[0][0]);

    char *c[] = { "Um", "dois", "tres"};
    nlen(&c[0]);

    return(0);
}

int nlen(char *p)
{
    int n = strlen(p);
    cout << space(40,'-') << endl;
    cout << n << endl;
    cout << p << endl;
    cout << space(40,'-') << endl;
    for(int x=0; x<n; x++)
    {
        cout << setw(10) << p[x] << *p << *(p+x) << endl;
    }
    cout << endl << endl;
    cout << space(40,'-') << endl;

    while(*p)
    {
        cout << setw(10) << p << " "  << *p << " " << &p << endl;
        *p++;
    }
    cout << space(40,'-') << endl;
    cout << sizeof(p) << endl;
    cout << sizeof(p) / sizeof(p[0]) <<endl;

    return 0;
}

char *space(int x, char c)
{
     char *buf= (char*)malloc(x);
     if(buf)
        memset(buf, c, x);
     buf[x] = '\0';
     return buf;
}


int nlen(char *p[])
{
    int n = 3;
    cout << space(40,'-') << endl;
    cout << n << endl;
    cout << p << endl;
    cout << space(40,'-') << endl;
    for(int x=0; x<n; x++)
    {
        cout << setw(10) << p[x] << " "  << *p << " " << *(p+x) << endl;
    }
    cout << endl << endl;
    cout << space(40,'-') << endl;

    while(**p != NULL)
    {
           cout << setw(10) << p << " " << *p << " "  << *p << " " << &p << endl;
           *p++;
    }
    cout << space(40,'-') << endl;
    //cout << sizeof(p) << endl;
    //cout << sizeof(p) / sizeof(p[0]) <<endl;
    getch();

    return 0;
}



