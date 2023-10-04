/*
   big-pacman-to-json - process output pacman to json
   go get github.com/go-ini/ini
   Chili GNU/Linux - https://github.com/vcatafesta/ChiliOS
   Chili GNU/Linux - https://chililinux.com
   Chili GNU/Linux - https://chilios.com.br

   Created: 2023/09/26
   Altered: 2023/09/26

   Copyright (c) 2023-2023, Vilmar Catafesta <vcatafesta@gmail.com>
*/

package main

import (
	"bufio"
	"encoding/json"
	"fmt"
	"os"
	"os/exec" // Adicione esta linha para importar o pacote "os/exec"
	"strings"
)

type PackageInfo struct {
	Name        string `json:"name"`
	Version     string `json:"version"`
	Size        string `json:"size"`
	Status      string `json:"status"`
	Description string `json:"description"`
}

func ProcessParuOutput(input, xcmd string) {
	// Variáveis para manter as informações do pacote
	var packages []PackageInfo
	var currentPackage PackageInfo
	isDescription := false
	isName := false

	// Divide o texto de entrada em linhas
	lines := strings.Split(input, "\n")

	// Processa cada linha da entrada
	for _, line := range lines {
		// Verifica se a linha começa com 2 espaços iniciais (indica descrição)
		if strings.HasPrefix(line, "  ") {
			line = strings.TrimSpace(line)
			currentPackage.Description += line
			isDescription = true
		} else {
			// Divide a linha em campos e verifica se há pelo menos 2 campos (nome e versão)
			fields := strings.Fields(line)
			if len(fields) >= 1 {
				currentPackage.Name = fields[0]
				currentPackage.Version = fields[1]

				switch xcmd {
				case "paru":
					if len(fields) >= 3 {
						currentPackage.Size = fields[2]
					}
					if len(fields) >= 4 {
						currentPackage.Size += " " + fields[3]
					}
					if len(fields) >= 5 {
						currentPackage.Status = fields[4]
					}
				case "pacman":
					if len(fields) >= 3 {
						currentPackage.Status = fields[2]
					}
				case "pamac":
					if len(fields) >= 3 {
						currentPackage.Status = fields[2]
					}
				default:
					if len(fields) >= 3 {
						currentPackage.Status = fields[2]
					}
				}
				isName = true
			}
		}
		// Se a linha não começar com 2 espaços, isso indica o início de um novo pacote
		if isDescription == true && isName == true {
			packages = append(packages, currentPackage)
			currentPackage = PackageInfo{}
			isDescription = false
			isName = false
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
		xcmd := "paru"
		// Processa a entrada
		ProcessParuOutput(input, xcmd)
	} else {
		// A stdin está vazia, verifique os argumentos do programa
		if len(os.Args) < 2 {
			// Se não houver argumentos, imprima uma mensagem de erro e retorne 1 para o shell
			fmt.Println("Erro: Nenhuma entrada fornecida.")
			os.Exit(1)
		}
		// Os argumentos a partir do segundo são as entradas, processa-os
		args := os.Args[1:]
		xcmd := os.Args[1]
		cmd := exec.Command(args[0], args[1:]...) // Executa o comando com os argumentos
		output, err := cmd.CombinedOutput()
		if err != nil {
			fmt.Printf("Erro ao executar o comando: %v\n", err)
			return
		}

		// Chame a função ProcessParuOutput com a saída do comando como argumento
		ProcessParuOutput(string(output), xcmd)
	}
}
