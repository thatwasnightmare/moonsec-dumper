--[[
    Written by Nightmare
    This is an old project
]]

local source = [=[]=] -- Put your script here
local patterns = {"if%(+.+==.+%)+then.+end if%(+.+==.+%)+then.+end if%(+.+==.+%)+then.+end", ".+%[+.+%]+=(.+)$"}

local split_semicolon = string.split(source, ";")
local moonsec_detected = false

for line = 1, #split_semicolon do
    local current_line = split_semicolon[line]
    local current_start = string.match(current_line, patterns[1])
    if current_start then
        local current_end = string.match(current_line, patterns[2])
        if current_end then
            split_semicolon[line] = current_line .. ' table.foreach(' .. current_end .. ',function(idx,val)if typeof(val)=="string"then val=string.gsub(val,"^%s*","")if val~=""and not table.find({"_", "__secureeq"},val)then print(val)end end end)'
            moonsec_detected = true
        end
    end
end

print("moonsec_detected", moonsec_detected)

if moonsec_detected then
    loadstring(table.concat(split_semicolon, ";"))()
end
