package main

import (
  "fmt"
  "os"
  "path/filepath"
)

func main() {
  // Verifica se os argumentos foram fornecidos corretamente
  if len(os.Args) < 3 {
    fmt.Println("Uso: programa <caminho> <arquivo>")
    os.Exit(1)
  }

  root := os.Args[1]   // Caminho base para busca
  target := os.Args[2] // Nome do arquivo a ser procurado

  err := filepath.Walk(root, func(path string, info os.FileInfo, err error) error {
    if err != nil {
      return nil // Ignora erros de permissão
    }
    if info.Name() == target {
      fmt.Println(path)
    }
    return nil
  })

  if err != nil {
    fmt.Println("Erro ao percorrer diretórios:", err)
  }
}
