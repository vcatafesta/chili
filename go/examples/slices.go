package main

import "fmt"

func main() {
	primes := [6]int{2, 3, 5, 7, 11, 13}
	nome   := [2]string{"Vilmar","Catafesta"}

	var s []int = primes[1:4]
	fmt.Println(s)

	var snome []string = nome[0:2]
	fmt.Println(nome[0])
	fmt.Println(nome[1])
	fmt.Println(snome)
}
