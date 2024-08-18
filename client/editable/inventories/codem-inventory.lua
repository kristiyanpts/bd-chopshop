if Config["Core"].Inventory ~= "codem-inventory" then return end

function HasItem(item)
    return Framework.Functions.HasItem(item)
end
