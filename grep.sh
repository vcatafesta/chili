grep -q root /etc/passwd && echo ta lá
ifconfig | grep '[[:xdigit:]][[:xdigit:]]:[[:xdigit:]][[:xdigit:]]:[[:xdigit:]][[:xdigit:]]:[[:xdigit:]][[:xdigit:]]:[[:xdigit:]][[:xdigit:]]:[[:xdigit:]][[:xdigit:]]'
ifconfig | grep -o '[[:xdigit:]][[:xdigit:]]:[[:xdigit:]][[:xdigit:]]:[[:xdigit:]][[:xdigit:]]:[[:xdigit:]][[:xdigit:]]:[[:xdigit:]][[:xdigit:]]:[[:xdigit:]][[:xdigit:]]'
grep '[a-z]' <<< "ação"
grep '[[:lower:]]' <<< "ação"
[[ `grep ^root: /etc/passwd` ]] && echo exist || echo nao existe
[[ `grep ^usuario: /etc/passwd` ]] && echo exist || echo nao existe


#retira linhas em branco
#cat $0 | grep -v ^$
echo -e "#############################################################################"
#borda: a limítrofe \b
palavras=("ave" "avestruz" "ave-do-paraíso" "trave" "cavei" "travesso")
#\bave    #casa com ave, avestruz, ave-do-paraiso
#ave\b	 #casa com ave, ave-do-paraiso, trave
#\bave\b	 #casa com ave, ave-do-paraiso

#ou
echo 1.1; echo "${palavras[@]}" | grep '\<ave\>'
echo 1.2; echo "$palavras" | grep '\bave'
echo 1.2; echo "$palavras" | grep 'ave\b'
echo 1.4; echo "$palavras" | grep '\bave\b'

echo 2.1; echo "$palavras" | grep '\Bave\b'
echo 2.2; echo "$palavras" | grep '\bave\B'
echo 2.3; echo "$palavras" | grep '\Bave\B'

palavra="Teste"
echo $palavra |  echo $palavra | grep '\<T'
echo $palavra |  echo $palavra | grep '\<.e'
echo -e "#############################################################################"


#forma errada
time for ((i=1; i<1000; i++))
{
    cat /etc/passwd | grep ^root: >/dev/null
}

#forma correta
time for ((i=1; i<1000; i++))
{
    grep ^root: /etc/passwd >/dev/null
}
