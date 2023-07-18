#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <curl/curl.h>

#define BUFFER_SIZE 1024

struct MemoryStruct {
  char *memory;
  size_t size;
};

static size_t write_memory_callback(void *contents, size_t size, size_t nmemb, void *userp) {
  size_t real_size = size * nmemb;
  struct MemoryStruct *mem = (struct MemoryStruct *) userp;
  mem->memory = realloc(mem->memory, mem->size + real_size + 1);
  if (mem->memory == NULL) {
    printf("Memory allocation error");
    return 0;
  }
  memcpy(&(mem->memory[mem->size]), contents, real_size);
  mem->size += real_size;
  mem->memory[mem->size] = 0;
  return real_size;
}

int main(void) {
  CURL *curl_handle;
  CURLcode res;
  char *url = "http://chililinux.com/packages/a/";
  struct MemoryStruct chunk;
  chunk.memory = malloc(1);
  chunk.size = 0;

  curl_global_init(CURL_GLOBAL_ALL);

  curl_handle = curl_easy_init();
  curl_easy_setopt(curl_handle, CURLOPT_URL, url);
  curl_easy_setopt(curl_handle, CURLOPT_WRITEFUNCTION, write_memory_callback);
  curl_easy_setopt(curl_handle, CURLOPT_WRITEDATA, (void *)&chunk);
  res = curl_easy_perform(curl_handle);

  if (res != CURLE_OK) {
    printf("curl_easy_perform() failed: %s\n", curl_easy_strerror(res));
  } else {
    char *filename;
    char *size;
    char *ptr;
    ptr = chunk.memory;
    while (ptr && (ptr = strstr(ptr, "<a href=\"/packages/a/")) != NULL) {
      filename = ptr + 22;
      ptr = strstr(ptr, "zst\">");
      size = strstr(ptr, "KB</a>");
      *size = 0;
      size = strrchr(ptr, '>');
      printf("%s,%s\n", filename, size+1);
    }
  }

  curl_easy_cleanup(curl_handle);
  curl_global_cleanup();

  free(chunk.memory);

  return 0;
}
