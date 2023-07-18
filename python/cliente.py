from socket import *


host = 'localhost'
port = 30800
mensagem = [b'Ola, bem vindo']
sockobj = socket(AF_INET, SOCK_STREAM)
sockobj.connect((host, port))


for linha in mensagem:
    sockobj.send(linha)
    data = sockobj.recv(1024)
    print("Cliente recebeu:", data)
    sockobj.close()
