package main

import (
	"fmt"
	"log"
	"github.com/AlecAivazis/survey/v2"
	"github.com/fatih/color"
)

func main() {
	options := []string{"Opção 1", "Opção 2", "Opção 3"}
	reverseOptions := reverseSlice(options)

	var selectedOption string

	prompt := &survey.Select{
		Message: "Selecione uma opção (opção ativa em cores reversas):",
		Options: reverseOptions,
	}

	idx := 0
	for i, option := range prompt.Options {
		// Inverte a cor de fundo e texto apenas para a opção selecionada
		if i == prompt.Default {
			prompt.Options[i] = color.New(color.BgBlack, color.FgWhite).Sprint(option)
		}else {
			prompt.Options[i] = color.New(color.FgBlack, color.BgWhite).Sprint(option)
		}
		idx++
	}

	if err := survey.AskOne(prompt, &selectedOption, nil); err != nil {
		log.Fatal(err)
	}

	fmt.Printf("Você selecionou: %s\n", selectedOption)
}

func reverseSlice(s []string) []string {
	reversed := make([]string, len(s))
	for i, j := 0, len(s)-1; i < len(s); i, j = i+1, j-1 {
		reversed[i] = s[j]
	}
	return reversed
}
