// go get github.com/takama/daemon


package main

import (
    "fmt"
    "net/http"
    "math/rand"
    "time"
)

func handler(w http.ResponseWriter, r *http.Request) {
    fmt.Fprintf(w, "Olá, Mundo!")
}

func main() {
    // Inicializa o gerador de números aleatórios com uma semente única
    rand.Seed(time.Now().UnixNano())

    // Gera uma porta aleatória entre 1024 e 65535
    minPort := 1024
    maxPort := 65535
    randomPort := rand.Intn(maxPort-minPort+1) + minPort

    // Configura um manipulador para a rota "/"
    http.HandleFunc("/", handler)

    // Inicia o servidor na porta aleatória
    addr := fmt.Sprintf(":%d", randomPort)
    fmt.Printf("Servidor rodando na porta %d...\n", randomPort)
    err := http.ListenAndServe(addr, nil)
    if err != nil {
        fmt.Println(err)
    }
}
