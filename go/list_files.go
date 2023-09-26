package main

import (
    "fmt"
    "os"
    "path/filepath"
)

func listFilesInDirectory(directoryPath string) error {
    err := filepath.Walk(directoryPath, func(path string, info os.FileInfo, err error) error {
        if err != nil {
            return err
        }
        if !info.IsDir() {
            fmt.Println(path)
        }
        return nil
    })

    return err
}

func main() {
    directoryPath := "." // Diretório atual, você pode alterar para o diretório desejado
    err := listFilesInDirectory(directoryPath)
    if err != nil {
        fmt.Println("Erro ao listar os arquivos:", err)
        os.Exit(1)
    }
}
