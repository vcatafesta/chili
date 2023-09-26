package main

import (
    "fmt"
    "os"

    "github.com/manifoldco/promptui"
)

func main() {
    options := []string{
        "Opção 1",
        "Opção 2",
        "Opção 3",
        "Sair",
    }

    prompt := promptui.Select{
        Label: "Selecione uma opção",
        Items: options,
        Templates: &promptui.SelectTemplates{
            Active:   `{{ . | green | bold }}`,
            Inactive: `{{ . | bold }}`,
            Selected: `{{ "✔" | green | bold }} {{ . | green | bold }}`,
        },
    }

    _, result, err := prompt.Run()

    if err != nil {
        fmt.Printf("Erro ao selecionar a opção: %v\n", err)
        os.Exit(1)
    }

    if result == "Sair" {
        fmt.Println("Saindo do programa.")
    } else {
        fmt.Printf("Você selecionou: %s\n", result)
    }
}
