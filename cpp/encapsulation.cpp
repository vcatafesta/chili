// C++ program to demonstrate
// Encapsulation
#include <iostream>
using namespace std;

class Encapsulation {
	private:
		// Data hidden from outside world
		int x;

	public:
		// Function to set value of
		// variable x
		void set(int a) { x = a; }

		// Function to return value of
		// variable x
		int get() { return x; }
};

// Driver code
int main() {
	Encapsulation obj;
	obj.set(5);
	cout << obj.get();
	return 0;
}
