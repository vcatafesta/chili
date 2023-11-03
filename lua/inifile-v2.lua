#!/usr/bin/env lua 

package.path = package.path .. ';demo/local/share/lua/5.3/?.lua'
inifile = require('inifile')
print(package.path)

-- find home directory
home = os.getenv('HOME')

-- detect path separator
-- returns '/' for Linux and Mac
-- and '\' for Windows
d = package.config:sub(1,1)

-- parse the INI file and
-- put values into a table called conf
conf = inifile.parse(home .. d .. 'myconfig.ini')

-- print the data for review
print(conf['example']['name'])
print(conf['example']['species'])
print(conf['example']['enabled'])

-- enable Tux
conf['example']['enabled'] = true
conf['novo']['vilmar'] = "catafesta"

-- save the change
inifile.save(home .. d .. 'myconfig.ini', conf)
