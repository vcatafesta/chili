// argparse.cpp, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>
#include <string>
#include <iostream>
#include <vector>
#include <array>
#include <algorithm>
#include "color.h"
#include <argparse/argparse.hpp>

using namespace std;

int main(int argc, char *argv[]) {
   std::cout << RED   << "argparse.cpp, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>\n\n" << RESET << '\n';
   std::cout << GREEN << "Hello, World!" << RESET << '\n';

	argparse::ArgumentParser program("program_name");

  program.add_argument("square")
    .help("display the square of a given integer")
    .scan<'i', int>();

  try {
    program.parse_args(argc, argv);
  }
  catch (const std::runtime_error& err) {
    std::cerr << err.what() << std::endl;
    std::cerr << program;
    std::exit(1);
  }

  auto input = program.get<int>("square");
  std::cout << (input * input) << std::endl;

   return EXIT_SUCCESS;
}

