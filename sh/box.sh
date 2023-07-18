#!/bin/bash

#. $PWD/funcoes

function sh_menu()
{
	#rm index.html*
	#wget -q $url_mazon

	cat index.html \
	| grep .xz \
	| awk '{print $2, $5}' \
	| sed 's/<a href=\"//g' \
	| cut -d'"' -f3 \
	| sed 's/>//g' \
	| sed 's/<\/a//g' >teste.txt

	dialog --title "teste" --menu "x" 0 0 0 $(cat teste.txt)
}

function sh_adduser()
{
	# open fd
	exec 3>&1
	dialog 															\
			--separate-widget	$'\n'								\
			--cancel-label 		"Cancelar"							\
			--backtitle 		"MazonOS Linux User Managment"		\
			--title 			"Useradd" 							\
			--form 				"Criar um novo usuário"				\
	12 50 0 														\
		"Username : " 1 1 "$cuser"        1 13 10 0 				\
		"Password : " 2 1 "$cpass"        2 13 20 0 				\
		"Hostname : " 3 1 "$chost"        3 13 20 0					\
	2>&1 1>&3 | {
		read -r cuser
		read -r cpass
		read -r chost

		if [ "$user" != "" ]; then
			cinfo=`log_info_msg "Aguarde, criando usuario..."`
		    msg "INFO" "$cinfo"
			useradd -m -G $groups $cuser > /dev/null 2>&1
		    evaluate_retval

			if [ $? = $true ]; then
				cinfo=`log_info_msg "Aguarde, definindo senha do usuario..."`
			    msg "INFO" "$cinfo"
				#$(echo $cpass ; echo $cpass) | passwd $cuser
				(echo $cuser:$cpass) | chpasswd > /dev/null 2>&1
			    evaluate_retval
				if [ $? = $true ]; then
					cinfo=`log_info_msg "OK, senha criada com sucesso..."`
				    msg "INFO" "$cinfo"
				fi
			fi

		fi
	}

	# close fd
	exec 3>&-
}
#sh_adduser
