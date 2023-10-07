package main

import (
	"bufio"
	"encoding/json"
	"fmt"
	"os"
	"os/exec"
	"strings"
)

const (
	_APP_     = "big-pacman-to-json"
	_VERSION_ = "0.5.0-20231007"
	_COPY_    = "Copyright (C) 2023 Vilmar Catafesta, <vcatafesta@gmail.com>"
)

// Constantes para cores ANSI
const (
	Reset   = "\x1b[0m"
	Red     = "\x1b[31m"
	Green   = "\x1b[32m"
	Yellow  = "\x1b[33m"
	Blue    = "\x1b[34m"
	Magenta = "\x1b[35m"
	Cyan    = "\x1b[36m"
	White   = "\x1b[37m"
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
	Name    string      `json:"Name"`
	Package PackageInfo `json:"Package"`
}

func main() {
	var input string

	stat, _ := os.Stdin.Stat()
	if (stat.Mode() & os.ModeCharDevice) == 0 {
		scanner := bufio.NewScanner(os.Stdin)
		for scanner.Scan() {
			input += scanner.Text() + "\n"
		}
	} else if len(os.Args) > 1 {

		if os.Args[1] == "-V" || os.Args[1] == "--version" {
			fmt.Printf("%s v%s\n", _APP_, _VERSION_)
			fmt.Printf("%s\n", _COPY_)
			return
		}

		command := os.Args[1]
		cmd := exec.Command(command, os.Args[2:]...)
		output, err := cmd.CombinedOutput()
		if err != nil {
			fmt.Printf("Erro ao executar o comando: %v\n", err)
			return
		}
		input = string(output)
	} else {
		fmt.Println("Erro: Nenhuma entrada fornecida.")
		return
	}

	ProcessOutput(input)
}

func ProcessOutput(output string) {
	var packageInfos = make(map[string]PackageInfo) // Inicialize o mapa

	lines := strings.Split(output, "\n")
	var currentPackage PackageInfo

	for _, line := range lines {
		parts := strings.SplitN(line, ":", 2)
		if len(parts) == 2 {
			key := strings.TrimSpace(parts[0])
			value := strings.TrimSpace(parts[1])

			switch key {
			case "Repository":
				currentPackage.Repository = value
			case "Name":
				currentPackage.Name = value
			case "Version":
				currentPackage.Version = value
			case "Description":
				currentPackage.Description = value
			case "Architecture":
				currentPackage.Architecture = value
			case "URL":
				currentPackage.URL = value
			case "Licenses":
				licenses := strings.Split(value, " ")
				currentPackage.Licenses = append(currentPackage.Licenses, licenses...)
			case "Groups":
				currentPackage.Groups = value
			case "Provides":
				currentPackage.Provides = value
			case "Depends On":
				dependencies := strings.Fields(value)
				currentPackage.DependsOn = append(currentPackage.DependsOn, dependencies...)
			case "Optional Deps":
				optionalDeps := strings.Fields(value)
				currentPackage.OptionalDeps = append(currentPackage.OptionalDeps, optionalDeps...)
			case "Required By":
				requiredBy := strings.Fields(value)
				currentPackage.RequiredBy = append(currentPackage.RequiredBy, requiredBy...)
			case "Conflicts With":
				currentPackage.ConflictsWith = value
			case "Replaces":
				currentPackage.Replaces = value
			case "Download Size":
				currentPackage.DownloadSize = value
			case "Installed Size":
				currentPackage.InstalledSize = value
			case "Packager":
				currentPackage.Packager = value
			case "Build Date":
				currentPackage.BuildDate = value
			case "MD5 Sum":
				currentPackage.MD5Sum = value
			case "SHA-256 Sum":
				currentPackage.SHA256Sum = value
			case "Signatures":
				currentPackage.Signatures = value
			}
		} else if len(parts) == 1 && len(parts[0]) == 0 && currentPackage.Name != "" {
			packageInfos[currentPackage.Name] = currentPackage
			currentPackage = PackageInfo{}
		}
	}

	// Salva no arquivo
	outputFilename := "vilmar.json"
	file, err := os.Create(outputFilename)
	if err != nil {
		fmt.Printf("Erro ao criar arquivo JSON: %v\n", err)
		return
	}
	defer file.Close()

	encoder := json.NewEncoder(file)
	encoder.SetIndent("", "    ")
	if err := encoder.Encode(packageInfos); err != nil {
		fmt.Printf("Erro ao escrever no arquivo JSON: %v\n", err)
		return
	}

	fmt.Printf("Arquivo JSON criado com sucesso: %s\n", outputFilename)
}
