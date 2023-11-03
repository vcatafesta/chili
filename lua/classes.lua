#!/usr/bin/env luajit

function addto(x)
    return function(y)
        return x + y
    end
end

fourplus = addto(4)
print(fourplus(3))

local Vetor = {} -- Criação da classe “Vetor”
Vetor.__index = Vetor

function Vetor:new(x, y, z) -- Construtor
    return setmetatable({
        x = x,
        y = y,
        z = z
    }, Vetor)
end

function Vetor:magnitude()
    -- Referenciamos atributos do próprio objeto utilizando “self”
    return math.sqrt(self.x ^ 2 + self.y ^ 2 + self.z ^ 2)
end

local vec = Vetor:new(0, 1, 0) -- Criação de um objeto da classe Vetor
print(vec:magnitude()) -- Chamada de um método (Saída: 1)
print(vec.x) -- Acessando um atributo (Saída: 0)

local Vetor = {}

do -- Um novo bloco
    Vetor.init = function(x, y, z) -- Construtor
        self = setmetatable({
            x = x,
            y = y,
            z = z
        }, {
            __index = Vetor
        })
        return self
    end

    function Vetor:magnitude() -- Função do objeto
        return math.sqrt(self.x ^ 2 + self.y ^ 2 + self.z ^ 2)
    end
end

local vec = Vetor.init(0, 1, 0) -- Criação de um objeto da classe Vetor
print(vec:magnitude()) -- Chamada de um método (Saída: 1)
print(vec.x) -- Acessando um atributo (Saída: 0)

function perfeitos(n)
    cont = 0
    x = 0
    print("Os números perfeitos são:")
    repeat
        x = x + 1
        soma = 0
        for i = 1, (x - 1) do
            if math.mod(x, i) == 0 then
                soma = soma + i;
            end
        end
        if soma == x then
            print(x)
            cont = cont + 1
        end
    until cont == n
    print("Pressione qualquer tecla para finalizar...")
end
