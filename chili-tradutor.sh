#!/usr/bin/env bash

#xgettext --language=Shell --keyword=gettext --output=$1.pot $1
#trans -b :en "Impressoras" "Bom dia" "Obrigado"
#trans -b :en "error: you cannot perform this operation unless you are root."
#trans -R #Para conhecer os códigos de idioma que podemos usar, basta executar o seguinte comando:
#trans -T #Para conhecer os códigos de idioma que podemos usar, basta executar o seguinte comando:

sh_configure() {
	# Definir a variável de controle para restaurar a formatação original
	reset=$(tput sgr0)

	# Definir os estilos de texto como variáveis
	bold=$(tput bold)
	underline=$(tput smul)   # Início do sublinhado
	nounderline=$(tput rmul) # Fim do sublinhado
	reverse=$(tput rev)      # Inverte as cores de fundo e texto

	# Definir as cores ANSI como variáveis
	black=$(tput bold)$(tput setaf 0)
	red=$(tput bold)$(tput setaf 196)
	green=$(tput bold)$(tput setaf 2)
	yellow=$(tput bold)$(tput setaf 3)
	blue=$(tput setaf 4)
	pink=$(tput setaf 5)
	magenta=$(tput setaf 5)
	cyan=$(tput setaf 6)
	white=$(tput setaf 7)
	gray=$(tput setaf 8)
	orange=$(tput setaf 202)
	purple=$(tput setaf 125)
	violet=$(tput setaf 61)
	light_red=$(tput setaf 9)
	light_green=$(tput setaf 10)
	light_yellow=$(tput setaf 11)
	light_blue=$(tput setaf 12)
	light_magenta=$(tput setaf 13)
	light_cyan=$(tput setaf 14)
	bright_white=$(tput setaf 15)

	# Cores - Substitua pelos códigos ANSI do seu terminal, se necessário
	GREEN="\033[1;32m"   # Verde
	RED="\033[1;31m"     # Vermelho
	YELLOW="\033[1;33m"  # Amarelo
	BLUE="\033[1;34m"    # Azul
	MAGENTA="\033[1;35m" # Magenta
	CYAN="\033[1;36m"    # Ciano
	RESET="\033[0m"      # Resetar as cores
}

sh_usage() {
	cat <<-EOF
		Usage:
			$0 <script>
			$0 <script> en
	EOF
	exit 1
}

