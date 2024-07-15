#!/usr/bin/env bash

#localizacao dos arquivos .desktop
global_launchers='/usr/share/applications/*.desktop'
local_launchers=$HOME'/.local/share/applications/*.desktop'

#expansao da lista de arquivos
desktop_files="$global_launchers $local_launchers"

# categorias
cats=('Acessórios'
	'Configurações'
	'Desenvolvimento'
	'Educação'
	'Escritório'
	'Gráficos'
	'Internet e Redes'
	'Jogos'
	'Multimedia'
	'Sistema'
	'Outros'
)

sh_desktop_files() {
	awk '
		/^(Name=|Comment=)/ {print NR" "$0}
	' $desktop_files
}

sh_desktop_files
