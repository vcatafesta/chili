#include <stdio.h>
#include <string.h>
#include <curl/curl.h>

struct MemoryStruct {
    char *memory;
    size_t size;
};

static size_t WriteMemoryCallback(void *contents, size_t size, size_t nmemb, void *userp) {
    size_t realsize = size * nmemb;
    struct MemoryStruct *mem = (struct MemoryStruct *)userp;
 
    mem->memory = realloc(mem->memory, mem->size + realsize + 1);
    if (mem->memory == NULL) {
        printf("Not enough memory (realloc returned NULL)\n");
        return 0;
    }
 
    memcpy(&(mem->memory[mem->size]), contents, realsize);
    mem->size += realsize;
    mem->memory[mem->size] = 0;
 
    return realsize;
}

int main(void) {
    CURL *curl_handle;
    CURLcode res;
    struct MemoryStruct chunk;
    chunk.memory = malloc(1);
    chunk.size = 0;

    curl_global_init(CURL_GLOBAL_ALL);

    curl_handle = curl_easy_init();
    if (curl_handle) {
        curl_easy_setopt(curl_handle, CURLOPT_URL, "http://chililinux.com/packages/a/");
        curl_easy_setopt(curl_handle, CURLOPT_WRITEFUNCTION, WriteMemoryCallback);
        curl_easy_setopt(curl_handle, CURLOPT_WRITEDATA, (void *)&chunk);

        res = curl_easy_perform(curl_handle);

        if (res != CURLE_OK) {
            fprintf(stderr, "curl_easy_perform() failed: %s\n", curl_easy_strerror(res));
        } else {
            char *line = strtok(chunk.memory, "\n");
            while (line != NULL) {
                char *filename = strrchr(line, '/') + 1;
                if (strstr(filename, ".zst")) {
                    char header[1000];
                    sprintf(header, "Range: bytes=0-0\r\n");
                    CURL *file_handle = curl_easy_init();
                    if (file_handle) {
                        curl_easy_setopt(file_handle, CURLOPT_URL, line);
                        curl_easy_setopt(file_handle, CURLOPT_FOLLOWLOCATION, 1L);
                        curl_easy_setopt(file_handle, CURLOPT_RANGE, "0-0");
                        curl_easy_setopt(file_handle, CURLOPT_WRITEFUNCTION, WriteMemoryCallback);
                        curl_easy_setopt(file_handle, CURLOPT_WRITEDATA, (void *)&chunk);
                        struct curl_slist *list = NULL;
                        list = curl_slist_append(list, header);
                        curl_easy_setopt(file_handle, CURLOPT_HTTPHEADER, list);
                        res = curl_easy_perform(file_handle);
                        if (res == CURLE_OK) {
                            char *content_length = NULL;
                            content_length = strstr(chunk.memory, "Content-Length:");
                            if (content_length != NULL) {
                                int length = strtol(content_length + 16, NULL, 10);
                                printf("%s,%d\n", filename, length);
                            }
                        } else {
                            fprintf(stderr, "curl_easy_perform() failed: %s\n", curl_easy_strerror(res));
                        }
                        curl_slist_free_all(list);
                        curl_easy_cleanup(file_handle);
                        chunk.memory[0] = '\0';
                        chunk.size = 0;
                    }
                }
                line = strtok(NULL, "\n");
            }
        }

        curl_easy_cleanup(curl_handle);
    }

    curl_global_cleanup();
    free(chunk.memory);
    return 0;
