package main

import (
	"fmt"
	"os"
	"path/filepath"
	"regexp"
	"strings"
	"sync"
	"time"
)

const maxWorkers = 10 // Número máximo de workers (goroutines)

type Config struct {
	RootDir    string        // Diretório raiz para a busca
	NamePattern string       // Padrão de nome do arquivo (pode ser um regex)
	TypeFilter string        // Filtro por tipo: "file", "dir", ou ""
	MaxDepth   int           // Profundidade máxima da busca (-1 para ilimitado)
	Recursive  bool          // Busca recursiva
	ModTime    time.Duration // Filtro por tempo de modificação (ex: arquivos modificados nas últimas 24h)
}

func searchFile(path string, config Config, resultChan chan<- string) {
	// Caminha recursivamente pelos diretórios
	err := filepath.Walk(path, func(filePath string, info os.FileInfo, err error) error {
		if err != nil {
			return nil // Ignora erros e continua a busca
		}

		// Verifica a profundidade da busca
		if config.MaxDepth >= 0 {
			depth := strings.Count(filePath, string(filepath.Separator)) - strings.Count(config.RootDir, string(filepath.Separator))
			if depth > config.MaxDepth {
				return filepath.SkipDir // Ignora subdiretórios além da profundidade máxima
			}
		}

		// Filtra por tipo (arquivo ou diretório)
		if config.TypeFilter != "" {
			switch config.TypeFilter {
			case "file":
				if info.IsDir() {
					return nil // Ignora diretórios
				}
			case "dir":
				if !info.IsDir() {
					return nil // Ignora arquivos
				}
			}
		}

		// Filtra por nome (usando regex)
		if config.NamePattern != "" {
			matched, err := regexp.MatchString(config.NamePattern, info.Name())
			if err != nil || !matched {
				return nil // Ignora se não corresponder ao padrão
			}
		}

		// Filtra por tempo de modificação
		if config.ModTime > 0 {
			if time.Since(info.ModTime()) > config.ModTime {
				return nil // Ignora arquivos/diretórios modificados fora do período
			}
		}

		// Se passar por todos os filtros, adiciona ao resultado
		resultChan <- filePath
		return nil
	})

	if err != nil {
		fmt.Println("Erro ao percorrer o diretório:", err)
	}
}

func worker(id int, paths <-chan string, config Config, wg *sync.WaitGroup, resultChan chan<- string) {
	defer wg.Done()
	for path := range paths {
		fmt.Printf("Worker %d processando: %s\n", id, path)
		searchFile(path, config, resultChan)
	}
}

func main() {
	if len(os.Args) < 2 {
		fmt.Println("Uso: go run find.go <diretório> [opções]")
		fmt.Println("Opções:")
		fmt.Println("  -name <padrão>  Filtra por nome de arquivo (regex)")
		fmt.Println("  -type <tipo>    Filtra por tipo: file (arquivo) ou dir (diretório)")
		fmt.Println("  -maxdepth <n>   Define a profundidade máxima da busca")
		fmt.Println("  -mtime <h>      Filtra por tempo de modificação (em horas)")
		return
	}

	// Configuração padrão
	config := Config{
		RootDir:    os.Args[1],
		NamePattern: "",
		TypeFilter: "",
		MaxDepth:   -1,
		Recursive:  true,
		ModTime:    0,
	}

	// Processa argumentos
	for i := 2; i < len(os.Args); i++ {
		switch os.Args[i] {
		case "-name":
			if i+1 < len(os.Args) {
				config.NamePattern = os.Args[i+1]
				i++
			}
		case "-type":
			if i+1 < len(os.Args) {
				config.TypeFilter = os.Args[i+1]
				i++
			}
		case "-maxdepth":
			if i+1 < len(os.Args) {
				fmt.Sscanf(os.Args[i+1], "%d", &config.MaxDepth)
				i++
			}
		case "-mtime":
			if i+1 < len(os.Args) {
				var hours int
				fmt.Sscanf(os.Args[i+1], "%d", &hours)
				config.ModTime = time.Duration(hours) * time.Hour
				i++
			}
		default:
			fmt.Printf("Opção desconhecida: %s\n", os.Args[i])
			return
		}
	}

	var wg sync.WaitGroup
	paths := make(chan string, 100)        // Canal para enviar diretórios para os workers
	resultChan := make(chan string, 100) // Canal para resultados encontrados

	// Cria workers
	for i := 0; i < maxWorkers; i++ {
		wg.Add(1)
		go worker(i, paths, config, &wg, resultChan)
	}

	// Envia o diretório raiz para os workers
	paths <- config.RootDir
	close(paths) // Fecha o canal de paths após enviar o diretório raiz

	// Aguarda os workers terminarem
	wg.Wait()
	close(resultChan) // Fecha o canal de resultados após todos os workers terminarem

	// Exibe os resultados encontrados
	found := false
	for result := range resultChan {
		found = true
		fmt.Println(result)
	}

	if !found {
		fmt.Println("Nenhum arquivo ou diretório encontrado.")
	}
}

