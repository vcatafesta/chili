#include <stdlib.h>
#include <stdio.h>
#include <stdbool.h>

typedef int8_t 	i8;
typedef int16_t 	i16;
typedef int32_t	i32;
typedef int64_t 	i64;

_Bool tem(){
	return true;

}

int main(){
	i16 *p = (i16 *)malloc(sizeof *p);
	*p     = 32768;
	printf("%d \t %d\n", *p, tem());
}
