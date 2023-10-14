/*
   chili-tradutor-go - Command-line JSON processor, similar to jq
   go get github.com/go-ini/ini
   Chili GNU/Linux - https://github.com/vcatafesta/chili/go
   Chili GNU/Linux - https://chililinux.com
   Chili GNU/Linux - https://chilios.com.br

   Created: 2023/10/01
   Altered: 2023/10/14

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
	"github.com/spf13/pflag"

	//	"github.com/ogier/pflag"
	"log"
	"os"
	"os/exec"
	"strings"
	"sync"
)

const (
	_APP_     = "chili-tradutor-go"
	_VERSION_ = "1.2.1-20231014"
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
	IsForce bool
	logger  *log.Logger
)

func init() {
	// Abrir o arquivo de log para escrita. Se o arquivo não existir, ele será criado.
	logFile, err := os.OpenFile("/tmp/"+_APP_+".log", os.O_CREATE|os.O_APPEND|os.O_WRONLY, 0666)
	if err != nil {
		log.Fatalf("Erro ao abrir o arquivo de log: %v", err)
	}

	// Configurar o logger para escrever no arquivo
	logger = log.New(logFile, "", log.LstdFlags)

	// Exemplos de uso do logger
	logger.Printf("Inciando log formatado de : %s", _APP_)
}

func main() {
	// Use pflag em vez de flag para criar opções curtas e longas
	pflag.StringVarP(&inputFile, "inputfile", "i", "", "Input file")
	pflag.BoolVarP(&showVersion, "version", "V", false, "Show version")
	pflag.BoolVarP(&showHelp, "help", "h", false, "Show help")
	pflag.BoolVarP(&forceFlag, "force", "f", false, "Force flag")
	pflag.StringVarP(&languageCode, "language", "l", "", "Language code")
	//	pflag.Lookup("language").NoOptDefVal = "4321"

	pflag.Parse()
	for _, arg := range os.Args[1:] {
		switch arg {
		case "-V", "--version":
			fmt.Printf("Version: %s\n", _VERSION_)
			os.Exit(0)
		case "-h", "--help":
			usage()
			os.Exit(0)
		case "-f", "--force":
			IsForce = true
		}
	}

	if inputFile == "" || len(os.Args) < 2 {
		usage()
		os.Exit(1)
	}

	_, err := os.Stat(inputFile)
	if err != nil {
		if os.IsNotExist(err) {
			log.Fatalf("%s Arquivo informado não existe! %v\n", red("[ERROR]"), err)
			logger.Printf("%s Arquivo informado não existe! %v\n", red("[ERROR]"), err)
		} else {
			log.Fatalf("%s Ocorreu um erro ao verificar o arquivo! %v\n", red("[ERROR]"), err)
			logger.Printf("%s Ocorreu um erro ao verificar o arquivo! %v\n", red("[ERROR]"), err)
		}
	}

	if languageCode != "" {
		supportedLanguages = []string{ languageCode }
	}

	// Preparar o arquivo .pot uma vez no início
	fmt.Printf("%s Preparing %s.pot file...\n", cyan("[INFO]"), inputFile)
	logger.Printf("%s Preparing %s.pot file...\n", cyan("[INFO]"), inputFile)
	prepareGettext(inputFile)
	var wg sync.WaitGroup

	for _, lang := range supportedLanguages {
		wg.Add(1)
		go func(lang string) {
			defer wg.Done()
			if languageCode == "" || languageCode == lang {
				prepareMsginit(inputFile,lang)
				translateFile(inputFile, lang)
			}
		}(lang)
	}
	wg.Wait()
}

func prepareMsginit(inputFile,lang string) {
	// Verificar se o arquivo .pot já existe
	potFile := inputFile + ".pot"
	poFile := inputFile + ".po"
	if _, err := os.Stat(poFile); os.IsNotExist(err) || forceFlag {
		// O arquivo .po nao existe, então executamos o msginit
		fmt.Printf("%s Running msginit for language %s...\n", yellow("[INFO]"), "en")
		logger.Printf("%s Running msginit for language %s...\n", yellow("[INFO]"), "en")
		cmd := exec.Command("msginit", "--no-translator", "--locale="+lang, "--input="+potFile, "--output="+poFile)
//		cmd.Stdout = os.Stdout
//		cmd.Stderr = os.Stderr
//		cmd.Stdout = os.NewFile(0, "/dev/null")
//		cmd.Stderr = os.NewFile(0, "/dev/null")
		if err := cmd.Run(); err != nil {
			log.Fatalf("%s Error running msginit: %v\n", red("[ERROR]"), err)
			logger.Printf("%s Error running msginit: %v\n", red("[ERROR]"), err)
		}
		fmt.Printf("%s Catalog of messages initialized %s: %s\n", green("[SUCCESS]"), lang, poFile)
		logger.Printf("%s Catlog of messages initialized %s: %s\n", green("[SUCCESS]"), lang, poFile)
	}

	// Executar sed #1 e sed #2 uma vez no início
	fmt.Printf("%s Running sed #1...\n", yellow("[INFO]"))
	logger.Printf("%s Running sed #1 ...\n", yellow("[INFO]"))
	cmd := exec.Command("sed", "-i", "s|Content-Type: text/plain; charset=ASCII|Content-Type: text/plain; charset=utf-8|g", poFile)
	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr
	if err := cmd.Run(); err != nil {
		log.Fatalf("%s Error running sed #1: %v\n", red("[ERROR]"), err)
		logger.Printf("%s Error running sed #1: %v\n", red("[ERROR]"), err)
	}
}

func translateFile(inputFile, lang string) {
	translatedFile := fmt.Sprintf("%s-%s.po", inputFile, lang)

	// Abrir o arquivo .pot para leitura
	file, err := os.Open(inputFile + ".po")
	if err != nil {
		log.Fatalf("%s Error opening file: %v\n", red("[ERROR]"), err)
		logger.Printf("%s Error opening file: %v\n", red("[ERROR]"), err)
	}
	defer file.Close()

	// Abrir o arquivo .po para escrita
	outputFile, err := os.Create(translatedFile)
	if err != nil {
		log.Fatalf("%s Error creating file: %v\n", red("[ERROR]"), err)
		logger.Printf("%s Error creating file: %v\n", red("[ERROR]"), err)
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
		} else {
			fmt.Fprintln(outputFile, line)
		}
	}

	if err := scanner.Err(); err != nil {
		log.Fatalf("%s Error reading file: %v\n", red("[ERROR]"), err)
		logger.Printf("%s Error reading file: %v\n", red("[ERROR]"), err)
	}

	fmt.Printf("%s Translated to %s: %s\n", green("[SUCCESS]"), lang, translatedFile)
	logger.Printf("%s Translated to %s: %s\n", green("[SUCCESS]"), lang, translatedFile)
	writeMsgfmtToMo(translatedFile, inputFile, lang)
}

func writeMsgfmtToMo(translatedFile, inputFile, lang string) {
	directoryPath := "usr/share/locale/" + lang + "/LC_MESSAGES"
	err := os.MkdirAll(directoryPath, os.ModePerm)

	if err != nil {
		fmt.Printf("Ocorreu um erro ao criar o diretório: %v\n", err)
		logger.Printf("Ocorreu um erro ao criar o diretório: %v\n", err)
	} else {
		fmt.Printf("%s Diretório criado com sucesso. %s...\n", yellow("[INFO]"), directoryPath)
		logger.Printf("%s Diretório criado com sucesso. %s...\n", yellow("[INFO]"), directoryPath)
	}
	cmd := exec.Command("msgfmt", translatedFile, "-o", directoryPath+"/"+inputFile+".mo")
	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr
	if err := cmd.Run(); err != nil {
		log.Printf("%s Error running msgfmt: %v\n", red("[ERROR]"), err)
		logger.Printf("%s Error running msgfmt: %v\n", red("[ERROR]"), err)
	}
	fmt.Printf("%s Translated to %s: %s\n", green("[SUCCESS]"), lang, inputFile+".mo")
	logger.Printf("%s Translated to %s: %s\n", green("[SUCCESS]"), lang, inputFile+".mo")
}

func prepareGettext(inputFile string) {
	// Verificar se o arquivo inputFile existe
	if _, err := os.Stat(inputFile); os.IsNotExist(err) {
		log.Fatalf("%s Input file does not exist: %s\n", red("[ERROR]"), inputFile)
		logger.Printf("%s Input file does not exist: %s\n", red("[ERROR]"), inputFile)
	}

	// Verificar se o arquivo .pot já existe
	potFile := inputFile + ".pot"
	if _, err := os.Stat(potFile); os.IsNotExist(err) || forceFlag {
		// O arquivo .pot não existe, então executamos o xgettext
		fmt.Printf("%s Running xgettext for language %s...\n", yellow("[INFO]"), "en")
		logger.Printf("%s Running xgettext for language %s...\n", yellow("[INFO]"), "en")
		cmd := exec.Command("xgettext", "--verbose", "--from-code=UTF-8", "--language=shell", "--keyword=gettext", "--output="+potFile, inputFile)
		cmd.Stdout = os.Stdout
		cmd.Stderr = os.Stderr
		if err := cmd.Run(); err != nil {
			log.Fatalf("%s Error running xgettext: %v\n", red("[ERROR]"), err)
			logger.Printf("%s Error running xgettext: %v\n", red("[ERROR]"), err)
		}
		if _, err := os.Stat(potFile); os.IsNotExist(err) {
			// O arquivo .pot não foi gerado
			log.Fatalf("%s Skipping proccess, %s not generated by xgettext \n", red("[ERROR]"), potFile)
			logger.Printf("%s Skipping proccess, %s not generated by xgettext \n", red("[ERROR]"), potFile)
			return
		}
	} else {
		fmt.Printf("%s Skipping xgettext, %s already exists\n", yellow("[INFO]"), potFile)
		logger.Printf("%s Skipping xgettext, %s already exists\n", yellow("[INFO]"), potFile)
	}

	// Executar sed #1 e sed #2 uma vez no início
	fmt.Printf("%s Running sed #1 and sed #2...\n", yellow("[INFO]"))
	logger.Printf("%s Running sed #1 and sed #2...\n", yellow("[INFO]"))
	cmd := exec.Command("sed", "-i", "s/Content-Type: text\\/plain; charset=CHARSET\\\\n/Content-Type: text\\/plain; charset=UTF-8\\\\n/", potFile)
	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr
	if err := cmd.Run(); err != nil {
		log.Fatalf("%s Error running sed #1: %v\n", red("[ERROR]"), err)
		logger.Printf("%s Error running sed #1: %v\n", red("[ERROR]"), err)
	}

	cmd = exec.Command("sed", "-i", "s/Language: \\n/Language: pt_BR\\n/", potFile)
	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr
	if err := cmd.Run(); err != nil {
		log.Fatalf("%s Error running sed #2: %v\n", red("[ERROR]"), err)
		logger.Printf("%s Error running sed #2: %v\n", red("[ERROR]"), err)
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
			log.Printf("%s Error translating message: %v\n", red("[ERROR]"), err)
			logger.Printf("%s Error translating message: %v\n", red("[ERROR]"), err)
			msgstr = msgid
		} else {
			output = bytes.TrimSpace(output)
			msgstr = `"` + string(output) + `"`
		}
	} else {
		msgstr = msgid
	}
	fmt.Printf("%s (%s)\t%s [len=%-3d] %s %s => %s\n", yellow("[INFO]"), cyan(languageCode), red("Translating msgid:"), len(msgid), msgid, green("to"), msgstr)
	logger.Printf("%s (%s)\t%s [len=%-3d] %s %s => %s\n", yellow("[INFO]"), cyan(languageCode), red("Translating msgid:"), len(msgid), msgid, green("to"), msgstr)
	return msgstr
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
