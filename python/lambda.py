sum = lambda x, y: x + y
print(sum)
print(sum(4, 5))

can_vote = lambda age: True if age >= 18 else False
print(can_vote)
print(can_vote(17))
print(can_vote(19))

powerlist = [lambda x: x ** 2,
             lambda x: x ** 3,
             lambda x: x ** 4]

for func in powerlist:
    print(func(4))

######################################################################################

attack = {
    "quick": lambda:
print("Quick Attack"),
"power": lambda:
print("Power Attack"),
"miss": lambda:
print("Missed Attack")}

attack["quick"]()
attack["miss"]()
import random

attackKey = random.choice(list(attack.keys()))
attack[attackKey]()

######################################################################################

import random

flipList = []
for i in range(1, 1000):
    flipList += random.choice(['H', 'T'])

print("Heads :", flipList.count("H"))
print("Tails :", flipList.count("T"))

######################################################################################

oneToTen = range(1, 11)


def dbl_num(num):
    return num * 2


print(list(map(dbl_num, oneToTen)))
print(list(map((lambda x: x * 3), oneToTen)))
aList = list(map((lambda x, y: x + y), [1, 2, 3], [1, 2, 3]))
print(aList)

######################################################################################
alist0 = list(map((lambda x: x % 4 == 0 and x % 100 != 0), range(2000, 2020)))
alist1 = list(
        filter((lambda x: x % 4 == 0 and x % 100 != 0), range(2000, 2020)))
print(alist0)
print(alist1)


######################################################################################
def f(x): return x ** 2


print(f(8))

g = lambda x: x ** 2
print(g(8))


######################################################################################

def make_incrementor(n): return lambda x: x + n


f = make_incrementor(2)
g = make_incrementor(6)

print(f(42), g(42))
print(make_incrementor(22)(33))

######################################################################################
from functools import reduce

foo = [2, 18, 9, 22, 17, 24, 8, 12, 27]

print(filter(lambda x: x % 3 == 0, foo))
print(map(lambda x: x * 2 + 10, foo))
print(reduce(lambda x, y: x * y, foo))


def bissextoarray(*args):
    return map((lambda x: x % 4 == 0 and x % 100 != 0), args)


def bissextofilter(*args):
    return filter((lambda x: x % 4 == 0 and x % 100 != 0), args)


def bissexto(arg):
    return True in map((lambda x: x % 4 == 0 and x % 100 != 0), [arg])

def iif(condicao, condtrue, condfalse):
    if condicao:
        return condtrue
    else:
        return condfalse


anos = list(range(2000, 2017))
print(bissextoarray(*anos))
print(bissextoarray(2004, 2005, 2006))
print(bissexto(2004), bissexto(2005))
anobissexto = bissextofilter(*anos)
print(anobissexto)
for i in anobissexto:
    print(bissexto(i))

for i in anos:
    print(i, iif(bissexto(i), "Bissexto", "Normal"))

print('Tem {} anos bissextos desde {} ate {}'.format(len(anobissexto),
                                                     anos[0], anos[-1]))
