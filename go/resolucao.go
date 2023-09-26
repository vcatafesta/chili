package main

import (
	"fmt"
	"github.com/go-gl/glfw/v3.3/glfw"
)

func main() {
	// Inicializa o GLFW
	err := glfw.Init()
	if err != nil {
		fmt.Println("Erro ao inicializar o GLFW:", err)
		return
	}
	defer glfw.Terminate()

	// Obtém a resolução do monitor primário
	primaryMonitor := glfw.GetPrimaryMonitor()
	mode := primaryMonitor.GetVideoMode()

	// Imprime a resolução
	fmt.Printf("Resolução do Monitor Primário:\n")
	fmt.Printf("Largura: %d pixels\n", mode.Width)
	fmt.Printf("Altura: %d pixels\n", mode.Height)
	fmt.Printf("Taxa de Atualização: %d Hz\n", mode.RefreshRate)
}
