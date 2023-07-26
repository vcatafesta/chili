#include <stdio.h>

void print2darray(int p[3][3], int r, int c);

int main(){
	int arr[3][3] = {
		{1,2,3},
		{4,5,6},
		{7,8,9}
	};

	print2darray(arr, 3, 3);
}

void print2darray(int p[3][3], int r, int c)
{
	int i;
	int j;

	for(i=0; i < r; i++)
	{
		for(j=0; j < c; j++)
		{
			printf("%d ", p[i][j]);
		}
		printf("\n");
	}
}

