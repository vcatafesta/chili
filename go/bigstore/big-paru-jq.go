package main

import (
//	"bufio"
	"encoding/json"
	"fmt"
	"os/exec"
	"strings"
)

type PackageInfo struct {
	Name        string `json:"name"`
	Version     string `json:"version"`
	Gmt     	string `json:"gmt"`
	Status     	string `json:"status"`
	Description string `json:"description"`
}

func main() {
	// Executa o comando "paru -Ssa dnsmasq" e captura a saída combinada (stdout e stderr)
	cmd := exec.Command("paru", "-Ssa", "dnsmasq")
	output, err := cmd.CombinedOutput()
	if err != nil {
		fmt.Printf("Erro ao executar o comando: %v\n", err)
		return
	}

	// Divide a saída em linhas
	lines := strings.Split(string(output), "\n")
	var packages []PackageInfo
	var currentPackage PackageInfo
	var isDescription bool

	// Loop pelas linhas da saída
	for _, line := range lines {
		// Se a linha estiver em branco, pule para a próxima
		if line == "" {
			continue
		}

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

	// Adiciona o último pacote à lista, se houver
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

