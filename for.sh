for i in $(seq 9)
do
     echo -n "$i "
done
#1 1 3 4 5 6 7 8 9

for i in $(seq 3 9)
do
     echo -n "$i "
done
#4 5 6 7 8 9

for i in $(seq 0 3 9)
do
     echo -n "$i "
done
#0 3 6 9

for ((i=1; i<=9; i++))
do
    echo -n "$i "
done
#1 2 3 4 5 6 7 8 9

for ((; i<=9;))
do
    let i++
    echo -n "$i "
done
#1 2 3 4 5 6 7 8 9

for arq in *
do
     let i++
     echo "$i -> $arq"
done
#1 -> ArqDoDOS.txt1
#2 -> confuso
#3 -> incusu
#4 -> listamusica
#5 -> listartista
#6 -> logado
#7 -> musexc
#8 -> musicas
#9 -> musinc
#10 -> muslist
#11 -> testefor1
#12 -> testefor2
