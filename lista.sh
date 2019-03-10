#!/bin/bash

# listas.sh
# Versão 0.1

# Funções referentes ao uso de pilhas e filas  (listas) em shell
# Escritas por Leandro Santiago da Silva
# e-mail: leandrosansilva@gmail.com
# Você pode usar e modificar essas funções como bem entender, 
# desde que não se esqueça de mencionar o meu nome como autor delas
# Sabe, essas frescuras todas..

# Maringá/PR Brasil 14/02/2007

# Essas funções eu escrevi num momento inútil, quando não temos nada para fazer.....
# Você pode considerá-las inúteis à vontade... 
# Qualquer reclamação, dúvida, favor me contactar por e-mail 
# (não, não vou resolver o seu problema, mas eh bom saber as dúvidas dos eventuais usuários destas funções).


## Para usar essas funções, simplismente inclua no início do seu script:
# PATHLISTA=<caminho ddo diretorio onde está listas.sh>
# source "$PATHLISTA/listas.sh"
## E você poderá usar essas funções normalmente 

#Funciona assim:

## Pilhas são listas onde inserimos e retiramos os elementos em uma só extremidade.
### O popular: Os últimos serão os primeiros, pois o último inserido será o peimeiro a ser retirado.
## Já uma fila é como uma minhoca "defecando" (Ugh..). O primeiro elemento inserido será necessariamente o primeiro a ser removido. 
### (Imagine o que é uma pilha segundo essa analogia...)

## Uma pilha pode ser usada como fila, e vice-versa, basicamente pq os dois são vetores, oras bolas!


##### Funções referentes ao uso de pilhas simples
###
##
#

# Função que recebe dois parâmetros, sendo o primeiro um NOME de um vetor
# e o segundo sendo o CONTEÙDO da variável a ser inserida
# Exemplo:
#   variável1=10
#   Empilha vetor1 $variavel1
# Neste caso, será empilhado o conteúdo de variavel1 (10) em vetor
# Empilhar é simplismente inserir no final
Empilha() 
{ 
   eval local Tamanho='${#'$1'[@]}'
   eval $1\[$Tamanho\]="$2"
}

# A função Desempilha recebe dois parâmetros, sendo o primeiro um NOME de um vetor
# e o segundo o NOME de uma variável, que irá receber o conteúdo da "desempilhação"
# Exemplo:
#   Desempilha vetor1 variavel2
# Neste caso, o valor do último elemento de vetor1 (10) será atribuído à variável variavel2
#   echo $variavel2
#   10
# Em seguida à atribuição, apaga-se o último elemento de vetor1
# Desempilhar é simplismente remover um elemento do final
Desempilha()
{
   eval local Tamanho='${#'$1'[@]}'
   ((Tamanho--))
   eval $2='${'$1'['$Tamanho']}'
   eval unset $1\[$Tamanho\]
}   

# Função que imprime na tela o último elemento de um vetor
# Ela recebe um parâmetro, que é o NOME do vetor
# Exemplo:
#   ElementodoTopo vetor1
#   10
ElementodoTopo()
{
   eval local Tamanho='${#'$1'[@]}'
   ((Tamanho--))
   eval echo '${'$1'['$Tamanho']}'
}

# Função que retorna zero se um vetor está vazio e um se não estiver.
# Ela recebe um parâmetro, que é o NOME do vetor analisado
# Exemplo:
#   PilhaVazia vetor1
#   echo $?
#   1
#
# Já se usarmos um vetor vazio:
#   PilhaVazia vetorvazio
#   echo $?
#   0
PilhaVazia()
{
   eval local Tamanho='${#'$1'[@]}'
   [ $Tamanho -ne 0 ] && return 1 || return 0
}   

#
##
###
####
###############FIM-PILHA##########################


# Funções referentes ao uso de filas simples
####
###
##
#
#

# Função que recebe dois parâmetros, sendo o primeiro um NOME de um vetor
# e o segundo sendo o CONTEÙDO da variável a ser inserida
# Exemplo:
#   variável1=10
#   InsereFila vetor1 $variavel1
# Neste caso, será adicionado o conteúdo de variavel1 (10) no final de  vetor
# Inserir em uma fila é simplismente inserir no final de um vetor (eh o mesmo que empilhar).
# Por isso, a função é simplismente um alias de Empilha...
alias 'InsereFila=Empilha'

# A função RemoveFila recebe dois parâmetros, sendo o primeiro um NOME de um vetor
# e o segundo o NOME de uma variável, que irá receber o conteúdo da insersão
# Exemplo:
#   RemoveFila vetor1 variavel2
# Neste caso, o valor do elemento de índice 0 de vetor1 (10) será atribuído à variável variavel2
#   echo $variavel2
#   10
# Em seguida à atribuição, apaga-se o elemento de índice 0 de vetor1
# Remover de uma fila é simplismente remover um elemento do início.
RemoveFila()
{
   eval $2=\${$1[0]}
   local Indice=1
   eval local Tamanho='${#'$1'[@]}'
   while [ $Indice -lt $Tamanho ]
   do
      eval $1[$((Indice-1))]='${'$1[$Indice]\}
      ((Indice++))
   done
   ((Tamanho--))
   eval unset $1[$Tamanho]
}

# Função que retorna zero se uma fila está vazia e um se não estiver.
# Ela recebe um parâmetro, que é o NOME do vetor analisado
# Exemplo:
#   PilhaVazia vetor1
#   echo $?
#   1
#
# Já se usarmos uma fila vazia:
#   FilaVazia vetorvazio
#   echo $?
#   0
# Novamente, trata-se de um alias
alias 'FilaVazia=PilhaVazia'

# Função que imprime na tela o primeiro elemento de uma fila
# Ela recebe um parâmetro, que é o NOME do vetor
# Exemplo:
#   PrimeirodaFila vetor1
#   10
PrimeirodaFIla()
{
   eval echo '${'$1'[0]}'
}


#
##
###
#################FIM-FILAS#######################
