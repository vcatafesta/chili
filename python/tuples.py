# coding: utf-8
import pprint

l = ['David', 'Pythonista', '+1-514-555-1234']
name, title, phone = l
print(name, title, phone)

people = [l, ['Guido', 'BDFL', 'unlisted']]
for (name, title, phone) in people:
    print name, phone

david, (gname,
        gtitle,
        gphone) = people
print(gname,
      gtitle,
      gphone,
      david
      )
items = []
result = ''.join(str(i) for i in items)
print(result)

given = ['John', 'Eric', 'Terry', 'Michael']
family = ['Cleese', 'Idle', 'Gilliam', 'Palin']
pythons = dict(zip(given, family))
pprint.pprint(pythons)


class MyContainer(object):
    def __init__(self, data):
        self.data = data

    def __len__(self):
        """Return my length."""
        return len(self.data)


a = MyContainer([])
print 'object a:'
print '  data   =', a.data
print '  length =', len(a)
print '  truth  =', bool(a)
print

b = MyContainer([1, 2, 3])
print 'object b:'
print '  data   =', b.data
print '  length =', len(b)
print '  truth  =', bool(b)
print


class MyClass(object):
    def __init__(self, value):
        self.value = value

    def __nonzero__(self):
        """Return my truth value (True or False)."""
        # This could be arbitrarily complex:
        return bool(self.value)

    # Python 3 compatibility:
    __bool__ = __nonzero__


c = MyClass(0)
print 'object c:'
print '  value =', c.value
print '  truth =', bool(c)
print

d = MyClass(3.14)
print 'object d:'
print '  value =', d.value
print '  truth =', bool(d)
print

'''
Este é um erro comum que os iniciantes costumam fazer. Programadores ainda mais 
avançados cometem esse erro se não entendem os nomes de Python.

def bad_append (new_item, a_list = []): 
    a_list.append (new_item) 
    return a_list

O problema aqui é que o valor padrão de a_list , uma lista vazia, é avaliado no
tempo de definição da função. Então, cada vez que você chama a função, você 
obtém o mesmo valor padrão. Experimente várias vezes:

>>> print bad_append ('one') 
['one']

>>> imprima bad_append ('two') 
['one', 'two']

As listas são objetos mutáveis; você pode mudar seus conteúdos. A maneira correta 
de obter uma lista padrão (ou dicionário ou conjunto) é criá-lo em tempo de
execução, dentro da função :

'''


def good_append(new_item, a_list = None):
    if a_list is None: a_list = []
    a_list.append(new_item);
    return a_list


b = []
a = good_append('Teste', b)
print a

name = 'Catafesta'
messages = 3
values = {'name': name, 'messages': messages}
print ('Hello %(name)s, you have %(messages)i '
       'messages' % values)

print ('Hello %(name)s, you have %(messages)i '
       'messages' % locals())

from pprint import pprint

pprint(locals())

total = sum([num * num for num in range(1, 101)])
pprint(total)
total = sum(num * num for num in xrange(1, 101))
print(total)

month_codes = dict((fn(i + 1), code)
                   for i, code in enumerate('FGHJKMNQUVXZ')
                   for fn in (int, str))

pprint(month_codes)

################################################################################

# geradores

from funcoes import strzero, upper


def my_range_generator(stop):
    value = 0
    while value < stop:
        yield [value, strzero(value, 10)]
        value += 1


for i in my_range_generator(20):
    print(i)

################################################################################

import csv
from funcoes import valtype


def filter_rows(row_iterator):
    for line, row in enumerate(row_iterator):
        if row:
            yield line


data_file = open('junk.csv', 'rb')
irows = filter_rows(csv.reader(data_file))
print irows
for i in irows:
    print i
try:
    print irows.next()
except StopIteration:
    print 'Erro: Acabou a iteracao:'
finally:
    print type(irows)
    print valtype(i)
################################################################################

gerador = (letra for letra in "Vilmar Catafesta")
print gerador.next()
print gerador.next()

for letra in gerador:
    print letra


################################################################################

def gerador():
    for i in range(10):
        yield 'Numero gerado :', str(i * 2)


gera = gerador()
print gera
gera.next()
gera.next()
for i in gera:
    print type(gera), type(i), valtype(gera), valtype(i), i[0], i[1]
    if type(i) == tuple: print("Tuple")
    if type(i[0]) == int: print("Inteiro")
    if type(i[0]) == str: print("String")

################################################################################

string = 'Hi there'  # True example
# string = 'Good bye' # False example
if 'Hi' in string:
    print 'Sucesso!'

################################################################################

recent_presidents = ['George Bush', 'Bill Clinton', 'George W. Bush']
print 'Os tres mais recentes presidentes dos EUA sao: %s.' % ', '.join(
        recent_presidents)


################################################################################

def add(a, b): return a + b


print(add(2, 2))

add2 = lambda a, b: a + b
print(add2(2, 2))

squares = map(lambda a: a * a, [1, 2, 3, 4, 5])
# squares is now [1,4,9,16,25]
print squares

exponencia = map(lambda a: a ** a, [1, 2, 3, 4, 5, 1000])
# exponencia is now [1, 4, 27, 256, 3125]
num = exponencia[5]
print(num)
print(len(str(num)))


################################################################################

def square_numbers(nums):
    for i in nums:
        yield (i * i)


my_nums = square_numbers([1, 2, 3, 4, 5])
print(my_nums)
print(list(my_nums))
for num in my_nums:
    assert isinstance(num, object)
    print num

my_nums = (x * x for x in [1, 2, 3, 4, 5])
print(my_nums)
print(list(my_nums))
for num in my_nums:
    print num


################################################################################
