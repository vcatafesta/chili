package main

import (
	"encoding/json"
	"fmt"
	"os/exec"
	"strings"
)

type PackageInfo struct {
	Name        string `json:"name"`
	Version     string `json:"version"`
	Description string `json:"description"`
}

func main() {
	cmd := exec.Command("paru", "-Ssa", "dnsmasq")
	output, err := cmd.CombinedOutput()
	if err != nil {
		fmt.Printf("Erro ao executar o comando: %v\n", err)
		return
	}

	lines := strings.Split(string(output), "\n")
	var packages []PackageInfo

	for i := 0; i < len(lines); i += 2 {
		if i >= len(lines) || i+1 >= len(lines) {
			break // Verifique se i e i+1 são índices válidos
		}

		nameVersionLine := strings.TrimSpace(lines[i])
		descriptionLine := strings.TrimSpace(lines[i+1])

		// Divida a linha de nome e versão em campos
		fields := strings.Fields(nameVersionLine)
		if len(fields) < 2 {
			continue // Ignorar linhas inválidas
		}

		name := fields[0]
		version := fields[1]

		pkg := PackageInfo{
			Name:        name,
			Version:     version,
			Description: descriptionLine,
		}

		packages = append(packages, pkg)
	}

	jsonData, err := json.Marshal(packages)
	if err != nil {
		fmt.Printf("Erro ao serializar para JSON: %v\n", err)
		return
	}

	fmt.Println(string(jsonData))
}

