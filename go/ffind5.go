package main

import (
	"fmt"
	"os"
	"path/filepath"
	"strings"
	"sync"
)

const maxWorkers = 10 // Número máximo de workers (goroutines)

func searchFile(path string, resultChan chan<- string, wg *sync.WaitGroup) {
	defer wg.Done() // Garante que o WaitGroup seja sinalizado quando a goroutine terminar

	// Simulação de busca
	if strings.Contains(path, "sci.dbf") {
		resultChan <- path // Envia o resultado para o canal
	}
}

func main() {
	rootDir := "/home"
	namePattern := "sci.dbf"
	var wg sync.WaitGroup

	// Canal para comunicação entre goroutines
	resultChan := make(chan string, 100) // buffer de 100, para evitar bloqueios imediatos

	// Busca recursiva pelos arquivos
	err := filepath.Walk(rootDir, func(path string, info os.FileInfo, err error) error {
		if err != nil {
			return err
		}

		// Filtro de arquivos pelo nome (pode ser ajustado conforme necessário)
		if strings.Contains(info.Name(), namePattern) {
			wg.Add(1) // Adiciona uma goroutine ao WaitGroup
			go searchFile(path, resultChan, &wg) // Inicia a busca em uma goroutine
		}

		return nil
	})

	if err != nil {
		fmt.Println("Erro ao acessar diretórios:", err)
		return
	}

	// Espera todas as goroutines terminarem
	wg.Wait()

	// Fechar o canal após todas as goroutines completarem
	close(resultChan)

	// Processa os resultados
	for result := range resultChan {
		fmt.Println(result)
	}
}
