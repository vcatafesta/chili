#!/usr/bin/env lua 

print( "O nome do arquivo é: " .. arg[0])

print([[Quantidade de argumentos
via linha de comando: ]] .. #arg)

if( #arg > 0 ) then
  for i = 1,#arg do
    print("Argumento "..i.." é "..arg[i])
  end
end

print("O comando é: " .. arg[-1])

