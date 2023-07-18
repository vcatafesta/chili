# A Simple Python program to compute sum
# of digits in numbers from 1 to n

# Returns sum of all digits in numbers
# from 1 to n
def sumOfDigitsFrom1ToN(n) :

    result = 0 # initialize result

    # One by one compute sum of digits
    # in every number from 1 to n
    for x in range(1, n+1) :
        result = result + sumOfDigits(x)

    return result

# A utility function to compute sum of
# digits in a given number x
def sumOfDigits(x) :
    sum = 0
    while (x != 0) :
        sum = sum + x % 10
        x = x // 10
    
    return sum


# Driver Program
n = 328
print("Sum of digits in numbers from 1 to", n, "is", sumOfDigitsFrom1ToN(n))
