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
	"io"

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
	_VERSION_ = "1.2.2-20231014"
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
	blue    = color.New(color.FgBlue).SprintFunc()
	white   = color.New(color.FgWhite).SprintFunc()
	black   = color.New(color.FgBlack).SprintFunc()
)
var (
	inputFile    string
	showVersion  bool
	showHelp     bool
	forceFlag    bool
	languageCode string
	languages    []string
)

var supportedLanguages = []string{
	"bg", "cs", "da", "de", "el", "en", "es", "et", "fi", "fr", "he", "hr", "hu", "is", "it", "ja",
	"ko", "nl", "no", "pl", "pt-PT", "pt-BR", "ro", "ru", "sk", "sv", "tr", "uk", "zh", "fa", "hi", "ar",
}

var (
	IsForce  bool
	logger   *log.Logger
	loggerMu sync.Mutex
)

func init() {
	fileLog := "/tmp/"+_APP_+".log"
	logFile, err := os.OpenFile(fileLog, os.O_CREATE|os.O_APPEND|os.O_WRONLY, 0666)
	if err != nil {
		log.Fatalf("Erro ao abrir o arquivo de log: %v", err)
	}
	// defer logFile.Close()

	//	Configurar o logger para escrever no arquivo
	//	logger = log.New(logFile, "", log.LstdFlags)
	//	logger = log.New(io.MultiWriter(os.Stdout, logFile), "[INFO] ", log.LstdFlags)
	//	logger = log.New(io.MultiWriter(os.Stdout, logFile), "", log.LstdFlags)
	logger = log.New(io.MultiWriter(os.Stdout, logFile), "", 0) // O 0 desabilita o timestamp

	// Exemplos de uso do logger
	logger.Printf("Iniciando log formatado em : %s", fileLog)
}

func main() {
	// Use pflag em vez de flag para criar opções curtas e longas
	pflag.StringVarP(&inputFile, "inputfile", "i", "", "Input file")
	pflag.BoolVarP(&showVersion, "version", "V", false, "Show version")
	pflag.BoolVarP(&showHelp, "help", "h", false, "Show help")
	pflag.BoolVarP(&forceFlag, "force", "f", false, "Force flag")
	//	pflag.StringVarP(&languageCode, "language", "l", "", "Language code")
	pflag.StringSliceVarP(&languages, "language", "l", nil, "Language code")
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
			logger.Printf("%s Arquivo informado não existe! %v\n", red("[ERROR]"), err)
		} else {
			logger.Printf("%s Ocorreu um erro ao verificar o arquivo! %v\n", red("[ERROR]"), err)
		}
	}

	//	if languageCode != "" {
	//		supportedLanguages = []string{languageCode}
	//	}
	if len(languages) != 0 {
		supportedLanguages = languages
	}

	if len(supportedLanguages) > 0 {
		logger.Printf("%s Preparando arquivo: %s.pot\n", cyan("[INFO]"), inputFile)
		prepareGettext(inputFile)
		var wg sync.WaitGroup

		for _, lang := range supportedLanguages {
			wg.Add(1)
			go func(lang string) {
				defer wg.Done()
				if languageCode == "" || languageCode == lang {
					prepareMsginit(inputFile, lang)
					translateFile(inputFile, lang)
					writeMsgfmtToMo(inputFile, lang)
					os.Remove(fmt.Sprintf("%s-temp-%s.po", inputFile, lang))
				}
			}(lang)
		}
		wg.Wait()
	}
}

func prepareMsginit(inputFile, lang string) {
	potFile := inputFile + ".pot"
	poFile := fmt.Sprintf("%s-%s.po", inputFile, lang)
	poFileTmp := fmt.Sprintf("%s-temp-%s.po", inputFile, lang)

	if _, err := os.Stat(poFile); os.IsNotExist(err) || forceFlag {
		logger.Printf("%s Rodando msginit para o idioma: %s\n", cyan("[INFO]"), lang)
		cmd := exec.Command("msginit", "--no-translator", "--locale="+lang, "--input="+potFile, "--output="+poFileTmp)

		if err := cmd.Run(); err != nil {
			logger.Printf("%s Error running msginit: %v\n", red("[ERROR]"), err)
		}
		logger.Printf("%s Catalogo de mensagens inicializado para %s: %s\n", green("[ OK ]"), lang, poFileTmp)

		logger.Printf("%s Rodando sed #1 em %s\n", cyan("[INFO]"), poFileTmp)
		cmd = exec.Command("sed", "-i", "s|Content-Type: text/plain; charset=ASCII|Content-Type: text/plain; charset=utf-8|g", poFileTmp)

		if err := cmd.Run(); err != nil {
			logger.Printf("%s Error running sed #1: %v\n", red("[ERROR]"), err)
		}
	}
}

