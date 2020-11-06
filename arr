##!/bin/bash

MEU_ARRAY=('A' 'B' 'C' 'D' 'E')
echo ${MEU_ARRAY[@]}; echo ${!MEU_ARRAY[@]}
#A B D E
#0 1 3 4
MEU_ARRAY=( ${MEU_ARRAY[@]} ) # reordenando
echo ${MEU_ARRAY[@]}; echo ${!MEU_ARRAY[@]}
#A B D E
#0 1 2 3

echo ${MEU_ARRAY[2]}  # C
echo $MEU_ARRAY[2]    # A[2]
echo ${MEU_ARRAY[@]}  # A B C D E
for I in ${MEU_ARRAY[*]}; do echo -n "${I} "; done ; echo


Todos sabem que o Bash possui suporte a variáveis e que estas podem ser sequências de caracteres — strings — ou então números inteiros mas o que poucos sabem (ou se esquecem as vezes) é que também há suporte para arrays.

O que acaba sendo bastante útil, aliás, para economizar o uso awk, cut ou sed dentro dos scripts.

Criando um array
Existem duas formas de criar um array em Bash, a primeira é bastante parecida com diversas linguagens:

$ MEU_ARRAY=()
Enquanto que a outra utiliza o comando declare:

$ declare -a MEU_ARRAY
Não existe diferença entre usar um método ou outro e em ambos é possível já preenchê-lo. Utilizando a forma direta:

$ MEU_ARRAY=('A' 'B' 'C' 'D' 'E')
ou usando o declare:

$ declare -a MEU_ARRAY=('A' 'B' 'C' 'D' 'E')
Ambos criarão a mesma estrutura de dados.

Acesso aos elementos dentro do array
Para acessar os elementos basta indicar o nome da variável seguido do seu número de ordem dentro do array:

$ echo ${MEU_ARRAY[2]}
C
Aí vale a lembrança de que no caso específico dos arrays é necessário colocar a variável entre colchetes — {...} — caso contrário o Bash entenderá algo completamente diferente:

$ echo $MEU_ARRAY[2]
A[2]
Os sinais de arroba — @ — ou asterisco — * — são usados para se fazer referência a todos os elementos dentro do array:

$ echo ${MEU_ARRAY[@]}
A B C D E
ou (e aproveitando para variar um pouco os exemplos):

$ for I in ${MEU_ARRAY[*]}; do echo -n "${I} "; done ; echo
A B C D E 
E aqui funcionando de forma idêntica, tal qual acontece com os ${@} e o ${*} em argumentos passados pela linha de comando.

Editando, incluindo e removendo elementos
Para editar um elemento já existente basta alterá-lo diretamente:

$ MEU_ARRAY[2]='K'; echo ${MEU_ARRAY[@]}
A B K D E
Para acrescentar um novo elemento ao array apenas utilize um índice vazio:

$ MEU_ARRAY[5]='F'; echo ${MEU_ARRAY[@]}
A B K D E F
Aliás, o Bash criará um array sempre que você declarar uma variável com esta sintaxe:

$ QUALQUER_COISA[999]="Teste"; echo ${QUALQUER_COISA[@]}
Teste
Para remover um elemento indique seu índice:

$ unset MEU_ARRAY[2]; echo ${MEU_ARRAY[@]}
A B D E F
O comando unset não rearranjará o array, ou seja, os índices continuarão os mesmos e somente o elemento de índice 2 é que deixará de existir:

$ for ((I=0;I<5;I++)); do echo "${I} -> $( test ${MEU_ARRAY[${I}]} \
  && echo "Existe" )"; done
0 -> Existe
1 -> Existe
2 -> 
3 -> Existe
4 -> Existe
Pela mesma lógica, remova todo o array com:

$ unset MEU_ARRAY; echo "-${MEU_ARRAY[@]}-"
--
Neste caso ele deixará totalmente de existir.

Dimensões do array e outras coisas…
Como saber o tamanho — o número de elementos — de um array? Basta usar a cerquilha — # — no começo do nome da variável — o mesmo método usado para se obter o tamanho de uma string.

