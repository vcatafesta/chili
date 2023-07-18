def substr(var, x, y):
    x -= 1
    y += x
    return var[x:y]


var = "ABCDE"
print(var)
print(substr(var, 3, 3))
