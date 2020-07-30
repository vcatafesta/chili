# https://elmord.org/blog/?entry=20121227-manipulando-strings-bash

Elmord's Magic Valley
Software, lingüística e rock'n'roll. Às vezes em Português, sometimes in English.
Manipulando strings em bash
2012-12-27 02:49 -0200. Tags: comp, prog, bash, em-portugues
Seguindo uma sugestão indireta, eis um post sobre as funções básicas de manipulação de strings do bash.

Antes de mais nada, gostaria de citar uma frase do manual do INTERCAL que me parece apropriada a respeito do bash:

Please be kind to our operators: they may not be very intelligent, but they're all we've got.
Dito isto, vamos ao ponto.

Parameter substitution
Como toda linguagem normal, bash possui variáveis.

person="Elmord"
echo "$person's Magic Valley"
A sintaxe $nome invoca o que se chama de parameter expansion. 'Parâmetro' é um termo mais geral que 'variável' em bash, e inclui variáveis, argumentos recebidos por um script ou função ($1, $2, ...), e alguns valores especiais mantidos pelo bash (e.g., $$ (PID do shell), $* (todos os argumentos do script/função em uma string só), etc.). Em bash, todos os parâmetros são strings (ou quase: $*, $@ e aparentados são meio indecisos sobre se são strings ou arrays de strings).

$nome pode ser escrito como ${nome}. Isso é útil quando se deseja isolar o nome do parâmetro de uma string adjacente que poderia ser interpretada como parte do nome:

animal="Raposa"
echo "${animal}s não dão dinheiro."
Além disso, essa sintaxe estendida permite especificar modificações sobre o valor a ser retornado pela expansão. Entre as modificações mais usadas estão as remoções de prefixos e sufixos:

