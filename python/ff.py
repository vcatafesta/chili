import os
import sys
import multiprocessing

def search_file(root, target, queue):
    """Busca recursivamente pelo arquivo e coloca os resultados na fila."""
    try:
        for dirpath, _, filenames in os.walk(root, followlinks=False):
            if target in filenames:
                queue.put(os.path.join(dirpath, target))  # Encontra e adiciona à fila
    except PermissionError:
        pass  # Ignora diretórios sem permissão

def main():
    if len(sys.argv) < 3:
        print("Uso: python programa.py <caminho> <arquivo>")
        sys.exit(1)

    root = sys.argv[1]  # Diretório base
    target = sys.argv[2]  # Nome do arquivo
    queue = multiprocessing.Queue()  # Fila para armazenar os resultados

    # Criando múltiplos processos para acelerar a busca
    num_processes = multiprocessing.cpu_count()
    processes = []
    for _ in range(num_processes):
        p = multiprocessing.Process(target=search_file, args=(root, target, queue))
        p.start()
        processes.append(p)

    # Espera os processos terminarem
    for p in processes:
        p.join()

    # Coletando resultados
    results = []
    while not queue.empty():
        results.append(queue.get())

    # Exibe os resultados
    if results:
        print("\nArquivos encontrados:")
        for path in results:
            print(path)
    else:
        print("\nNenhum arquivo encontrado.")

if __name__ == "__main__":
    multiprocessing.set_start_method("fork", force=True)  # Evita bugs em Unix
    main()
