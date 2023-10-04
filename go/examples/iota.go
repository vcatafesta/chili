// https://go.dev/play/p/Qu4DuMEE645

package main

import "fmt"

const (
	a = iota
	b = iota
	_ = iota
	c = iota
)

func main() {
	fmt.Println(a, b, c)
}
