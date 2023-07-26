#include <iostream>

template<typename T>
T maximo(T a, T b) {
    return (a > b) ? a : b;
}

int main() {
    int a = 10, b = 20;
    std::cout << "O maior entre " << a << " e " << b << " é " << maximo(a, b) << std::endl;

    double c = 3.14, d = 2.71;
    std::cout << "O maior entre " << c << " e " << d << " é " << maximo(c, d) << std::endl;

    char e[] = { 'a' };
    char f[] = { 'B' };
    std::cout << "O maior entre " << e << " e " << f << " é " << maximo(e, f) << std::endl;

    return 0;
}

