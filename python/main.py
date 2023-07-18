from random import choice, shuffle

class C(object):
    def __init__(self,x=0):
        self.__x = x
    def getx(self):
        return self.__x
    def setx(self,valor):
        self.__x = valor if valor >= 0 else 0
    x = property(getx,setx)

class B(object):
    def __init__(self,x=0):
        self.__x = x
    @property
    def x(self):
        return self.__x
    @x.setter
    def x(self,valor):
        self.__x = valor if valor >= 0 else 0

class Carta(object):
    def __init__(self, valor, naipe):
        self.valor = valor
        self.naipe = naipe
    def __repr__(self):
        return '<%s de %s' % (self.valor, self.naipe)

class Baralho(object):
    naipes = 'paus copas espadas ouros'.split()
    valores = 'A 2 3 4 5 6 7 8 9 10 J Q K'.split()

    def __init__(self):
        self.cartas = [Carta(v, n) for n in self.naipes
                                 for v in self.valores]

    def __len__(self):
        return len(self.cartas)

    def __getitem__(self, pos):
        return self.cartas[pos]


a = C()
a.x = 10
print(a.x)
a.x = -10
print(a.x)

a = B()
a.x = 10
print(a.x)
a.x = -20
print(a.x)
print(type(a.x))

jogo = Baralho()
print(len(jogo))
print(choice(jogo))
print(type(jogo))




