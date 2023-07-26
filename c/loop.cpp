#include <iostream>
using namespace std;

int main() {
std:
   int n1      = 0;
   int n2      = 0;
   int currVal = 0;
   int val     = 0;

   cout << "Welcome to C++" << endl ;
   cout << "Enter two numbers: " << endl;
   cin >> n1 >> n2;
   cout << "The sum of    " << n1 << " and " << n2 << " is " << n1 + n2 << endl;

   if(cin >> currVal) {
      int cnt = 1;
      while(cin >>val) {
         if(val == currVal)
            cnt++;
         else {
            cout << currVal << " occurs " << cnt << " time " << endl;
            currVal = val;
            cnt = 1;
         }
      }
      cout << currVal << " occurs " << cnt << " time " << endl;
   }
   return 0;
}
