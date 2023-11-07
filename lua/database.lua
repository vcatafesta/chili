local driver = require('luasql.sqlite3')
local env = driver.sqlite3()
local db = env:connect('./litelua.db')

local results = db:execute[[
  SELECT * FROM example;
]]

local id,mail,url,lang,name = results:fetch()
while id do
  print(id..' | '..mail..' | '..url..' | '..lang ..' | '..name)
  id,mail,url,lang,name = results:fetch()
end

results:close()

db:close()
env:close()
