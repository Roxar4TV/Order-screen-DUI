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
        url = ("nui://order_screen/html/ui.html"):format(cache.resource),
        width = 1920,
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

RegisterNetEvent("orderscreen:updateAll", function(orders, completedOrders)
    if duiHandle then
        duiHandle:sendMessage({
            action = "UPDATE_ORDERS",
            orders = orders,
            completedOrders = completedOrders
        })
    end
end)

AddEventHandler('playerSpawned', function()
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