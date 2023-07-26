#include <stdio.h>

#define NAME_SIZE 30

typedef struct player {
   char name[NAME_SIZE];
   unsigned char player_number;
   float batting_average;
   struct player *next;
}PLAYER_REC;



void main()
{
   PLAYER_REC clark, ruth, mays;
   ruth.next = &mays;

}

