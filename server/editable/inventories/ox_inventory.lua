if Config["Core"]["Inventory"] ~= "ox_inventory" then return end

inventory = exports["ox_inventory"]

function AddItem(inv, item, amount, metadata)
    if amount < 0 then
        return false
    end

    local success, response = inventory:AddItem(inv, item, amount, metadata)
    return success
end

-- * If using ox_inventory this function is registered instead of the one in in editables/frameworks
function RemoveItem(inv, item, amount, slot)
    if amount < 0 then
        return false
    end

    local success = inventory:RemoveItem(inv, item, amount, nil, slot)
    return success
end

function HasItem(source, item)
    return exports.ox_inventory:Search(source, "count", item, nil) > 0
end
