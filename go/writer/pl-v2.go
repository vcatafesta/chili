package main

import (
	"fmt"
	"log"
	"github.com/AlecAivazis/survey/v2"
	"github.com/fatih/color"
)

func main() {
	options := []string{"Opção 1", "Opção 2", "Opção 3"}
	// Inverta a ordem das opções
	reverseOptions := reverseSlice(options)

	var selectedOption string

	prompt := &survey.Select{
		Message: "Selecione uma opção (cores reversas):",
		Options: reverseOptions,
	}

	idx := 0
	for _, option := range prompt.Options {
		// Inverte a cor de fundo e texto
		if idx%2 == 0 {
			option = color.New(color.BgBlack, color.FgWhite).Sprint(option)
		} else {
			option = color.New(color.BgWhite, color.FgBlack).Sprint(option)
		}
		prompt.Options[idx] = option
		idx++
	}

	if err := survey.AskOne(prompt, &selectedOption, nil); err != nil {
		log.Fatal(err)
	}

	fmt.Printf("Você selecionou: %s\n", selectedOption)
}

func reverseSlice(s []string) []string {
	// Crie uma fatia invertida
	reversed := make([]string, len(s))
	for i, j := 0, len(s)-1; i < len(s); i, j = i+1, j-1 {
		reversed[i] = s[j]
	}
	return reversed
}
