#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main()
{
    int targetStrLen = 10;           // Target output length
    const char *myString="Monkey";   // String for output
    const char *padding="#####################################################";

    int padLen = targetStrLen - strlen(myString); // Calc Padding length
    if(padLen < 0) padLen = 0;    // Avoid negative length

    printf("[%*.*s%s]\n", padLen, padLen, padding, myString);  // LEFT Padding
    printf("[%s%*.*s]\n", myString, padLen, padLen, padding);  // RIGHT Padding
    return 0;
}
