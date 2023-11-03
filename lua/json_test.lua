#!/usr/bin/env lua 
-- pacman -S luarocks
-- sudo luarocks install lua-cjson

local cjson = require "cjson"

local json = cjson.encode({
    foo = "bar",
    some_object = {},
    some_array = cjson.empty_array
})
print(json)

local t = { "hello", "world" }
setmetatable(t, cjson.array_mt)
cjson.encode(t) -- ["hello","world"]
print(t)

local t = {}
t[1] = "one"
t[2] = "two"
t[4] = "three"
t.foo = "bar"
setmetatable(t, cjson.array_mt)
cjson.encode(t) -- ["one","two",null,"three"]
print(t)

local function serialize(arr)
    if #arr < 1 then
        arr = cjson.empty_array
    end

    return cjson.encode({some_array = arr})
end

