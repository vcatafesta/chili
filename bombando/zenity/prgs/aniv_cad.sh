#!/bin/bash
# Programa didático em shell+zenity
# Cadastramento

function Sai { # Pede confirmação para fim anormal
	zenity --question \
		--title "$Titulo" \
		--text "Deseja continuar?\n \
        - Para SIM clique em OK\n \
        - Para NÃO clique em CANCEL"
	return $? # Se clicou OK volta 0, senão 1
}

while true; do
	Nome=$(zenity --entry \
		--title "Informações para o catálogo" \
		--text "Informe o nome da pessoa a cadastrar")
	[ "$Nome" ] && break
	Titulo="Nome não Informado" \
		Sai || exit 1 # Termina se clicou CANCEL na função
done

while true; do
	Nasc=$(zenity --calendar \
		--title "Informações para o catálogo" \
		--text "Informe a data do aniversário:" \
		--date-format "%Y%m%d")
	[ "$Nasc" ] || {
		Titulo="Data não Informada"
		Sai || exit 1 # Termina se clicou CANCEL na função
		continue
	}
	Hoje=$(date +%Y%m%d)
	if [ $((Hoje - Nasc)) -lt 10000 ]; then
		zenity --question \
			--title "Provável erro de informação" \
			--text "Menos de 1 ano de idade?\n\
              Clique OK para continuar ou\n\
              Clique CANCELAR para informar nova data" \
			--no-wrap || continue
	fi
	break
done

Email=$(zenity --entry \
	--title "Informações para o catálogo" \
	--text "Infome o endereço de e-mail de $Nome")
#    --no-wrap)

while true; do
	let i++
	Tel[i]=$(zenity --entry \
		--title "Informações para o catálogo" \
		--text "Informe o telefone $i de $Nome")
	[ -z "${Tel[i]}" ] && break
	[ $(cut -sf2 -d' ' <<<${Tel[i]}) ] && {
		zenity --warning \
			--title "Telefone inválido" \
			--text "O número do telefone não pode ter brancos"
		unset Tel[i]
		let i--
	}
done

# if  Arq=$(zenity --file-selection                         \
#     --title "Informe o arquivo para salvar este catálogo" \
#     --save                                                \
#     --confirm-overwrite) || {
#         zenity --error \
#             --text "Nenhum arquivo foi selecionado"
#         exit 1
#         }
# then
#     echo $Nome:$(tr ' ' ^ <<< ${Tel[@]}):$Nasc >> $Arq
# else
#     exit 1
# fi
