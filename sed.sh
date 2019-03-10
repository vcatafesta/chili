#!/usr/bin/env bash

echo "01140404040" >> sed.tmp
echo "01120202020" >> sed.tmp
echo "01250505050" >> sed.tmp
echo "02010203040" >> sed.tmp

sed 's/\(...\)\(.*\)/\19\2/g' -i sed.tmp # 3 digitos
#sed 's/\(..\)\(.*\)/\19\2/g' -i sed.tmp # 2 digitos

# onde:
# \(...\) - Agrupa três caracteres (o DDD)
# \(.*\) - Agrupa o restante dos números
# \19\2 - Imprime o primeiro grupo (DDD), insere o 9 e imprime o segundo grupo
# -i sed.tmp - Modifica o arquivo sed.tmp

#Exemplo de uso:

# antes:
# 01140404040
# 01120202020
# 01250505050
# 02010203040


# Depois:
# 011940404040
# 011920202020
# 012950505050
# 020910203040

#Lista completa das classes de caracteres do GNU sed
#[[:alnum:]] Alfabéticos e númericos [a-z A-Z 0-9]
#[[:alpha:]] Alfabéticos [a-z A-Z]
#[[:blank:]] Caractere em branco, espaço ou tab [ \t]
#[[:cntrl:]] Caracteres de controle [\x00-\x1F\x7F]
#[[:digit:]] Números [0-9]
#[[:graph:]] Qualquer caractere visível(ou seja, exceto em branco) [\x20-\x7E]
#[[:lower:]] Letras minúsculas [a-z]
#[[:upper:]] Letras maiúsculas [A-Z]
#[[:print:]] Caracteres visíveis (ou seja, exceto os de controle) [\x20-\x7E]
#[[:punct:]] Pontuação [-!”#$%&’()*+,./:;?@[\]_`{    }~].
#[[:space:]] Espaço em branco [ \t\r\n\v\f]
#[[:xdigit:]] Número hexadecimais [0-9 a-f A-F]

# http://terminalroot.com.br/2015/07/30-exemplos-do-comando-sed-com-regex.html

#1 - Troca todas as palavras em um arquivo por outra
sed -i 's/palavra/outra/' arquivo.txt

#2 - Imprime só a nona linha
sed -n '9p' arquivo.txt

#3 - Imprime da sexta linha até a nona linha
sed -n '6,9p' arquivo.txt

#4 - Deleta todas as lihas que contém a palavra string no arquivo
sed -i '/dmx/d' arquivo.txt

#5 - Coloca uma palavra no INÍCIO de cada linha
sed 's/^/palavra/' arquivo.txt

#6 - Coloca uma palavra no final de cada linha
sed 's/$/palavra/' arquivo.txt

#7 - Imprime só as linhas que COMEÇAM com a string ‘http’
sed -n '/^http/p' arquivo.txt

#8 - Deleta só as linhas que COMEÇAM com a string ‘http’
sed -n '/^http/d' arquivo.txt

#9 - Troca TODAS ocorrências da palavra “marcos”, “eric”, “camila” pela palavra “pinguim”
sed 's/marcos\|eric\|camila/pinguim/g' arquivo.txt

#10 - Troca tudo que estiver ENTRE as palavras “Marcos” e “Eric” pela palavra “eles”, exemplo, o 
#texto é:
#“No sábado Marcos saiu de pra brincar de bicicleta com o Eric, mas não ficaram até tarde.” e 
#ficará assim: “No sábado eles, mas não ficaram até tarde.”

sed 's/Marcos.*Eric/eles/' arquivo.txt

# 11 - Deleta linha em branco e altera o arquivo
sed -i '/^$/d' arquivo.txt

#12 - Substitui “foo” por “bar” somente as linhas que contém “plop”
sed '/plop/ s/foo/bar/g' arquivo.txt

#13 - Substitui “foo” por “bar” exceto as linhas que contém “plop”
sed '/plop/! s/foo/bar/g' arquivo.txt

14 - Insere da Linha 2 a linha 7 o “#” no início de cada linha
sed '2,7s/^/#/' arquivo.txt
15 - Insere a palavra ‘NEW’ no início de cada linha, da linha 21 até a linha 28
sed -i '21,28s/^/NEW/' arquivo.txt
16 - Troca tudo entre as tags “” e “” pela palavra “CODIGO” , exemplo de código html:
É assim: São os homens os produtores das suas representações, das suas ideias, etc.; mas os 
homens reais agentes, tais como são condicionados por um desenvolvimento determinado das suas 
forças produtivas e da… Depois fica assim: CODIGO

