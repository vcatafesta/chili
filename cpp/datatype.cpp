// C++ program to Demonstrate the sizes of data types
#include <iostream>
#include <limits.h>
using namespace std;

int main()
{
	puts("");
	cout << "char minimum value        : " << CHAR_MIN << endl;
	cout << "char maximum value        : " << CHAR_MAX << endl;
	cout << "Size of char              : " << sizeof(char) << " byte"<< endl;
	cout << "Size of int               : " << sizeof(int) << " bytes" << endl;
	cout << "Size of short int         : " << sizeof(short int) << " bytes" << endl;
	cout << "Size of long int          : " << sizeof(long int) << " bytes" << endl;
	cout << "Size of signed long int   : " << sizeof(signed long int) << " bytes" << endl;
	cout << "Size of unsigned long int : " << sizeof(unsigned long int) << " bytes" << endl;
	cout << "Size of float             : " << sizeof(float) << " bytes"<< endl;
	cout << "Size of double            : " << sizeof(double) << " bytes" << endl;
	cout << "Size of wchar_t           : " << sizeof(wchar_t) << " bytes" << endl;

	return 0;
}
