#!/usr/bin/env lua 

dias = {"Domingo", "Segunda", "Terca", "Quarta", "Quinta", "Sexta", "Sabado"}

-- for i = 1, 10, 2 do
--     print(i)
-- end

for k, v in pairs(dias) do
    print(k .. " - " .. v)
end

print(8 * 9, 9 / 8)
a = math.sin(3) + math.cos(10)
print(os.date())

print "Hello World"
print("Hello World")
dofile 'main.lua'
dofile('main.lua')
print [[a multi-line  
    message]]
print([[a multi-line
    message]])

type {}
type({})
print(os.date())
print(os.getenv("SHELL"))
print(os.getenv('CDPATH'))

function maximum(a)
    local mi = 1 -- maximum index
    local m = a[mi] -- maximum value
    for i, val in ipairs(a) do
        if val > m then
            mi = i
            m = val
        end
    end
    return m, mi
end

print(maximum({8, 10, 23, 12, 5})) -- > 23   3

local openPop = assert(io.popen('/bin/ls -la', 'r'))
local output = openPop:read('*all')
openPop:close()
print(output) -- > Prints the output of the command.

os.execute("ls")
-- Função para executar um comando e verificar o valor de retorno
local status = os.execute("ls -la")
if status == true then
    print("Comando executado com sucesso", status)
else
    print("O comando falhou com um código de saída: ", status)
end

-- set locale for Portuguese-Brazil
print(os.setlocale('pt_BR')) -- > pt_BR
print(3, 4) -- > 3    4
print(3.4) -- > stdin:1: malformed number near `3.4'

print(os.clock() / 60 / 60) -- > 34.381006944444 (hours)
print(os.date("%x")) -- > 25/04/07
print(os.date("%c")) -- > 25/04/07 10:10:05
print(os.date("%A, %m %B %Y")) -- > Wednesday, 04 April 2007

f = io.input("test.txt")
repeat
    s = f:read("*l") -- read one line
    if s then -- if not end of file (EOF)
        print(s) -- print that line
    end
until not s -- until end of file
f:close() -- close that file now

f = io.tmpfile()
print(io.type(f))
f:close()
print(io.type(f))

f = assert(io.tmpfile()) -- open temporary file
f:write("some data here") -- write to it
f:seek("set", 0) -- back to start
s = f:read("*a") -- read all of it back in
print(s) -- print out
f:close() -- close file

print(string.format("To wield the %s you need to be level %i", "sword", 10))
print(string.format("To wield the %%s you need to be level %%i", "sword", 10))
string.format("%g", 15.656) -- > 15.656
string.format("%g", 1) -- > 1
string.format("%g", 1.2) -- > 1.2

t = {
    "the",
    "quick",
    "brown",
    "fox",
    name = "Nick"
}

for k, v in pairs(t) do
    print(k, v)
end

t = {"the", "quick", "brown", "fox"}
table.insert(t, 2, "very") -- new element 2
table.insert(t, "jumped") -- add to end of table

for k, v in pairs(t) do
    print(k, v)
end
