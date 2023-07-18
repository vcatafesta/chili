from __future__ import generators


# geradores

def my_range_generator(stop):
    value = 0
    while value < stop:
        yield [value, str(value)]
        value += 1


for i in my_range_generator(20):
    print(i)

################################################################################
'''
import csv

def filter_rows(row_iterator):
    for row in row_iterator:
        if row:
            yield row


data_file = open('junk.csv', 'rb')
irows = filter_rows(csv.reader(data_file))
print(irows)
for i in irows:
    print(i)
try:
    print(irows.next())
except StopIteration:
    print ('Erro: Acabou a iteracao:')
finally:
    print(type(irows))
    print(type(i))
'''
################################################################################

gerador = (letra for letra in "Vilmar Catafesta")
gerador.next()
gerador.next()

for letra in gerador:
    print(letra)


################################################################################

def gerador():
    for i in range(10):
        yield 'Numero gerado :', str(i * 2)


gera = gerador()
print(gera)
gera.next()
gera.next()
for i in gera:
    print (type(gera), type(i), type(gera), type(i), i[0], i[1])
    if type(i) == tuple: print("Tuple")
    if type(i[0]) == int: print("Inteiro")
    if type(i[0]) == str: print("String")

################################################################################

string = 'Hi there'  # True example
# string = 'Good bye' # False example
if 'Hi' in string:
    print('Sucesso!')

################################################################################

recent_presidents = ['George Bush', 'Bill Clinton', 'George W. Bush']
print('Os tres mais recentes presidentes dos EUA sao: %s.' % ', '.join(
        recent_presidents))


################################################################################

def add(a, b): return a + b


print(add(2, 2))

add2 = lambda a, b: a + b
print(add2(2, 2))

squares = map(lambda a: a * a, [1, 2, 3, 4, 5])
# squares is now [1,4,9,16,25]
print(squares)

exponencia = map(lambda a: a ** a, [1, 2, 3, 4, 5, 1000])
# exponencia is now [1, 4, 27, 256, 3125]
num = exponencia[5]


# print(num)
# print(len(str(num)))


################################################################################

def square_numbers(nums):
    for i in nums:
        yield (i * i)


my_nums = square_numbers([1, 2, 3, 4, 5])
print(my_nums)
print(list(my_nums))
for num in my_nums:
    print(num)

my_nums = (x * x for x in [1, 2, 3, 4, 5])
print(my_nums)
print(list(my_nums))
for num in my_nums:
    print(num)

################################################################################

import memory_profiler
import random
import time

names = ['John', 'Corey', 'Vilmar', 'Adam', 'Steve', 'Rick', 'Thomas']
majors = ['Math', 'Engeneering', 'Engeneering', 'CompSci', 'Arts', 'Business']

print ('Memoria (Before): {}Mb'.format(memory_profiler.memory_usage()))


def people_list(num_people):
    result = []
    for i in xrange(num_people):
        person = {
            'id'   : i,
            'name' : random.choice(names),
            'major': random.choice(majors)
            }
        result.append(person)
    return result


def people_generator(num_people):
    for i in xrange(num_people):
        person = {
            'id'   : i,
            'name' : random.choice(names),
            'major': random.choice(majors)
            }
        yield person


t1 = time.clock()
# people = people_list(1000000)
people = people_generator(1000000)
t2 = time.clock()

print('Memoria (After) : {}Mb'.format(memory_profiler.memory_usage()))
print('Lag             : {}s'.format(t2 - t1))


################################################################################

def spam():
    while True:
        item = yield
        print('Resposta:', item)


s = spam()
print(s)
next(s)
s.send("Hello")
s.send(42)
s.send([1, 2, 3, 4])
