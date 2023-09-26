package main

import (
	"fmt"
	"github.com/go-ini/ini"
	"os"
)

func main() {
	// Verifique se todos os argumentos necessários foram fornecidos
	if len(os.Args) != 5 {
		fmt.Println("Uso: ./script <nome_do_arquivo.ini> <secao> <chave> <valor>")
		return
	}

	// Obtenha os argumentos da linha de comando
	filePath := os.Args[1]
	sectionName := os.Args[2]
	key := os.Args[3]
	value := os.Args[4]

	// Carregue o arquivo .ini especificado para leitura/escrita
	cfg, err := ini.Load(filePath)
	if err != nil {
		fmt.Printf("Erro ao carregar o arquivo .ini: %v\n", err)
		return
	}

	// Obtenha a seção especificada
	section, err := cfg.GetSection(sectionName)
	if err != nil {
		// Se a seção não existir, crie-a
		section, err = cfg.NewSection(sectionName)
		if err != nil {
			fmt.Printf("Erro ao criar a seção: %v\n", err)
			return
		}
	}

	// Defina o valor da chave
	section.Key(key).SetValue(value)

	// Salve as alterações no arquivo .ini
	err = cfg.SaveTo(filePath)
	if err != nil {
		fmt.Printf("Erro ao salvar o arquivo .ini: %v\n", err)
		return
	}

	fmt.Println("Arquivo .ini atualizado com sucesso.")
}
