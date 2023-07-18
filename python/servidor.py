from socket import *

host = ''
port = 30800

sockobj = socket(AF_INET, SOCK_STREAM)
sockobj.bind((host, port))
sockobj.listen(5)

while True:
    conexao, endereco = sockobj.accept()
    print("Servidor:", endereco)

    while True:
        data = conexao.recv(1024)
        if not data:
            break
        conexao.send(b'Echo=>' + data)

conexao.close()
