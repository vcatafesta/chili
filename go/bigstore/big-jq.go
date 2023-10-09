/*
	big-jq - Command-line JSON processor, similar to jq
    go get github.com/go-ini/ini
    Chili GNU/Linux - https://github.com/vcatafesta/chili/go
    Chili GNU/Linux - https://chililinux.com
    Chili GNU/Linux - https://chilios.com.br

	Created: 2023/10/01
	Altered: 2023/10/05

	Copyright (c) 2023-2023, Vilmar Catafesta <vcatafesta@gmail.com>
	All rights reserved.

	Redistribution and use in source and binary forms, with or without
	modification, are permitted provided that the following conditions
	are met:
	1. Redistributions of source code must retain the above copyright
		notice, this list of conditions and the following disclaimer.
	2. Redistributions in binary form must reproduce the above copyright
		notice, this list of conditions and the following disclaimer in the
		documentation and/or other materials provided with the distribution.

	THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR
	IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
	OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
	IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
	INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
	NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
	DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
	THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
	(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
	THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

package main

import (
	"encoding/json"
	"fmt"
	"io/ioutil"
	"log"
	"os"
	"strings"
)

const (
	_APP_     = "big-jq"
	_VERSION_ = "0.7.0-20231007"
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

type Summary struct {
	Id_Name string            `json:"id_name"`
	Name    string            `json:"name"`
	Version string            `json:"version"`
	Status  string            `json:"status"`
	Size    string            `json:"size"`
	Summary map[string]string `json:"summary"`
}

func main() {
	//	command := os.Args[1]

	if len(os.Args) < 3 {
		fmt.Println("     big-jq -C|--create <arquivo_json> <pacote_id> <pacote> <version> <status> <size> <summary> <lang>")
		fmt.Println("     big-jq -S|--search] <arquivo_json> <pacote_id> [--json]")
		fmt.Println("     big-jq -S|--search] <arquivo_json> <pacote_id.value> [--json]")
		fmt.Println("     big-jq -S|--search] <arquivo_json> <pacote_id.subchave.value> [--json]")
		fmt.Println("     big-jq -L|--list <arquivo_json>")
		os.Exit(1)
	}

	var (
		jsonFile string
		id_name  string
		name     string
		version  string
		status   string
		size     string
		summary  string
		lang     string
		command  string // Variável para armazenar o comando encontrado
		updated  bool
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
		emptyObj := map[string]Summary{}
		jsonStr, _ := json.MarshalIndent(emptyObj, "", "    ")
		_ = ioutil.WriteFile(jsonFile, jsonStr, 0644)
	}

	switch command {
	case "-J", "--json":
		showJSON = true
	case "-S", "--search":
		if len(os.Args) < 4 {
			fmt.Println("Uso: big-jq -S|--search] <arquivo_json> <pacote_id> [--json]")
			fmt.Println("     big-jq -S|--search] <arquivo_json> <pacote_id.value> [--json]")
			fmt.Println("     big-jq -S|--search] <arquivo_json> <pacote_id.subchave.value> [--json]")
			os.Exit(1)
		}
		jsonFile := os.Args[2]
		id_name := os.Args[3]
		searchAndPrintSummary(jsonFile, id_name, showJSON)
		return
	case "-L", "--list":
		jsonFile := os.Args[2]
		listSummarys(jsonFile)
		return
	case "-C", "--create":
	default:
		fmt.Println("Comando inválido")
		return
	}

	if len(os.Args) < 10 {
		fmt.Println("Uso: big-jq -C|--create <arquivo_json> <pacote_id> <pacote> <version> <status> <size> <summary> <lang>")
		os.Exit(1)
	}

	jsonFile = os.Args[2]
	id_name = os.Args[3]
	name = os.Args[4]
	version = os.Args[5]
	status = os.Args[6]
	size = os.Args[7]
	summary = os.Args[8]
	lang = os.Args[9]

	data, err := ioutil.ReadFile(jsonFile)
	if err != nil {
		log.Fatalf("Erro ao ler o arquivo JSON: %v\n", err)
		os.Exit(1)
	}

	var summarys map[string]Summary
	if err := json.Unmarshal(data, &summarys); err != nil {
		log.Fatalf("Erro ao decodificar o JSON: %v\n", err)
		os.Exit(1)
	}

	key := strings.ToLower(id_name)

	if desc, ok := summarys[key]; !ok || desc.Summary[lang] != summary {
		updated = createOrUpdateSummary(&summarys, key, id_name, name, version, status, size, summary, lang)
	}

	// foi atualizada algo ?
	if updated {
		// Converte as descrições em JSON e escreve no arquivo
		data, err = json.MarshalIndent(summarys, "", "  ")
		if err != nil {
			log.Fatalf("Erro ao codificar para o JSON: %v\n", err)
			os.Exit(1)
		}

		err = ioutil.WriteFile(jsonFile, data, os.ModePerm)
		if err != nil {
			log.Fatalf("Erro ao escrever no arquivo JSON: %v\n", err)
			os.Exit(1)
		}
		// log.Printf("big-jq %sAtualizando arquivo JSON:%s %s\n", Yellow, Reset, jsonFile)
		log.Printf("%s %sSET: %s'%s'%s em %s %s- 200 OK%s\n", _APP_, Green, Yellow, key, Reset, jsonFile, Green, Reset)
		os.Exit(0)
	}
	log.Printf("big-jq %sNada a ser feito no arquivo JSON:%s %s\n", Yellow, Reset, jsonFile)
	os.Exit(0)
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

func searchAndPrintSummary(jsonFile, fieldPath string, showJSON bool) {
	// Lê o conteúdo do arquivo JSON
	data, err := ioutil.ReadFile(jsonFile)
	if err != nil {
		log.Fatalf("Erro ao ler o arquivo JSON: %v\n", err)
		os.Exit(1)
	}

	var summarys map[string]interface{}
	if err := json.Unmarshal(data, &summarys); err != nil {
		log.Fatalf("Erro ao decodificar o JSON: %v\n", err)
		os.Exit(1)
	}

	if showJSON {
		// Se o parâmetro "json" estiver definido, imprime o objeto JSON completo a partir da chave especificada
		fieldVal := summarys[fieldPath]
		if fieldVal != nil {
			fieldMap := map[string]interface{}{fieldPath: fieldVal}
			jsonVal, _ := json.MarshalIndent(fieldMap, "", "  ")
			fmt.Println(string(jsonVal))
		} else {
			fmt.Println("null")
			os.Exit(1)
		}
		os.Exit(0)
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
	fieldVal := getField(summarys, fields)
	if fieldVal != nil {
		log.Printf("%s %sGET: %s'%s'%s em %s %s- 200 OK%s\n", _APP_, Green, Yellow, strings.TrimSpace(fieldPath), Reset, jsonFile, Green, Reset)
		// log.Println(_APP_, "GET:", jsonFile, Yellow, strings.TrimSpace(fieldPath), Green, "- 200 OK", Reset)
		fmt.Println(fieldVal)
		os.Exit(0)
	}
	log.Printf("%s %sGET: %s'%s'%s em %s %s- 404 NOK%s\n", _APP_, Red, Yellow, strings.TrimSpace(fieldPath), Reset, jsonFile, Red, Reset)
	// log.Println(_APP_, Red, "GET:", Cyan, strings.TrimSpace(fieldPath), Reset, "em", jsonFile, "-", Red, "200 NOK", Reset)
	fmt.Println("null")
	os.Exit(1)
}

func searchAndPrintSummaryOLD(jsonFile, id_name, field string, showJSON bool) {
	// Lê o conteúdo do arquivo JSON
	data, err := ioutil.ReadFile(jsonFile)
	if err != nil {
		fmt.Println("Erro ao ler o arquivo JSON:", err)
		return
	}

	var summarys map[string]Summary
	if err := json.Unmarshal(data, &summarys); err != nil {
		fmt.Println("Erro ao decodificar o JSON:", err)
		return
	}

	key := strings.ToLower(id_name)

	// Procura a descrição no idioma especificado
	if desc, ok := summarys[key]; ok {
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

func listSummarys(jsonFile string) {
	// Lê o conteúdo do arquivo JSON
	data, err := ioutil.ReadFile(jsonFile)
	if err != nil {
		fmt.Println("Erro ao ler o arquivo JSON:", err)
		return
	}

	var summarys map[string]Summary
	if err := json.Unmarshal(data, &summarys); err != nil {
		fmt.Println("Erro ao decodificar o JSON:", err)
		return
	}

	// Converte para JSON e imprime
	resultJSON, err := json.MarshalIndent(summarys, "", "  ")
	if err != nil {
		fmt.Println("Erro ao codificar para JSON:", err)
		return
	}

	fmt.Println(string(resultJSON))
}

func createOrUpdateSummary(summarys *map[string]Summary, key, id_name, name, version, status, size, summary, lang string) bool {
	// Inicialize a variável updated como false
	updated := false

	// Verifique se a descrição já existe
	if desc, ok := (*summarys)[key]; ok {
		// Verifique se algum campo é diferente e atualize se for o caso
		if desc.Id_Name != id_name || desc.Name != name || desc.Version != version || desc.Status != status || desc.Size != size || desc.Summary[lang] != summary {
			desc.Id_Name = id_name
			desc.Name = name
			desc.Version = version
			desc.Status = status
			desc.Size = size
			desc.Summary[lang] = summary
			// Atualize o objeto no mapa
			(*summarys)[key] = desc
			// Defina updated como true, indicando que a descrição foi atualizada com sucesso
			updated = true
		}
	} else {
		// Crie uma nova descrição se ela não existir
		newSummary := Summary{
			Id_Name: id_name,
			Name:    name,
			Version: version,
			Status:  status,
			Size:    size,
			Summary: map[string]string{
				lang: summary,
			},
		}
		(*summarys)[key] = newSummary
		// Defina updated como true, indicando que a descrição foi criada com sucesso
		updated = true
	}

	// Retorne o valor de updated no final da função
	return updated
}
