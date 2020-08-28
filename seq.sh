seq 1000
seq 1 10
seq 2 2 10 >par
seq 1 2 10 >impar
paste par impar
paste -d+ par impar
paste -d+ par impar | bc
paste -s par impar
