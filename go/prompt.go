package main

import (
	"fmt"
	"os"

	"github.com/manifoldco/promptui"
)

func main() {
	// Defina as opções do menu
	options := []string{
		"Opção 1",
		"Opção 2",
		"Opção 3",
		"Sair",
	}

	// Crie um novo seletor de prompt
	prompt := promptui.Select{
		Label: "Selecione uma opção",
		Items: options,
	}

	// Execute o seletor de prompt e capture o índice da opção selecionada
	_, result, err := prompt.Run()

	if err != nil {
		fmt.Printf("Erro ao selecionar a opção: %v\n", err)
		os.Exit(1)
	}

	// Imprima a opção selecionada
	fmt.Printf("Você selecionou: %s\n", result)
}
