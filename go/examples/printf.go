package main

import "fmt"

const (
	a = iota
	b = iota
	_ = iota
	c = iota
)

func main() {
	x := 10
	A := 'A'
	fmt.Printf("%d, %#x, %b\n", x, x, x)
	fmt.Printf("%d, %#x, %b\n", A, A, A)
}
