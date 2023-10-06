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
//	listOnly := false
	outputJSON := false
//	searchOnly := false
//	createOrUpdate := false

	if len(os.Args) < 4 {
		fmt.Println("Uso: programa [-S] <arquivo_json> <name> <lang> [--json]")
		return
	}

	switch os.Args[1] {
	case "-l", "--list":
		if len(os.Args) != 3 {
			fmt.Println("Uso: programa [-l|--list] <arquivo_json>")
			return
		}
//		listOnly = true
		listDescriptions(os.Args[2])
		return

	case "-C", "--create":
		if len(os.Args) != 3 {
			fmt.Println("Uso: programa -C <arquivo_json>")
			return
		}

	case "-J", "--json":

	case "-S", "--search":
		if len(os.Args) != 9 {
			fmt.Println("Uso: programa -S <arquivo_json> <name> <lang> --json <version> <status> <size> <description>")
			return
		}
		jsonFile := os.Args[2]
		name := os.Args[3]
		lang := os.Args[4]
		outputJSON := os.Args[5] == "--json"
		version := os.Args[6]
		status := os.Args[7]
		size := os.Args[8]
		description := os.Args[9]
	default:
		fmt.Println("Comando não reconhecido.")
		fmt.Println("Uso: programa [-l] <arquivo_json> ou programa -S <arquivo_json> <name> <lang> --json <version> <status> <size> <description>")
	}

	jsonFile := os.Args[1]
	name := os.Args[2]
	lang := os.Args[3]
	outputJSON := len(os.Args) == 5 && os.Args[4] == "--json"

	if !outputJSON && len(os.Args) != 4 {
		fmt.Println("Uso: programa [-S] <arquivo_json> <name> <lang> [--json]")
		return
	}

	if !outputJSON {
		searchDescription(jsonFile, name, lang, outputJSON)
		return
	}

	version := os.Args[4]
	status := os.Args[5]
	size := os.Args[6]
	description := os.Args[7]

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

	if desc, ok := descriptions[key]; ok {
		if val, exists := desc.Description[lang]; exists {
			if desc.Name != name || desc.Version != version || desc.Status != status || desc.Size != size || val != description {
				// Atualiza o objeto se os parâmetros não forem iguais
				createOrUpdateDescription(&descriptions, key, name, version, status, size, description, lang)
			} else {
				fmt.Println(val)
			}
			return
		}
	}

	// Se não encontrou a descrição, cria ou atualiza
	createOrUpdateDescription(&descriptions, key, name, version, status, size, description, lang)

	// Converte as descrições em JSON e escreve no arquivo
	data, err = json.MarshalIndent(descriptions, "", "  ")
	if err != nil {
		fmt.Println("Erro ao codificar para JSON:", err)
		return
	}

	err = ioutil.WriteFile(jsonFile, data, os.ModePerm)
	if err != nil {
		fmt.Println("Erro ao escrever no arquivo JSON:", err)
	}
}

func createOrUpdateDescription(descriptions *map[string]Description, key, name, version, status, size, description, lang string) {
	if _, ok := (*descriptions)[key]; ok {
		// Cria uma cópia da estrutura para evitar modificar diretamente a original
		copy := (*descriptions)[key]
		copy.Name = name
		copy.Version = version
		copy.Status = status
		copy.Size = size
		copy.Description[lang] = description
		(*descriptions)[key] = copy
	} else {
		// Cria uma nova descrição
		newDescription := Description{
			Name:    name,
			Version: version,
			Status:  status,
			Size:    size,
			Description: map[string]string{
				lang: description,
			},
		}
		(*descriptions)[key] = newDescription
	}
}

func listDescriptions(jsonFile string) {
	data, err := ioutil.ReadFile(jsonFile)
	if err != nil {
		fmt.Println("Erro ao ler o arquivo JSON:", err)
		return
	}

	fmt.Println(string(data))
}


func searchDescription(jsonFile, name, lang string, outputJSON bool) {
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

	if desc, ok := descriptions[key]; ok {
		if val, exists := desc.Description[lang]; exists {
			if outputJSON {
				result := map[string]interface{}{
					"name":        desc.Name,
					"version":     desc.Version,
					"status":      desc.Status,
					"size":        desc.Size,
					"description": val,
				}
				resultJSON, _ := json.Marshal(result)
				fmt.Println(string(resultJSON))
			} else {
				fmt.Println(val)
			}
			return
		}
	}

	if outputJSON {
		fmt.Println("null")
	} else {
		fmt.Println("Descrição não encontrada")
	}
}

