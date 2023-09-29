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
	"os"

	"github.com/go-ini/ini"
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

func imprimirConteudoDoArquivo(nomeArquivo string) error {
	// Lê o conteúdo do arquivo
	conteudo, err := os.ReadFile(nomeArquivo)
	if err != nil {
		return err
	}

	// Imprime o conteúdo na tela
	fmt.Println(string(conteudo))
	return nil
}

func main() {
	textoFormatado := TextFormatter{
		Text:   "Uso: tini_pretty [opções]",
		Cor:    White,
		Estilo: BgBlue,
	}

	var helpFlag bool
	quiet := false
	pretty := false

	//help := flag.Bool("help", false, "Mostra a mensagem de uso")
	flag.BoolVar(&helpFlag, "help", false, "Mostra a mensagem de uso")
	flag.BoolVar(&helpFlag, "h", false, "Mostra a mensagem de uso")
	flag.BoolVar(&quiet, "quiet", false, "Não mostra saída")
	flag.BoolVar(&quiet, "q", false, "Não mostrar saída")

	flag.BoolVar(&pretty, "pretty", false, "Ativar formatação pretty (padrão é false)")
	flag.BoolVar(&pretty, "p", false, "Ativar formatação pretty (padrão é false)")

	// Analise os argumentos da linha de comando
	flag.Parse()

	sum := 0
	for sum < 1000 {
		// sum += sum
		sum++
		fmt.Println(sum)
	}

	// Verifique se todos os argumentos necessários foram fornecidos
	if helpFlag || len(os.Args) == 1 {
		fmt.Println(textoFormatado.Formatar())
		println()
		fmt.Println(Red + "Opções:" + Reset)
		flag.PrintDefaults()
		return
	}

	// Verifique se há argumentos não processados (que não são flags)
	if flag.NArg() == 0 {
		fmt.Println("Erro: é necessário fornecer um nome de arquivo.")
		return
	}

	// O primeiro argumento não processado é considerado o nome do arquivo
	filePath := flag.Arg(0)

	// Carregue o arquivo .ini especificado para leitura/escrita
	cfg, err := ini.Load(filePath)
	if err != nil {
		fmt.Printf("%v\n", err)
		os.Exit(1)
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
	if pretty {
		err = cfg.SaveTo(filePath)
	} else {
		err = cfg.SaveToIndent(filePath, "")
	}

	if err != nil {
		fmt.Printf("%v\n", err)
		os.Exit(1)
	}

	if !quiet {
		imprimirConteudoDoArquivo(filePath)
	}

	// Saia com código de retorno 0 para indicar sucesso
	os.Exit(0)
}
