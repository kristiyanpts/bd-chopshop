if Config["Core"].Inventory ~= "qb-inventory" then return end

function HasItem(item)
    return Framework.Functions.HasItem(item)
end
