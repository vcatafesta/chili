#include <stdio.h>
#include <stdlib.h>

struct person
{
	int id;
	char fname[20];
	char lname[20];
};

int main ()
{
	FILE *infile;
	struct person input;

	infile = fopen ("person.dat", "r");
	if (infile == NULL)
	{
		fprintf(stderr, "\nError opening file\n");
		exit (1);
	}

	while(fread(&input, sizeof(struct person), 1, infile))
		printf ("id = %d name = %s %s\n", input.id,
		input.fname, input.lname);

	fclose (infile);
	return 0;
}

