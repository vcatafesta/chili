#include <iostream>
#include <conio.h>

using namespace std;

int main()
{
   int iBytesiMatriz = 4;
   int iBytescMatriz = 1;
   int l;
   int c;
   int  iMatriz[4][4];
   char cMatriz[6][2];

   int iTamiMatriz = sizeof(iMatriz) / (iBytesiMatriz*iBytesiMatriz);
   int iTamcMatriz = sizeof(cMatriz);

   cout << sizeof(char) << endl;
   cout << iTamiMatriz << endl;
   cout << iTamcMatriz << endl;
   getch();


   for(l=0; l<iTamiMatriz; l++) {
      for(c=0; c<iTamiMatriz; c++) {
         iMatriz[l][c] = l;
         cout << iMatriz[l][c] <<endl;
      }
   }

   for(l=0; l<iTamcMatriz; l++) {
      for(c=0; c<iTamcMatriz; c++) {
         cMatriz[l][c] = l + 65;
         cout << cMatriz[l][c];
      }
   }

   return 0;
}
