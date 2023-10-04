package main

import (
    "encoding/json"
    "fmt"
    "io/ioutil"
    "os"
)

const FILE_DESCRIPTION_JSON = "description.json"

type Description struct {
    Name        string            `json:"name"`
    Version     string            `json:"version"`
    Size        string            `json:"size"`
    Status      string            `json:"status"`
    Description map[string]string `json:"description"`
}

func main() {
    name := "teste"
    version := "1.0.0"
    size := "10MB"
    status := "[Installed]"
    lang := "en_US"
    description := "description"

    // Verifique se o arquivo JSON existe e, se não, crie-o com um objeto vazio
    if _, err := os.Stat(FILE_DESCRIPTION_JSON); os.IsNotExist(err) {
        emptyObj := map[string]Description{}
        jsonStr, _ := json.MarshalIndent(emptyObj, "", "    ")
        _ = ioutil.WriteFile(FILE_DESCRIPTION_JSON, jsonStr, 0644)
    }

    // Carregue o arquivo JSON atual
    file, err := ioutil.ReadFile(FILE_DESCRIPTION_JSON)
    if err != nil {
        fmt.Println("Erro ao ler o arquivo JSON:", err)
        return
    }

    descriptions := map[string]Description{}
    _ = json.Unmarshal(file, &descriptions)

    // Verifique se o objeto já existe no JSON
    existingDescription, exists := descriptions[name]
    if exists {
        // O objeto já existe, então atualize-o
        existingDescription.Name = name
        existingDescription.Version = version
        existingDescription.Size = size
        existingDescription.Status = status
        existingDescription.Description[lang] = description
    } else {
        // O objeto não existe, então crie-o
        newDescription := Description{
            Name:    name,
            Version: version,
            Size:    size,
            Status:  status,
            Description: map[string]string{
                lang: description,
            },
        }
        descriptions[name] = newDescription
    }

    // Serialize o mapa de descrições de volta para JSON
    updatedJSON, _ := json.MarshalIndent(descriptions, "", "    ")

    // Escreva o JSON atualizado de volta para o arquivo
    err = ioutil.WriteFile(FILE_DESCRIPTION_JSON, updatedJSON, 0644)
    if err != nil {
        fmt.Println("Erro ao escrever o arquivo JSON:", err)
        return
    }

    fmt.Println("JSON atualizado com sucesso!")
}
