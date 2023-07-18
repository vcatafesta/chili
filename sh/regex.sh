#!/bin/bash

<<comment
	O ponto (.) é um fácil e casa com qualquer um, não
	importa com quem seja. Pode ser um numero, uma letra, um
	TAB, um @, o que vier ele traça, pois o ponto casa quaquer
	coisa. É um promiscuo :)
	Pode ser usado para procurar:
		Palavras que não lembra se acentou ou não.
		Palavras que podem começar com maisculas/minusculas ou nao
		Pobremas com o portugueiz?
		Horario com qualquer separador
			exemplos		casa com
			coc.			coco, cocô, ...
			.osta			costa, Costa, ...
			ca.ado			casado, cazado, ...
			12.45			12:45,	12 45, 12.45, ...

	A lista [] é muito mais seletiva que o ponto, pois não casa
	com qualquer um. A lista só casa com quem ela está afim.
	Pode ser usado para procurar:
		Palavras que não lembra se acentou ou não.
		Palavras que podem começar com maisculas/minusculas ou nao
		Pobremas com o portugueiz?
		Horario com qualquer separador
		Marcacoes (tags) HTML
			exemplos			casa com
			coc[oô]				coco, cocô, ...
			[Cc]osta			costa, Costa, ...
			ca[sz]ado			casado, cazado, ...
			12[: .]45			12:45,	12 45, 12.45, ...
			<[BIP]>				<B> <I> <P>
			<[bip]>				<b> <i> <p>

		Evite:					prefira:
		[0123456789]			[0-9]
		[0-9][0-9]:[0-9[0-9]	[012][0-9]:[0-5][0-9]
		[A-z]					[A-Za-z]

	Classes de Caractes POSIX
	POSIX class	similar to	meaning
	[:upper:]	[A-Z]			letras maiúsculas
	[:lower:]	[a-z]			letras mainusculas
	[:alpha:]	[A-Za-z]		letras maisculas e minusculas
	[:digit:]	[0-9]			digitos
	[:xdigit:]	[0-9A-Fa-f]		digitos hexadecimal
	[:xdigit:]	[A-Fa-f0-9]		digitos hexadecimal
	[:word:]	[A-Za-z0-9_]	caracteres de palavra (letras numero e sublinhados)
	[:alnum:]	[A-Za-z0-9]		digitos, letras maisculas e minusculas
	[:punct:]	[!"\#$%&'()*+,\-./:;<=>?@\[\\\]^_`{|}~]				pontuação(todos os caracteres graficos, exceto letras e digitos)
	[:blank:]	[ \t]			espacos e caracteres TAB apenas
	[:space:]	[ \t\n\r\f\v]	caracters em branco (espaco em branco)
	[:cntrl:]	[\x00-\x1F\x7F]	caracteres de controle
	[:cntrl:]	[^ [:cntrl:]]	caracteres de controle
	[:graph:]	[[:graph] ]		caracteres imprimiveis
	[:graph:]	[\x21-\x7E]		caracteres imprimiveis
	[:print:]	[\x21-\x7E]		imprimiveis e espaco
	[:print:]	[\x20-\x7E]		imprimiveis e espaco

	ESCAPE		SIGNIFICADO
	\s			casa espacos em branco, r\ ou \t
	\S			negacao de \s; casa o que nao for espaco em branco, \r ou \t
	\w			casa letras, digitos, ou '_'
	\W			negacao de \w

	Exemplo
	sed 's/\s/ X /g' texto.txt	# troca todas as ocorrencias por espaco+X+espacos
	sed 's/\s/X/g' texto.txt 	# troca todas as ocorrencias por X
	sed 's/\s//g' texto.txt 	# troca todos os espacos por nada/tira todo o espaco e tab
	sed 's/\w/x/g' <<< '1, 2, 3, 4 e já. Lá vou eu!'
		# x, x, x, x x xx. xx xxx xx!
	sed 's/\W/x/g' <<< '1, 2, 3, 4 e já. Lá vou eu!'
		# 1xx2xx3xx4xexjáxxLáxvouxeux
	grep -P '\d' <<< 1234-abcd
		# 1234
	grep -P '\D' <<< 1234-abcd
		# abcd

	LISTA NEGADA: A EXPERIENTE
	[:;,.!:][^ ]
	[[:punct:]][^ ]

EXEMPLOS UTEIS
#HH:MM
([01][0-9]|2[0-3]):[0-5][0-9]
#DD/MM/AAAA
(0[1-9]|[12][0-9]|3[01])/(0[1-9]|1[012])/([12][0-9]{3})



comment





