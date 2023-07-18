#!/usr/bin/python
# -*- coding: utf-8 -*-
print("Bem vindo ao Colecionador de Carros 10.000 Plus!")
nome = input("Qual é o seu nome? ")
print("Olá " + nome + ", vamos à sua coleção?")
quantidade = int(raw_input("Quantos carros o senhor tem? "))
i = 1
carros = []
placas = []
while i <= quantidade:
    carros.append(raw_input("Carro %i: " % i))
    i += 1
print("Agora as placas...")
i = 0
while i < quantidade:
    placas.append(raw_input("Placa do %s: " % carros[i]))
    i += 1
print("Hora de mostrar a sua coleção!")
i = 0
while i < quantidade:
    print("O %s tem placas %s" % (carros[i], placas[i]))
    i += 1
print("Então é isso, tchau!")
