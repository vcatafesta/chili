#!/usr/bin/ruby

# abre o arquivo em modo de leitura
file = File.open("file.txt", "r")

# lê todo o conteúdo do arquivo e armazena em uma variável
content = file.read

# fecha o arquivo
file.close

# imprime o conteúdo na saída padrão
puts content
