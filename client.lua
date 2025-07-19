ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(1)
    end
end)

local tvPropHash = "prop_tv_flat_01"
local tvPropTxtHash = "script_rt_tvscreen"
local tvPropCoords = { x = 200.6409, y = -900.2134, z = 29.6630, h = 83.8239 }
local tvHandle = nil
local duiHandle = nil

function CreateDUI()
    if duiHandle ~= nil then return end
    duiHandle = lib.dui:new({
<<<<<<< HEAD
        url = ("nui://order_screen/html/ui.html"):format(cache.resource),
        width = 1920,
=======
        url = ("nui://order_screen/html/ui.html"):format(cache.resource), 
        width = 1920, 
>>>>>>> 1d147271a55aaf006421e0eeffe7a5bfc006c51f
        height = 1080,
        debug = false
    })
    lib.waitFor(function()
        if duiHandle and duiHandle.dictName and duiHandle.txtName then return true end
    end)

    if duiHandle and duiHandle.dictName and duiHandle.txtName then
        AddReplaceTexture(tvPropHash, tvPropTxtHash, duiHandle.dictName, duiHandle.txtName)
        Wait(500)
        duiHandle:sendMessage({ action = "DISPLAY" })
    end
end

function CreateTV(x, y, z, heading)
    local prop = CreateObject(tvPropHash, x, y, z, true, false, false)
    if prop then
        SetEntityHeading(prop, heading)
        FreezeEntityPosition(prop, true)
    end
    return prop
end

<<<<<<< HEAD
RegisterNetEvent("orderscreen:updateAll", function(orders, completedOrders)
=======
RegisterNetEvent("orderscreen:order:add", function()
    local order = { id = nextOrderId, text = "Order #" .. tostring(nextOrderId) }
    nextOrderId = nextOrderId + 1

    table.insert(orders, order)

    if duiHandle then
        duiHandle:sendMessage({
            action = "UPDATE_ORDERS",
            orders = orders,
            completedOrders = completedOrders
        })
    else
        ESX.ShowNotification("No active DUI.", "error", 3000) -- ENG
        -- ESX.ShowNotification("Brak aktywnego DUI.", "error", 3000) -- PL
        -- print("No active DUI.")
    end
end)

RegisterNetEvent("orderscreen:order:end", function(id)
    if not id then
        ESX.ShowNotification("You must provide the order ID to complete.", "info", 3000) -- ENG
        -- ESX.ShowNotification("Musisz podać ID zamówienia do zakończenia.", "info", 3000) -- PL
        -- print("You must provide the order ID to complete.")
        return
    end

    local foundIndex = nil
    for i, order in ipairs(orders) do
        if order.id == id then
            foundIndex = i
            break
        end
    end

    if not foundIndex then
        ESX.ShowNotification("Order with ID #" .. id .. " not found,", "error", 3000) -- ENG
        -- ESX.ShowNotification("Nie znaleziono zamówienia o ID #" .. id .. ".", "error", 3000) -- PL
        -- print("Order with ID #" .. id .. " not found.")
        return
    end

    local order = table.remove(orders, foundIndex)
    table.insert(completedOrders, order)

>>>>>>> 1d147271a55aaf006421e0eeffe7a5bfc006c51f
    if duiHandle then
        duiHandle:sendMessage({
            action = "UPDATE_ORDERS",
            orders = orders,
            completedOrders = completedOrders
        })
    end
end)

<<<<<<< HEAD
AddEventHandler('playerSpawned', function()
=======
RegisterNetEvent("orderscreen:order:clear", function(id)
    if not id then
        ESX.ShowNotification("You must provide the order ID to delete.", "info", 3000) -- ENG
        -- ESX.ShowNotification("Musisz podać ID zamówienia do usunięcia.", "info", 3000) -- PL
        -- print("Musisz podać ID zamówienia do usunięcia.")
        return
    end

    local foundIndex = nil
    for i, order in ipairs(completedOrders) do
        if order.id == id then
            foundIndex = i
            break
        end
    end

    if not foundIndex then
        ESX.ShowNotification("No order with #" .. id .. "found in completed.", "error", 3000) -- ENG
        -- ESX.ShowNotification("Nie znaleziono ukonczonego zamówienia o ID #" .. id .. ".", "error", 3000) -- PL
        -- print("No order with #" .. id .. "found in completed.")
        return
    end

    table.remove(completedOrders, foundIndex)

    if duiHandle then
        duiHandle:sendMessage({
            action = "UPDATE_ORDERS",
            orders = orders,
            completedOrders = completedOrders
        })
    end
end)

-- -- Komendy testowe
-- RegisterCommand("order", function()
--     TriggerEvent("orderscreen:order:add")
-- end, false)

-- RegisterCommand("orderend", function(source, args)
--     local id = tonumber(args[1])
--     TriggerEvent("orderscreen:order:end", id)
-- end, false)

-- RegisterCommand("orderclear", function(source, args)
--     local id = tonumber(args[1])
--     TriggerEvent("orderscreen:order:clear", id)
-- end, false)
-- -------------------

CreateThread(function()
    Wait(1000)
>>>>>>> 1d147271a55aaf006421e0eeffe7a5bfc006c51f
    tvHandle = CreateTV(tvPropCoords.x, tvPropCoords.y, tvPropCoords.z, tvPropCoords.h)
    Wait(5000)
    CreateDUI()
    Wait(1000)
    TriggerServerEvent("orderscreen:requestSync")
end)

AddEventHandler('onResourceStart', function(resource)
    if resource ~= GetCurrentResourceName() then return end
    tvHandle = CreateTV(tvPropCoords.x, tvPropCoords.y, tvPropCoords.z, tvPropCoords.h)
    Wait(5000)
    CreateDUI()
    Wait(1000)
    TriggerServerEvent("orderscreen:requestSync")
end)

AddEventHandler('onResourceStop', function(resource)
    if resource ~= GetCurrentResourceName() then return end
    RemoveReplaceTexture(tvPropHash, tvPropTxtHash)
    DeleteEntity(tvHandle)
end)

RegisterCommand("order", function()
    TriggerServerEvent("orderscreen:order:add")
end, false)

RegisterCommand("orderend", function(source, args)
    local id = tonumber(args[1])
    if id then
        TriggerServerEvent("orderscreen:order:end", id)
    else
        ESX.ShowNotification("You must provide the order ID to complete.", "info", 3000)
    end
end, false)

RegisterCommand("orderclear", function(source, args)
    local id = tonumber(args[1])
    if id then
        TriggerServerEvent("orderscreen:order:clear", id)
    else
        ESX.ShowNotification("You must provide the order ID to clear.", "info", 3000)
    end
end, false)