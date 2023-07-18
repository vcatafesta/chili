
# "-n" limita a quantidade de caractere e "-s" ativa o modo silencioso (sem "ecoar" o que está sendo digitado). 
read -n3 -s SETA
case $SETA in
    $'\e[A') echo "1";;
    $'\e[B') comando;;
    $'\e[C') comando);;
    $'\e[D') comando);;
    *) comando;;
esac
