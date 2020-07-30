#!/bin/bash
# Versão 2.0
# Isso foi feito para mostrar que em shell se
# pode fazer de tudo, inclusive na tela.
#
# Autor: Julio Neves
#

trap "tput reset; tput cnorm; exit" 2

#  Troque Julio Neves pelo seu nome para enviar a amigos, mas
#+ sempre pelo menos 2 e somente 2 nomes ;)
#+ O nome tb pode ser passado como parâmetro.

NomeIni=(${*:-Julio Neves})

#  Feliz Ano ... 
#+ Se já passou do meio do ano, este ano mais 1, senão este ano
Ano=$[$(date +%j)>365/2?$(date +%Y)+1:$(date +%Y)]

function MontaArr
{
#  Monta um array Arr[$Lin$Col] (ambas com zeros à esqueda) 
#+ com o caracteres que está naquela posição
    local i
    local l
    for ((i=0; i<${#3}; i++))
    {
        l="${3:i:1}"
        Arr[$(printf "$1%02i" $[$2+$i])]="$l:$4"
    }
}

# Preparando nome para escrever no canto inferior direito da tela
for ((Pos=0; ;Pos++))
{
    s0=${NomeIni[0]:$Pos:1}
	s0=${s0:- }
	s1=${NomeIni[1]:$Pos:1}
	s1=${s1:- }
    [[ $s0 == ' ' && $s1 == ' ' ]] && break
    Nome="$Nome$s0 $s1"
}

# UltLin="São os votos de "$Nome" para você e sua família"
# UltCol=$[($(tput cols) - ${#UltLin}) / 2]

                 # Montando a Árvore
ColLogo=$[$(tput cols)-4]
LinLogo=$[$(tput lines)-$Pos-1]
LogoTrab=0
tput civis
lin=2
col=$(($(tput cols) / 2))
ccnev=$[col - 13]
c=$((col-1))
est=$((c-2))
cor=0
tput setab 0; clear
tput setaf 2; tput bold
for ((i=1; i<20; i+=2))
{
    tput cup $lin $col
    for ((j=1; j<=i; j++))
    {
        echo -n \*
    	MontaArr $lin $[col+j] \* 2
    }
    let lin++
    let col--
}
tput sgr0; tput setab 0; tput setaf 3; tput bold
for ((i=1; i<=2; i++))
{
    MontaArr $lin $[c+1] mWm 3
    tput cup $((lin++)) $c
    echo mWm
}
tput setab 0; tput setaf 7; tput bold
tput cup $lin $((c - 4)); echo BOAS FESTAS
MontaArr $lin $[c-3] "BOAS FESTAS" 7
tput cup $((lin + 1)) $((c - 11)); echo E muito suSHELLso em $Ano
MontaArr $((lin + 1)) $((c - 10)) "E muito suSHELLso em $Ano" 7
# tput cup $((lin + 3)) $UltCol; echo $UltLin
let c++
k=1

                   # Pendurando as bolas (da árvore, claro!)
while true
do
    for ((i=1; i<=35; i++))
    {
                   # Apagando a bola que foi ligada há 35 rodadas atras
        [ $k -gt 1 ] && {
            tput setab 0; tput setaf 2; tput bold
            tput cup ${linha[$[k-1]$i]} ${coluna[$[k-1]$i]}; echo \*
            MontaArr ${linha[$[k-1]$i]} ${coluna[$[k-1]$i]} \* 2
            unset linha[$[k-1]$i]; unset coluna[$[k-1]$i]  # Mantenha limpo o vetor
            }
        li=$((RANDOM % 9 + 3))
        ini=$((c-li+2))
        fim=$((c+li+2))
        co=$((RANDOM % (li-2) * 2 + 1 + ini))
        tput setab 0; tput setaf $cor; tput bold   # Troca cor das bolas
        tput cup $li $co
        echo o
        linha[$k$i]=$li
        coluna[$k$i]=$co
	    MontaArr $li $co o $cor
        sh=1
        for l in S H E L L
        do
            tput cup $((lin+1)) $((c-3+sh))
            echo $l
            let sh++
        done
# Olha a neve
        for ((n=0; n<15; n++))
	    {
	        [ "${nev[n]}" ] || {
	            nev[n]=$[$RANDOM % 12 + 1]$(printf "%02i" $[RANDOM % 28 + ccnev])
  		    }
	        lnev=$[nev[n] / 100]
	        cnev=$[nev[n] % 100]
	        idx=$lnev$(printf "%02i" $cnev)
	        Antigo=${Arr[10#$idx-100]%:*}
	        Antigo=${Antigo:-' '}
            CorAnt=${Arr[10#$idx-100]#*:}
	        CorAnt=${CorAnt:-0}
	        tput setab 0
	        tput setaf $CorAnt
 	        tput cup $[lnev-1] $[cnev-1]
	        echo "$Antigo"
	        tput setab 0; tput setaf 7; tput cup $lnev $[cnev-1]; echo .
	        let lnev++
	        nev[n]=$lnev$(printf "%02i" $cnev)
	        [ $lnev -gt 16 ] && {
	            tput setab 0; tput setaf 7; tput cup $[lnev-1] $[cnev-1]; echo " "
		        unset nev[n]
	        }
	        tput setaf $[n%7+1]
            tput cup $[LinLogo+LogoTrab] $ColLogo
            echo "${Nome:$[LogoTrab*3]:3}"
            (( LogoTrab++ == Pos-1)) && {
	            LogoTrab=0
    	        }
		}
        cor=$(((cor+1)%8))
    }
    k=$((k % 2 + 1))
done
