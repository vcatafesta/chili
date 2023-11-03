#!/usr/bin/env lua 

a = {} -- criar tabela vazia
print(a)
a[1] = "ChiliLinux"
a[2] = "Vilmar"
a[3] = 3
a['x'] = 10
a["y"] = 20
print(a[1])
print(a[2])
print(a[3])
print(a['x'])
print(a["y"])
key = 'x'
print(a[key])

notas = {25, 20, 22, 23}
for i in ipairs(notas) do
    print(notas[i])
end

print(notas[1])
print(notas[2])
print(notas[3])
print(notas[4])

dados = {
    nome = "Vilmar",
    tipo = "Devboy",
    posicao = {
        x = 10,
        y = 20,
        z = 30
    },
    mochila = {
        corda = 1,
        pederneira = 1,
        medicamento = 5
    }
}

print(dados.nome)
print(dados.tipo)
print(dados.posicao.x)
print(dados.posicao.y)
print(dados.posicao.z)
print(dados.mochila.corda)
print(dados.mochila.medicamento)

for i = 0, #dados do
    print(a[i])
    print(dados[i])
end
