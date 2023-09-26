package main

import (
    "fmt"
    "net/http"
    "golang.org/x/net/html"
    "io"
)

func main() {
    siteURL := "https://www.chililinux.com" // Substitua pelo URL do site que deseja analisar
    resp, err := http.Get(siteURL)
    if err != nil {
        fmt.Println("Erro ao fazer a solicitação HTTP:", err)
        return
    }
    defer resp.Body.Close()

    if resp.StatusCode != http.StatusOK {
        fmt.Println("Erro: Código de status não OK:", resp.StatusCode)
        return
    }

    tokenizer := html.NewTokenizer(resp.Body)
    for {
        tokenType := tokenizer.Next()
        switch tokenType {
        case html.ErrorToken:
            if tokenizer.Err() == io.EOF {
                return // Fim do documento
            }
            fmt.Println("Erro durante a análise HTML:", tokenizer.Err())
            return
        case html.StartTagToken, html.SelfClosingTagToken:
            token := tokenizer.Token()
            if token.Data == "a" {
                for _, attr := range token.Attr {
                    if attr.Key == "href" {
                        fmt.Println("Arquivo encontrado:", attr.Val)
                    }
                }
            }
        }
    }
}
