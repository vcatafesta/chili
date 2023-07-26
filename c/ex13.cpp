// C++ program to find the count
// of numbers in Array ending
// with digits of number N

#include <bits/stdc++.h>
using namespace std;

// Array to keep the
// track of digits occurred
// Initially all are 0(false)
int digit[10] = { 0 };

// Function to initialize true
// if the digit is present
void digitsPresent(int n)
{
	// Variable to store the last digit
	int lastDigit;

	// Loop to iterate through every
	// digit of the number N
	while (n != 0) {
		lastDigit = n % 10;

		// Updating the array according
		// to the presence of the
		// digit in n at the array index
		digit[lastDigit] = true;
		n /= 10;
	}
}

// Function to check if the
// numbers in the array
// end with the digits of
// the number N
int checkLastDigit(int num)
{

	// Variable to store the count
	int count = 0;

	// Variable to store the last digit
	int lastDigit;
	lastDigit = num % 10;

	// Checking the presence of
	// the last digit in N
	if (digit[lastDigit] == true)
		count++;

	return count;
}

// Function to find
// the required count
void findCount(int N, int K, int arr[])
{

	int count = 0;

	for (int i = 0; i < K; i++) {

		count = checkLastDigit(arr[i]) == 1
					? count + 1
					: count;
	}
	cout << count << endl;
}

// Driver code
int main()
{
	int N = 1731;

	// Preprocessing
	digitsPresent(N);

	int K     = 5;
	int arr[] = {57,6786,1111,3,9812};

	findCount(N, K, arr);
	return 0;
}
