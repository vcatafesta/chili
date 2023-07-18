#!/bin/bash

sh_resultadosena()
{
	clear
	#### REMOVENDO ARQUIVOS TEMPORARIOS
	rm /tmp/UltSort.txt 2> /dev/null
	rm /tmp/UltSortAtualiza.txt 2> /dev/null

	#### COLETANDO DADOS DO ULTIMO RESULTADO DA MEGASENA PULICADO PELA API DA CAIXA
	wget https://servicebus2.caixa.gov.br/portaldeloterias/api/megasena/ --no-check-certificate -qO- > /tmp/UltSort.txt
	numUltSort=$(cat /tmp/UltSort.txt | grep  '"numero":' | awk '{print $2}' | sed 's/\,//g' | sed '/^$/d' | sed -e "s/\r//g")
	#### COLETANDO O NUMERO DO ULTIMO SORTEIO GRAVADO NO BD
	numUltSortGrav=$(cat novoarquivo.txt | tail -1 | awk -F"-" '{print $1}')
	#### COLETANDO DADOS DOS DOS RESULTADOS NAO INCLUÍDOS NO BD
	echo $numUltSort
	echo $numUltSortGrav

	if [[ $numUltSort -eq $numUltSortGrav ]] ; then
		echo "BD já atualizado!"
		echo "Nenhum registro novo encontrado."
		sleep 2
		exit 1
	else
		echo "Resgistro novo encontrado!"
		echo "Atualizando Banco de Dados. Aguarde."
		sleep 2
		for (( contLinha=$numUltSortGrav+1; contLinha<=$numUltSort; contLinha++ ))
		do
			wget https://servicebus2.caixa.gov.br/portaldeloterias/api/megasena/$contLinha --no-check-certificate -qO- > /tmp/UltSortAtualiza.txt
			listaDezenas=$(cat /tmp/UltSortAtualiza.txt | sed -n '/listaDezenas/,/],/p' | sed 's/[^0-9]//g' | sed -e "s/\r//g" | awk -F"-" '{print $1}')
			listaDezenas=$(echo $listaDezenas  | cut -c1-18)
			dataApuracao=$(cat /tmp/UltSortAtualiza.txt | grep  '"dataApuracao":' | awk '{print $2}' | sed 's/\"//g' | sed 's/\,//g' | sed -e "s/\r//g" )
			valorEstimadoProximoConcurso=$(cat /tmp/UltSortAtualiza.txt | grep  '"valorEstimadoProximoConcurso":' | awk -F"-" '{print $2}' | sed 's/\,//g')
			dadosSena=$(cat /tmp/UltSortAtualiza.txt | sed -n '/"faixa": 1/,/},/p')
			dadosQuina=$(cat /tmp/UltSortAtualiza.txt | sed -n '/"faixa": 2/,/},/p')
			dadosQuadra=$(cat /tmp/UltSortAtualiza.txt | sed -n '/"faixa": 3/,/},/p')
			numGanhadoresSena=$(echo $dadosSena | awk -F'"' '{ print $5 }' | sed 's/://g' | sed 's/,//g')
			valorPremioSena=$(echo $dadosSena | awk -F'"' '{print $7}' | sed 's/://g' | sed 's/,//g')
			valorPremioSena=$(awk '{printf "%.2f\n" ,$1}' <<< "$valorPremioSena")
			valorPremioSenaFormat=$(echo $valorPremioSena  | sed -e :a -e 's/\(.*[0-9]\)\([0-9]\{3\}\)/\1,\2/;ta' | tr ',.' '.,')
	    	varLinhaInteira=$(echo $contLinha - $dataApuracao - $listaDezenas - $valorPremioSenaFormat - $numGanhadoresSena)
	    	echo $varLinhaInteira |& tee -a novoarquivo.txt
		done
		echo "Banco de Dados atualizado!"
	fi
}

sh_resultadosena