$ MEU_ARRAY=('A' 'B' 'C' 'D' 'E'); echo ${#MEU_ARRAY[@]}
5
Quando um elemento é apagado com quantos itens ele fica?

$ unset MEU_ARRAY[2]; echo ${#MEU_ARRAY[@]}
4
Neste caso pode ser útil recuperar os índices válidos para identificar os “buracos” dentro do array, com o auxílio do ponto de exclamação — ! — no começo do nome da variável:

$ echo ${!MEU_ARRAY[@]}
0 1 3 4
Ou reorganizá-lo completamente:

$ echo ${MEU_ARRAY[@]}; echo ${!MEU_ARRAY[@]}
A B D E
0 1 3 4
$ MEU_ARRAY=( ${MEU_ARRAY[@]} )
$ echo ${MEU_ARRAY[@]}; echo ${!MEU_ARRAY[@]}
A B D E
0 1 2 3
Caso os índices não sejam assim tão importantes — sim, neste caso o array está sendo recriado.

Também é possível “fatiar” o array pegando determinados elementos dele. Para recuperar todo o array a partir do n-ésimo elemento use o sinal de dois pontos — : — seguido da posição desejada:

$ echo ${MEU_ARRAY[@]:2}
D E
Para indicar o número de elementos a recuperar basta complementar com outro sinal de dois pontos:

$ echo ${MEU_ARRAY[@]:1:2}
B D
É possível usar valores relativos e assim recuperar o último elemento do array:

$ echo ${MEU_ARRAY[@]: -1}
E
Neste caso o espaço é importante para que o Bash compreenda o número. E para saber o índice do último elemento é possível usar:

$ echo ${#MEU_ARRAY[@]: -1}
4
O que permite se retornar ao exemplo de inclusão de elementos e definir uma forma automática de acrescentar elementos:

$ MEU_ARRAY[ (( ${#MEU_ARRAY[@]: -1}+1 )) ]="Z"
$ echo ${MEU_ARRAY[@]}
A B D E Z
E assim ter certeza de que um novo elemento estará usando um próximo índice disponível.

Finalizando
E para encerrar o mesmo aviso dado no caso das expressões regulares. Quem tem suporte a arrays é o Bash, (“/bin/bash”), e não o Dash (“/bin/dash”) que, no caso da Debian/Ubuntu em algumas outras distribuições, é quem responde pelo comando “/bin/sh”.

$ sh -c "MEU_ARRAY=('A' 'B' 'C' 'D' 'E')"
sh: 1: Syntax error: "(" unexpected
Portanto seu script deverá começar, por segurança, sempre com #!/bin/bash ou então com #!/usr/bin/env bash no caso do Bash não estar em seu lugar “habitual”.

Até!

Compartilhe isso:
Clique para enviar por e-mail a um amigo(abre em nova janela)Clique para imprimir(abre em nova janela)Clique para compartilhar no Facebook(abre em nova janela)Clique para compartilhar no LinkedIn(abre em nova janela)Clique para compartilhar no Pinterest(abre em nova janela)Clique para compartilhar no Pocket(abre em nova janela)Clique para compartilhar no Reddit(abre em nova janela)Clique para compartilhar no Skype(abre em nova janela)Clique para compartilhar no Telegram(abre em nova janela)Clique para compartilhar no Tumblr(abre em nova janela)Clique para compartilhar no Twitter(abre em nova janela)Clique para compartilhar no WhatsApp(abre em nova janela)

Declaração de variáveis no Bash
Em "Dicas"
REGEX direto no Bash
Em "Dicas"
Trabalhando com números em Bash
Em "Programação"
 Dicas, Programação
ARRAY, BASH, DASH, SHELL
Navegação de Posts
← Desenvolvimento cruzado no MC-1000Manipulação de strings em Bash →
4 comentários sobre “Arrays em Bash”
souenzzo
29/05/2017 ÀS 16:34
Vale lembrar:

A=("foo" "my bar")
for i in "${A[@]}"; do echo $i; done

Vai gerar

foo
my bar

Enquanto

for i in "${A[*]}"; do echo $i; done

geraria

foo
my
bar

Curtir

Giovanni Nunes
29/05/2017 ÀS 19:57
Obrigado pela lembrança (ah, eu editei teu comentário pois o WordPress não curtiu teu Markdown).

Curtir

Pingback: Manipulação de strings em Bash | giovannireisnunes

Pingback: Declaração de variáveis no Bash | giovannireisnunes

Os comentários estão desativados.

Pesquisar por:
Pesquisar …
!SOCIAL
Ver perfil de giovanninunes no FacebookVer perfil de plainspooky no TwitterVer perfil de giovanninunes no LinkedInVer perfil de plainspooky no GitHub
TAGS
assembly automação bash bootstrap classes debian django framework git gnu/linux hashicorp javascript jogos linux msx mvc objetos perl python rest retrocomputaria Retrocomputação ruby screenshot shell survive ubuntu vagrant virtualbox virtualenv windows z80
POSTS RECENTES
Utilizando o FastAPI – parte 4 25/09/2020
Utilizando o FastAPI – parte 3 11/09/2020
Convertendo imagens para MSX 28/08/2020
Utilizando o FastAPI – parte 2 14/08/2020
Utilizando o FastAPI – parte 1 31/07/2020
Usando arquivos CSV em Python 17/07/2020
Implementando API REST com Django – parte 3 17/04/2020
Mais decoradores em Python 03/04/2020
Close Windows, Open Doors
CATEGORIAS
Aplicativos e Ferramentas (70)
Dicas (32)
Erratas (2)
In english (5)
Literatura (1)
Notícias (13)
Outras Coisas (23)
Programação (117)
Retrocomputação (11)
Sistemas Operacionais (10)
Licença Creative Commons
Este obra está licenciado com uma Licença Creative Commons Atribuição-CompartilhaIgual 4.0 Internacional.
SITE NO WORDPRESS.COM.
Privacidade e cookies: Esse site utiliza cookies. Ao continuar a usar este site, você concorda com seu uso.
Para saber mais, inclusive sobre como controlar os cookies, consulte aqui: Política de cookies
:)
