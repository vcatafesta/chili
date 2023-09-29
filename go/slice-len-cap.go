//Tamanho e capacidade de uma Slice
//Uma slice tem tanto um tamanho quanto uma capacidade.
//O comprimento de uma slice é o número de elementos que ela contém.
//A capacidade de uma slice é o número de elementos na matriz subjacente, contando a partir do primeiro elemento na slice.
//O comprimento e a capacidade de uma slice S podem ser obtidos utilizando as expressões len(s) e cap(s).
//Você pode estender o comprimento de uma slice "refatiando-a", desde que tenha capacidade suficiente. Tente alterar uma das operações da slice no programa de exemplo para estendê-la além de sua capacidade e veja o que acontece.

package main

import "fmt"

func main() {
	s := []int{2, 3, 5, 7, 11, 13}
	printSlice(s)

	// Slice the slice to give it zero length.
	s = s[:0]
	printSlice(s)

	// Extend its length.
	s = s[:4]
	printSlice(s)

	// Drop its first two values.
	s = s[2:]
	printSlice(s)
}
