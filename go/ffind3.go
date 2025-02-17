package main

import (
	"fmt"
	"os"
	"path/filepath"
	"strings"
	"sync"
)

const maxWorkers = 10 // Número máximo de workers (goroutines)

func searchFile(path string, target string, wg *sync.WaitGroup, resultChan chan<- string) {
	defer wg.Done()

	// Caminha recursivamente pelos diretórios
	err := filepath.Walk(path, func(filePath string, info os.FileInfo, err error) error {
		if err != nil {
			return nil // Ignora erros e continua a busca
		}
		// Verifica se o nome do arquivo corresponde ao alvo (ignorando maiúsculas/minúsculas)
		if !info.IsDir() && strings.EqualFold(info.Name(), target) {
			resultChan <- filePath // Envia o caminho do arquivo encontrado para o canal de resultados
		}
		return nil
	})

	if err != nil {
		fmt.Println("Erro ao percorrer o diretório:", err)
	}
}

func worker(id int, jobs <-chan string, target string, wg *sync.WaitGroup, resultChan chan<- string) {
	defer wg.Done()
	for path := range jobs {
		fmt.Printf("Worker %d processando: %s\n", id, path)
		searchFile(path, target, wg, resultChan)
	}
}

func main() {
	if len(os.Args) < 3 {
		fmt.Println("Uso: go run programa.go <diretório> <arquivo>")
		return
	}

	root := os.Args[1]
	target := os.Args[2]

	var wg sync.WaitGroup
	jobs := make(chan string, 100)        // Canal para enviar diretórios para os workers
	resultChan := make(chan string, 100) // Canal para resultados encontrados

	// Cria workers
	for i := 0; i < maxWorkers; i++ {
		wg.Add(1)
		go worker(i, jobs, target, &wg, resultChan)
	}

	// Envia os diretórios para os workers
	go func() {
		err := filepath.Walk(root, func(path string, info os.FileInfo, err error) error {
			if err != nil {
				return nil // Ignora erros e continua a busca
			}
			if info.IsDir() {
				jobs <- path // Envia o diretório para os workers
			}
			return nil
		})

		if err != nil {
			fmt.Println("Erro ao percorrer o diretório:", err)
		}
		close(jobs) // Fecha o canal de jobs, indicando que não haverá mais diretórios para processar
	}()

	// Aguarda os workers terminarem
	go func() {
		wg.Wait()
		close(resultChan) // Fecha o canal de resultados após todos os workers terminarem
	}()

	// Exibe os resultados encontrados
	found := false
	for result := range resultChan {
		found = true
		fmt.Println("Arquivo encontrado:", result)
	}

	if !found {
		fmt.Println("Nenhum arquivo encontrado.")
	}
}
