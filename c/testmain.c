#include "util.h"
#include "util.c"
#define NUMVALS 10

int main() {
   double vals[NUMVALS] = {1.2, 5, 78.3, 23.0, 0.004, 4.5, 23, 6};
   PERSON me;

   strcpy(me.name, "VILMAR");
   me.age = 2021;

   printf("mean: %lf\n", getmean(vals, NUMVALS));
   print_person_info(&me);
   return 0;
}


