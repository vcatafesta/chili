package main

import (
	"encoding/json"
	"fmt"
	"io/ioutil"
	"os"
	"strings"
)

const FILE_DESCRIPTION_JSON = "description.json"

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
	} else if len(os.Args) != 7 {
		fmt.Println("Uso: programa <name> <version> <status> <size> <description> <lang>")
		return
	}

	name := os.Args[1]
	version := os.Args[2]
	status := os.Args[3]
	size := os.Args[4]
	description := os.Args[5]
	lang := os.Args[6]

	// Verifica se o arquivo JSON existe
	if _, err := os.Stat(FILE_DESCRIPTION_JSON); os.IsNotExist(err) {
		createEmptyJSON()
	}

	// Lê o conteúdo do arquivo JSON
	data, err := ioutil.ReadFile(FILE_DESCRIPTION_JSON)
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
			fmt.Println(val)
			return
		}
	}

	// Se não encontrou a descrição, cria ou atualiza
	createOrUpdateDescription(&descriptions, key, name, version, status, size, description, lang)
}

func createOrUpdateDescription(descriptions *map[string]Description, key, name, version, status, size, description, lang string) {
	if _, ok := (*descriptions)[key]; ok {
		// Cria uma cópia da estrutura para evitar modificar diretamente a original
		copy := (*descriptions)[key]
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

	// Converte as descrições em JSON e escreve no arquivo
	data, err := json.MarshalIndent(*descriptions, "", "  ")
	if err != nil {
		fmt.Println("Erro ao codificar para JSON:", err)
		return
	}

	err = ioutil.WriteFile(FILE_DESCRIPTION_JSON, data, os.ModePerm)
	if err != nil {
		fmt.Println("Erro ao escrever no arquivo JSON:", err)
	}
}

func listDescriptions() {
	// Lê o conteúdo do arquivo JSON
	data, err := ioutil.ReadFile(FILE_DESCRIPTION_JSON)
	if err != nil {
		fmt.Println("Erro ao ler o arquivo JSON:", err)
		return
	}

	fmt.Println(string(data))
}

func createEmptyJSON() {
	// Cria um arquivo JSON vazio
	data := []byte("{}")
	err := ioutil.WriteFile(FILE_DESCRIPTION_JSON, data, os.ModePerm)
	if err != nil {
		fmt.Println("Erro ao criar o arquivo JSON:", err)
	}
}
