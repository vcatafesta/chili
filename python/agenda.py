import os

lista = []
arq2 = open("agenda.csv", "rw")
lista = arq2.readlines()
arq2.close()

print(lista)

def menu():
    print("\n", "=" * 50)
    print("1 - Criar contato")
    print("2 - Para excluir contato")
    print("3 - Para listar contatos")
    print("4 - Sair")

def lista_agenda(nome, data, opc):
    if(opc==1):
        contato = nome+";"+data+"\n"
        lista.append(contato)
        lista.sort()
        
        print("Contato inserido com sucesso!")
        os.system("sleep 1s")

    if(opc==2):
        tam = len(lista)
        
        for i in range(tam):
            print(i,"-",lista[i])

        delete = int(input("Qual deseja apagar? "))
        lista.pop(delete)
        print("Registro excluido")
        os.system("sleep 3s")

    if(opc==3):
        for i in lista:
            print(i)
        os.system("sleep 3s")

    if(opc==4):
        print("byebye")
        return 0;

    arq = open("agenda.csv", "w")
    tam = len(lista)

    for i in range(tam):
        arq.write(lista[i])
    arq.close()

o = 0

while True:
    os.system("clear")
    menu()
    o = int(input("Opcao: "))
    if(o==4):
        break
    if(o==1):
        n = input("Digite um nome: ")
        d = input("Digite uma data: ")
        lista_agenda(n,d,1)
    if(o==2):
        lista_agenda(0,0,2)
    if(o==3):
        lista_agenda(0,0,3)
