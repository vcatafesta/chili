/*
	big-pacman-to-json - process output pacman to json
    go get github.com/go-ini/ini
    Chili GNU/Linux - https://github.com/vcatafesta/chili/go
    Chili GNU/Linux - https://chililinux.com
    Chili GNU/Linux - https://chilios.com.br

    Created: 2023/10/01
    Altered: 2023/10/05

    Copyright (c) 2023-2023, Vilmar Catafesta <vcatafesta@gmail.com>
    All rights reserved.

    Redistribution and use in source and binary forms, with or without
    modification, are permitted provided that the following conditions
    are met:
    1. Redistributions of source code must retain the above copyright
        notice, this list of conditions and the following disclaimer.
    2. Redistributions in binary form must reproduce the above copyright
        notice, this list of conditions and the following disclaimer in the
        documentation and/or other materials provided with the distribution.

    THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR
    IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
    OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
    IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
    INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
    NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
    DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
    THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
    (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
    THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
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
		ProcessOutput(input, xcmd)
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

		// Chame a função ProcessOutput com a saída do comando como argumento
		ProcessOutput(string(output), xcmd)
	}
}

func ProcessOutput(input, xcmd string) {
	// Variáveis para manter as informações do pacote
	var packages []PackageInfo
	var currentPackage PackageInfo
	IsDescription := false
	IsName := false

	// Divide o texto de entrada em linhas
	lines := strings.Split(input, "\n")

	// Processa cada linha da entrada
	for _, line := range lines {
		// Verifica se a linha começa com 2 espaços iniciais (indica descrição)
		if strings.HasPrefix(line, "  ") && IsName == true {
			line = strings.TrimSpace(line)
			currentPackage.Description += line
			IsDescription = true
		} else if IsName == false {
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
				IsName = true
			}
		}
		// Se a linha não começar com 2 espaços, isso indica o início de um novo pacote
		if IsDescription == true && IsName == true {
			packages = append(packages, currentPackage)
			currentPackage = PackageInfo{}
			IsDescription = false
			IsName = false
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

