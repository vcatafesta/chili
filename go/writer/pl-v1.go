package main

import (
	"fmt"
	"log"
	"github.com/AlecAivazis/survey/v2"
)

func main() {
	var selectedOption string

	prompt := &survey.Select{
		Message: "Selecione uma opção:",
		Options: []string{"Opção 1", "Opção 2", "Opção 3"},
	}

	if err := survey.AskOne(prompt, &selectedOption, nil); err != nil {
		log.Fatal(err)
	}

	fmt.Printf("Você selecionou: %s\n", selectedOption)
}
