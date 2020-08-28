#!/usr/bin/python3
# -*- coding: utf-8 -*-

import os
import re

print(os.name)
print()

path = "/home/"
dirs = os.listdir(path)
for file in dirs:
    print(file)

for a in os.listdir("."):
    if os.path.isdir(a):
        print("d %s" % a)
    elif os.path.isfile(a):
        print("- %s" % a)

print()

if os.path.exists("z"):
    print("O diretório z existe.")
else:
    print("O diretório z não existe.")


# O local onde o script esta salvo,
# relativo ao ponto onde ele é
# acionado (executado).
print(__file__)                                         # projetos/trash/foo.py

#
# Nome do script
#
print(os.path.basename(__file__))                       # foo.py

#
# Pasta relativa do script
#
print(os.path.dirname(__file__))                        # projetos/trash

#
# Pasta absoluta do script + nome do script
#
# /home/projetos/trash/foo.py
print(os.path.abspath(__file__))


def erCasaComDia(subject):
    pattern = r'\bdia\b'
    return re.match(pattern, subject)


assert erCasaComDia('dia')
assert not erCasaComDia('bom-dia')


class Carro(object):
    estado = "novo"


print(Carro.estado)  # 'novo'

Fusca = Carro()
Fusca.estado = "velho"
print(Fusca.estado)  # novo

c = Carro()
print(c.estado)  # novo


class Automovel(object):
    def dirigir(self):
        self.estado = "usado"
        return self.estado


c = Automovel()
print(c.dirigir())  # AttributeError: 'Carro' object has no attribute 'estado'
c.estado = "v"
print(c.estado)


class Carro(object):
    def __init__(self, estado):
        self.estado = estado


bmw = Carro('semi-novo')
print(bmw.estado)  # 'semi-novo'


class Veiculo(object):
    estado = "novo"


class Carro(Veiculo):
    pass


bmw = Carro()
print(bmw.estado)  # 'novo'
