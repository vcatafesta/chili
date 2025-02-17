import os
import sys
import multiprocessing

def search_file(root, target, queue):
    """Busca o arquivo em um diretório e envia os resultados para a fila."""
    try:
        for entry in os.scandir(root):
            if entry.is_dir(follow_symlinks=False):
                # Cria um novo processo para explorar subdiretórios
                process = multiprocessing.Process(target=search_file, args=(entry.path, target, queue))
                process.start()
                process.join()  # Espera o processo filho terminar antes de continuar
            elif entry.name == target:
                queue.put(entry.path)  # Adiciona o caminho do arquivo na fila
    except PermissionError:
        pass  # Ignora diretórios sem permissão

def main():
    if len(sys.argv) < 3:
        print("Uso: python programa.py <caminho> <arquivo>")
        sys.exit(1)

    root = sys.argv[1]  # Caminho base
    target = sys.argv[2]  # Nome do arquivo
    queue = multiprocessing.Queue()  # Fila para armazenar os resultados

    # Cria o processo principal
    process = multiprocessing.Process(target=search_file, args=(root, target, queue))
    process.start()
    process.join()

    # Exibe os resultados encontrados
    results = []
    while not queue.empty():
        results.append(queue.get())

    if results:
        print("\nArquivos encontrados:")
        for path in results:
            print(path)
    else:
        print("\nNenhum arquivo encontrado.")

if __name__ == "__main__":
    multiprocessing.set_start_method("fork")  # Garante melhor compatibilidade no Linux
    main()
