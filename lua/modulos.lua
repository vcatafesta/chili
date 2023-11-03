#!/usr/bin/env lua

math = require("matematica")
print(math.add(1, 3))
print(math.seed)

function exec_chonos()
    local chronos = require("chronos")
    local start = chronos.nanotime()
    os.execute("sleep 1")
    local stop = chronos.nanotime()
    print(("sleep took %s seconds"):format(stop - start))
end
-- exec_chonos()

-- assert
velocidade = 10
assert(velocidade == 10, "Velocidade diferente de 10")

-- tostring
print(type(velocidade))
print(tostring(velocidade))

-- tonumber
str = "20"
print(type(str))
n = tonumber(str)
print(type(n))

function substr(cString, nStart, nCount) -- > cSubstring
    str = cString or ''
    return string.sub(str, nStart, nCount)
end
str = "Vilmar Catafesta"
print(substr(str, 8, 12))

local io = require('io')
f = io.open('io.txt', 'a+')
f:write("nova linha\n")
f:close()

local DOCUMENT_ID, DOCUMENT_FILE_NAME = arg[1], arg[2]
print("Document id " .. DOCUMENT_ID)
print("Generated file name " .. DOCUMENT_FILE_NAME)

local tbl = {"this", 2, 9.9, true, {"ok", "cool"}}
-- #tbl
for i = 1, #tbl do
    print(tbl[i])
end

-- pairs
for i in pairs(tbl) do
    print(i, tbl[i])
end

-- ipairs
for i in ipairs(tbl) do
    print(i, tbl[i])
end

local names = {
    name = "Vilmar",
    age = 57,
    location = "Pimenta Bueno"
}
print(names.name)
print(names.age)
print(names.location)
print(names.location)

