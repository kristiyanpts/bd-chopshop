if Config["Core"]["Inventory"] ~= "codem-inventory" then return end

function AddItem(source, item, amount, metadata)
    -- OLD CODE, if you want to use it, you need to uncomment it and comment the new code
    -- local Player = Framework.Functions.GetPlayer(source)
    -- if not Player or amount < 0 then
    --     return false
    -- end

    -- if Player.Functions.AddItem(item, amount, nil, metadata) then
    --     return true
    -- else
    --     return false
    -- end

    -- NEW CODE
    return exports['codem-inventory']:AddItem(source, item, amount, nil, metadata, 'bd-computer additem function')
end

function RemoveItem(source, item, amount, slot)
    -- OLD CODE, if you want to use it, you need to uncomment it and comment the new code
    -- local Player = Framework.Functions.GetPlayer(source)
    -- if not Player or amount < 0 then
    --     return false
    -- end

    -- if Player.Functions.RemoveItem(item, amount) then
    --     return true
    -- else
    --     return false
    -- end

    -- NEW CODE
    return exports['codem-inventory']:RemoveItem(source, item, amount, slot, 'bd-computer removeitem function')
end

function HasItem(source, item)
    -- OLD CODE, if you want to use it, you need to uncomment it and comment the new code
    -- local Player = Framework.Functions.GetPlayer(source)
    -- if not Player then
    --     return false
    -- end

    -- return Player.Functions.GetItemByName(item)

    -- NEW CODE
    return exports['codem-inventory']:HasItem(source, item, 1)
end
