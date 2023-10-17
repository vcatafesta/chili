/*
   chili-tradutor-go - Command-line JSON processor, similar to jq
   go get github.com/go-ini/ini
   Chili GNU/Linux - https://github.com/vcatafesta/chili/go
   Chili GNU/Linux - https://chililinux.com
   Chili GNU/Linux - https://chilios.com.br

   Created: 2023/10/01
   Altered: 2023/10/16

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
	cyan    = color.New(color.Bold, color.FgCyan).SprintFunc()
	orange  = color.New(color.FgYellow).SprintFunc()
	yellow  = color.New(color.Bold, color.FgYellow).SprintFunc()
	green   = color.New(color.FgGreen).SprintFunc()
	magenta = color.New(color.FgMagenta).SprintFunc()
	red     = color.New(color.FgRed).SprintFunc()
	boldred = color.New(color.Bold, color.FgRed).SprintFunc()
	blue    = color.New(color.FgBlue).SprintFunc()
	white   = color.New(color.FgWhite).SprintFunc()
	black   = color.New(color.Bold, color.FgBlack).SprintFunc()
	success = color.New(color.Bold, color.FgGreen).FprintlnFunc()
	notice  = color.New(color.Bold, color.FgGreen).PrintlnFunc()
)
var (
	inputFile    string
	showVersion  bool
	showHelp     bool
	forceFlag    bool
	quietFlag    bool
	verboseFlag  bool
	nocolorFlag  bool
	languageCode string
	languages    []string
)

var supportedLanguages = []string{
	"ar",
	"bg",
	"cs",
	"da", "de",
	"el", "en", "es", "et",
	"fa", "fi", "fr",
	"he", "hi", "hr", "hu",
	"is", "it",
	"ja",
	"ko",
	"nl", "no",
	"pl", "pt-PT", "pt-BR",
	"ro", "ru",
	"sk", "sv",
	"tr",
	"uk",
	"zh",
}

var (
	IsForce  bool
	logger   *log.Logger
	loggerMu sync.Mutex
)

func init() {

}

func confLog() {
	fileLog := "/tmp/" + _APP_ + ".log"
	logFile, err := os.OpenFile(fileLog, os.O_CREATE|os.O_APPEND|os.O_WRONLY, 0666)
	if err != nil {
		log.Fatalf("Erro ao abrir o arquivo de log: %v", err)
	}
	// defer logFile.Close()

	//	Configurar o logger para escrever no arquivo
	//	logger = log.New(logFile, "", log.LstdFlags)
	//	logger = log.New(io.MultiWriter(os.Stdout, logFile), "[INFO] ", log.LstdFlags)
	//	logger = log.New(io.MultiWriter(os.Stdout, logFile), "", log.LstdFlags)

	if quietFlag {
		logger = log.New(logFile, "", 0)
	} else {
		logger = log.New(io.MultiWriter(os.Stdout, logFile), "", 0) // O 0 desabilita o timestamp
	}

	logger.Printf("%s Iniciando log: %s", black("[LOG]"), magenta(fileLog))
}

func main() {
	// Use pflag em vez de flag para criar opções curtas e longas
	pflag.StringVarP(&inputFile, "inputfile", "i", "", "Arquivo de entrada")
	pflag.BoolVarP(&showVersion, "version", "V", false, "Mostar versão")
	pflag.BoolVarP(&showHelp, "help", "h", false, "Mostrar help")
	pflag.BoolVarP(&forceFlag, "force", "f", false, "Forçar")
	pflag.BoolVarP(&quietFlag, "quiet", "q", false, "Modo quieto")
	pflag.BoolVarP(&verboseFlag, "verbose", "v", false, "Modo verbose")
	pflag.BoolVarP(&nocolorFlag, "nocolor", "n", false, "Desliga saida em cores")
	//	pflag.StringVarP(&languageCode, "language", "l", "", "Language code")
	pflag.StringSliceVarP(&languages, "language", "l", nil, "Idiomas")
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

	confLog()
	if nocolorFlag {
		color.NoColor = true // disables colorized output
	}

	if inputFile == "" || len(os.Args) < 2 {
		usage()
		os.Exit(1)
	}

	_, err := os.Stat(inputFile)
	if err != nil {
		if os.IsNotExist(err) {
			logger.Printf("%s Arquivo informado não existe: %v\n", red("[ERROR]"), err)
		} else {
			logger.Printf("%s Erro ao verificar o arquivo: %v\n", red("[ERROR]"), err)
		}
	}

	//	if languageCode != "" {
	//		supportedLanguages = []string{languageCode}
	//	}
	if len(languages) != 0 {
		supportedLanguages = languages
	}

	if len(supportedLanguages) > 0 {
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

	if quietFlag {
		fmt.Printf("%s Inicializando catalogo de mensagens para o idioma '%s'\n", green("[MSGINIT]"), cyan(lang))
	}

	if _, err := os.Stat(poFile); os.IsNotExist(err) || forceFlag {
		logger.Printf("%s Rodando msginit para o idioma: '%s'\n", black("[MSGINIT]"), cyan(lang))
		cmd := exec.Command("msginit", "--no-translator", "--locale="+lang, "--input="+potFile, "--output="+poFileTmp)

		if err := cmd.Run(); err != nil {
			logger.Printf("%s Erro ao executar 'msginit': %v\n", red("[MSGINIT]"), err)
		}
		logger.Printf("%s Catalogo de mensagens para o idioma '%s' inicializado: %s\n", green("[MSGINIT]"), cyan(lang), magenta(poFileTmp))

		logger.Printf("%s Rodando '%s' em: %s\n", black("[MSGINIT]"), black("sed"), magenta(poFileTmp))
		cmd = exec.Command("sed", "-i", "s|Content-Type: text/plain; charset=ASCII|Content-Type: text/plain; charset=utf-8|g", poFileTmp)

		if err := cmd.Run(); err != nil {
			logger.Printf("%s Erro ao executar '%s': %v\n", red("[SED]"), black("sed"), err)
		}
	}
}

func translateFile(inputFile, lang string) {
	translatedFile := fmt.Sprintf("%s-%s.po", inputFile, lang)
	poFileTemp := fmt.Sprintf("%s-temp-%s.po", inputFile, lang)

	if quietFlag {
		fmt.Printf("%s Traduzindo mensagens para o idioma: '%s'\n", black("[TRANS]"), cyan(lang))
	}

	if _, err := os.Stat(translatedFile); !os.IsNotExist(err) && !forceFlag {
		logger.Printf("%s Pulando %s, arquivo existe.\n", cyan("[TRANS]"), translatedFile)
		return
	}

	file, err := os.Open(poFileTemp)
	if err != nil {
		logger.Printf("%s Erro ao abrir arquivo: %v\n", red("[ERROR]"), err)
	}
	defer file.Close()

	outputFile, err := os.Create(translatedFile)
	if err != nil {
		logger.Printf("%s Erro ao criar arquivo: %v\n", red("[ERROR]"), err)
	}
	defer outputFile.Close()

	scanner := bufio.NewScanner(file)
	var msgidLines []string
	var isMsgid bool

	logger.Printf("%s Traduzindo mensagens para o idioma: '%s'\n", black("[TRANS]"), cyan(lang))
	for scanner.Scan() {
		line := scanner.Text()
		if strings.HasPrefix(line, "msgid ") {
			isMsgid = true
			msgidLines = []string{strings.TrimPrefix(line, "msgid ")}
		} else if strings.HasPrefix(line, "msgstr ") && isMsgid {
			msgstr := translateMessage(strings.Join(msgidLines, "\n"), lang)
			fmt.Fprintf(outputFile, "msgid %s\nmsgstr %s\n\n", strings.Join(msgidLines, "\n"), msgstr)

			isMsgid = false
			msgidLines = nil
		} else if isMsgid {
			msgidLines = append(msgidLines, line)
		} else {
			fmt.Fprintln(outputFile, line)
		}
	}

	if err := scanner.Err(); err != nil {
		logger.Printf("%s Erro ao ler o arquivo: [%v]\n", red("[ERROR]"), err)
	}
	logger.Printf("%s Traduzido para o idioma: '%s' [%s]\n", green("[TRANS]"), cyan(lang), translatedFile)
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
			logger.Printf("%s Erro (%v) ao traduzir mensagem para o idioma: '%s', tentando novamente...\n", red("[TRANS]"), red(err), cyan(languageCode))
			cmd := exec.Command("trans", "-no-autocorrect", "-b", ":"+languageCode, msgid)
			// output, err := cmd.CombinedOutput()
			output, err := cmd.Output()
			if err != nil {
				logger.Printf("%s Erro ao traduzir a mensagem, usando original: %v\n", red("[TRANS]"), err)
				msgstr = msgid
			} else {
				output = bytes.TrimSpace(output)
				msgstr = `"` + string(output) + `"`
			}
		} else {
			output = bytes.TrimSpace(output)
			msgstr = `"` + string(output) + `"`
		}
	} else {
		msgstr = msgid
	}
	if verboseFlag {
		logger.Printf("%s (%s)\t%s [len=%-3d] %s %s => %s\n", orange("[TRANS]"), cyan(languageCode), yellow("Traduzindo msgid:"), len(msgid), msgid, green("to"), msgstr)
	}
	return msgstr
}

func writeMsgfmtToMo(inputFile, lang string) {
	directoryPath := "usr/share/locale/" + lang + "/LC_MESSAGES"
	translatedFile := fmt.Sprintf("%s-%s.po", inputFile, lang)
	moFile := fmt.Sprintf("%s/%s.mo", directoryPath, inputFile)
	var cmd *exec.Cmd

	if err := os.MkdirAll(directoryPath, os.ModePerm); err != nil {
		logger.Printf("%s Ocorreu erro ao criar o diretório: %v\n", red("[MSGFMT]"), err)
		os.Exit(1)
	}
	logger.Printf("%s Diretório criado com sucesso: %s\n", green("[MSGFMT]"), directoryPath)

	cmd = exec.Command("msgfmt", translatedFile, "-o", moFile)
	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr
	if err := cmd.Run(); err != nil {
		logger.Printf("%s Erro ao executar 'msgfmt': %v\n", red("[MSGFMT]"), err)
		os.Exit(1)
	}
	if quietFlag {
		fmt.Printf("%s Traduzido para o idioma '%s':\t%s\n", green("[MSGFMT]"), cyan(lang), magenta(moFile))
	} else {
		logger.Printf("%s Traduzido para o idioma '%s':\t%s\n", green("[MSGFMT]"), cyan(lang), magenta(moFile))
	}
}

func prepareGettext(inputFile string) {
	potFile := inputFile + ".pot"
	logger.Printf("%s Preparando arquivo: %s\n", black("[XGETTEXT]"), magenta(potFile))

	// Verificar se o arquivo .pot já existe
	if _, err := os.Stat(potFile); os.IsNotExist(err) || forceFlag {
		logger.Printf("%s Rodando xgettext em: %s\n", black("[XGETTEXT]"), magenta(inputFile))
		cmd := exec.Command("xgettext", "--verbose", "--from-code=UTF-8", "--language=shell", "--keyword=gettext", "--output="+potFile, inputFile)
		cmd.Stdout = os.Stdout
		cmd.Stderr = os.Stderr
		if err := cmd.Run(); err != nil {
			logger.Printf("%s => executando 'xgettext': %v\n", red("[XGETTEXT]"), err)
			os.Exit(1)
		}
		if _, err := os.Stat(potFile); os.IsNotExist(err) {
			logger.Printf("%s => xgettext não gerou '%s': (%s)\n", red("[XGETTEXT]"), potFile, err)
			os.Exit(1)
		}
	} else {
		logger.Printf("%s Pulando xgettext, %s já existe!\n", cyan("[XGETTEXT]"), potFile)
	}

	logger.Printf("%s Rodando '%s' passo #1\n", black("[XGETTEXT]"), cyan("sed"))
	cmd := exec.Command("sed", "-i", "s/Content-Type: text\\/plain; charset=CHARSET\\\\n/Content-Type: text\\/plain; charset=UTF-8\\\\n/", potFile)
	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr
	if err := cmd.Run(); err != nil {
		logger.Printf("%s Erro (%v) ao executar '%s' passo #1\n", red("[SED]"), red(err), cyan("sed"))
	}

	logger.Printf("%s Rodando '%s' passo #2\n", black("[XGETTEXT]"), cyan("sed"))
	cmd = exec.Command("sed", "-i", "s/Language: \\n/Language: pt_BR\\n/", potFile)
	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr
	if err := cmd.Run(); err != nil {
		logger.Printf("%s Erro (%v) ao executar '%s' passo #2\n", red("[SED]"), red(err), cyan("sed"))
	}
}

func usage() {
	fmt.Println("Uso: chili-tradutor-go -i <input_file> [-q] [-V] [-h] [-f] [-l <en,fr,es,...>]")
	fmt.Fprintf(os.Stderr, "  --i, --inputfile          Input file\n")
	fmt.Fprintf(os.Stderr, "  --V, --version            Show version\n")
	fmt.Fprintf(os.Stderr, "  --h, --help               Show help\n")
	fmt.Fprintf(os.Stderr, "  --f, --force              Force flag\n")
	fmt.Fprintf(os.Stderr, "  --q, --quiet              Quiet flag\n")
	fmt.Fprintf(os.Stderr, "  --l, --language           Language code\n")
}
