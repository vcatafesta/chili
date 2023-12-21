// luhntest2.c, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <stdint.h>
#include <string.h>
#include <ctype.h>
#include <time.h>
#include <unistd.h>
#include <sys/ioctl.h>

#define BLACK        "\033[30m"
#define RED          "\033[31m"
#define GREEN        "\033[32m"
#define YELLOW       "\033[33m"
#define BLUE         "\033[34m"
#define MAGENTA      "\033[35m"
#define CYAN         "\033[36m"
#define WHITE        "\033[37m"
#define GRAY         "\033[90m"
#define LIGHTWHITE   "\033[97m"
#define LIGHTGRAY    "\033[37m"
#define LIGHTRED     "\033[91m"
#define LIGHTGREEN   "\033[92m"
#define LIGHTYELLOW  "\033[93m"
#define LIGHTBLUE    "\033[94m"
#define LIGHTMAGENTA "\033[95m"
#define LIGHTCYAN    "\033[96m"
#define RESET        "\033[0m"
#define BOLD         "\033[1m"
#define FAINT        "\033[2m"
#define ITALIC       "\033[3m"
#define UNDERLINE    "\033[4m"
#define BLINK        "\033[5m"
#define INVERTED     "\033[7m"
#define HIDDEN       "\033[8m"

bool isValidCreditCardNumber(long creditCardNumber)
{
    int sum = 0;
    int digitCount = 0;
    bool isSecondDigit = false;

    // Loop através de todos os dígitos do número do cartão de crédito
    while (creditCardNumber != 0) {
        int digit = creditCardNumber % 10;

        if (isSecondDigit) {
            // Multiplica o dígito por 2 e adiciona os dígitos do resultado
            digit *= 2;
            sum += digit / 10 + digit % 10;
        } else {
            // Adiciona o dígito à soma
            sum += digit;
        }

        // Alterna a flag isSecondDigit
        isSecondDigit = !isSecondDigit;
        creditCardNumber /= 10;
        digitCount++;
    }

    // Retorna falso se o número de dígitos não for válido
    if (digitCount != 16 || sum % 10 != 0) {
        return false;
    } else {
        return true;
    }
}

int main(int argc, char **argv) {
   printf("%sluhntest2.c, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>%s\n\n", RED, RESET);
    long creditCardNumber;
    printf("Digite o número do cartão de crédito (16 dígitos): ");
    scanf("%ld", &creditCardNumber);

    if (isValidCreditCardNumber(creditCardNumber)) {
        printf("Válido\n");
    } else {
        printf("Inválido\n");
    }

   return EXIT_SUCCESS;
}
