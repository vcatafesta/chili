#!/usr/bin/env bash

cat <<-EOF > exemplo.xml
<?xml version="1.0" encoding="UTF-8"?>
<root>
  <elemento>Valor do elemento</elemento>
  <elemento1 atributo1="valor1" atributo2="valor2">Conteúdo do elemento 1</elemento1>
  <elemento2>Conteúdo do elemento 2</elemento2>
  <!-- Seu comentário aqui -->
</root>
EOF

echo 'xmlstarlet sel -t -v "/root/elemento" exemplo.xml'
xmlstarlet sel -t -v "/root/elemento" exemplo.xml
echo
echo
echo "awk -F'[<>]' '/<elemento>/{print $3}' exemplo.xml"
awk -F'[<>]' '/<elemento>/{print $3}' exemplo.xml

xmllint --format exemplo.xml

conteudo=$(xmllint --xpath "//elemento" exemplo.xml)
echo $conteudo
