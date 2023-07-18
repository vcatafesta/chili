#include <stdio.h>
#include <stdlib.h>
#include <iostream>

using namespace std;
enum dias {Dom=1, Seg, Ter, Qua, Qui, Sex, Sab};
#define true	1
#define false	0

struct Veiculo {
   string nome;
   string cor;
   int pot;
   int velmax;
   int vel;

   void add(string stnome, string stcor, int stpot, int stvelmax) {
      nome = stnome;
      cor = stcor;
      pot = stpot;
      velmax = stvelmax;
      vel = 0;
   }

   void show() {
      cout << "Nome       : " << nome << "\n";
      cout << "Cor        : " << cor   << "\n";
      cout << "Potencia   : " << pot    << "\n";
      cout << "Vel Max    : " << velmax << "\n";
      cout << "Vel Atual  : " << vel    << "\n\n";
   }

   void mudavel(int mv) {
      vel = mv;

      if(vel > velmax) {
         vel = velmax;
      }
      if( vel < 0) {
         vel = 0;
      }
   }
};

//=====================================================
int main()
{
   Veiculo vectra;

   vectra.add("GM Vectra", "Vermelho", 2000, 200);
   vectra.show();
   vectra.mudavel(150);
   vectra.show();
   system("pause");
   return 0;
}
//=====================================================
