import socket

ip = '10.0.0.66'
port = 6666

server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
server.connect((ip, port))
