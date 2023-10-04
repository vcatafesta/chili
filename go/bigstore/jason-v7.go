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
	if len(os.Args) == 2 && (os.Args[1] == "-l" || os.Args[1] == "--list") {
		listDescriptions()
		return
	} else if len(os.Args) < 8 || len(os.Args) > 9 {
		fmt.Println("Uso: programa [-S] <arquivo_json> <name> <version> <status> <size> <description> <lang>")
		return
	}

	searchOnly := false
	jsonFile := os.Args[1]
	if os.Args[1] == "-S" {
		searchOnly = true
		jsonFile = os.Args[2]
	}

	name := os.Args[2]
	version := os.Args[3]
	status := os.Args[4]
	size := os.Args[5]
	description := os.Args[6]
	lang := os.Args[7]

	// Verifica se o arquivo JSON existe
	if _, err := os.Stat(jsonFile); os.IsNotExist(err) {
		createEmptyJSON(jsonFile)
	}

	// Se for apenas busca, então busque e retorne
	if searchOnly {
		searchAndPrintDescription(jsonFile, name, lang)
		return
	}

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

func listDescriptions() {
	if len(os.Args) != 2 {
		fmt.Println("Uso: programa <arquivo_json>")
		return
	}

	jsonFile := os.Args[1]

	// Lê o conteúdo do arquivo JSON
	data, err := ioutil.ReadFile(jsonFile)
	if err != nil {
		fmt.Println("Erro ao ler o arquivo JSON:", err)
		return
	}

	fmt.Println(string(data))
}

func createEmptyJSON(jsonFile string) {
	// Cria um arquivo JSON vazio
	data := []byte("{}")
	err := ioutil.WriteFile(jsonFile, data, os.ModePerm)
	if err != nil {
		fmt.Println("Erro ao criar o arquivo JSON:", err)
	}
}

func searchAndPrintDescription(jsonFile, name, lang string) {
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
			result := map[string]string{
				"name":        desc.Name,
				"version":     desc.Version,
				"status":      desc.Status,
				"size":        desc.Size,
				"description": val,
			}
			resultJSON, _ := json.Marshal(result)
			fmt.Println(string(resultJSON))
			return
		}
	}

	fmt.Println("null")
}
