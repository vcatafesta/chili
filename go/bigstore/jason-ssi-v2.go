package main

import (
	"bufio"
	"encoding/json"
	"fmt"
	"os"
	"os/exec"
	"strings"
)

type PackageInfo struct {
	Repository    string   `json:"Repository"`
	Name          string   `json:"Name"`
	Version       string   `json:"Version"`
	Description   string   `json:"Description"`
	Architecture  string   `json:"Architecture"`
	URL           string   `json:"URL"`
	Licenses      []string `json:"Licenses"`
	Groups        string   `json:"Groups"`
	Provides      string   `json:"Provides"`
	DependsOn     []string `json:"DependsOn"`
	OptionalDeps  []string `json:"OptionalDeps"`
	RequiredBy    []string `json:"RequiredBy"`
	ConflictsWith string   `json:"ConflictsWith"`
	Replaces      string   `json:"Replaces"`
	DownloadSize  string   `json:"DownloadSize"`
	InstalledSize string   `json:"InstalledSize"`
	Packager      string   `json:"Packager"`
	BuildDate     string   `json:"BuildDate"`
	MD5Sum        string   `json:"MD5Sum"`
	SHA256Sum     string   `json:"SHA256Sum"`
	Signatures    string   `json:"Signatures"`
}

type PackageData struct {
	Package map[string]PackageInfo `json:"Package"`
}

func main() {
	var input string

	// Verifica se há entrada disponível na stdin
	stat, _ := os.Stdin.Stat()
	if (stat.Mode() & os.ModeCharDevice) == 0 {
		// A stdin não está vazia, leia a entrada
		scanner := bufio.NewScanner(os.Stdin)
		for scanner.Scan() {
			input += scanner.Text() + "\n"
		}
	} else if len(os.Args) > 1 {
		// A stdin está vazia, use o primeiro argumento como comando
		// Os argumentos a partir do segundo são as entradas, processa-os
		args := os.Args[1:]
		cmd := exec.Command(args[0], args[1:]...) // Executa o comando com os argumentos
		output, err := cmd.CombinedOutput()
		if err != nil {
			fmt.Printf("Erro ao executar o comando: %v\n", err)
			return
		}
		input = string(output)
	} else {
		// Se não houver entrada disponível e nenhum argumento, imprima uma mensagem de erro
		fmt.Println("Erro: Nenhuma entrada fornecida.")
		return
	}

	// Processa a entrada
	ProcessOutput(input)
}

// Função para processar a saída e criar um arquivo JSON
func ProcessOutput(output string) {
	var packageInfos []PackageInfo

	// Divide a saída em linhas
	lines := strings.Split(output, "\n")
	var packageInfo PackageInfo

	for _, line := range lines {
		parts := strings.SplitN(line, ":", 2)
		if len(parts) == 2 {
			key := strings.TrimSpace(parts[0])
			value := strings.TrimSpace(parts[1])

			switch key {
			case "Repository":
				packageInfo.Repository = value
			case "Name":
				packageInfo.Name = value
			case "Version":
				packageInfo.Version = value
			case "Description":
				packageInfo.Description = value
			case "Architecture":
				packageInfo.Architecture = value
			case "URL":
				packageInfo.URL = value
			case "Licenses":
				// Dividir licenças por espaços em branco
				licenses := strings.Split(value, " ")
				for _, license := range licenses {
					packageInfo.Licenses = append(packageInfo.Licenses, license)
				}
			case "Groups":
				packageInfo.Groups = value
			case "Provides":
				packageInfo.Provides = value
			case "Depends On":
				// Dividir dependências por espaços em branco
				dependencies := strings.Fields(value) // Use strings.Fields para dividir por espaços em branco
				for _, dependency := range dependencies {
					packageInfo.DependsOn = append(packageInfo.DependsOn, dependency)
				}
			case "Optional Deps":
				// Dividir dependências opcionais por espaços em branco
				optionalDeps := strings.Fields(value) // Use strings.Fields para dividir por espaços em branco
				for _, optionalDep := range optionalDeps {
					packageInfo.OptionalDeps = append(packageInfo.OptionalDeps, optionalDep)
				}
			case "Required By":
				// Dividir pacotes que dependem deste por espaços em branco
				requiredBy := strings.Fields(value) // Use strings.Fields para dividir por espaços em branco
				for _, r := range requiredBy {
					packageInfo.RequiredBy = append(packageInfo.RequiredBy, r)
				}
			case "Conflicts With":
				packageInfo.ConflictsWith = value
			case "Replaces":
				packageInfo.Replaces = value
			case "Download Size":
				packageInfo.DownloadSize = value
			case "Installed Size":
				packageInfo.InstalledSize = value
			case "Packager":
				packageInfo.Packager = value
			case "Build Date":
				packageInfo.BuildDate = value
			case "MD5 Sum":
				packageInfo.MD5Sum = value
			case "SHA-256 Sum":
				packageInfo.SHA256Sum = value
			case "Signatures":
				packageInfo.Signatures = value
			}
		} else if len(parts) == 1 && parts[0] == "" {
			// Linha em branco indica o final de um pacote, adicionamos ao slice
			packageInfos = append(packageInfos, packageInfo)
			packageInfo = PackageInfo{}
		}
	}

	// Crie um arquivo com o nome especificado
	file, err := os.Create("output.json")
	if err != nil {
		fmt.Printf("Erro ao criar arquivo JSON: %v\n", err)
		return
	}
	defer file.Close()

	// Encode the packageInfo as JSON and write it to the file
	encoder := json.NewEncoder(file)
	encoder.SetIndent("", "    ")
	if err := encoder.Encode(packageInfos); err != nil {
		fmt.Printf("Erro ao escrever no arquivo JSON: %v\n", err)
		return
	}

	fmt.Println("Arquivo JSON criado com sucesso: output.json")
}
