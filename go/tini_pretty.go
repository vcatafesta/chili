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

// Cores de Texto (Foreground)
const (
    Black   = "\033[30m"
    Red     = "\033[31m"
    Green   = "\033[32m"
    Yellow  = "\033[33m"
    Blue    = "\033[34m"
    Magenta = "\033[35m"
    Cyan    = "\033[36m"
    White   = "\033[37m"
)

// Cores de Fundo
const (
    BgBlack   = "\033[40m"
    BgRed     = "\033[41m"
    BgGreen   = "\033[42m"
    BgYellow  = "\033[43m"
    BgBlue    = "\033[44m"
    BgMagenta = "\033[45m"
    BgCyan    = "\033[46m"
    BgWhite   = "\033[47m"
)

// Estilos de Texto
const (
    Bold      = "\033[1m"
    Underline = "\033[4m"
    Reset     = "\033[0m"
)

// TextFormatter é uma struct que representa um objeto de formatação de texto
type TextFormatter struct {
    Text   string
    Cor    string
    Estilo string
}

// Formatar formata o texto com a cor e o estilo especificados
func (tf *TextFormatter) Formatar() string {
    return tf.Cor + tf.Estilo + tf.Text + Reset
}

func main() {
    textoFormatado := TextFormatter{
        Text:   "Uso: tini_pretty [--verbose|-v] [--pretty|-p] <nome_do_arquivo.ini>",
        Cor:    Red,
        Estilo: Bold,
    }

	verbose := false
	pretty := false

	flag.BoolVar(&verbose, "verbose", false, "Modo verbose")
	flag.BoolVar(&verbose, "v", false, "Modo verbose")

	flag.BoolVar(&pretty, "pretty", false, "Ativar formatação pretty (padrão é false)")
	flag.BoolVar(&pretty, "p", false, "Ativar formatação pretty (padrão é false)")

	// Analise os argumentos da linha de comando
	flag.Parse()

	// Verifique se todos os argumentos necessários foram fornecidos
	if len(flag.Args()) != 1 {
		fmt.Println(textoFormatado.Formatar())
		os.Exit(1)
	}

	if verbose {
		fmt.Println("Modo verbose ativado.")
	}
	if pretty {
		fmt.Println("Modo bonito ativado.")
	}

	// Obtenha o nome do arquivo .ini a partir dos argumentos da linha de comando
	filePath := flag.Arg(0)

	// Carregue o arquivo .ini especificado para leitura/escrita
	cfg, err := ini.Load(filePath)
	if err != nil {
		fmt.Printf("Erro ao carregar o arquivo: %v\n", err)
		os.Exit(1)
	}

	if verbose {
		fmt.Printf("%s carregado\n", filePath)
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
		fmt.Printf("Erro ao salvar o arquivo: %v\n", err)
		os.Exit(1)
	}

	if verbose {
		fmt.Printf("%s atualizado com sucesso", filePath)
	}

	// Saia com código de retorno 0 para indicar sucesso
	os.Exit(0)
}
