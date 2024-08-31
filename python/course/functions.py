#!/usr/bin/python3
# -*- coding: utf-8 -*-

def emoji_converter(message):
	words = message.split(" ")
	emojis = {
		":)": "😊",
		":(": "🌟"
	}
	output = ""
	for word in words:
		output += emojis.get(word, word) + " "
	
	return output

def greet_user(str: str):
	return f'{str}'

def square(number):
	return number * number

print(greet_user('Hi'))
print(square(2))

try:
	message = input('>')
except ValueError:
	print('Entrada inválida')

result = emoji_converter(message)
print(result)