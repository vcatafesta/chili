#!/usr/bin/env python
# -*- coding: utf-8 -*-


def luhn_checksum(card_number):
    card_number = card_number.replace(" ", "")  # Remova espaços em branco
    card_number = card_number[::-1]  # Inverta o número do cartão

    total = 0
    is_second_digit = False

    for digit in card_number:
        digit = int(digit)

        if is_second_digit:
            digit *= 2
            if digit > 9:
                digit -= 9

        total += digit
        is_second_digit = not is_second_digit

    checksum = total % 10
    if checksum == 0:
        return 0
    else:
        return 10 - checksum


def generate_valid_credit_card(card_number):
    checksum = luhn_checksum(card_number)
    return card_number + str(checksum)


# Exemplo de uso:
credit_card_number = (
    "1234 5678 9012 3456"  # Insira seu número de cartão de crédito aqui
)
valid_credit_card = generate_valid_credit_card(credit_card_number)
print(f"Seu número de cartão válido: {valid_credit_card}")
