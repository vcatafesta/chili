#include <stdio.h>
#include <string.h>
#include <curl/curl.h>

// Função para processar a resposta da requisição HTTP
size_t write_data(void *buffer, size_t size, size_t nmemb, void *userp) {
    char *filename = userp;
    char *content_length;
    char *pch;
    long length;

    // Procura pelo cabeçalho "Content-Length" na resposta
    pch = strstr(buffer, "Content-Length");
    if (pch != NULL) {
        content_length = strtok(pch, " ");
        content_length = strtok(NULL, " ");
        // Converte o tamanho para um valor numérico
        length = strtol(content_length, NULL, 10);
        // Escreve no arquivo de saída
        FILE *fp = fopen("arquivos.csv", "a");
        fprintf(fp, "%s,%ld\n", filename, length);
        fclose(fp);
    }

    return size * nmemb;
}

int main(void) {
    CURL *curl;
    CURLcode res;
    char url[256];
    char filename[256];

    // Inicializa a biblioteca libcurl
    curl_global_init(CURL_GLOBAL_DEFAULT);

    // Cria o objeto de requisição HTTP
    curl = curl_easy_init();
    if (curl) {
        // Define a URL da requisição
        strcpy(url, "http://chililinux.com/packages/a/");

        // Define as opções da requisição HTTP
        curl_easy_setopt(curl, CURLOPT_URL, url);
        curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, write_data);

        // Faz a requisição HTTP para cada arquivo com extensão .zst
        strcpy(filename, "");
        struct curl_slist *headers = NULL;
        headers = curl_slist_append(headers, "Accept: text/html");
        curl_easy_setopt(curl, CURLOPT_HTTPHEADER, headers);
        curl_easy_setopt(curl, CURLOPT_FOLLOWLOCATION, 1L);
        curl_easy_setopt(curl, CURLOPT_ACCEPT_ENCODING, "");
        curl_easy_setopt(curl, CURLOPT_WRITEDATA, filename);
        res = curl_easy_perform(curl);

        // Finaliza a requisição HTTP
        curl_easy_cleanup(curl);
    }

    // Finaliza a biblioteca libcurl
    curl_global_cleanup();

    return 0;
}
