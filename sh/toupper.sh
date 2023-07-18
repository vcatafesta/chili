# Não só é possível utilizar expressões regulares diretamente dentro do Bash e assim acelerar a 
# execução de um script como também pode-se aproveitar algumas das facilidades no tratamento de 
# strings — ou cadeias de caracteres se preferir — para não só ganhar alguma velocidade como 
# também dar um pouco mais de clareza no código e, ao mesmo tempo, resolver algumas limitações 
# conhecidas de algumas ferramentas

# Maiúsculas e minúsculas

#Talvez a forma mais conhecida para alterar a caixa de uma string em um script seja utilizando 
#o comando tr para trocar as letras¹:

MENSAGEM="AaBbCcDdEeFf"
echo ${MENSAGEM} | tr [:upper:] [:lower:]
#aabbccddeeff

echo ${MENSAGEM} | tr [:lower:] [:upper:]
#AABBCCDDEEFF

#Claro que esta abordagem apresenta um pequeno problema quando o tr se encontra com caracteres 
#acentuados em UNICODE, como no caso deste exemplo²:

MENSAGEM="Você deve tomar o ônibus elétrico número três. Não tome o ônibus grená!"
echo ${MENSAGEM} | tr [:lower:] [:upper:]
#VOCê DEVE TOMAR O ôNIBUS ELéTRICO NúMERO TRêS. NãO TOME O ôNIBUS GRENá!

# Mas é um problema que pode ser contornado utilizando awk ao invés de tr.

echo ${MENSAGEM} | awk '{ print toupper($0); }'
#VOCÊ DEVE TOMAR O ÔNIBUS ELÉTRICO NÚMERO TRÊS. NÃO TOME O ÔNIBUS GRENÁ!

# Porém é possível utilizar uma solução inteiramente em Bash com ajuda do comando declare para 
# definir (leia: forçar) que determinada string contenha apenas caracteres em caixa baixa com o 
# parâmetro -l ou em caixa alta usando o -u.

declare -l BAIXA=${MENSAGEM}
declare -u ALTA=${MENSAGEM} 
echo ${BAIXA}
# você deve tomar o ônibus elétrico número três. não tome o ônibus grená!
$ echo ${ALTA}
$ VOCÊ DEVE TOMAR O ÔNIBUS ELÉTRICO NÚMERO TRÊS. NÃO TOME O ÔNIBUS GRENÁ!

#!/usr/bin/env bash

function toupper(){
    declare -u TOUPPER=${@}
    echo ${TOUPPER}
}

function tolower(){
    declare -l TOLOWER=${@}
    echo ${TOLOWER}
}

I="Você deve tomar o ônibus elétrico número três. Não tome o ônibus grená!"
echo $( toupper "${I}")
echo $( tolower "${I}" )


#!/usr/bin/env bash

declare -u MENSAGEM

MENSAGEM="Você deve tomar o ônibus elétrico número três. Não tome o ônibus grená! "

TAM=$(( ${#MENSAGEM}-1 ))
for ((I=0; I<18;I++)); do
    MENSAGEM="${MENSAGEM: -${TAM}}${MENSAGEM:0:1}"
    echo "   ${MENSAGEM}"
done
