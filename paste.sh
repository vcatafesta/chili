seq 2 2 10 >par
seq 1 2 10 >impar
paste par impar
paste -d+ par impar
paste -d+ par impar | bc
paste -s par impar
paste -sd+ par
ls | paste -sd:
ls |  paste -s -d";"

