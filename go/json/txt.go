package main

import (
	"fmt"
	"os"
	"strings"
)

var p = fmt.Println

func main() {
	var data []byte
	var err error


	data, err = os.ReadFile("vilmar.json")
	if err != nil {
		panic(err)
	}
	p(string(data))



	data, err = os.ReadFile("texto.txt")
	if err != nil {
		panic(err)
	}
	p(string(data))

	txt := strings.Replace(string(data), "novidade", "legal", -1)
	err = os.WriteFile("texto.txt", []byte(txt), 0755)
	if err != nil {
		panic(err)
	}
}

