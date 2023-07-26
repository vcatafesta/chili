#include <stdio.h>

int main()
{
	int account;
	char name[30];
	double balance;

	FILE *cfPtr;
	if ((cfPtr=fopen("clients.dat","r"))==NULL)
	{
		printf("File could not be opened.\n");
	}
	else
	{
		printf("%-10s%-13s%s\n","Account","Name","Balance");
		fscanf(cfPtr,"%d%s%lf",&account,name,&balance);
		while(!feof(cfPtr))
		{
			printf("%-10d%-13s%lf\n",account,name,balance);
			fscanf(cfPtr,"%d%s%lf",&account,&name,&balance);
		}
		fclose(cfPtr);
	}
	return 0;
}
