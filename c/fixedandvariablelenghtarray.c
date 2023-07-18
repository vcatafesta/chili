#include "funcoes.c"

const int ARRAY_LENGTH = 5;

void printarray0(int myarray[ARRAY_LENGTH]){
	int i;
	for(i=0;i<ARRAY_LENGTH;i++){
		printf("%i, ", myarray[i]);
	}
	printf("\n");
}

void printarray1(int *myarray, int length){
	int i;
	for(i=0;i<length;i++){
		printf("%i, ", myarray[i]);
	}
	printf("\n");
}

int main(int argc, char **argv){
	int a[ARRAY_LENGTH] = {1,2,3,4,5};
	int b[ARRAY_LENGTH] = {5,4,3,2,1};
#ifdef __cplusplus
	int *p              = new int[15];
#else
	int *p              = (int *)malloc(sizeof(int) * 15);
#endif
	int i;
	for(i=0;i<15;i++){
		p[i] = i;
	}

	int arglengths[argc];
	for(i=0;i<argc;i++){
		arglengths[i] = strlen(argv[i]);
	}

	p = (int *)realloc(p, sizeof(int) *20);

	printarray0(a);
	printarray0(b);
	printarray0(p);
	printarray1(a, ARRAY_LENGTH);
	printarray1(b, ARRAY_LENGTH);
	printarray1(p, 20);
	printarray1(arglengths, argc);

#ifdef __cplusplus
	delete[] p;
#else
	free(p);
#endif
	
	return 0;
}



