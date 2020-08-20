import math

def soma(x: float, y: float) -> float:
    return x + y

def main() ->None :
    num = input('Entre com o numero: ')
    try:
        raiz = math.sqrt(int(num))
    except (ValueError, EnvironmentError, SyntaxError, NameError) as E:  # catch multiple exception
        print(E)
        print('Erro: Somente numeros')
        exit(1)
    print(f'A raiz quadrada de {num} é {raiz}')


if __name__ == '__main__':
    main()
