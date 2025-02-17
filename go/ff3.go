package main

import (
  "fmt"
  "os"
  "path/filepath"
  "sync"
)

func searchFile(root, target string, results chan<- string, wg *sync.WaitGroup) {
  defer wg.Done()

  filepath.Walk(root, func(path string, info os.FileInfo, err error) error {
    if err != nil {
      return nil // Ignora erros de permissão
    }
    if info.Name() == target {
      results <- path
    }
    return nil
  })
}

func main() {
  if len(os.Args) < 3 {
    fmt.Println("Uso: programa <caminho> <arquivo>")
    os.Exit(1)
  }

  root := os.Args[1]   // Caminho base para busca
  target := os.Args[2] // Nome do arquivo a ser procurado

  results := make(chan string) // Canal para coletar resultados
  var wg sync.WaitGroup

  // Inicia a busca em paralelo
  wg.Add(1)
  go searchFile(root, target, results, &wg)

  // Goroutine para fechar o canal quando todas as buscas terminarem
  go func() {
    wg.Wait()
    close(results)
  }()

  // Lê e imprime os resultados conforme são encontrados
  for path := range results {
    fmt.Println(path)
  }
}
