import colorconsole

colorconsole
from datetime import date

# def greet(name):
#    return 'Hello {}!'.format(name)

system("cls")
lista = []
dic = {}
greet = lambda name: 'Hello {}!'.format(name)
print(greet('Vilmar'))


def bissexto(ano):
    return ano % 4 == 0 and ano % 100 != 0 or ano % 400 == 0


ano = date.today().year
print('Ano : {}'.format(ano), bissexto(ano))
print('Ano : {}'.format(2016), bissexto(2016))


def soma(x, y):
    return x + y


def mult(x, y):
    return x * y


def exp(x, y):
    return x ** y


print(soma(10, 10))
print(mult(10, 10))
print(exp(10, 10))
print('*' * 100)
