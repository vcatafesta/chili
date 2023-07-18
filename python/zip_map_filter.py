import random

l = [0, 1, 2]
new = zip("ABC", l)
print(new)  # [('A', 0), ('B', 1), ('C', 2)]

new = map(lambda x: x * 10, l)
print(new)  # [0, 10, 20]

new = filter(None, l)
print(new)  # [1, 2]

# um gerador eh um objeto iteravel:

for par in zip('ABC', l):
    print(par)

# para criar a lista, basta passar o gerador para o construtor
print(list(zip("ABC", l)))  # [('A', 0), ('B', 1), ('C', 2)]

# varios construtores de colecoes aceitam iteraveis

print(dict(zip("ABC", l)))  # 'A': 0, 'C': 2, 'B': 1}


# com expressao geradora
class Trem1(object):
    def __init__(self, n):
        self.vagoes = n

    def __iter__(self):
        return ('Vagao1 # %d' % (i + 1) for i in range(self.vagoes))


# com funcao geradora
class Trem2(object):
    def __init__(self, n):
        self.vagoes = n

    def __iter__(self):
        for i in range(self.vagoes):
            yield 'Vagao2 # %d' % (i + 1)


def Trem3(vagoes):
    for i in range(vagoes):
        yield 'Vagao3 # %d' % (i + 1)


for vagao in Trem1(10): print(vagao)
for vagao in Trem2(10): print(vagao)
for vagao in Trem3(10): print(vagao)


def fibonacci(n):
    a, b = 0, 1
    for _ in range(n):
        yield a
        a, b = b, a + b


fib = fibonacci(10)
for i in range(10):
    print(next(fib))

fib = list(fibonacci(10))
print(fib)
print(len(fib))

a, b, c = 'XYZ'
print(a, b, c)

g = (n for n in [1, 2, 3])
a, b, c = g
print(a, b, c)

print('-' * 100)

octetos = b'Python'
for oct in octetos:
    print(oct)

print('-' * 100)


def d6():
    return random.randint(0,6)


for dado in iter(d6, 6):
    print(dado)
