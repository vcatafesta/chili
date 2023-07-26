#include <iostream>
#include <unordered_map>
#include <string>

namespace hash = std::unordered_map;

int main() {
    // Criando um mapa vazio
    std::unordered_map<std::string, int> mapa;

    // Inserindo pares chave-valor no mapa
    mapa.insert({"chave1", 42});
    mapa.insert({"chave2", 17});
    mapa.insert({"chave3", 99});

    // Acessando valores a partir das chaves
    std::cout << "Tamanho do mapa     " << mapa.size() << std::endl;
    std::cout << "O valor de chave2 é " << mapa["chave2"] << std::endl;

    // Verificando se uma chave existe no mapa
    if (mapa.count("chave4")) {
        std::cout << "A chave4 está no mapa!" << std::endl;
    } else {
        std::cout << "A chave4 não está no mapa." << std::endl;
    }

    // Removendo um par chave-valor do mapa
    mapa.erase("chave1");

    // Iterando sobre os pares chave-valor no mapa
    for (const auto& par : mapa) {
        std::cout << "A chave " << par.first << " tem o valor " << par.second << std::endl;
    }

    return 0;
}

