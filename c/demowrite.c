#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct _iobuf_ {
   char*   _ptr;
   int _cnt;
   char*   _base;
   int _flag;
   int _file;
   int _charbuf;
   int _bufsiz;
   char*   _tmpfname;
} FILENAME;

struct person {
   int id;
   char fname[20];
   char lname[20];
};

int main () {
   FILE *outfile;

   // open file for writing
   outfile = fopen ("person.dat", "w");
   if (outfile == NULL) {
      fprintf(stderr, "\nError opend file\n");
      exit (1);
   }

   struct person input1 = {1, "Vilmar", "Catafesta"};
   struct person input2 = {2, "Evili", "Franciele"};

   fwrite (&input1, sizeof(struct person), 1, outfile);
   fwrite (&input2, sizeof(struct person), 1, outfile);

   if(fwrite != 0)
      printf("contents to file written successfully !\n");
   else
      printf("error writing file !\n");

   // close file
   fclose (outfile);

   return 0;
}

