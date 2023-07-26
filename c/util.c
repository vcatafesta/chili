#include "util.h"

double getmean(double *evalues, int length) {
   double sum = 0.0;
   int i;

   for(i=0; i < length; i++) {
      sum += evalues[i];
   }
   return sum / (double)length;
}

void print_person_info(PERSON *p) {
   printf("Person: %s is %d years old\n", p->name, p->age);
}

