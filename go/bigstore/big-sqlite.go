/*
    big-sqlite - search/add into sqlite bigstore
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
	"database/sql"
	"encoding/json"
	"fmt"
	"github.com/ogier/pflag" // Importe o pacote pflag
	"io/ioutil"
	"log"
	"os"
	//	"flag"
	_ "github.com/mattn/go-sqlite3" // Importe o driver SQLite3
	"path/filepath"
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

// Estrutura de dados para armazenar informações do pacote
type PackageInfo struct {
	ID      int
	Name    string
	Desc    string
	Summary string
}

// Função para criar a tabela no banco de dados, se não existir
func createTable(db *sql.DB) error {
	createTableSQL := `
        CREATE TABLE IF NOT EXISTS flatpak (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            package TEXT,
            desc TEXT,
            summary TEXT
        );
    `
	_, err := db.Exec(createTableSQL)
	return err
}

// Função para inserir informações do pacote no banco de dados
func insertPackageInfo(db *sql.DB, pkg PackageInfo) error {
	insertSQL := `
        INSERT INTO flatpak (package, desc, summary)
        VALUES (?, ?, ?)
    `
	_, err := db.Exec(insertSQL, pkg.Name, pkg.Desc, pkg.Summary)
	return err
}

// Função para verificar se um pacote já existe no banco de dados
func packageExists(db *sql.DB, packageName string) (bool, error) {
	query := "SELECT COUNT(*) FROM flatpak WHERE package = ?"
	var count int
	err := db.QueryRow(query, packageName).Scan(&count)
	if err != nil {
		return false, err
	}
	return count > 0, nil
}

// Função principal para processar pacotes
func processPackages(rootDir string, db *sql.DB, quiet bool) {
	dirs, err := ioutil.ReadDir(rootDir)
	count := 0
	if err != nil {
		log.Fatalf("Erro ao listar diretórios: %v\n", err)
	}

	for _, dir := range dirs {
		if dir.IsDir() {
			packageName := dir.Name()

			// Define os caminhos para os arquivos 'desc' e 'summary'
			//			dirPath := filepath.Join(rootDir, packageName, "pt_BR")
			descFile := filepath.Join(rootDir, packageName, "pt_BR", "desc")
			summaryFile := filepath.Join(rootDir, packageName, "pt_BR", "summary")
			count++

			// Verifica se os arquivos 'desc' e 'summary' existem
			_, err := os.Stat(descFile)
			if os.IsNotExist(err) {
				log.Printf("Arquivo 'desc' não encontrado em: %s\n", descFile)
				//				continue
			}

			_, err = os.Stat(summaryFile)
			if os.IsNotExist(err) {
				log.Printf("Arquivo 'summary' não encontrado em: %s\n", summaryFile)
				continue
			}

			// Verifica se o pacote já existe no banco de dados
			exists, err := packageExists(db, packageName)
			if err != nil {
				log.Printf("Erro ao verificar se o pacote existe no banco de dados: %v\n", err)
				continue
			}

			if exists {
				if !quiet {
					fmt.Println("Registro #", count, Red+"Pacote", Cyan+packageName, Red+"já existe no banco de dados.", Reset)
				}
				continue
			}

			// Lê o conteúdo dos arquivos 'desc' e 'summary'
			desc, err := ioutil.ReadFile(descFile)
			if err != nil {
				log.Printf("Erro ao ler o arquivo 'desc' em: %s\n", descFile)
				continue
			}

			summary, err := ioutil.ReadFile(summaryFile)
			if err != nil {
				log.Printf("Erro ao ler o arquivo 'summary' em: %s\n", summaryFile)
				continue
			}

			// Cria uma estrutura PackageInfo com as informações do pacote
			pkgInfo := PackageInfo{
				Name:    packageName,
				Desc:    string(desc),
				Summary: string(summary),
			}

			// Insere os dados no banco de dados
			if err := insertPackageInfo(db, pkgInfo); err != nil {
				log.Printf("Erro ao inserir os dados no banco de dados: %v\n", err)
				continue
			}

			// Mostra mensagem para cada pasta processada
			if !quiet {
				fmt.Println("Registro #", count, "Pacote processado:", packageName)
			}
		}
	}
}

// Função para listar todos os registros da tabela flatpak
func listAllPackages(db *sql.DB) ([]PackageInfo, error) {
	query := "SELECT id, package, desc, summary FROM flatpak"

	rows, err := db.Query(query)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	var packages []PackageInfo

	for rows.Next() {
		var pkg PackageInfo
		if err := rows.Scan(&pkg.ID, &pkg.Name, &pkg.Desc, &pkg.Summary); err != nil {
			return nil, err
		}
		packages = append(packages, pkg)
	}

	if err := rows.Err(); err != nil {
		return nil, err
	}

	return packages, nil
}

func searchAndPrintAllPackage(db *sql.DB) {
	packages, err := listAllPackages(db)
	if err != nil {
		log.Fatal(err)
	}

	for _, pkg := range packages {
		fmt.Printf("ID         : %d\n", pkg.ID)
		fmt.Printf("Package    : %s\n", pkg.Name)
		fmt.Printf("Description: %s\n", pkg.Desc)
		fmt.Printf("Summary    : %s\n", pkg.Summary)
		fmt.Println()
	}
}

// Função para buscar um pacote por nome e imprimir se encontrado
func searchAndPrintAllPackageJSON(db *sql.DB) {
	packages, err := listAllPackages(db)
	if err != nil {
		log.Fatal(err)
	}

	for _, pkg := range packages {
		foundPackage, err := searchPackage(db, pkg.Name)
		if err != nil {
			// Se ocorrer um erro, imprima em vermelho
			log.Printf("big-sqlite %sErro:'%s' %s%v\n", Red, pkg.Name, Reset, err)
		} else {
			// Converte o resultado em JSON e imprime em verde
			jsonResult, err := json.Marshal(foundPackage)
			if err != nil {
				log.Printf("%sErro ao serializar para JSON:%s %v\n", Red, Reset, err)
			} else {
				fmt.Printf("%s%s%s\n", Green, string(jsonResult), Reset)
				println()
			}
		}
	}
}

// Função para buscar um pacote por nome e imprimir se encontrado
func searchAndPrintPackageJSON(db *sql.DB, packageName string) {
	foundPackage, err := searchPackage(db, packageName)
	if err != nil {
		// Se ocorrer um erro, imprima em vermelho
		log.Printf("big-sqlite %sErro:'%s' %s%v\n", Red, packageName, Reset, err)
		os.Exit(1)
	} else {
		// Converte o resultado em JSON e imprime em verde
		jsonResult, err := json.Marshal(foundPackage)
		if err != nil {
			log.Printf("%sErro ao serializar para JSON:%s %v\n", Red, Reset, err)
			os.Exit(1)
		} else {
			fmt.Printf("%s%s%s\n", Green, string(jsonResult), Reset)
			os.Exit(0)
		}
	}
}

func searchAndPrintPackage(db *sql.DB, packageName string) {
	pkg, err := searchPackage(db, packageName)
	if err != nil {
		// Se ocorrer um erro, imprima em vermelho
		log.Printf("big-sqlite %sErro:'%s' %s%v\n", Red, pkg.Name, Reset, err)
		os.Exit(1)
	} else {

		fmt.Printf("ID         : %d\n", pkg.ID)
		fmt.Printf("Package    : %s\n", pkg.Name)
		fmt.Printf("Description: %s\n", pkg.Desc)
		fmt.Printf("Summary    : %s\n", pkg.Summary)
		fmt.Println()
	}
}

// Função para buscar um pacote pelo nome no banco de dados
func searchPackage(db *sql.DB, packageName string) (PackageInfo, error) {
	query := "SELECT id, package, desc, summary FROM flatpak WHERE package = ?"

	var pkg PackageInfo
	err := db.QueryRow(query, packageName).Scan(&pkg.ID, &pkg.Name, &pkg.Desc, &pkg.Summary)
	if err != nil {
		return PackageInfo{}, err
	}

	return pkg, nil
}

// Função principal
func main() {
	rootDir := "/github/bcc/big-store/big-store/usr/share/bigbashview/bcc/apps/big-store/description"
	databaseFile := "bigstore.db"

	// Abre o banco de dados SQLite
	db, err := sql.Open("sqlite3", databaseFile)
	if err != nil {
		log.Fatal(err)
	}
	defer db.Close()

	// Crie a tabela se ela não existir
	if err := createTable(db); err != nil {
		log.Fatal(err)
	}

	// Define as flags para os argumentos
	//	lJason := false
	//	flag.BoolVar(&lJason, "J", false, "Usa o formato de saída JSON")
	//	flag.BoolVar(&lJason, "json", false, "Usa o formato de saída JSON")
	//	processFlag := flag.Bool("S", false, "Processar/adicionar pacotes ao BD")
	//	listFlag := flag.Bool("L", false, "Lista todos pacotes do BD")
	//	queryFlag := flag.String("Q", "", "<nome_do_pacote> Buscar um pacote por nome")
	//	quietFlag := flag.Bool("q", false, "Não mostrar mensagens de processamento")
	//	helpFlag := flag.Bool("help", false, "Mostra a mensagem de uso")

	// Use pflag em vez de flag para criar opções curtas e longas
	var (
		processFlag = pflag.BoolP("search", "S", false, "Processar/adicionar pacotes ao BD")
		queryFlag   = pflag.StringP("query", "Q", "", "<nome_do_pacote> Buscar um pacote por nome")
		quietFlag   = pflag.BoolP("quiet", "q", false, "Não mostrar mensagens de processamento")
		helpFlag    = pflag.BoolP("help", "h", false, "Mostra a mensagem de uso")
		jsonFlag    = pflag.BoolP("json", "J", false, "Usa o formato de saída JSON")
		listFlag    = pflag.BoolP("list", "L", false, "Lista todos pacotes do BD")
	)

	// Parse os argumentos usando pflag
	pflag.Parse()

	// Analise os argumentos da linha de comando
	switch {
	case *helpFlag || len(os.Args) == 1:
		fmt.Println("Uso: big-sqlite [opcoes]")
		fmt.Println("[opcoes]")
		pflag.PrintDefaults()

	case *processFlag:
		// Se -S foi fornecido, processe a função processPackages
		processPackages(rootDir, db, *quietFlag)

	case *listFlag:
		if *jsonFlag {
			searchAndPrintAllPackageJSON(db)
		} else {
			searchAndPrintAllPackage(db)
		}

	case *queryFlag != "":
		// Se -Q foi fornecido, use o valor de queryFlag como nome do pacote a buscar
		packageNameToSearch := *queryFlag
		if *jsonFlag {
			searchAndPrintPackageJSON(db, packageNameToSearch)
		} else {
			searchAndPrintPackage(db, packageNameToSearch)
		}
	}
}
