#!/bin/bash

source /etc/bashrc

function ImportPkgOldToZst()
{
	cfiles=$(ls -1 *.chi)
	for pkg in $cfiles
	do
		echo
		newpkg=$(echo $pkg|sed 's/_/-/g')
		log_info_msg "Renomeando $pkg para $newpkg"
		mv $pkg $newpkg &>/dev/null
		evaluate_retval

		cnewpkgsemext=$(echo $newpkg|sed 's/.chi//g')
		log_info_msg "Criando diretorio $cnewpkgsemext"
		mkdir $cnewpkgsemext &>/dev/null
		evaluate_retval

		log_info_msg "Extraindo arquivos $newpkg"
		tar --extract --file $newpkg -C $cnewpkgsemext
		evaluate_retval

		log_info_msg "Entrando diretorio $cnewpkgsemext"
		pushd $cnewpkgsemext/ &>/dev/null
		evaluate_retval

		fetch -g
		echo -e
		fetch create
		echo -e
		popd &>/dev/null
	done
}
