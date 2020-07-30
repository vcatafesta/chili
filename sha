#!/bin/bash
#
################################################################
#       install dialog Mazon OS - version 1.0       			#
#                                                     			#
#      @utor: Diego Sarzi 		<diegosarzi@gmail.com>			#
#             Vilmar Catafesta 	<vcatafesta@gmail.com>			#
#      created: 2019/02/15          licence: MIT      			#
#      altered: 2019/02/17          licence: MIT      			#
#################################################################

. $PWD/funcoes

function sh_testarota(){
	cinfo=`log_info_msg "Aguarde, testando rota para o servidor MazonOS..."`
	msg "INFO" "$cinfo"
	ping -c 2 $site > /dev/null 2>&1
	evaluate_retval
	return $?
}

function sh_testsha256sum(){
	cinfo=`log_info_msg "Aguarde, testando sha256sum"`
	msg "INFO" "$cinfo"
	#result=`sha256sum -c $sha256_default`
	sha256sum -c $sha256_default > /dev/null 2>&1
	evaluate_retval
	return $?
}

function sh_delsha256sum(){
	cinfo=`log_info_msg "Aguarde, excluindo sha256 antigo..."`
	msg "INFO" "$info"
	rm -f $sha256_default > /dev/null 2>&1
	evaluate_retval
	return $?
}

function sh_wgetsha256sum(){
	ret=`log_info_msg "Aguarde, baixando sha256 novo..."`
	msg "INFO" "$ret"
	wget -q $clinksha > /dev/null 2>&1
	evaluate_retval
	return $?
}

function sh_delpackageindex(){
	ret=`log_info_msg "Aguarde, apagando indice antigo..."`
	msg "INFO" "$ret"
	rm index.html* > /dev/null 2>&1
	evaluate_retval
	return $?

}

function sh_wgetpackageindex(){
	ret=`log_info_msg "Aguarde, baixando indice de pacotes..."`
	msg "INFO" "$ret"
	wget $url_mazon > /dev/null 2>&1
	evaluate_retval
	return $?
}

function sh_checksha256sum(){
	clinksha=$url_mazon$sha256_default
	ret=`log_info_msg "Aguarde, entrando no diretorio de trabalho..."`
	msg "INFO" "$ret"
	cd $pwd > /dev/null 2>&1
	evaluate_retval
	return $?

	#sh_testarota
	#confirma $? "Sem internet cara, deseja encerrar?"; yes "clear" "exit"

}

function sh_choosepackage(){
	pkt=($(cat index.html \
		| grep .xz \
		| awk '{print $2, $5}' \
		| sed 's/<a href=\"//g' \
		| cut -d'"' -f3 | sed 's/>//g' \
		| sed 's/<\/a//g' ))

     sd=$(dialog --clear             							\
                 --backtitle     "$ccabec" 						\
                 --title    	 "$ccabec" 						\
                 --cancel-label  "Voltar"						\
                 --menu          "\nPacotes disponiveis:" 		\
				0 50 0 											\
				"${pkt[@]}" 2>&1 >/dev/tty  					)

     exit_status=$?
     case $exit_status in
         $ESC)
             #scrend 1
             #exit 1
             #scrmain
             ;;
         $CANCEL)
             #scrend 0
             #scrmain
            ;;
     esac
}

function sh_choosepackageGet(){
	pkt=($(cat index.html \
		| grep .xz.sha256sum \
		| awk '{print $2}' \
		| sed 's/<a href=\"//g' \
		| cut -d'"' -f3 | sed 's/>//g' \
		| sed 's/<\/a//g' \
		| sed 's/.sha256sum//g'))

	echo ${pkt[0]}
	echo ${pkt[1]}

	if echo "${pkt[0]}" | grep 'minimal' >/dev/null
	then
		echo "achei a minimal"
		echo ${pkt[0]}
	else
		echo "achei a minimal no 1"
		echo ${pkt[1]}
	fi


	sleep 10

}

clear
#sh_checksha256sum
#sh_testarota
#sh_delsha256sum
#sh_wgetsha256sum
#sh_testsha256sum
sh_delpackageindex
sh_wgetpackageindex
sh_choosepackage
