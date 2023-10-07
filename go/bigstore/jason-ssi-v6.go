/*
 *	  big-pacman-to-json - process output pacman to json
 *	  go get github.com/go-ini/ini
 *    Chili GNU/Linux - https://github.com/vcatafesta/chili/go
 *    Chili GNU/Linux - https://chililinux.com
 *    Chili GNU/Linux - https://chilios.com.br
 *
 *    Created: 2023/10/01
 *    Altered: 2023/10/07
 *
 *    Copyright (c) 2023-2023, Vilmar Catafesta <vcatafesta@gmail.com>
 *    All rights reserved.
 *
 *    Redistribution and use in source and binary forms, with or without
 *    modification, are permitted provided that the following conditions
 *    are met:
 *    1. Redistributions of source code must retain the above copyright
 *        notice, this list of conditions and the following disclaimer.
 *    2. Redistributions in binary form must reproduce the above copyright
 *        notice, this list of conditions and the following disclaimer in the
 *        documentation and/or other materials provided with the distribution.
 *
 *    THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR
 *    IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
 *    OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
 *    IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
 *    INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
 *    NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 *    DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 *    THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 *    (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
 *    THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

package main

import (
	"bufio"
	"encoding/json"
	"fmt"
	"log"
	"os"
	"os/exec"
	"strings"
)

const (
	_APP_     = "big-pacman-to-json"
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

type PackageInfoSearch struct {
	Name        string `json:"name"`
	Version     string `json:"version"`
	Size        string `json:"size"`
	Status      string `json:"status"`
	Description string `json:"description"`
}

type PackageInfo struct {
	Repository    string   `json:"Repository"`
	Name          string   `json:"Name"`
	Version       string   `json:"Version"`
	Description   string   `json:"Description"`
	Architecture  string   `json:"Architecture"`
	URL           string   `json:"URL"`
	Licenses      []string `json:"Licenses"`
	Groups        string   `json:"Groups"`
	Provides      string   `json:"Provides"`
	DependsOn     []string `json:"DependsOn"`
	OptionalDeps  []string `json:"OptionalDeps"`
	RequiredBy    []string `json:"RequiredBy"`
	ConflictsWith string   `json:"ConflictsWith"`
	Replaces      string   `json:"Replaces"`
	DownloadSize  string   `json:"DownloadSize"`
	InstalledSize string   `json:"InstalledSize"`
	Packager      string   `json:"Packager"`
	BuildDate     string   `json:"BuildDate"`
	MD5Sum        string   `json:"MD5Sum"`
	SHA256Sum     string   `json:"SHA256Sum"`
	Signatures    string   `json:"Signatures"`
}

type PackageData struct {
	Name    string      `json:"Name"`
	Package PackageInfo `json:"Package"`
}

var (
	Advanced bool = false
)

func main() {
	var input string

	stat, _ := os.Stdin.Stat()
	if (stat.Mode() & os.ModeCharDevice) == 0 {
		scanner := bufio.NewScanner(os.Stdin)
		for scanner.Scan() {
			input += scanner.Text() + "\n"
		}
		xcmd := "paru"
		// Processa a entrada
		ProcessOutputSearch(input, xcmd)
	} else if len(os.Args) > 1 {
		// Percorre os argumentos usando um loop for
		for _, arg := range os.Args {
			// Testa se ten argumento igual a "-Sii" ou "-Si"
			if arg == "-Sii" {
				Advanced = true
			} else if arg == "-Si" {
				Advanced = true
			} else if arg == "-V" || arg == "--version" {
				fmt.Printf("%s v%s\n", _APP_, _VERSION_)
				fmt.Printf("%s\n", _COPY_)
				os.Exit(0)
			} else if arg == "-h" || arg == "--help" {
				usage(true)
			}
		}

		if len(os.Args) >= 3 {
			// Os argumentos a partir do segundo são as entradas, processa-os
			args := os.Args[1:]
			xcmd := os.Args[1]
			cmd := exec.Command(args[0], args[1:]...) // Executa o comando com os argumentos
			output, err := cmd.CombinedOutput()
			if err != nil {
				log.Printf("%sErro ao executar o comando: %s'%s' - %s%v%s\n", Red, Cyan, os.Args[1:], Yellow, err, Reset)
				return
			}
			input = string(output)
			if Advanced {
				// Chame a função ProcessOutput com a saída do comando como argumento
				ProcessOutput(input)
			} else {
				// Chame a função ProcessOutputSearch com a saída do comando como argumento
				ProcessOutputSearch(input, xcmd)
			}
		} else {
			usage(false)
		}
	} else {
		log.Printf("%sErro: nenhuma operação/entrada especificada (use -h para obter ajuda)%s", Red, Reset)
		os.Exit(1)
	}
}

func usage(IsValidParameter bool) {
	boolToInt := func(value bool) int {
		if value {
			return 0
		}
		return 1
	}

	if IsValidParameter == false {
		log.Printf("%sErro: Parâmetro(s) inválido(s) %s'%s'%s\n", Red, Cyan, os.Args[1:], Reset)
	}
	fmt.Printf("Uso:%s %s%s {<comando>}%s\n", Red, _APP_, Cyan, Reset)
	fmt.Printf("comandos:\n")
	fmt.Printf("     %s {-h --help}\n", _APP_)
	fmt.Printf("     %s {-v --version}\n", _APP_)
	fmt.Printf("     %s {pacman -Ss <regex>}\n", _APP_)
	fmt.Printf("     %s {pacman -Qm}\n", _APP_)
	fmt.Printf("     %s {pacman -Qn}\n", _APP_)
	fmt.Printf("     LC_ALL=C %s {pacman -Si [<pacote> [<...>]}\n", _APP_)
	fmt.Printf("     LC_ALL=C %s {pacman -Sii [<pacote> [<...>]}\n", _APP_)
	fmt.Printf("     %s {pacman -Ss <regex>}\n", _APP_)
	fmt.Printf("     %s {paru -Ssa [<pacote> [<...>]}\n", _APP_)
	fmt.Printf("     %s {paru -Ss [<pacote> [<...>]}\n", _APP_)
	fmt.Printf("     %s {yay -Ss [<pacote> [<...>]}\n", _APP_)
	fmt.Printf("     LC_ALL=C %s {yay -Sii [<pacote> [<...>]}\n", _APP_)
	os.Exit(boolToInt(IsValidParameter))
}

func ProcessOutput(output string) {
	var packageInfos = make(map[string]PackageInfo) // Inicialize o mapa

	lines := strings.Split(output, "\n")
	var currentPackage PackageInfo

	for _, line := range lines {
		parts := strings.SplitN(line, ":", 2)
		if len(parts) == 2 {
			key := strings.TrimSpace(parts[0])
			value := strings.TrimSpace(parts[1])

			switch key {
			case "Repository":
				currentPackage.Repository = value
			case "Name":
				currentPackage.Name = value
			case "Version":
				currentPackage.Version = value
			case "Description":
				currentPackage.Description = value
			case "Architecture":
				currentPackage.Architecture = value
			case "URL":
				currentPackage.URL = value
			case "Licenses":
				licenses := strings.Split(value, " ")
				currentPackage.Licenses = append(currentPackage.Licenses, licenses...)
			case "Groups":
				currentPackage.Groups = value
			case "Provides":
				currentPackage.Provides = value
			case "Depends On":
				dependencies := strings.Fields(value)
				currentPackage.DependsOn = append(currentPackage.DependsOn, dependencies...)
			case "Optional Deps":
				optionalDeps := strings.Fields(value)
				currentPackage.OptionalDeps = append(currentPackage.OptionalDeps, optionalDeps...)
			case "Required By":
				requiredBy := strings.Fields(value)
				currentPackage.RequiredBy = append(currentPackage.RequiredBy, requiredBy...)
			case "Conflicts With":
				currentPackage.ConflictsWith = value
			case "Replaces":
				currentPackage.Replaces = value
			case "Download Size":
				currentPackage.DownloadSize = value
			case "Installed Size":
				currentPackage.InstalledSize = value
			case "Packager":
				currentPackage.Packager = value
			case "Build Date":
				currentPackage.BuildDate = value
			case "MD5 Sum":
				currentPackage.MD5Sum = value
			case "SHA-256 Sum":
				currentPackage.SHA256Sum = value
			case "Signatures":
				currentPackage.Signatures = value
			}
		} else if len(parts) == 1 && len(parts[0]) == 0 && currentPackage.Name != "" {
			packageInfos[currentPackage.Name] = currentPackage
			currentPackage = PackageInfo{}
		}
	}

	// Salva no arquivo
	outputFilename := "/tmp/" + _APP_ + ".json"
	file, err := os.Create(outputFilename)
	if err != nil {
		log.Printf("%sErro ao criar arquivo JSON: %v%s\n", Red, err, Reset)
		os.Exit(1)
	}
	defer file.Close()

	encoder := json.NewEncoder(file)
	encoder.SetIndent("", "    ")
	if err := encoder.Encode(packageInfos); err != nil {
		log.Printf("%sErro ao escrever no arquivo JSON: %v%s\n", Red, err, Reset)
		os.Exit(1)
	}

	// Converte a lista de pacotes em formato JSON
	jsonData, err := json.Marshal(packageInfos)
	if err != nil {
		log.Printf("%sErro ao serializar para JSON: %v%s\n", Red, err, Reset)
		os.Exit(1)
	}

	// Imprime os dados JSON na saída padrão
	fmt.Println(string(jsonData))
	os.Exit(0)
}

func ProcessOutputSearch(input, xcmd string) {
	// Variáveis para manter as informações do pacote
	var packages []PackageInfoSearch
	var currentPackage PackageInfoSearch
	IsDescription := false
	IsName := false

	// Divide o texto de entrada em linhas
	lines := strings.Split(input, "\n")

	// Processa cada linha da entrada
	for _, line := range lines {
		// Verifica se a linha começa com 2 espaços iniciais (indica descrição)
		if strings.HasPrefix(line, "  ") && IsName == true {
			line = strings.TrimSpace(line)
			currentPackage.Description += line
			IsDescription = true
		} else if IsName == true {
			IsDescription = true
		} else if IsName == false {
			// Divide a linha em campos e verifica se há pelo menos 2 campos (nome e versão)
			fields := strings.Fields(line)
			if len(fields) >= 1 {
				currentPackage.Name = fields[0]
				currentPackage.Version = fields[1]

				switch xcmd {
				case "paru":
					if len(fields) >= 3 {
						currentPackage.Size = fields[2]
					}
					if len(fields) >= 4 {
						currentPackage.Size += " " + fields[3]
					}
					if len(fields) >= 5 {
						currentPackage.Status = fields[4]
					}
				case "pacman":
					if len(fields) >= 3 {
						currentPackage.Status = fields[2]
					}
					if len(fields) >= 4 {
						currentPackage.Status += " " + fields[3]
					}
				case "pamac":
					if len(fields) >= 3 {
						currentPackage.Status = fields[2]
					}
				default:
					if len(fields) >= 3 {
						currentPackage.Status = fields[2]
					}
				}
				IsName = true
			}
		}
		// Se a linha não começar com 2 espaços, isso indica o início de um novo pacote
		if IsDescription == true && IsName == true {
			packages = append(packages, currentPackage)
			currentPackage = PackageInfoSearch{}
			IsDescription = false
			IsName = false
		}
	}

	// Certifique-se de adicionar o último pacote à lista
	if currentPackage.Name != "" {
		packages = append(packages, currentPackage)
	}

	// Converte a lista de pacotes em formato JSON
	jsonData, err := json.Marshal(packages)
	if err != nil {
		log.Printf("%sErro ao serializar para JSON: %v%s\n", Red, err, Reset)
		os.Exit(1)
	}

	// Imprime os dados JSON na saída padrão
	fmt.Println(string(jsonData))
	os.Exit(0)
}
