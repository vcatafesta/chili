package main

import (
	"fmt"
	"os"
)

func main() {
	// Obtém o valor da variável de ambiente "PATH"
	path := os.Getenv("PATH")
	shell := os.Getenv("SHELL")
	fmt.Println("PATH:", path)
	fmt.Println("SHELL:", shell)
}
