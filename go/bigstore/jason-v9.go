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
	//	command := os.Args[1]

	var (
		jsonFile    string
		name        string
		version     string
		status      string
		size        string
		description string
		lang        string
		command     string // Variável para armazenar o comando encontrado
		updated     bool
	)

	showJSON := false

	// Iterar por os.Args a partir do segundo elemento (os.Args[0] é o nome do programa)
	for i := 1; i < len(os.Args); i++ {
		arg := os.Args[i]
		switch arg {
		case "-L", "--list":
			command = arg
		case "-C", "--create":
			command = arg
		case "-S", "--search":
			command = arg
		case "-J", "--json":
			showJSON = true
		}
	}

	switch command {
	case "-J", "--json":
		showJSON = true
	case "-S", "--search":
		if len(os.Args) < 5 {
			fmt.Println("Uso: programa [-S|--search] <arquivo_json> <name> <lang>")
			return
		}
		jsonFile := os.Args[2]
		name := os.Args[3]
		lang := os.Args[4]
		searchAndPrintDescription(jsonFile, name, lang, showJSON)
		return
	case "-L", "--list":
		jsonFile := os.Args[2]
		listDescriptions(jsonFile)
		return
	case "-C", "--create":
	default:
		fmt.Println("Comando inválido")
		return
	}

	if len(os.Args) < 9 {
		fmt.Println("Uso: programa <arquivo_json> <name> <version> <status> <size> <description> <lang>")
		return
	}

	jsonFile = os.Args[2]
	name = os.Args[3]
	version = os.Args[4]
	status = os.Args[5]
	size = os.Args[6]
	description = os.Args[7]
	lang = os.Args[8]

	// Verifique se o arquivo JSON existe e, se não, crie-o com um objeto vazio
	if _, err := os.Stat(jsonFile); os.IsNotExist(err) {
		emptyObj := map[string]Description{}
		jsonStr, _ := json.MarshalIndent(emptyObj, "", "    ")
		_ = ioutil.WriteFile(jsonFile, jsonStr, 0644)
	}

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

	if desc, ok := descriptions[key]; !ok || desc.Description[lang] != description {
	    updated = createOrUpdateDescription(&descriptions, key, name, version, status, size, description, lang)
	}

	// foi atualizada algo ?
	if updated {
		// Converte as descrições em JSON e escreve no arquivo
		data, err = json.MarshalIndent(descriptions, "", "  ")
		if err != nil {
			fmt.Println("Erro ao codificar para JSON:", err)
			return
		}

		//		fmt.Println("Escrevendo dados atualizados no arquivo JSON...")
		err = ioutil.WriteFile(jsonFile, data, os.ModePerm)
		if err != nil {
			fmt.Println("Erro ao escrever no arquivo JSON:", err)
			return
		}
		//		fmt.Println("Dados atualizados escritos no arquivo JSON com sucesso!")
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
	resultJSON, err := json.MarshalIndent(descriptions, "", "  ")
	if err != nil {
		fmt.Println("Erro ao codificar para JSON:", err)
		return
	}

	fmt.Println(string(resultJSON))
}

func createOrUpdateDescription(descriptions *map[string]Description, key, name, version, status, size, description, lang string) bool {
	// Inicialize a variável updated como false
	updated := false

	// Verifique se a descrição já existe
	if desc, ok := (*descriptions)[key]; ok {
		// Verifique se algum campo é diferente e atualize se for o caso
		if desc.Name != name || desc.Version != version || desc.Status != status || desc.Size != size || desc.Description[lang] != description {
			desc.Name = name
			desc.Version = version
			desc.Status = status
			desc.Size = size
			desc.Description[lang] = description
			// Atualize o objeto no mapa
			(*descriptions)[key] = desc
			// Defina updated como true, indicando que a descrição foi atualizada com sucesso
			updated = true
		}
	} else {
		// Crie uma nova descrição se ela não existir
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
		// Defina updated como true, indicando que a descrição foi criada com sucesso
		updated = true
	}

	// Retorne o valor de updated no final da função
	return updated
}
