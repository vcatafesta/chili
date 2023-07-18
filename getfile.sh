:<<'comment'
#!/usr/bin/env bash

time curl -s https://chililinux.com/packages/a/ | grep -o '<a [^>]*href="[^"]*"' | awk -F '"' '{print $2}' | awk -F '/' '{print $NF}'
time curl -s https://chililinux.com/packages/a/ | grep -oP '(?<=href=")[^"]+(?=")'
time curl -s http://chililinux.com/packages/a/ | grep -oP 'href="[^"]*\.zst"' | sed 's/href="//' | sed 's/"//'
time wget -qO- http://chililinux.com/packages/a/ | grep -Eo '<a href="[^\"]*\.zst\"' | sed 's/<a href="//' | sed 's/"$//'
time wget -qO- http://chililinux.com/packages/a/ | grep -oP 'href=".*?\K[^"/]+\.zst(?=")' #top
time wget -q -O - http://chililinux.com/packages/a/ | grep -o '<a href="[^"]*.zst"' | cut -d '"' -f 2 | rev | cut -d '/' -f 1 | rev
time wget -qO - http://chililinux.com/packages/a/ | grep -oP '(?<=href=")[^"]*\.zst'

lynx -dump http://chililinux.com/packages/a/ | awk '/\.zst/{print $NF}' > files.txt
echo "name,size" > output.csv
while read file; do
  size=$(lynx -head -dump http://chililinux.com/packages/a/"$file" | awk '/Content-Length/{print $2}')
  echo "$file,$size" >> output.csv
done < files.txt
comment


#!/usr/bin/python3
# -*- coding: utf-8 -*-
import requests
from bs4 import BeautifulSoup
import re
import csv

url = 'http://chililinux.com/packages/a/'

# Faz a requisição HTTP para a página
response = requests.get(url)

# Extrai o conteúdo HTML da página
html = response.content

# Cria um objeto BeautifulSoup com o conteúdo HTML
soup = BeautifulSoup(html, 'html.parser')

# Encontra todos os links que terminam com .zst
links = soup.find_all('a', href=re.compile('\.zst$'))

# Cria um arquivo CSV para escrever as informações
with open('arquivo.csv', mode='w', newline='') as csv_file:
	fieldnames = ['nome', 'tamanho']
	writer = csv.DictWriter(csv_file, fieldnames=fieldnames)

	# Escreve o cabeçalho do arquivo CSV
	writer.writeheader()

	# Percorre todos os links encontrados
	for link in links:
        # Extrai o nome do arquivo a partir do link
		nome = link.get('href')
        # Faz uma nova requisição HTTP para obter o tamanho do arquivo
		response = requests.head(url + nome)
		tamanho = response.headers.get('Content-Length')
		# Escreve as informações do arquivo no arquivo CSV
		writer.writerow({'nome': nome, 'tamanho': tamanho})
