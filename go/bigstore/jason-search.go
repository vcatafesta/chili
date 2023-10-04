package main

import (
	"encoding/json"
	"fmt"
	"io/ioutil"
	"os"
	"strings"
)

type Description struct {
	Name        string            `json:"name"`
	Version     string            `json:"version"`
	Status      string            `json:"status"`
	Size        string            `json:"size"`
	Description map[string]string `json:"description"`
}

func main() {
	if len(os.Args) < 4 {
		fmt.Println("Uso: jason.go <comando> <arquivo_json> <nome> <idioma> [--json]")
		return
	}

	command := os.Args[1]
	jsonFile := os.Args[2]
	name := os.Args[3]
	lang := os.Args[4]

	showJSON := false
	if len(os.Args) > 5 && os.Args[5] == "--json" {
		showJSON = true
	}

	switch command {
	case "-S":
		searchAndPrintDescription(jsonFile, name, lang, showJSON)
	case "-U":
		// Implemente a atualização aqui
		fmt.Println("Implemente a atualização aqui")
	case "--list":
		listDescriptions(jsonFile)
	default:
		fmt.Println("Comando inválido")
	}
}

func searchAndPrintDescription(jsonFile, name, lang string, showJSON bool) {
	// Lê o conteúdo do arquivo JSON
	data, err := ioutil.ReadFile(jsonFile)
	if err != nil {
		fmt.Println("Erro ao ler o arquivo JSON:", err)
		return
	}

	var descriptions map[string]Description
	if err := json.Unmarshal(data, &descriptions); err != nil {
		fmt.Println("Erro ao decodificar o JSON:", err)
		return
	}

	key := strings.ToLower(name)

	// Procura a descrição no idioma especificado
	if desc, ok := descriptions[key]; ok {
		if val, exists := desc.Description[lang]; exists {
			if showJSON {
				desc.Description[lang] = val
				resultJSON, _ := json.Marshal(desc)
				fmt.Println(string(resultJSON))
			} else {
				fmt.Println(val)
			}
			return
		}
	}

	if showJSON {
		fmt.Println("null")
	} else {
		fmt.Println("null")
	}
}

func listDescriptions(jsonFile string) {
	// Lê o conteúdo do arquivo JSON
	data, err := ioutil.ReadFile(jsonFile)
	if err != nil {
		fmt.Println("Erro ao ler o arquivo JSON:", err)
		return
	}

	var descriptions map[string]Description
	if err := json.Unmarshal(data, &descriptions); err != nil {
		fmt.Println("Erro ao decodificar o JSON:", err)
		return
	}

	// Converte para JSON e imprime
	resultJSON, err := json.Marshal(descriptions)
	if err != nil {
		fmt.Println("Erro ao codificar para JSON:", err)
		return
	}

	fmt.Println(string(resultJSON))
}
