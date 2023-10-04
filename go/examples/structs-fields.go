package main

import "fmt"

type Vertex struct {
	X int
	Y int
}

func main() {
	v := Vertex{10, 2}
	fmt.Println(v.X, v.Y)
	v.X = 4
	v.Y = 5
	fmt.Println(v.X, v.Y)
}
