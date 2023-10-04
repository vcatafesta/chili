package main

import (
	"bufio"
	"encoding/json"
	"fmt"
	"os"
	"strings"
)

type PackageInfo struct {
	Name        string `json:"name"`
	Version     string `json:"version"`
	Gmt         string `json:"gmt"`
	Status      string `json:"status"`
	Description string `json:"description"`
}

func ProcessParuOutput(input string) {
	// Crie um scanner para ler a entrada fornecida
	scanner := bufio.NewScanner(strings.NewReader(input))

	// Variáveis para manter as informações do pacote
	var packages []PackageInfo
	var currentPackage PackageInfo
	isDescription := false

	// Processar cada linha da entrada fornecida
	for scanner.Scan() {
		line := scanner.Text()

		// Verifica se a linha começa com 2 espaços iniciais (indica descrição)
		if strings.HasPrefix(line, "  ") {
			line = strings.TrimSpace(line)
			currentPackage.Description += line
			isDescription = true
		} else {
			// Divide a linha em campos e verifica se há pelo menos 2 campos (nome e versão)
			fields := strings.Fields(line)
			if len(fields) >= 2 {
				currentPackage.Name = fields[0]
				currentPackage.Version = fields[1]
				currentPackage.Gmt = fields[2] + fields[3]
				if len(fields) >= 5 {
					currentPackage.Status = fields[4]
				} else {
					currentPackage.Status = ""
				}
				isDescription = false
			}

			// Se a linha não começar com 2 espaços, isso indica o início de um novo pacote
			if !isDescription && currentPackage.Name != "" {
				packages = append(packages, currentPackage)
				currentPackage = PackageInfo{}
			}
		}
	}

	// Certifique-se de adicionar o último pacote à lista
	if currentPackage.Name != "" {
		packages = append(packages, currentPackage)
	}

	// Converte a lista de pacotes em formato JSON
	jsonData, err := json.Marshal(packages)
	if err != nil {
		fmt.Printf("Erro ao serializar para JSON: %v\n", err)
		return
	}

	// Imprime os dados JSON na saída padrão
	fmt.Println(string(jsonData))
}


func main() {
	// Verifica se há entrada disponível na stdin
	stat, _ := os.Stdin.Stat()
	if (stat.Mode() & os.ModeCharDevice) == 0 {
		// A stdin não está vazia, leia a entrada
		scanner := bufio.NewScanner(os.Stdin)
		var input string
		for scanner.Scan() {
			input += scanner.Text() + "\n"
		}
		// Processa a entrada
		ProcessParuOutput(input)
	} else {
		// A stdin está vazia, verifique os argumentos do programa
		if len(os.Args) < 2 {
			// Se não houver argumentos, imprima uma mensagem de erro e retorne 1 para o shell
			fmt.Println("Erro: Nenhuma entrada fornecida.")
			os.Exit(1)
		}
		// Os argumentos a partir do segundo são as entradas, processa-os
		for i := 1; i < len(os.Args); i++ {
			ProcessParuOutput(os.Args[i])
		}
	}
}
