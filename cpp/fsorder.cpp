// fsorder.cpp, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>
#ifdef __cplusplus
   #include <iostream>  // std::cout
   #include <filesystem>
   #include <cstddef>   // std::size_t
   #include <valarray>  // std::valarray, std::slice
   #include <sstream>   // std::stringstream
   #include <string>
   #include <cctype>
   #include <array>
   #include <algorithm>
   #include <functional>
   #include <map>
   #include <vector>
   #include <chrono>
   #include <thread>
   #include <cwchar>
   #include <clocale>
#endif
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>
#include <signal.h>
#include <sys/wait.h>
#ifdef _WIN32
   #include <Windows.h>
   #include <dos.h>
#else
   #include <unistd.h>
#endif
#include "color.h"

#ifdef __cplusplus
   using namespace std;
   namespace fs = std::filesystem;
#endif /* __cplusplus */

#if defined( __GNUC__ )
   //#pragma GCC diagnostic ignored "-Wwrite-strings"
   //#pragma GCC diagnostic ignored "-Wunused-parameter"
   //#pragma GCC diagnostic ignored "-Wuninitialized"
   //#pragma GCC diagnostic ignored "-Wunused-function"
   //#pragma GCC diagnostic ignored "-Wduplicated-cond"
   #pragma GCC diagnostic ignored "-Wunused-variable"
   #pragma GCC diagnostic ignored "-Wformat"
   #pragma GCC diagnostic ignored "-Wformat-extra-args"
#endif

#define CURSOR(top, bottom)  (((top) << 8) | (bottom))
#define getrandom(min, max)  ((rand()%(int)(((max) + 1)-(min)))+ (min))

//=================================================================

void qqout() {}
template <typename T, typename... Args>
void qqout(T arg, Args... args) {
   std::cout << arg << "";
   qqout(args...);
}

void qout() { std::cout << '\n'; }
template <typename T, typename... Args>
void qout(T arg, Args... args) {
   std::cout << arg << "";
   qout(args...);
}

template <class T, typename X>
std::string replicate(T ch, X tam) {
   std::string replicate;
   replicate.assign(tam, ch);
   return replicate;
}

size_t my_strlen(char *c) {
   size_t i = 0;
   while(*c != NULL) {
      c++;
      i++;
   }
   return i;
}

size_t LenArray(char **a) {
   size_t i = 0;
   //while(*(a+i)){
   while( a[i] ){
      i++;
   }
   return i;
}

//=================================================================

bool num_str_cmp(const fs::path& x, const fs::path& y) {
  auto get_number = [](const fs::path& path) {
    auto str_num = path.stem().string();

    std::string num_part {};
    for (char c : str_num) {
      if (std::isdigit(c)) {
        num_part += c;
      }
    }

    return !num_part.empty() ? std::stoi(num_part) : 0;
  };

  return get_number(x) < get_number(y);
}

int main(int argc, char **argv) {
    qout(RED,"\u2630 fsorder.cpp, Copyright \u24d2  2023 Vilmar Catafesta <vcatafesta@gmail.com>\u21b4", RESET, '\n');
    qout(GREEN, "Hello, World!", RESET, '\n');

    std::string path = "/home/vcatafesta/Imagens";
    std::vector<fs::path> files_in_dir;
    std::copy(fs::directory_iterator(path), fs::directory_iterator(), std::back_inserter(files_in_dir));
    std::sort(files_in_dir.begin(), files_in_dir.end(), num_str_cmp);

    for (const auto &entry : files_in_dir){
        std::cout << entry << '\n';
    }
    return EXIT_SUCCESS;
}

