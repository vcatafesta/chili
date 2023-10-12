package main

import "fmt"

type Pessoa struct {
	Nome      string
	Sobrenome string
	Idade     int
	Sexo      string
}

func main() {
	pessoas := []Pessoa{
		{"Vilmar", "Catafesta", 57, "M"},
		{"Thales", "Catafesta", 30, "M"},
		{"Tharic", "Catafesta", 30, "M"},
		{"Thaina", "Catafesta", 30, "M"},
	}

	table := HashTable()

	keys := make([]int, len(pessoas))
	for i, pessoa := range pessoas {
		keys[i] = table.Put(pessoa)
	}

	for _, key := range keys {
		ps := table.Get(key)
		for _, p := range ps {
			fmt.Println(p.Nome, p.Sobrenome)

		}
	}
}
