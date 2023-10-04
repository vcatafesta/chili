// https://go.dev/play/p/Qu4DuMEE645

package main

import "fmt"

const (
	_  = iota
	KB = 1 << (iota * 10)
	MB
	GB
	TB
)

func main() {
	fmt.Println("Binary\t\t\t\t\t\tdecimal")
	fmt.Printf("%b\t\t\t\t\t", KB)
	fmt.Printf("%d\n", KB)
	fmt.Printf("%b\t\t\t\t", MB)
	fmt.Printf("%d\n", MB)
	fmt.Printf("%b\t\t\t", GB)
	fmt.Printf("%d\n", GB)
	fmt.Printf("%b\t", TB)
	fmt.Printf("%d\n", TB)
}
