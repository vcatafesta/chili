package main

import (
	"fmt"
	"os"
)

var p = fmt.Println

func main() {
	data, err := os.ReadFile("summary.json")
	if err != nil {
		panic(err)
	}
	p(string(data))

}
