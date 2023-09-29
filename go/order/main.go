package main

import "internal/entity"

type TCar struct {
	Modelo string
	Cor    string
}

func (T TCar) start() {
	println(T.Modelo + " " + T.Cor + " foi iniciado")
}

func (T TCar) ChangeColorReferencia(newcor string) {
	T.Cor = newcor
	println("Nova Cor: " + T.Cor)
}

func (T *TCar) ChangeColorPonteiro(newcor string) {
	T.Cor = newcor
	println("Nova Cor: " + T.Cor)
}

func soma(x, y int) int {
	return x + y
}

func main() {
	car := TCar{Modelo: "Ferrari", Cor: "Vermelho"}
	println(soma(10, 10))
	car.start()
	car.ChangeColorReferencia("Blue")
	println(car.Cor)
	car.ChangeColorPonteiro("Blue")
	println(car.Cor)

	a := 10
	b := &a
	*b = 20
	println(&a)
	println(&b)
	println(a)
	println(b)

	order,err := entity.Neworder("1", 20, 5)

}
