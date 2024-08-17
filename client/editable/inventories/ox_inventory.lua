if Config["Core"].Inventory ~= "ox_inventory" then return end

function HasItem(item)
    return exports.ox_inventory:Search('count', item) > 0
end
