local lunajson = require("lunajson")

function readJSON(file_name)
    local file = io.open(file_name, "r")
    local data = file:read("*all")
    file:close()
    return lunajson.decode(data)
end

-- data = readJSON("summary.json")
-- print(data['1password']['id_name'])
-- print(data['1password']['summary']['pt_BR'])

local jsonstr = '{"Hello":["lunajson",1.5]}'
local t = lunajson.decode(jsonstr)
print(t.Hello[2]) -- prints 1.5
print(lunajson.encode(t)) -- prints {"Hello":["lunajson",1.5]}
