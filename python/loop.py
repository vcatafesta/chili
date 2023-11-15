#!/usr/bin/python3
# -*- coding: utf-8 -*-


def ex1():
	letters = ["a", "b", "c", "d", "e"]

	for letter in letters:
		print(letter)

	for i in range(len(letters)):
		print(f'{i+1} - {letters[i]}')

	j = 1
	for letter in letters:
		print(f'{j} - {letter}')
		j += 1

	for i, letter in enumerate(letters):
		print(f'{i+1} - {letter}')

	for letter in reversed(letters):
		print(letter)

	for letter in sorted(letters):
		print(letter)



ex1()
