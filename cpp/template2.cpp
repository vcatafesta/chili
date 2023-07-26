#include <iostream>

template <class generico>
generico funcao(generico a){
	std::cout << typeid(a).name() << " = ";
//	return ++a;
	return a;
}

template<typename T>
T maximo(T a, T b) {
    return (a > b) ? a : b;
}

int main() {
    int a = 10, b = 20;
    double c = 3.14, d = 2.71;
    char e[] = { 'a' }, f[] = { 'B' };

    std::cout << "O maior entre " << a << " e " << b << " é " << maximo(a, b) << std::endl;
    std::cout << "O maior entre " << c << " e " << d << " é " << maximo(c, d) << std::endl;
    std::cout << "O maior entre " << e[0] << " e " << f[0] << " é " << maximo(e, f) << std::endl;

    std::cout << funcao(100) << '\n';
    std::cout << funcao(3.14f) << '\n';
    std::cout << funcao(3.141516) << '\n';
    std::cout << funcao('a') << '\n';

    return 0;
}

