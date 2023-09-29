/*
	tini_pretty - reformat .ini files
	go get github.com/go-ini/ini
	Chili GNU/Linux - https://github.com/vcatafesta/ChiliOS
	Chili GNU/Linux - https://chililinux.com
	Chili GNU/Linux - https://chilios.com.br

	Created: 2023/09/26
	Altered: 2023/09/26

	Copyright (c) 2023-2023, Vilmar Catafesta <vcatafesta@gmail.com>
*/

package main

import (
	"flag"
	"fmt"
	"github.com/go-ini/ini"
	"os"
)

func main() {
	// Variáveis para controlar o modo verbose e pretty
	verbose := false
	pretty := false

	// Defina uma flag para --verbose ou -v
	flag.BoolVar(&verbose, "verbose", false, "Modo verbose")

	// Defina uma flag para --pretty ou -p
	flag.BoolVar(&pretty, "pretty", false, "Ativar formatação pretty (padrão é false)")

	// Analise os argumentos da linha de comando
	flag.Parse()

	// Verifique se todos os argumentos necessários foram fornecidos
	if len(flag.Args()) != 1 {
		fmt.Println("Uso: ./script [--verbose|-v] [--pretty|-p] <nome_do_arquivo.ini>")
		os.Exit(1)
	}

	// Obtenha o nome do arquivo .ini a partir dos argumentos da linha de comando
	filePath := flag.Arg(0)

	// Carregue o arquivo .ini especificado para leitura/escrita
	cfg, err := ini.Load(filePath)
	if err != nil {
		if verbose {
			fmt.Printf("Erro ao carregar o arquivo .ini: %v\n", err)
		}
		os.Exit(1)
	}

	// Se estiver no modo verbose, exiba mensagens verbosas
	if verbose {
		fmt.Println("Modo verbose ativado.")
		fmt.Printf("Arquivo .ini carregado: %s\n", filePath)
	}

/*
	// Itere por todas as seções e chaves e remova espaços entre a chave e o valor
	for _, section := range cfg.Sections() {
		for _, key := range section.Keys() {
	//		key.SetValue(strings.TrimSpace(key.String()))
			key.SetValue(key.Name() + "=" + key.String())
		}
	}

*/

	// Configure a opção PrettyFormat com base na flag pretty
	ini.PrettyFormat = pretty

	// Salve as alterações no arquivo .ini com a formatação desejada
	err = cfg.SaveTo(filePath)
	if err != nil {
		fmt.Printf("Erro ao salvar o arquivo .ini: %v\n", err)
		os.Exit(1)
	}

	if verbose {
		fmt.Println("Arquivo .ini atualizado com sucesso.")
	}

	// Saia com código de retorno 0 para indicar sucesso
	os.Exit(0)
}
