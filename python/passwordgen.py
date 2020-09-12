#!/usr/bin/python3
import string
import random

LETTERS 		= string.ascii_letters
NUMBERS 		= string.digits
PUNCTUATION = '@%#_+=.,'

def generate_password(letters=8, numbers=4, punctuation=2):
	generated = ''
	generated += random_chars(letters, LETTERS)
	generated += random_chars(numbers, NUMBERS)
	generated += random_chars(punctuation, PUNCTUATION)
	generated = list(generated)
	return shuffle_string(generated)

def random_chars(length, chars):
	generated = ''
	for i in range(length):
		generated  += random.choice(chars)
	return generated

def shuffle_string(text):
	text = list(text)
	random.shuffle(text)
	return ''.join(text)


if __name__ == '__main__':
	import argparse
	parser = argparse.ArgumentParser('Gerador de senhas aleatorias')
	parser.add_argument('--letters', type=int, default=8, help='Quantidade de letras')
	parser.add_argument('--numbers', type=int, default=4, help='Quantidade de numeros')
	parser.add_argument('--punctuation', type=int, default=2, help='Quantidade de caracteres especiais')
	args = parser.parse_args()
	print(generate_password(
		letters=args.letters,
		numbers=args.numbers,
		punctuation=args.punctuation
	))

