#Import the NumPy module
import numpy as np

#Create an array
array1 = np.array([34.5, 89.34, 23.6, 45.72, 62.87])

#Copy the array using '=' operator
array2 = array1

#Modify the 4th element of the main array
array1[3] = 10.12

print("The output after modifying the main array")
#Display both arrays
print("The content of the main array", array1)
print("The content of the copied array", array2)

#Modify the 1st element of the copied array
array2[0] = 20.34

print("\nThe output after modifying the copied array")
#Display both arrays again
print("The content of the main array", array1)
print("The content of the copied array", array2)
