package main

import (
    "database/sql"
    "fmt"
    _ "github.com/mattn/go-sqlite3" // Importe o driver SQLite3
    "io/ioutil"
    "log"
    "os"
    "path/filepath"
)

func main() {
    rootDir := "/github/bcc/big-store/big-store/usr/share/bigbashview/bcc/apps/big-store/description"
    databaseFile := "bigstore.db"

    // Abre o banco de dados SQLite
    db, err := sql.Open("sqlite3", databaseFile)
    if err != nil {
        log.Fatal(err)
    }
    defer db.Close()

    // Cria a tabela se ela não existir
    createTableSQL := `
        CREATE TABLE IF NOT EXISTS flatpak (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            package TEXT,
            desc TEXT,
            summary TEXT
        );
    `
    _, err = db.Exec(createTableSQL)
    if err != nil {
        log.Fatal(err)
    }

    // Itera sobre os diretórios
    err = filepath.Walk(rootDir, func(dirPath string, info os.FileInfo, err error) error {
        if err != nil {
            log.Printf("Erro ao acessar o diretório: %v\n", err)
            return err
        }
        if info.IsDir() && info.Name() != rootDir {
            // Obtém o nome da subpasta, que será o valor do campo "package"
            packageName := filepath.Base(dirPath)

            // Lê o conteúdo dos arquivos 'desc' e 'summary'
            descFile := filepath.Join(dirPath, "desc")
            summaryFile := filepath.Join(dirPath, "summary")

			println("PASTA       ", dirPath)
			println("DESCFILE    ", descFile)
			println("SUMMARYFILE ", summaryFile)

            desc, err := ioutil.ReadFile(descFile)
            if err != nil {
                log.Printf("Erro ao ler o arquivo 'desc' em: %s\n", descFile)
				//                return nil
				os.Exit(1)
            }

            summary, err := ioutil.ReadFile(summaryFile)
            if err != nil {
                log.Printf("Erro ao ler o arquivo 'summary' em: %s\n", summaryFile)
                return nil
            }

            // Insere os dados no banco de dados
            insertSQL := `
                INSERT INTO flatpak (package, desc, summary)
                VALUES (?, ?, ?)
            `
            _, err = db.Exec(insertSQL, packageName, string(desc), string(summary))
            if err != nil {
                log.Printf("Erro ao inserir os dados no banco de dados: %v\n", err)
                return nil
            }

            // Mostra mensagem para cada pasta processada
            fmt.Printf("Pasta processada: %s\n", dirPath)
        }
        return nil
    })

    if err != nil {
        log.Fatal(err)
    }
}
