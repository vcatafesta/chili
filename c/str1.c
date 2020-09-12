#include <iostream>
#include<stdio.h>
#include<stdlib.h>
#include<string.h>

using namespace std;

int main() {
    // your code goes here
    int pi_length=11; //Total length 
    char *str1;
    const char *padding="0000000000000000000000000000000000000000";
    const char *myString="Monkey";

    int padLen = pi_length - strlen(myString); //length of padding to apply

    if(padLen < 0) padLen = 0;   

    str1= (char *)malloc(100*sizeof(char));

    sprintf(str1,"%*.*s%s", padLen, padLen, padding, myString);

    printf("%s --> %d \n",str1,strlen(str1));

    return 0;
}
