#!/usr/bin/env python

# Luhn algorithm
# More information about Luhn algorithm, visit:
# http://en.wikipedia.org/wiki/Luhn_algorithm
###############################################################################

import easygui
import math


def verify_card(number_card):
    """Performs the sum of digits"""

    # Converting the string to list
    card = list(number_card[0])

    # Reversing the positions's list
    card.reverse()
    sum = 0
    for index in range(len(card)):
        value = int(card[index])

        if not math.fmod(index, 2):
            value *= 2

        if value >= 10:
            value %= 10
            value += 1

        sum += value

    # Checking if the sum is divisible for 10
    mod = int(math.fmod(sum, 10))

    # If mod_10 like 10, then mod_10 = 0
    if (mod >= 10) or (mod == 0):
        mod_10 = 0

    else:
        mod_10 = 10 - mod

    return mod_10


msg = "Entre o numero do cartão: "
title = "Numero do Cartão"

values_names = ["Numero Cartão", "Digito verificador"]
values = []
values = easygui.multenterbox(msg, title, values_names)

# Converting the values received to integer
# If the value is found valid, show result
# Otherwise, show error message
try:
    int(values[0])

    if values[1]:
        int(values[1])
        sum = verify_card(values)

        digit = int(values[1][0])
        # If the number's card is valid, show result
        # Otherwise, show the valid value
        if sum == digit:
            type_card = {
                "1": "Companhia Aerea",
                "2": "Companhia Aerea",
                "3": "Empresa de viagens, entretenimento ou American Express",
                "4": "Visa",
                "5": "MasterCard",
                "6": "Rede Discover",
                "7": "Petroleo",
                "8": "Telecomunicacoes",
                "9": "Outras Atividades",
                "0": "Outras Atividades",
            }

            easygui.msgbox("Numero cartão válido - " + type_card.get(values[0][0]))

        else:
            s = str(sum)
            easygui.msgbox("Digito verificador inválido, deveria ser " + s[0])

    else:
        sum = verify_card(values)
        s = str(sum)

        easygui.msgbox("Digito verificador inválido, deveria ser " + s[0])

except:
    easygui.msgbox("Valor inválido!")
