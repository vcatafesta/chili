#include <iostream>
using namespace std;

// declaring class
class Circle {
	// access modifier
	private:
		// Data Member
		float area;
		float radius;

	public:
		void getRadius() {
			cout << "Enter radius   : ";
			cin >> radius;
		}
		void findArea() {
			area = 3.14 * radius * radius;
			cout << "Area of circle = " << area << '\n';
		}
};

int main() {
	puts("");
	// creating instance(object) of class
	Circle cir;
	cir.getRadius(); // calling function
	cir.findArea(); // calling function
}
