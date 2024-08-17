if Config["Core"]["Inventory"] ~= "custom" then return end

function AddItem(inv, item, amount, metadata)
    return true
end

function RemoveItem(inv, item, amount, slot)
    return true
end

function HasItem(source, item)
    return true
end
