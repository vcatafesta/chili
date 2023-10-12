/*
   chili-tradutor-go - Command-line JSON processor, similar to jq
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
	"bufio"
	"bytes"
	"fmt"
	"github.com/fatih/color"
	"github.com/ogier/pflag" // Importe o pacote pflag
	"log"
	"os"
	"os/exec"
	"strings"
	"sync"
)

const (
	_APP_     = "chili-tradutor-go"
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

var (
	cyan    = color.New(color.FgCyan).SprintFunc()
	yellow  = color.New(color.FgYellow).SprintFunc()
	green   = color.New(color.FgGreen).SprintFunc()
	magenta = color.New(color.FgMagenta).SprintFunc()
	red     = color.New(color.FgRed).SprintFunc()
)
var (
	inputFile    string
	showVersion  bool
	showHelp     bool
	forceFlag    bool
	languageCode string
)

var supportedLanguages = []string{
	"bg", "cs", "da", "de", "el", "en", "es", "et", "fi", "fr", "he", "hr", "hu", "is", "it", "ja",
	"ko", "nl", "no", "pl", "pt-PT", "pt-BR", "ro", "ru", "sk", "sv", "tr", "uk", "zh", "fa", "hi", "ar",
}

var (
	isForce bool
)

func main() {
	flags := pflag.NewFlagSet("chili-tradutor-go", pflag.ContinueOnError)

	flags.StringVar(&inputFile, "inputfile", "", "Input file")
	flags.StringVar(&inputFile, "i", "", "Input file")
	flags.BoolVar(&showVersion, "V", false, "Show version")
	flags.BoolVar(&showVersion, "version", false, "Show version")
	flags.BoolVar(&showHelp, "h", false, "Show help")
	flags.BoolVar(&showHelp, "help", false, "Show help")
	flags.BoolVar(&forceFlag, "f", false, "Force flag")
	flags.BoolVar(&forceFlag, "force", false, "Force flag")
	flags.StringVar(&languageCode, "l", "", "Language code")
	flags.StringVar(&languageCode, "language", "", "Language code")

	err := flags.Parse(os.Args[1:])
	if err != nil {
		fmt.Fprintf(os.Stderr, "Error: %v\n", err)
		os.Exit(1)
	}
	for index, arg := range flags.Args() {
		switch arg {
		case "--i", "--inputfile":
			fmt.Printf("Input file: %s\n", inputFile, index)
		case "--V", "--version":
			fmt.Printf("Version: %s\n", _VERSION_)
		case "--h", "--help":
			usage()
			os.Exit(0)
		case "--f", "--force":
			isForce = true
		case "--l", "--language":
			fmt.Printf("Language code: %s\n", languageCode)
			languageCode = os.Args[2]
		default:
			fmt.Printf("Unknown flag: %s\n", arg)
		}
	}

	if inputFile == "" || len(os.Args) < 2 {
		usage()
		os.Exit(1)
	}

	inputFile := os.Args[1]
	languageCode := ""

	if len(os.Args) > 2 {
		languageCode = os.Args[2]
	}

	// Preparar o arquivo .pot uma vez no início
	fmt.Printf("%s Preparing .pot file...\n", cyan("[INFO]"))
	prepare(inputFile)

	var wg sync.WaitGroup

	for _, lang := range supportedLanguages {
		wg.Add(1)
		go func(lang string) {
			defer wg.Done()
			if languageCode == "" || languageCode == lang {
				translateFile(inputFile, lang)
			}
		}(lang)
	}

	wg.Wait()
}

func usage() {
	fmt.Println("Usage: chili-tradutor-go -i <input_file> [-V] [-h] [-f] [-l <language_code>]")
	// fmt.Fprintf(os.Stderr, "Usage of chili-tradutor-go:\n")
	fmt.Fprintf(os.Stderr, "  --i, --inputfile          Input file\n")
	fmt.Fprintf(os.Stderr, "  --V, --version            Show version\n")
	fmt.Fprintf(os.Stderr, "  --h, --help               Show help\n")
	fmt.Fprintf(os.Stderr, "  --f, --force              Force flag\n")
	fmt.Fprintf(os.Stderr, "  --l, --language           Language code\n")
}

func init() {
	return
}

func translateFile(inputFile, lang string) {
	translatedFile := fmt.Sprintf("%s-%s.po", inputFile, lang)

	// Abrir o arquivo .pot para leitura
	file, err := os.Open(inputFile + ".pot")
	if err != nil {
		log.Fatalf("%s Error opening file: %v\n", red("[ERROR]"), err)
	}
	defer file.Close()

	// Abrir o arquivo .po para escrita
	outputFile, err := os.Create(translatedFile)
	if err != nil {
		log.Fatalf("%s Error creating file: %v\n", red("[ERROR]"), err)
	}
	defer outputFile.Close()

	// Criar um scanner para ler o arquivo .pot
	scanner := bufio.NewScanner(file)

	// Variável para armazenar as linhas do texto msgid
	var msgidLines []string

	// Variável para determinar se estamos lendo uma linha msgid ou msgstr
	var isMsgid bool

	// Ler o arquivo .pot linha por linha e traduzir para o idioma atual
	for scanner.Scan() {
		line := scanner.Text()
		if strings.HasPrefix(line, "msgid ") {
			// Começou uma nova linha msgid
			isMsgid = true
			msgidLines = []string{strings.TrimPrefix(line, "msgid ")}
		} else if strings.HasPrefix(line, "msgstr ") && isMsgid {
			// Continuação da linha msgid, mas começou a linha msgstr
			msgstr := translateMessage(strings.Join(msgidLines, "\n"), lang)
			fmt.Fprintf(outputFile, "msgid %s\nmsgstr %s\n\n", strings.Join(msgidLines, "\n"), msgstr)

			// Reset das variáveis para a próxima mensagem
			isMsgid = false
			msgidLines = nil
		} else if isMsgid {
			// Se já tivermos encontrado "msgid", as linhas seguintes são parte do texto msgid
			msgidLines = append(msgidLines, line)
		}
	}

	if err := scanner.Err(); err != nil {
		log.Fatalf("%s Error reading file: %v\n", red("[ERROR]"), err)
	}

	fmt.Printf("%s Translated to %s: %s\n", green("[SUCCESS]"), lang, translatedFile)
}

func prepare(inputFile string) {
	// Verificar se o arquivo inputFile existe
	if _, err := os.Stat(inputFile); os.IsNotExist(err) {
		log.Fatalf("%s Input file does not exist: %s\n", red("[ERROR]"), inputFile)
	}

	// Verificar se o arquivo .pot já existe
	potFile := inputFile + ".pot"
	if _, err := os.Stat(potFile); os.IsNotExist(err) {
		// O arquivo .pot não existe, então executamos o xgettext
		fmt.Printf("%s Running xgettext for language %s...\n", yellow("[INFO]"), "en")
		cmd := exec.Command("xgettext", "--verbose", "--from-code=UTF-8", "--language=shell", "--keyword=gettext", "--output="+potFile, inputFile)
		cmd.Stdout = os.Stdout
		cmd.Stderr = os.Stderr
		if err := cmd.Run(); err != nil {
			log.Fatalf("%s Error running xgettext: %v\n", red("[ERROR]"), err)
		}
		if _, err := os.Stat(potFile); os.IsNotExist(err) {
			// O arquivo .pot não foi gerado
			log.Fatalf("%s Skipping proccess, %s not generated by xgettext \n", red("[ERROR]"), potFile)
			return
		}
	} else {
		fmt.Printf("%s Skipping xgettext, %s already exists\n", yellow("[INFO]"), potFile)
	}

	// Executar sed #1 e sed #2 uma vez no início
	fmt.Printf("%s Running sed #1 and sed #2...\n", yellow("[INFO]"))
	cmd := exec.Command("sed", "-i", "s/Content-Type: text\\/plain; charset=CHARSET\\\\n/Content-Type: text\\/plain; charset=UTF-8\\\\n/", inputFile+".pot")
	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr
	if err := cmd.Run(); err != nil {
		log.Fatalf("%s Error running sed #1: %v\n", red("[ERROR]"), err)
	}

	cmd = exec.Command("sed", "-i", "s/Language: \\n/Language: pt_BR\\n/", inputFile+".pot")
	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr
	if err := cmd.Run(); err != nil {
		log.Fatalf("%s Error running sed #2: %v\n", red("[ERROR]"), err)
	}
}

func translateMessage(msgid, languageCode string) string {
	var msgstr string
	msgid = strings.TrimSpace(msgid)
	if len(msgid) > 2 {
		msgid = strings.Trim(msgid, `"`)
		cmd := exec.Command("trans", "-no-autocorrect", "-b", ":"+languageCode, msgid)
		// output, err := cmd.CombinedOutput()
		output, err := cmd.Output()
		if err != nil {
			log.Fatalf("%s Error translating message: %v\n", red("[ERROR]"), err)
		}
		output = bytes.TrimSpace(output)
		msgstr = `"` + string(output) + `"`
	} else {
		msgstr = msgid
	}
	fmt.Printf("%s (%s)\t%s [len=%-3d] %s %s => %s\n", yellow("[INFO]"), cyan(languageCode), red("Translating msgid:"), len(msgid), msgid, green("to"), msgstr)
	return msgstr
}
