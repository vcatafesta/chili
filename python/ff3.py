import os
import sys
import multiprocessing

def search_file(args):
    """Função que procura o arquivo dentro de um diretório."""
    root, target = args
    matches = []

    try:
        for entry in os.scandir(root):
            if entry.is_dir(follow_symlinks=False):
                continue  # Deixa para o pool de processos lidar com diretórios
            elif entry.name == target:
                matches.append(entry.path)
    except PermissionError:
        pass  # Ignora diretórios sem permissão

    return matches  # Retorna uma lista de caminhos encontrados

def main():
    if len(sys.argv) < 3:
        print("Uso: python programa.py <caminho> <arquivo>")
        sys.exit(1)

    root = sys.argv[1]  # Caminho base
    target = sys.argv[2]  # Nome do arquivo

    # Coleta todos os diretórios de nível superior para processamento paralelo
    dirs_to_search = [os.path.join(root, d) for d in os.listdir(root) if os.path.isdir(os.path.join(root, d))]
    dirs_to_search.append(root)  # Inclui o diretório raiz na busca

    with multiprocessing.Pool(processes=multiprocessing.cpu_count()) as pool:
        results = pool.map(search_file, [(d, target) for d in dirs_to_search])

    # Filtra e exibe os resultados encontrados
    matches = [match for sublist in results for match in sublist]

    if matches:
        print("\nArquivos encontrados:")
        for path in matches:
            print(path)
    else:
        print("\nNenhum arquivo encontrado.")

if __name__ == "__main__":
    multiprocessing.set_start_method("fork", force=True)  # Evita bugs em Unix-like
    main()
