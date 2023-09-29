// go get github.com/takama/daemon

package main

import (
    "fmt"
    "net/http"
    "os"
    "github.com/takama/daemon"
)

const (
    name        = "my-http-server"
    description = "Servidor HTTP Go Daemon"
)

var dependencies = []string{}

type Service struct {
    daemon.Daemon
}

func (service *Service) Manage() (string, error) {
    usage := "Uso: my-http-server install | remove | start | stop | status"
    // Detecta o modo de operação solicitado
    if len(os.Args) > 1 {
        command := os.Args[1]
        switch command {
        case "install":
            return service.Install()
        case "remove":
            return service.Remove()
        case "start":
            return service.Start()
        case "stop":
            return service.Stop()
        case "status":
            return service.Status()
        }
    }
    return usage, nil
}

func handler(w http.ResponseWriter, r *http.Request) {
    fmt.Fprintf(w, "Olá, Mundo!")
}

func main() {
    srv, err := daemon.New(name, description, daemon.SystemDaemon, dependencies...)
    if err != nil {
        fmt.Println("Erro ao criar o serviço:", err)
        os.Exit(1)
    }

    service := &Service{srv}

    // Configura um manipulador para a rota "/"
    http.HandleFunc("/", handler)

    // Verifica se o programa está sendo executado como um serviço
    if len(os.Args) > 1 && os.Args[1] == "start" {
        // Inicia o servidor HTTP
        go func() {
            err := http.ListenAndServe(":5061", nil)
            if err != nil {
                fmt.Println("Erro ao iniciar o servidor HTTP:", err)
            }
        }()
    }

    result, err := service.Manage()
    if err != nil {
        fmt.Println("Erro:", result, "\n", err)
    }
    fmt.Println(result)
}

