#!/usr/bin/python3
# -*- coding: utf-8 -*-

'''
Coleções de Python (matrizes)
Existem quatro tipos de dados de coleta na linguagem de programação Python:

List é uma coleção ordenada e modificável. Permite membros duplicados.
Tuple é uma coleção que é ordenada e imutável. Permite membros duplicados.
Set é uma coleção desordenada e não indexada. Nenhum membro duplicado.
Dicionário é uma coleção que é desordenada, alterável e indexada. Nenhum membro duplicado.
Ao escolher um tipo de coleção, é útil entender as propriedades desse tipo. Escolher o
tipo certo para um determinado conjunto de dados pode significar retenção de significado
e isso pode significar um aumento na eficiência ou segurança.
'''

"""
Method  Description
append()    Adds an element at the end of the list
clear() Removes all the elements from the list
copy()  Returns a copy of the list
count() Returns the number of elements with the specified value
extend()    Add the elements of a list (or any iterable), to the end of the current list
index() Returns the index of the first element with the specified value
insert()    Adds an element at the specified position
pop()   Removes the element at the specified position
remove()    Removes the item with the specified value
reverse()   Reverses the order of the list
sort()  Sorts the list
"""

#Crie uma lista:
thislist = ["apple", "banana", "cherry"]
print(thislist)

#Imprima o segundo item da lista:
thislist = ["apple", "banana", "cherry"]
print(thislist[1]

#Altere o segundo item:
thislist = ["apple", "banana", "cherry"]
thislist[1] = "blackcurrant"
print(thislist)

#Imprimir todos os itens na lista, um por um:
thislist = ["apple", "banana", "cherry"]
for x in thislist:
  print(x)

#Verifique se "apple" está presente na lista:
thislist = ["apple", "banana", "cherry"]
if "apple" in thislist:
  print("Yes, 'apple' is in the fruits list")

#Imprima o número de itens na lista:
thislist = ["apple", "banana", "cherry"]
print(len(thislist))

#Usando o método append () para anexar um item:
thislist = ["apple", "banana", "cherry"]
thislist.append("orange")
print(thislist)

#Inserir um item como segunda posição:
thislist = ["apple", "banana", "cherry"]
thislist.insert(1, "orange")
print(thislist)

#O remove()método remove o item especificado:
thislist = ["apple", "banana", "cherry"]
thislist.remove("banana")
print(thislist)

#O pop()método remove o índice especificado (ou o último item, se o índice não for especificado):
thislist = ["apple", "banana", "cherry"]
thislist.pop()
print(thislist)







