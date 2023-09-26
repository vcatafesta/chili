package main

import (
	"fmt"
	"github.com/go-ini/ini"
	"os"
)

func main() {
	// Verifique se um nome de arquivo .ini foi fornecido como argumento
	if len(os.Args) != 2 {
		fmt.Println("Uso: ./script <nome_do_arquivo.ini>")
		return
	}

	// Obtenha o nome do arquivo .ini a partir dos argumentos da linha de comando
	filePath := os.Args[1]

	// Carregue o arquivo .ini especificado para leitura/escrita
	cfg, err := ini.Load(filePath)
	if err != nil {
		fmt.Printf("Erro ao carregar o arquivo .ini: %v\n", err)
		return
	}

	// Leia ou modifique valores no arquivo .ini conforme necessário
	section, err := cfg.GetSection("ConfigSection")
	if err != nil {
		fmt.Printf("Erro ao obter a seção: %v\n", err)
		return
	}

	key := "Chave"
	value := section.Key(key).String()
	fmt.Printf("Valor da chave %s: %s\n", key, value)

	// Modifique valores no arquivo .ini, se necessário
	section.Key(key).SetValue("NovoValor")
	err = cfg.SaveTo(filePath)
	if err != nil {
		fmt.Printf("Erro ao salvar o arquivo .ini: %v\n", err)
		return
	}

	fmt.Println("Arquivo .ini atualizado com sucesso.")

	// Remova a chave do arquivo .ini, se necessário
	section.DeleteKey(key)
	err = cfg.SaveTo(filePath)
	if err != nil {
		fmt.Printf("Erro ao salvar o arquivo .ini após a exclusão: %v\n", err)
		return
	}

	fmt.Println("Chave removida do arquivo .ini.")
}
