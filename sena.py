#!/usr/bin/env python
# -*- coding: utf-8 -*-
import random
num1 = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
num2 = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
# random.shuffle(num2)
sorteados = "Dezenas sorteadas: "
i = 0
while i < 5:
    dezena = "00"
    while dezena == "00":
        random.shuffle(num1)
        random.shuffle(num2)
        dezena = num1[0] + num2[0]
    sorteados += dezena + " "
    i += 1
print(sorteados)