${nome#pattern}: Remove o menor prefixo que case com pattern
${nome##pattern}: Remove o maior prefixo que case com pattern
${nome%pattern}: Remove o menor sufixo que case com pattern
${nome%%pattern}: Remove o maior sufixo que case com pattern
(Mnemônico: # fica à esquerda (prefixo) de $ no teclado, % à direita (sufixo) de $.)

Por exemplo:

file="arquivo.feliz.html"
echo "$file"         # arquivo.feliz.html
echo "${file%.*}"    # arquivo.feliz (remove o menor sufixo do tipo .*, i.e., do último ponto em diante)
echo "${file##*.}"   # html (remove o maior prefixo do tipo *., i.e., do começo até o último ponto)
echo "${file%%.*}"   # arquivo (remove tudo do primeiro ponto em diante)
echo "${file#*.}"    # feliz.html (remove apenas até o primeiro ponto)
Exemplo levemente mais elaborado:

path="foo/bar/baz/quux/hack"
echo "${path%/*}"          # foo/bar/baz/quux
echo "${path%/*/*}"        # foo/bar/baz
echo "${path%/*/*/*}"      # foo/bar
echo "${path%/*/*/*/*}"    # foo
echo "${path%/*/*/*/*/*}"  # foo/bar/baz/quux/hack
No primeiro echo, removemos apenas o último componente do caminho. No segundo, removemos o menor sufixo que casa com /*/*, i.e., que consiste de uma barra, seguida por qualquer coisa (inclusive nada), seguido por outra barra, seguida por qualquer coisa (inclusive nada), o que resulta na eliminação dos dois últimos componentes do caminho. No último comando, o pattern não casa com nada (não há cinco barras na string), e portanto o resultado é o valor de path intacto. (Note que isso funciona porque estamos removendo o menor sufixo, com o operador % simples. Se usássemos o operador %% (i.e., ${path%%/*}, etc.) ficaríamos apenas com foo em todos os casos exceto o último.)

E se ao invés de remover os dois últimos componentes, quiséssemos ficar com apenas os dois últimos componentes? Infelizmente não existe um operador para remover o "segundo maior prefixo" que case com */. Uma maneira de conseguir isso é fazer a operação em dois passos:

path="foo/bar/baz/quux/hack"
prefix="${path%/*/*}"      # coloca "foo/bar/baz" em prefix
echo "${path#"$prefix"}"   # remove "foo/bar/baz" do começo de $path, deixando "/quux/hack"; ou
echo "${path#"$prefix/"}"  # remove "foo/bar/baz/" do começo de $path, deixando "quux/hack"
Ou, de maneira mais abreviada (e talvez menos legível):

echo "${path#"${path%/*/*}"}"
Note as aspas ao redor da sub-expressão (${path#"prefix"}). Elas são necessárias porque o valor de $prefix poderia conter caracteres como *, que seriam interpretados como wildcards se não houvesse aspas.

Os wildcards que podem aparecer nas patterns são os mesmos que podem ser usados com nomes de arquivos: * (zero ou mais caracteres quaisquer), ? (um caractere qualquer), [abcde] (qualquer um dos caracteres listados; ranges do tipo A-Z, bem como classes de caracteres do tipo [:digit:], podem ser incluídos na lista), [^abcde] (qualquer caractere não listado). Se a opção shopt -s extglob estiver ativa, patterns estendidas também são aceitas, mas isso é assunto para outro post.

Outro tipo de modificação útil são as substituições de substrings:

${nome/pattern/string}: substitui a primeira ocorrência de pattern por string;
${nome//pattern/string}: substitui todas as ocorrências de pattern por string;
${nome/#pattern/string}: substitui uma ocorrência de pattern por string, desde que pattern ocorra no início de $nome;
${nome/%pattern/string}: substitui uma ocorrência de pattern por string, desde que pattern ocorra no fim de $nome.
A pattern de substituição sempre casa com a maior ocorrência (i.e., se x="foo.bar.baz.quux.hack", ${x/.*./BOOM} expande para fooBOOMhack). Aparentemente não há um meio de substituir o menor prefixo/sufixo. Go figure.

Outra modificação útil é o slicing: ${nome:início:tamanho} seleciona tamanho caracteres de $nome, começando pelo início-ésimo (contando do zero). início e tamanho são expressões aritméticas; portanto, nomes de variáveis podem ser usados sem $, e operações aritméticas podem ser realizadas diretamente, sem necessidade de usar a sintaxe usual para expansão aritmética ($((expressão))):

x="foobarbazquux"
echo "${x:6:3}"      # baz
n=6
echo "${x:n:n/2}"    # baz
Se tamanho for omitido, o trecho de início até o final da string é usado. Se início for negativo, conta-se a partir do final da string:

echo "${x:(-4):1}"   # q
echo "${x:(-4)}"     # quux
(Note que o - deve ser separado do : que o precede (com parênteses ou espaços, por exemplo), pois ${nome:-string} significa algo completamente diferente em bash (usa o valor de $nome, ou string se $nome for vazio).)

Se um índice negativo indicar uma posição antes do começo da string, o resultado é a string vazia. (Por quê? Por quê?)

${#nome} devolve o comprimento de $nome. Há outras modificações; para mais informações, procure por Parameter Expansion na manpage do bash.

Separando em pedacinhos
Uma operação comum sobre strings é separá-la em diversos componentes segundo algum caractere separador. Essa operação existe em diversas linguagens sob o nome de split. Por exemplo, em JavaScript:

js> x = "foo bar baz"
"foo bar baz"
js> partes = x.split(" ")
["foo", "bar", "baz"]
js> partes[1]
"bar"
(By the way: já experimentou dar Ctrl-Shift-K no Firefox?)

Bash é uma linguagem muito hábil em separar strings. Por sinal, bash é hábil demais em separar strings: qualquer parâmetro não envolto em aspas está sujeito ao infame word splitting: o valor resultante da expansão do parâmetro é separado em múltiplas "palavras", e cada palavra é tratada como um argumento separado. Por exemplo:

$ file="nome com espaços"
$ ls "$file"
ls: cannot access nome com espaços: No such file or directory
$ ls $file
ls: cannot access nome: No such file or directory
ls: cannot access com: No such file or directory
ls: cannot access espaços: No such file or directory
Isso significa que você deve colocar aspas maniacamente em torno de qualquer string com variáveis que você não quer que sejam splitadas. Isso também significa que você pode se aproveitar dessa feature para obter os pedacinhos individuais de uma string. Uma maneira de fazer isso é criando um array com o resultado da expansão:

partes=($file)
echo "${partes[0]}"     # nome
echo "${partes[1]}"     # com
echo "${partes[2]}"     # espaços
echo "${#partes[@]}"    # 3 (comprimento do array)
Outra maneira é substituir os argumentos posicionais do shell pelo resultado da expansão:
set -- $file
echo "$1"               # nome
echo "$2"               # com
echo "$3"               # espaços
echo "$#"               # 3
O que define uma "palavra" são os separadores contidos na variável IFS (internal field separator): essa variável contém todos os caracteres que são considerados separadores. Por padrão, os separadores são espaços, tabs e newlines. Você pode setar essa variável para quaisquer outros caracteres, e remover a variável (com unset IFS) para restaurar os separadores originais. Por exemplo, se quiséssemos escrever um script para procurar no arquivo /etc/passwd (cujos campos são separados por :) o nome do shell de um determinado usuário, poderíamos fazer assim:
#!/bin/bash
user="$1"

IFS=":"
while read line; do
    campos=($line)
    if [ "${campos[0]}" = "$user" ]; then
        echo "${campos[6]}"
    fi
done </etc/passwd
Update: Há uma solução melhor.

Matching
Às vezes queremos saber se uma string casa com um determinado padrão. A maneira mais comum de se fazer isso é através do comando case:

case "$file" in
    *.txt)
        echo "É um arquivo de texto."
        cat "$file"
        ;;
    *.gif|*.jpg|*.png)
        echo "É uma figurinha."
        xloadimage "$file"
        ;;
    *)
        echo "Que que é isso, medeus?"
        ;;
esac
Cada cláusula do case começa com uma pattern, seguida de ). Os tipo de pattern aceitos são os mesmos usados para expansão de nomes de arquivos e para remoções de prefixo/sufixo e outras substituições de string. Cada cláusula é terminada com ;;. (O ;; na última cláusula é opcional.) Múltiplas patterns, separadas por |, podem ser especificadas.

As patterns do shell são um tanto quanto limitadas, o que exige uma certa dose de treta na hora de usá-las. Por exemplo, imagine que queiramos fazer um script que exige um número como argumento, e queremos que o script teste se o argumento foi passado corretamente. Não temos como especificar uma pattern que diga que apenas números são aceitos. A solução é especificar que se o argumento contiver algum caractere que não seja um número, o script deve emitir um erro:

case "$1" in
    *[^0-9]*)
        echo "Erro: argumento deve ser um número."
        exit 1
        ;;
    *)
        echo "Eis um número: $1."
        ;;
esac
Parece bom? Quase: se uma string vazia for passada, nenhum dos caracteres que a compõem casa com [^0-9], e portanto a primeira pattern não casa, e portanto caímos na segunda cláusula do case, embora o argumento passado não seja um número. Para resolver esse problema, temos que incluir a string vazia na primeira cláusula:

case "$1" in
    *[^0-9]*|)
        echo "Erro: argumento deve ser um número."
        exit 1
        ;;
    *)
        echo "Eis um número: $1"
        ;;
esac
Comandos externos
Até agora utilizamos apenas recursos internos do shell. Mas temos também à disposição a vasta gama de comandos de manipulação de texto do Unix, tais como cut, sed e tr. Se quisermos alimentar um desses comandos com o conteúdo de uma variável, podemos usar o comando echo em uma pipeline, e capturar o resultado com a sintaxe $(comando):

dmy="27/05/1990"
ymd="$(echo "$dmy" | sed -re 's,(..)/(..)/(....),\3-\2-\1,')"
echo "$ymd"   # 1990-05-27
A partir do bash 3, é possível alimentar a entrada padrão de um comando com uma string através da sintaxe comando <<<string:

ymd="$(sed -re 's,(..)/(..)/(....),\3-\2-\1,' <<<"$dmy")"
Outras features
Este post não cobre todas as features de manipulação de strings no bash. (Em particular, faltou cobrir o comando [[ expressão ]] e suas habilidades com expressões regulares, as quais eu ainda não experimentei direito.) Para mais informações, dê uma olhada na manpage do bash. Sinta-se à vontade para acrescentar outras mandingas ou fazer perguntas nos comentários.
