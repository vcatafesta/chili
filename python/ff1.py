#!/usr/bin/python3
# -*- coding: utf-8 -*-

import os
import sys
import concurrent.futures

def search_file(root, target, results):
    try:
        for entry in os.scandir(root):  # Lista os arquivos/diretórios
            if entry.is_dir(follow_symlinks=False):
                with concurrent.futures.ThreadPoolExecutor() as executor:
                    executor.submit(search_file, entry.path, target, results)
            elif entry.name == target:
                results.append(entry.path)  # Salva o caminho do arquivo encontrado
    except PermissionError:
        pass  # Ignora diretórios sem permissão

def main():
    if len(sys.argv) < 3:
        print("Uso: python programa.py <caminho> <arquivo>")
        sys.exit(1)

    root = sys.argv[1]  # Caminho base para busca
    target = sys.argv[2]  # Nome do arquivo

    results = []  # Lista para armazenar os resultados

    # Usa um ThreadPoolExecutor para executar a busca
    with concurrent.futures.ThreadPoolExecutor() as executor:
        executor.submit(search_file, root, target, results)

    if results:
        print("\nArquivos encontrados:")
        for path in results:
            print(path)
    else:
        print("\nNenhum arquivo encontrado.")

if __name__ == "__main__":
    main()

