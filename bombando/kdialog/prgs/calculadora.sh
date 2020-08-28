#!/bin/bash
Conta=$(kdialog --caption "Calculadora em Bash" --inputbox "Digite a conta que você quer fazer. Ex:
       ø 2 x 3 ou 2 X3 ou 2*3 para multiplicar;
       ø 22/7 ou 22 \7 para dividir;
       ø 11^2 para 11 ao quadrado ou 5 ^3 para 5 ao cubo;
       ø 13%7 dá o resto da divisão de 13 por 7.")
[ "$Conta" ] || exit 1
#  O tr a seguir transforma:
#+ X ou x em * para multiplicação;
#+ Vírgula decimal em ponto decimal;
#+ \ em / para divisão.
Conta=$(tr 'Xx,\' '**./' <<< "$Conta" 2>/dev/null)
#  O grep a seguir usa uma expressão regular para testar
#+ se a conta informada tem uma das seguintes situações:
#+ ø Uma barra (sinal de divisão) entre números ou
#+   entre números e brancos (ex: 22/7 ou 22 / 7);
#+ ø Números com ponto decimal (o tr já converteu vírgula para ponto).
#+ Caso uma situação dessas ocorra um loop infinito
#+ será feito para pedir a precisão do resultado.
grep -qE '([0-9] */ *[0-9]|[0-9]\.[0-9])' <<< "$Conta" && while true
do
    Precisao=$(kdialog --caption "Calculadora em Bash" --inputbox "Quantas decimais no resultado?")
    [[ "$Precisao"  =~ ^[0-9]$ ]] && {
        Conta="scale=$Precisao; $Conta"
        break
    }
    kdialog --caption "Erro na precisão" --error "Informe um número entre zero e nove"
done
kdialog --title "Calculadora em Bash" --msgbox "O resultado é $(bc <<< $Conta | tr . ,)"
