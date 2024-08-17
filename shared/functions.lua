local currentResourceName = GetCurrentResourceName()

function debugPrint(...)
    if not Config["Core"]["DebugEnabled"] then
        return
    end

    local args = { ... }

    local appendStr = ''
    for _, v in ipairs(args) do
        appendStr = appendStr .. ' ' .. tostring(v)
    end

    local msgTemplate = '^3[%s]^0%s'
    local finalMsg = msgTemplate:format(currentResourceName, appendStr)
    print(finalMsg)
end

--- This will print the table in JSON like format to the console.
---@param tbl any The table to print.
function debugTable(tbl)
    if not Config["Core"]["DebugEnabled"] then
        return
    end

    if type(tbl) ~= "table" then
        debugPrint("Invalid input. Expected a table.")
        return
    end

    local function printTableHelper(tbl, indent)
        indent = indent or 0
        local indentStr = string.rep("  ", indent)

        for key, value in pairs(tbl) do
            if type(value) == "table" then
                print(indentStr .. key .. " = {")
                printTableHelper(value, indent + 1)
                print(indentStr .. "}")
            else
                print(indentStr .. key .. " = " .. tostring(value))
            end
        end
    end

    printTableHelper(tbl)
end

function indexOf(array, value)
    local index = 0
    for i, v in pairs(array) do
        index = index + 1
        if i == value then
            return index
        end
    end
    return nil
end

function arrayLength(array)
    local length = 0
    for _, __ in pairs(array) do
        length = length + 1
    end
    return length
end
