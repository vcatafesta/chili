package main

import (
	"fmt"
	"os"
	"path/filepath"
	"strings"
	"sync"
)

func searchFile(root string, target string, wg *sync.WaitGroup, resultChan chan string) {
	defer wg.Done()

	// Caminha recursivamente pelo diretório
	err := filepath.Walk(root, func(path string, info os.FileInfo, err error) error {
		if err != nil {
			// Se houver erro ao acessar o arquivo ou diretório, ignora
			return nil
		}

		// Verifica se o nome do arquivo é igual ao alvo
		if strings.EqualFold(info.Name(), target) {
			resultChan <- path  // Envia o caminho encontrado para o canal
		}

		return nil
	})

	if err != nil {
		fmt.Println("Erro ao percorrer:", err)
	}
}

func main() {
	if len(os.Args) < 3 {
		fmt.Println("Uso: go run programa.go <diretório> <arquivo>")
		return
	}

	root := os.Args[1]   // Diretório de busca
	target := os.Args[2] // Nome do arquivo

	var wg sync.WaitGroup
	resultChan := make(chan string, 100) // Canal para armazenar os resultados

	// Cria uma goroutine para cada subdiretório encontrado
	err := filepath.Walk(root, func(path string, info os.FileInfo, err error) error {
		if err != nil {
			// Se não for possível acessar um diretório, ignora
			return nil
		}

		if info.IsDir() {
			wg.Add(1)
			go searchFile(path, target, &wg, resultChan) // Executa a busca em paralelo
		}

		return nil
	})

	if err != nil {
		fmt.Println("Erro ao percorrer:", err)
		return
	}

	// Aguarda todas as goroutines terminarem
	go func() {
		wg.Wait()
		close(resultChan) // Fecha o canal após todas as goroutines terminarem
	}()

	// Exibe os resultados encontrados
	found := false
	for result := range resultChan {
		found = true
		fmt.Println(result)
	}

	if !found {
		fmt.Println("Nenhum arquivo encontrado.")
	}
}
