#include <iostream>
#include <ares.h>

using namespace std;

int main(){
  int i;
  int *v;
  v = new int[10];  // 'v' é um ponteiro para uma área que
                    // tem 10 inteiros.
                    // 'v' funciona exatamente como um vetor
  v[0] = 10;
  v[1] = 11;
  v[2] = 12;
 // continua...
  v[9] = 19;

  for(i = 0; i < 10; i++)
    cout << "v[" << i << "]: " << v[i] << endl;

  cout << "Endereço de 'v': " << v << endl; // imprime o endereço da área alocada para 'v'
  delete[] v;
}
