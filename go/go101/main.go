package main

import (
	"fmt"
	"log"
	"os"
	"time"
)

type iDoc interface {
	Doc() string
}

var (
	nome        string
	n1          int
	n2          int
	PublicValor int
)

type Pessoa struct {
	Name     string
	LastName string
	Idade    uint8
	Status   bool
	cpf      string
}

type Empresa struct {
	Razao  string
	Ende   string
	Cida   string
	Esta   string
	Status bool
	cnpj   string
}

func showDoc(i iDoc) {
	switch t := i.(type) {
	case Pessoa:
		// fmt.Println(i.Cpf())
		fmt.Println(t.cpf)
	case Empresa:
		// fmt.Println(i.Cpf())
		fmt.Println(t.cnpj)
	default:
		fmt.Println("")
	}
}

func (p Pessoa) Doc() string {
	return fmt.Sprintf(p.cpf)
}
func (p Empresa) Doc() string {
	return fmt.Sprintf(p.cnpj)
}

type Categoria struct {
	Nome string
	Pai  *Categoria
}

func (c Categoria) HasParent() bool {
	return c.Pai != nil
}

// func (p Pessoa) String() string {
// 	return fmt.Sprintf(p.Name, p.Idade)
// }

func ex_if() {
	a, b := 15, 15

	if a > b {
		fmt.Println("a é maior que b")
	} else if a < b {
		fmt.Println("a é menor que b")
	} else {
		fmt.Println("a é b são iguais")
	}
}

func ex_switch() {
	a, b := 15, 15
	switch {
	case a > b:
		fmt.Println("a é maior que b")
	case a < b:
		fmt.Println("a é menor que b")
	default:
		fmt.Println("a é b são iguais")
	}
}

func ex_open() {
	file, err := os.Open("hello.txt")
	if err != nil {
		log.Panic(err)
	}

	data := make([]byte, 2)
	if _, err := file.Read(data); err != nil {
		log.Panic(err)
	}

	println(string(data))
}

func ex_range() {
	nomes := []string{"Vilmar", "Tharic", "Thales", "Thaina"}
	for i := range nomes {
		fmt.Println(nomes[i])
	}
}

func ex_slices() {
	nomes := []string{"Vilmar", "Tharic", "Thales", "Thaina"}
	fmt.Println(nomes)

	nomes = append(nomes, "Rafael")

	for i := range nomes {
		fmt.Println(nomes[i])
	}

	fmt.Println("nomes      :", nomes)
	fmt.Println("len        :", len(nomes))
	fmt.Println("capacidade :", cap(nomes))
}

func ex_make() {
	idades := make(map[string]uint8)

	idades["Vilmar"] = 57
	idades["Tharic"] = 30

	fmt.Println(idades["Vilmar"])
	val, ok := idades["Lucas"]
	fmt.Println(val, ok)
	val, ok = idades["Vilmar"]
	fmt.Println(val, ok)
}

func ex_slice_void() {
	nomes := make([]string, 10, 20) // tamanho: 10, 20 posições
	println(nomes)
}

func ex_struct() {
	o := Empresa{
		Razao:  "TurboNET",
		Ende:   "Temporario",
		Status: true,
		cnpj:   "00.000.000/0001-11",
	}
	p := Pessoa{
		Name:     "Tharic",
		LastName: "Temporario",
		Idade:    30,
		Status:   true,
		cpf:      "111.222.333-44",
	}
	// fmt.Println(o, p)
	showDoc(o)
	showDoc(p)
}

func ex_goroutines_numeros(done chan<- bool) {
	for i := 0; i < 10; i++ {
		fmt.Printf("%d ", i)
		time.Sleep(time.Millisecond * 1)
	}
	done <- true
}

func ex_goroutines_letras(done chan<- bool) {
	for l := 'a'; l < 'j'; l++ {
		fmt.Printf("%c ", l)
		time.Sleep(time.Millisecond * 1)
	}
	done <- true
}

func ex_goroutines_numeros_ex2(n chan<- int) {
	for i := 0; i < 10; i++ {
		n <- i
		fmt.Printf("Escrito no channel: %d\n", i)
		time.Sleep(time.Millisecond * 1)
	}
	close(n)
}

func run_goroutines_ex1() {
	cn := make(chan bool)
	cl := make(chan bool)
	go ex_goroutines_numeros(cn)
	go ex_goroutines_letras(cl)
	<-cn
	<-cl
}

func run_goroutines_ex2() {
	cn := make(chan int, 3)
	go ex_goroutines_numeros_ex2(cn)

	for v := range cn {
		fmt.Printf("Lido do channel   : %d\n", v)
		time.Sleep(time.Millisecond * 1)
	}
}

func main() {
	// fmt.Println("Hello World")
	// ex_if()
	// ex_switch()
	// ex_open()
	// ex_range()
	// ex_slices()
	// ex_make()
	// ex_slice_void()
	// ex_struct()
	// run_goroutines_ex1()
	run_goroutines_ex2()
}
