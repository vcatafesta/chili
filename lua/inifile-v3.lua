#!/usr/bin/env lua 

-- ==============================================================================
local function file_exists(path)
    local f = io.open(path)
    if f == nil then
        return
    end
    f:close()
    return path
end

--------------------------------------------------------------------------------
-- Read the whole configuration in a table such that each section is a key to
-- key/value pair table containing the corresponding pairs from the file.

function read_config(filename)
    filename = filename or ''
    assert(type(filename) == 'string')
    local ans, u, k, v, temp = {}
    if not file_exists(filename) then
        return ans
    end
    for line in io.lines(filename) do
        temp = line:match('^%[(.+)%]$')
        if temp ~= nil and u ~= temp then
            u = temp
        end
        k, v = line:match('^([^=]+)=(.+)$')
        if u ~= nil then
            ans[u] = ans[u] or {}
            if k ~= nil then
                ans[u][k] = v
            end
        end
    end
    return ans
end

--------------------------------------------------------------------------------
-- When all three parametes are nil, no action at all.
-- When both key and value are nil but section is not, delete section.
-- When only value is nil, delete key value pair for given section.

function write_config(filename, section, key, value)
    filename = filename or ''
    assert(type(filename) == 'string')
    if section == nil and key == nil and value == nil then
        return
    end
    local t = read_config(filename) -- read existing configuration, if any

    if section ~= nil and value == nil then
        if key == nil then
            t[section] = nil -- eliminate whole section
        else
            t[section][key] = nil -- eliminate key/value pair
        end
        goto WriteFile
    end

    if key:match '=' then
        error('An equals sign is not expected inside key')
    end

    t[section] = t[section] or {} -- create section if not present
    t[section][key] = value -- update key value

    ::WriteFile:: -- write to file
    local fo = io.open(filename, 'w')
    for k, v in pairs(t) do
        fo:write('[' .. k .. ']\n')
        for k, v in pairs(v) do
            fo:write(k .. '=' .. v .. '\n')
        end
        fo:write('\n')
    end
    fo:close()

    return t -- return updated configuration table
end

-- ==============================================================================

--------------------------------------------------------------------------------
-- Example use
--------------------------------------------------------------------------------

f = 'personal.ini' -- file to use

write_config(f, 'user2', 'id', 'my_id') -- update key value pair
write_config(f, 'user2', 'name', 'noone') -- add key value pair
write_config(f, 'user3', 'id', '818') -- update key value pair
write_config(f, 'user3', 'xxx', 'whatever') -- add key value pair
write_config(f, 'newuser', 'id', '54321') -- create new user
write_config(f, 'newuser', 'xxx', '54321') -- create new key/value pair
write_config(f, 'newuser', 'xxx') -- remove key/value pair
write_config(f, 'newuser') -- remove section

write_config(f, 'bigstore', 'snap', '1')
write_config(f, 'bigstore', 'flatpak', '0')
