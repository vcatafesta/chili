package main

import (
	"fmt"
	"log"
	"os"
)

var (
	nome        string
	n1          int
	n2          int
	PublicValor int
)

func main() {
	fmt.Println("Hello World")

	file, err := os.Open("hello.txt")
	if err != nil {
		log.Panic(err)
	}

	data := make([]byte, 100)
	if _, err := file.Read(data); err != nil {
		log.Panic(err)
	}

	println(file)
}
