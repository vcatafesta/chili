#include <iostream>
using namespace std;

int main() {
   int shipWeightPounds;
   int shipCostCents = 0;
   const int FLAT_FEE_CENTS = 75;

   /* Your solution goes here  */

   cout << "Weight(lb): " << shipWeightPounds;
   cout << ", Flat fee(cents): " << FLAT_FEE_CENTS;
   cout << ", Cents per lb: " << CENTS_PER_POUND << endl;
   cout << "Shipping cost(cents): " << shipCostCents << endl;

   return 0;
}
