#include<stdio.h>
#include<stdlib.h>
#include<conio2.h>

int main(void)
{
   char_info *buf = (char_info*)malloc(4096);
   buf->attr = 75;
   buf->letter = 176;
   puttext(1,1, 80, 50, buf);
   cputsxy (10, 10, "teste");
   return 0;
}
