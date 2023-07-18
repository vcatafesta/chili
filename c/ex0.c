# include <stdio.h>
# include <stdint.h>
# include <string.h>
# include <stdbool.h>

int main()
{
	int i=0;

	printf("\nex0.c, Copyright(c) 2021, Vilmar Catafesta\n");  
	printf("\n");
	for(i=0; i<20; i++)
	{
		switch(i)
		{
		case 0:
			i += 5;
		case 1:
			i += 2;
		case 5:
			i += 5;
		defaul:
			i += 4;
			break;
		}
			printf("%d ", i);
	}
	printf("\n");
	return 0;
}