sed 's/.*/CODIGO/' arquivo.txt
17 - Imprime somente a primeira ocorrência da linha com determinada string
sed -n '/dia/{p;q;}' arquivo.txt
18 - Inclue texto no final da linha 9
sed '9s/$/final da linha/' arquivo.txt
19 - Coloca todas as linhas em uma só
sed ':a;$!N;s/\n//;ta;' arquivo.txt
20 - Substitui a palavra “BELEZA” por “SIM” somente entre determinadas linhas
sed '3,6s/BELEZA/SIM/' arquivo.txt
21 - Apaga o que está entre a palavra “falou” e “segundo” ( delimitadores )
sed '/segundo/{/falou/{s/segundo.*falou//;t};:a;/falou/!{N;s/\n//;ta;};s/segundo.*falou/\n/;}' 
arquivo.txt
22 - Retira comandos HTML (tudo entre < e > )
sed 's/<[^>]*>//g' arquivo.txt
Curso Completo de Expressões Regulares na Udemy
23 - Apaga o 1o caracter da frase
sed 's/.//' arquivo.txt
24 - Apaga o 4o caractere da frase
sed 's/.//4' arquivo.txt
25 - Apaga os 4 primeiros caracteres
sed 's/.\{4\}//' arquivo.txt
26 - Apaga no mínimo 4 caracteres
sed 's/.\{4,\}//' arquivo.txt
27 - Apaga de 2 a 4 caracteres (o máx. que tiver)
sed 's/.\{2,4\}//' arquivo.txt
28 - Exemplos de intervalo
echo "aáeéiíoóuú" | sed "s/[a-u]//g"
áéíóú
echo "aáeéiíoóuú" | sed "s/[á-ú]//g"
aeiou
29 - Transforma texto (URL) em tags HTML de links.
Era : http://www.com

Fica: <a href=”http://www.com”>http://www.com</a>

sed 's_\<\(ht\|f\)tp://[^ ]*_<a href="&">&</a>_' arquivo.txt
30 - Expressões Regulares com SED ( sed regex )
Este sed lê dados do arquivo.txt e apaga (comando d) desde a primeira linha, até a linha que 
contenha 3 números seguidos, jogando o resultado na tela. Se quiser gravar o resultado, 
redirecione-o para outro arquivo, não o próprio arquivo.txt .

sed '1,/[0-9]\{3\}/d' arquivo.txt
Apagar números

s/[0-9]\+//g' arquivo.txt
Imprime só linhas que contém PONTUAÇÃO

sed -n '/[[:punct:]]/p' arquivo.txt
Imprime só linhas que começam com Números

sed -n '/^[[:digit:]]/p' arquivo.txt
Formatando Numero De Telefone
temos um arquivo com os números de telefone assim:

7184325689
4333285236
1140014004
3633554488
Executando alguns desse modos de comando em SED:

Modo Neandertal
Substitui 2 caracteres “..” por “&” que é a saída da solicitação
Executa outro sed pra substituir 8 caracteres de novo pelo “&”
Obs.: Precisa sempre escapar os parênteses “\(“ e “\)”

sed 's/../\(&\)/' arquivo.txt | sed 's/......../&-/' arquivo.txt
Modo Medieval
O mesmo do de cima, só pus o “{8}” pra marcar 8 caracteres “.”
Também precisa, SEMPRE, escapar as chaves “\{“ e “/}”
sed 's/../\(&\)/' arquivo.txt | sed 's/.\{8\}/&-/' arquivo.txt
Modo Moderno
Ao invés de jogar a saída, separei o comando com ponto-vírgula “;” e lancei outro sed “s”

sed 's/../\(&\)/;s/.\{8\}/&-/' arquivo.txt
Modo Pós-Moderno
Esse modo é pra entender o seguinte

O primeiro comando entre parênteses “\(..\)”
Depois separado por barra \
Lancei ou comando entre parênteses “\(.\{4\}\)”
A saída do primeiro comando vai pro barra 1 “\1”
E a do segundo comando pro barra 2 “\2”
Poderia ter também o barra 3, n, …
sed 's/\(..\)\(.\{4\}\)/(\1)\2-/g' arquivo.txt
Fica Assim:
(71)8432-5689
(43)3328-5236
(11)4001-4004
(36)3355-4488
