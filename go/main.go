package main

import (
	"fmt"
	"math/cmplx"
)

var (
	ToBe   bool       = false
	MaxInt uint64     = 1<<64 - 1
	z      complex128 = cmplx.Sqrt(-5 + 12i)
)

func main() {
	fmt.Printf("Type: %T Value: %v\n", ToBe, ToBe)
	fmt.Printf("Type: %T Value: %v\n", MaxInt, MaxInt)
	fmt.Printf("Type: %T Value: %v\n", z, z)

	var i, j int = 1, 2
	k := 3
	c, python, java := true, false, "no!"
	fmt.Println(i, j, k, c, python, java)

	// Variáveis declaradas sem um valor inicial explicitado darão seu valor zero.
	// O valor zero é:
	// 		0 para tipos numéricos,
	// 		false para tipos boleanos, e
	// 		"" (string vazia) para strings.
	var ii int
	var f float64
	var b bool
	var s string
	fmt.Printf("%v %v %v %q\n", ii, f, b, s)
}