func translateFile(inputFile, lang string) {
	translatedFile := fmt.Sprintf("%s-%s.po", inputFile, lang)
	poFileTemp := fmt.Sprintf("%s-temp-%s.po", inputFile, lang)

	if _, err := os.Stat(translatedFile); !os.IsNotExist(err) && !forceFlag {
		logger.Printf("%s Pulando %s, arquivo existe.\n", cyan("[INFO]"), translatedFile)
		return
	}

	// Abrir o arquivo .po para leitura
	file, err := os.Open(poFileTemp)
	if err != nil {
		logger.Printf("%s Error opening file: %v\n", red("[ERROR]"), err)
	}
	defer file.Close()

	// Abrir o arquivo .po para escrita
	outputFile, err := os.Create(translatedFile)
	if err != nil {
		logger.Printf("%s Error creating file: %v\n", red("[ERROR]"), err)
	}
	defer outputFile.Close()

	// Criar um scanner para ler o arquivo .po
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
		logger.Printf("%s Error reading file: %v\n", red("[ERROR]"), err)
	}

	logger.Printf("%s Traduzido para %s: %s\n", green("[SUCCESS]"), lang, translatedFile)
}

func writeMsgfmtToMo(inputFile, lang string) {
	directoryPath := "usr/share/locale/" + lang + "/LC_MESSAGES"
	translatedFile := fmt.Sprintf("%s-%s.po", inputFile, lang)
	moFile := fmt.Sprintf("%s/%s.mo", directoryPath, inputFile)

	if err := os.MkdirAll(directoryPath, os.ModePerm); err != nil {
		logger.Printf("%s Ocorreu um erro ao tentar criar o diretório: %v\n", red("[ERROR]"), err)
		return
	}
	logger.Printf("%s Diretório criado com sucesso: %s\n", cyan("[INFO]"), directoryPath)

	cmd := exec.Command("msgfmt", "-v", translatedFile, "-o", moFile)
	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr
	if err := cmd.Run(); err != nil {
		logger.Printf("%s Error running msgfmt: %v\n", red("[ERROR]"), err)
		return
	}
	logger.Printf("%s Translated to language %s: %s\n", green("[SUCCESS]"), lang, moFile)
}

func prepareGettext(inputFile string) {
	potFile := inputFile + ".pot"

	// Verificar se o arquivo .pot já existe
	if _, err := os.Stat(potFile); os.IsNotExist(err) || forceFlag {
		logger.Printf("%s Rodando xgettext em: %s\n", cyan("[INFO]"), inputFile)
		cmd := exec.Command("xgettext", "--verbose", "--from-code=UTF-8", "--language=shell", "--keyword=gettext", "--output="+potFile, inputFile)
		cmd.Stdout = os.Stdout
		cmd.Stderr = os.Stderr
		if err := cmd.Run(); err != nil {
			logger.Printf("%s => running xgettext: %v\n", red("[ERROR]"), err)
			os.Exit(1)
		}
		if _, err := os.Stat(potFile); os.IsNotExist(err) {
			logger.Printf("%s => xgettext não gerou '%s': (%s)\n", red("[ERROR]"), potFile, err)
			os.Exit(1)
		}
	} else {
		logger.Printf("%s Pulando xgettext, %s já existe!\n", cyan("[INFO]"), potFile)
	}

	logger.Printf("%s Rodando sed passo #1\n", cyan("[INFO]"))
	cmd := exec.Command("sed", "-i", "s/Content-Type: text\\/plain; charset=CHARSET\\\\n/Content-Type: text\\/plain; charset=UTF-8\\\\n/", potFile)
	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr
	if err := cmd.Run(); err != nil {
		logger.Printf("%s Error running sed #1: %v\n", red("[ERROR]"), err)
	}

	logger.Printf("%s Rodando sed passo #2\n", cyan("[INFO]"))
	cmd = exec.Command("sed", "-i", "s/Language: \\n/Language: pt_BR\\n/", potFile)
	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr
	if err := cmd.Run(); err != nil {
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
			logger.Printf("%s Error translating message: %v\n", red("[ERROR]"), err)
			msgstr = msgid
		} else {
			output = bytes.TrimSpace(output)
			msgstr = `"` + string(output) + `"`
		}
	} else {
		msgstr = msgid
	}
	logger.Printf("%s (%s)\t%s [len=%-3d] %s %s => %s\n", cyan("[INFO]"), cyan(languageCode), red("Translating msgid:"), len(msgid), msgid, green("to"), msgstr)
	return msgstr
}

func usage() {
	fmt.Println("Usage: chili-tradutor-go -i <input_file> [-V] [-h] [-f] [-l <en,fr,es,...>]")
	fmt.Fprintf(os.Stderr, "  --i, --inputfile          Input file\n")
	fmt.Fprintf(os.Stderr, "  --V, --version            Show version\n")
	fmt.Fprintf(os.Stderr, "  --h, --help               Show help\n")
	fmt.Fprintf(os.Stderr, "  --f, --force              Force flag\n")
	fmt.Fprintf(os.Stderr, "  --l, --language           Language code\n")
}
