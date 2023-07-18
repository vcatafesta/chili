#ifndef UTIL_H
#define UTIL_H
#include <stdio.h>
#include <string.h>

#ifdef __cplusplus
	extern "C" {
#endif

typedef struct {
	int age;
	char name[256];
}PERSON;

double getmean(double *evalues, int length);
void print_person_info(PERSON *p);

#ifdef __cplusplus
}
#endif
#endif
