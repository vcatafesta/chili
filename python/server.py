# coding: utf-8
import socket
from os import system

ip = '0.0.0.0'
port = 666

server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
try:
    server.bind((ip, port))
    server.listen(5)
    print('Litening on %s %s' % (ip, port))
    (obj, cliente) = server.accept()
    print 'Connect received from %s' % cliente[0]
    while True:
        msg = obj.recv(1024)
        print msg
        if msg == 'dir\n':
            print 'Voce tentou obter os arquivos do sistema'
        else:
            print 'Comando invalido'

        obj.send(msg)
    server.close()
except Exception as erro:
    print erro

finally:
    server.close()
