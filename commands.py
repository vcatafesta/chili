#!/usr/bin/python3
# -*- coding: utf-8 -*-

# Dictionary Methods
# Python has a set of built-in methods that you can use on dictionaries.

# Method  Description
# clear() Removes all the elements from the dictionary
# copy()  Returns a copy of the dictionary
# fromkeys()  Returns a dictionary with the specified keys and values
# get()   Returns the value of the specified key
# items() Returns a list containing the a tuple for each key value pair
# keys()  Returns a list containing the dictionary's keys
# pop()   Removes the element with the specified key
# popitem()   Removes the last inserted key-value pair
# setdefault()    Returns the value of the specified key. If the key does not exist: insert the key, with the specified value
# update()    Updates the dictionary with the specified key-value pairs
# values()    Returns a list of all the values in the dictionary

cadastro = {
    "nome" : "Vilmar",
    "idade" : 52
}

print(cadastro)
print(cadastro["nome"])
print(cadastro["idade"])
print(cadastro.keys())
#dict_values(['Vilmar', 33])

thisdict =  {
  "brand": "Ford",
  "model": "Mustang",
  "year": 1964
}
print(thisdict)
x = thisdict["model"]
x = thisdict.get("model")
thisdict["year"] = 2018

for x in thisdict:
  print(x)

for x in thisdict.values():
  print(x)

for x, y in thisdict.items():
  print(x, y)

if "model" in thisdict:
  print("Yes, 'model' is one of the keys in the thisdict dictionary")

print(len(thisdict))

#Adding an item to the dictionary is done by using a new index key and assigning a value to it:
thisdict =  {
  "brand": "Ford",
  "model": "Mustang",
  "year": 1964
}
thisdict["color"] = "red"
print(thisdict)

# The pop() method removes the item with the specified key name:
thisdict =  {
  "brand": "Ford",
  "model": "Mustang",
  "year": 1964
}
thisdict.pop("model")
print(thisdict)

#The popitem() method removes the last inserted item (in versions before 3.7, a random item is removed instead):
thisdict =  {
  "brand": "Ford",
  "model": "Mustang",
  "year": 1964
}
thisdict.popitem()
print(thisdict)

#The del keyword removes the item with the specified key name:
thisdict =  {
  "brand": "Ford",
  "model": "Mustang",
  "year": 1964
}
del thisdict["model"]
print(thisdict)

#The del keyword can also delete the dictionary completely:
thisdict ={
  "brand": "Ford",
  "model": "Mustang",
  "year": 1964
}
del thisdict
#print(thisdict) #this will cause an error because "thisdict" no longer exists.

#The clear() keyword empties the dictionary:
thisdict =  {
  "brand": "Ford",
  "model": "Mustang",
  "year": 1964
}
thisdict.clear()
print(thisdict)

#Make a copy of a dictionary with the copy() method:
thisdict =  {
  "brand": "Ford",
  "model": "Mustang",
  "year": 1964
}
mydict = thisdict.copy()
print(mydict)

#Make a copy of a dictionary with the dict() method:
thisdict ={
  "brand": "Ford",
  "model": "Mustang",
  "year": 1964
}
mydict = dict(thisdict)
print(mydict)

#It is also possible to use the dict() constructor to make a new dictionary:
thisdict =  dict(brand="Ford", model="Mustang", year=1964)
# note that keywords are not string literals
# note the use of equals rather than colon for the assignment
print(thisdict)