sh_configure
if [[ $# -eq 0 ]]; then
	sh_usage
fi

if [[ $# -ge 2 ]]; then
	declare -a idioma=($2)
else
	declare -a idioma=(bg cs da de el en es et fi fr he hr hu is it ja ko nl no pl pt-PT pt-BR ro ru sk sv tr uk zh fa hi ar)
fi

echo 'Running xgettext'
xgettext --verbose --from-code=UTF-8 --language=shell --keyword=gettext --output $1.pot $1
#bash --dump-po-strings $1 >>$1.pot
echo 'Running sed #1'
sed -i 's/"Content-Type: text\/plain; charset=CHARSET\\n"/"Content-Type: text\/plain; charset=UTF-8\\n"/' $1.pot
echo 'Running sed #2'
sed -i 's/"Language: \\n"/"Language: pt_BR\\n"/' $1.pot
#traduzir com o trans
echo 'Running msggrep'
msggrep -vvv --msgid --msgstr --output-file=$1-temp.po $1.pot
echo

if ! test -e $1.pot; then
	echo "Error: Cannot open $1.pot"
	exit 1
fi

for i in "${idioma[@]}"; do
	file_po="$1-$i.po"
	temp_po="$1-temp-$i.po"
	[[ -e $file_po ]] && rm $file_po
	msginit --no-translator --locale="$i" --input $1.pot --output $file_po
	sed -i 's|Content-Type: text/plain; charset=ASCII|Content-Type: text/plain; charset=utf-8|g' $file_po
	cp $file_po $temp_po
	rm $file_po
	#	msgfmt -v "$i.po" -o "$i.mo"
	#	sudo install -v "$i.mo" "/usr/share/locale/$i/LC_MESSAGES/$1.mo"

	quiet=1
	process=0
	line_number=0
	while read -r line; do
		((line_number++))
		if grep -qi '^msgid ' <<<"$line" || grep -qi '^msgstr' <<<$line; then
			msgid=$(echo "$line" | grep '^msgid ' | awk -F'"' '{print $2}')
			msgstr=$(echo "$line" | grep '^msgstr ' | awk -F'"' '{print $2}')

			if ((process)); then
				process=0
				continue
			fi
			if [[ -n "$msgid" && -z "$msgstr" ]]; then
				process=1
				if ! ((quiet)); then
					echo "${orange}#: $i.pot:$line_number $line${reset}"
				fi
				translation=$(trans -no-auto -b :"$i" "$msgid")
				if ! ((quiet)); then
					{
						echo "$line"
						echo "msgstr \"$translation\""
					} | tee -a $file_po
				else
					echo "$line" >>$file_po
					echo "msgstr \"$translation\"" >>$file_po
				fi
				continue
			fi
		fi
		if ! ((quiet)); then
			echo "${black}$line${reset}"
		fi
		echo "$line" >>$file_po
	done <<<"$(<"$temp_po")"
	#	sed -i 's|"\.$|\."|g' $i.po
	#	sed -i 's|"\.|"|g' $i.po
	#	sed -i 's|»|"|g' $i.po
	#	sed -i 's|«|"|g' $i.po
	#	sed -i 's|„|"|g' $i.po
	#	sed -i 's|“|"|g' $i.po
	#	sed -i 's|„“|""|g' $i.po

	cp $file_po $temp_po
	mkdir -p usr/share/locale/$i/LC_MESSAGES/
	if msgfmt -v $file_po -o usr/share/locale/$i/LC_MESSAGES/$1.mo; then
		rm $temp_po
	fi
	echo
done
exit

for x in *.po; do
	echo $x
	file_name="$x"
	lang="${file_name%.po}"
	msgfmt -v $x -o usr/share/locale/$lang/LC_MESSAGES/$i.mo
done

## Substitua a chave da API do Google Translate abaixo (https://console.cloud.google.com/)
#GOOGLE_TRANSLATE_API_KEY="SUA_CHAVE_DA_API_AQUI"
## Idioma de origem (deve ser o mesmo idioma das mensagens originais no .po)
#SOURCE_LANGUAGE="en"
## Idioma para o qual você deseja traduzir (exemplo: francês)
#TARGET_LANGUAGE="fr"
## Nome do arquivo .po de entrada
#INPUT_PO_FILE="seu_arquivo.po"
## Nome do arquivo .po de saída (com as traduções)
#OUTPUT_PO_FILE="traduzido.po"
## Extrai as mensagens originais do arquivo .po e salva em um novo arquivo temporário
#msggrep --msgid --msgstr --output-file=temp.po "$INPUT_PO_FILE"
## Obtém as traduções automáticas usando o Google Translate API
#cat temp.po | while read -r line; do
#    msgid=$(echo "$line" | grep '^msgid ' | sed 's/^msgid //')
#    msgstr=$(echo "$line" | grep '^msgstr ' | sed 's/^msgstr //')
#    if [[ "$msgid" && "$msgstr" == '""' ]]; then
#        translation=$(curl -s -G --data-urlencode "key=$GOOGLE_TRANSLATE_API_KEY" --data-urlencode "source=$SOURCE_LANGUAGE" --data-urlencode "target=$TARGET_LANGUAGE" --data-urlencode "q=$msgid" https://translation.googleapis.com/language/translate/v2 | jq -r '.data.translations[0].translatedText')
#        echo "msgid $msgid" >> "$OUTPUT_PO_FILE"
#        echo "msgstr \"$translation\"" >> "$OUTPUT_PO_FILE"
#        echo >> "$OUTPUT_PO_FILE"
#    fi
#done
## Remove o arquivo temporário
## rm temp.po
#
##chmod +x translate_po.sh
##./translate_po.sh

#pacman -Sq --noconfirm  git gettext npm translate-shell
#sudo npm install --location=global attranslate

#set -o extglob
#git clone https://github.com/biglinux/big-auto-translator.git
#mv big-auto-translator/gettext_po_generator_github.sh .
#gitfolder=$(echo ${{ github.repository }} | rev | cut -d "/" -f1 | rev)
#bash gettext_po_generator_github.sh $gitfolder
#
#git config --local user.email "github-actions[bot]@users.noreply.github.com"
#git config --local user.name "github-actions[bot]"
#if [ -n "$(git commit -m "translate $(date +%y-%m-%d_%H:%M)" -a | grep "nothing to commit")" ];then exit 0; fi
#	curl -X POST -H "Accept: application/json" -H "Authorization: token ${{ secrets.WEBHOOK_TOKEN }}" --data '{"event_type": "${{ github.repository }}", "client_payload": { "branch": "${{ github.ref_name }}", "url": "https://github.com/${{ github.repository }}"}}' https://api.github.com/repos/BigLinux-Package-Build/build-package/dispatches
#fi
