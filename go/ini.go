// go get github.com/go-ini/ini

package main

import (
    "fmt"
    "github.com/go-ini/ini"
)

func main() {
    // Caminho do arquivo .ini
    filePath := "config.ini"

    // Criar ou abrir um arquivo .ini para leitura/escrita
    cfg, err := ini.Load(filePath)
    if err != nil {
        fmt.Printf("Erro ao carregar o arquivo .ini: %v\n", err)
        return
    }

    // Ler valores do arquivo .ini
    section, err := cfg.GetSection("snap")
    if err != nil {
        fmt.Printf("Erro ao obter a seção: %v\n", err)
        return
    }

    key := "Chave"
    value := section.Key(key).String()
    fmt.Printf("Valor da chave %s: %s\n", key, value)

    // Modificar valores no arquivo .ini
    section.Key(key).SetValue("NovoValor")
    err = cfg.SaveTo(filePath)
    if err != nil {
        fmt.Printf("Erro ao salvar o arquivo .ini: %v\n", err)
        return
    }

    fmt.Println("Arquivo .ini atualizado com sucesso.")

    // Remover a chave do arquivo .ini
    section.DeleteKey(key)
    err = cfg.SaveTo(filePath)
    if err != nil {
        fmt.Printf("Erro ao salvar o arquivo .ini após a exclusão: %v\n", err)
        return
    }

    fmt.Println("Chave removida do arquivo .ini.")
}
