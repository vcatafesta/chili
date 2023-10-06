package main

import (
	"encoding/json"
	"fmt"
	"io/ioutil"
	"os"
	"strings"
)

type Description struct {
	Id_Name     string            `json:"id_name"`
	Name        string            `json:"name"`
	Version     string            `json:"version"`
	Status      string            `json:"status"`
	Size        string            `json:"size"`
	Description map[string]string `json:"description"`
}

func main() {
	//	command := os.Args[1]

	if len(os.Args) < 2 {
		fmt.Println("     big-jq -C|--create <arquivo_json> <pacote-id> <pacote> <version> <status> <size> <description> <lang>")
		fmt.Println("     big-jq -S|--search] <arquivo_json> <chave> [--json]")
		fmt.Println("     big-jq -S|--search] <arquivo_json> <chave.value> [--json]")
		fmt.Println("     big-jq -S|--search] <arquivo_json> <chave.subchave.value> [--json]")
		fmt.Println("     big-jq -L|--list <arquivo_json>")
		return
	}

	var (
		jsonFile    string
		id_name     string
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

	jsonFile = os.Args[2]
	// Verifique se o arquivo JSON existe e, se não, crie-o com um objeto vazio
	if _, err := os.Stat(jsonFile); os.IsNotExist(err) {
		emptyObj := map[string]Description{}
		jsonStr, _ := json.MarshalIndent(emptyObj, "", "    ")
		_ = ioutil.WriteFile(jsonFile, jsonStr, 0644)
	}

	switch command {
	case "-J", "--json":
		showJSON = true
	case "-S", "--search":
		if len(os.Args) < 4 {
			fmt.Println("Uso: programa [-S|--search] <arquivo_json> <id_name> <lang>")
			return
		}
		jsonFile := os.Args[2]
		id_name := os.Args[3]
		searchAndPrintDescription(jsonFile, id_name, showJSON)
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

	if len(os.Args) < 10 {
		fmt.Println("Uso: programa <arquivo_json> <_keyname> <name> <version> <status> <size> <description> <lang>")
		return
	}

	jsonFile = os.Args[2]
	id_name = os.Args[3]
	name = os.Args[4]
	version = os.Args[5]
	status = os.Args[6]
	size = os.Args[7]
	description = os.Args[8]
	lang = os.Args[9]

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

	key := strings.ToLower(id_name)

	if desc, ok := descriptions[key]; !ok || desc.Description[lang] != description {
		updated = createOrUpdateDescription(&descriptions, key, id_name, name, version, status, size, description, lang)
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

func printFieldRecursively(prefix string, data interface{}, showJSON bool) {
	switch v := data.(type) {
	case map[string]interface{}:
		for key, value := range v {
			newPrefix := fmt.Sprintf("%s.%s", prefix, key)
			printFieldRecursively(newPrefix, value, showJSON)
		}
	default:
		if showJSON {
			resultJSON, _ := json.Marshal(data)
			fmt.Printf("%s: %s\n", prefix, string(resultJSON))
		} else {
			fmt.Printf("%s: %v\n", prefix, data)
		}
	}
}

func searchAndPrintDescription(jsonFile, fieldPath string, showJSON bool) {
	// Lê o conteúdo do arquivo JSON
	data, err := ioutil.ReadFile(jsonFile)
	if err != nil {
		fmt.Println("Erro ao ler o arquivo JSON:", err)
		return
	}

	var descriptions map[string]interface{}
	if err := json.Unmarshal(data, &descriptions); err != nil {
		fmt.Println("Erro ao decodificar o JSON:", err)
		return
	}

	if showJSON {
		// Se o parâmetro "json" estiver definido, imprime o objeto JSON inteiro
		//		jsonVal, _ := json.Marshal(descriptions)
		//		fmt.Println(string(jsonVal))
		//		return

		// Se o parâmetro "json" estiver definido, imprime o objeto JSON completo a partir da chave especificada
		fieldVal := descriptions[fieldPath]
		if fieldVal != nil {
			fieldMap := map[string]interface{}{fieldPath: fieldVal}
			jsonVal, _ := json.MarshalIndent(fieldMap, "", "  ")
			fmt.Println(string(jsonVal))
		} else {
			fmt.Println("null")
		}
		return
	}

	fields := strings.Split(fieldPath, ".")

	// Função recursiva para acessar campos aninhados
	var getField func(map[string]interface{}, []string) interface{}
	getField = func(m map[string]interface{}, keys []string) interface{} {
		if len(keys) == 0 {
			return nil
		}
		key := keys[0]
		if len(keys) == 1 {
			return m[key]
		}
		nested, ok := m[key].(map[string]interface{})
		if !ok {
			return nil
		}
		return getField(nested, keys[1:])
	}

	// Procura o campo especificado
	fieldVal := getField(descriptions, fields)
	if fieldVal != nil {
		fmt.Println(fieldVal)
		return
	}
	fmt.Println("null")
}

func searchAndPrintDescriptionOLD(jsonFile, id_name, field string, showJSON bool) {
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

	key := strings.ToLower(id_name)

	// Procura a descrição no idioma especificado
	if desc, ok := descriptions[key]; ok {
		// Verifica se o campo desejado existe na descrição
		switch field {
		case "name":
			printField(desc.Name, showJSON)
		case "version":
			printField(desc.Version, showJSON)
		case "status":
			printField(desc.Status, showJSON)
		case "size":
			printField(desc.Size, showJSON)
		default:
			fmt.Println("null")
		}
		return
	}

	if showJSON {
		fmt.Println("null")
	} else {
		fmt.Println("null")
	}
}

func printField(value string, showJSON bool) {
	if showJSON {
		resultJSON, _ := json.Marshal(map[string]string{"field": value})
		fmt.Println(string(resultJSON))
	} else {
		fmt.Println(value)
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

func createOrUpdateDescription(descriptions *map[string]Description, key, id_name, name, version, status, size, description, lang string) bool {
	// Inicialize a variável updated como false
	updated := false

	println(id_name)

	// Verifique se a descrição já existe
	if desc, ok := (*descriptions)[key]; ok {
		// Verifique se algum campo é diferente e atualize se for o caso
		if desc.Id_Name != id_name || desc.Name != name || desc.Version != version || desc.Status != status || desc.Size != size || desc.Description[lang] != description {
			desc.Id_Name = id_name
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
			Id_Name: id_name,
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
