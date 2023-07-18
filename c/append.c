#include <stdio.h>
#include <stdlib.h>
#include <stddef.h>
#include <string.h>
#include <stdbool.h>

char *append(char *buf, size_t bufsize)
{
	char *temp;
    temp = strncat(buf, ".txt", bufsize);
    printf("%s", temp);
	return temp;
}

int main()
{
	int num;
	FILE *fptr;
	char *cfile;
	char buf[50];
	strcpy(buf, (char*)"arquivo");
	cfile = append(buf, 4);
	while(true){
		fptr = fopen(cfile, "a+");
		if( fptr == NULL )
		{
			printf("\nError");
			exit(1);
		}
		printf("\nEnter num: ");
   		scanf("%d",&num);
	  	fprintf(fptr,"%d\n",num);
	 	fclose(fptr);
	}
	return 0;
}


