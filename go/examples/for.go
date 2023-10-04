package main

import "fmt"

func main() {
	for horas := 0; horas <= 24; horas++ {
		fmt.Printf("Hora: %02d\n", horas)
		for x := 0; x < 60; x++ {
			fmt.Printf(" %02d", x)
		}
		fmt.Println()
	}

	/*
		for dia := 1; dia <= 30; dia++ {
			fmt.Printf("%02d ", dia)
		}
	*/

	if x < 10 {
			println(x, "< 10")
			x++
		} else {
			println(">= 10. Fora!")
			break
		}
	}
	println("Break")

	for i := 33; i <= 122; i++ {
		fmt.Printf("%d = %v\n", i, string(i))
	}
}
