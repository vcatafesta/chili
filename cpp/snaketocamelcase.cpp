// C++ Program to convert
// Snake case to Camel Case
#include <iostream>
#include <string>

using namespace std;

// Function to convert camel case
// string to snake case string
string camelToSnake(string str)
{

	// Empty String
	string result = "";

	// Append first character(in lower case)
	// to result string
	char c = tolower(str[0]);
	result+=(char(c));

	// Traverse the string from
	// ist index to last index
	for (int i = 1; i < str.length(); i++) {

		char ch = str[i];

		// Check if the character is upper case
		// then append '_' and such character
		// (in lower case) to result string
		if (isupper(ch)) {
			result = result + '_';
			result+=char(tolower(ch));
		}

		// If the character is lower case then
		// add such character into result string
		else {
			result = result + ch;
		}
	}

	// return the result
	return result;
}

int main()
{
	// Given string str
	string str = "VilmarCatafesta";

	// Print the modified string
	cout << camelToSnake(str);

	return 0;
}
