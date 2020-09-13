#include <stdio.h>
#include <string.h>

int main(void) {
    char buf[BUFSIZ] = { 0 };
    char str[] = "Hello";
    char fill = '#';
    int width = 20; /* or whatever you need but less than BUFSIZ ;) */

    printf("%s%s\n", (char*)memset(buf, fill, width - strlen(str)), str);

    return 0;
}
