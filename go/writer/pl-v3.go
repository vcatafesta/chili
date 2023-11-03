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
        Message: "Selecione uma opção:",
        Options: reverseOptions,
    }

    if err := survey.AskOne(prompt, &selectedOption, nil); err != nil {
        log.Fatal(err)
    }

    // Obtém o índice da opção selecionada
    selectedIndex := 0
    for i, option := range reverseOptions {
        if option == selectedOption {
            selectedIndex = i
            break
        }
    }

    // Inverte as cores da opção selecionada
    reverseSelectedOption := color.New(color.BgBlack, color.FgWhite).Sprint(selectedOption)

    // Substitui a opção selecionada no slice de opções com a opção invertida
    reverseOptions[selectedIndex] = reverseSelectedOption

    fmt.Printf("Você selecionou: %s\n", reverseSelectedOption)
    fmt.Println("Opções restantes:")
    for _, option := range reverseOptions {
        fmt.Println(option)
    }
}

func reverseSlice(s []string) []string {
    reversed := make([]string, len(s))
    for i, j := 0, len(s)-1; i < len(s); i, j = i+1, j-1 {
        reversed[i] = s[j]
    }
    return reversed
}
