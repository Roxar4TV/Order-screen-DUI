--[[
  #######################################
  # Author: Roxar4TV / Discord: roxar4tv
  # © 2025 All rights reserved
  # Unauthorized distribution or resale is prohibited
  #######################################
]]

local orders = {}
local completedOrders = {}
local nextOrderId = 1

RegisterServerEvent("orderscreen:order:add")
AddEventHandler("orderscreen:order:add", function()
    local order = { id = nextOrderId, text = "Order #" .. tostring(nextOrderId) }
    nextOrderId = nextOrderId + 1

    table.insert(orders, order)
    -- print("Dodano zamówienie: " .. order.text)
    TriggerClientEvent("orderscreen:updateAll", -1, orders, completedOrders)
end)

RegisterServerEvent("orderscreen:order:end")
AddEventHandler("orderscreen:order:end", function(id)
    if not id then 
        print("Błąd: ID zamówienia jest puste.")
        return 
    end
    for i, order in ipairs(orders) do
        if order.id == id then
            local removed = table.remove(orders, i)
            table.insert(completedOrders, removed)
            -- print("Zakończono zamówienie: " .. removed.text)
            TriggerClientEvent("orderscreen:updateAll", -1, orders, completedOrders)
            return
        end
    end
    print("Błąd: Nie znaleziono zamówienia o ID: " .. tostring(id))
end)

RegisterServerEvent("orderscreen:order:clear")
AddEventHandler("orderscreen:order:clear", function(id)
    if not id then 
        print("Błąd: ID zamówienia jest puste.")
        return 
    end
    for i, order in ipairs(completedOrders) do
        if order.id == id then
            table.remove(completedOrders, i)
            -- print("Usunięto zakończone zamówienie: " .. order.text)
            TriggerClientEvent("orderscreen:updateAll", -1, orders, completedOrders)
            return
        end
    end
    print("Błąd: Nie znaleziono zakończonego zamówienia o ID: " .. tostring(id))
end)

RegisterServerEvent("orderscreen:requestSync")
AddEventHandler("orderscreen:requestSync", function()
    local src = source
    TriggerClientEvent("orderscreen:updateAll", src, orders, completedOrders)
    -- print("Synchronizacja zamówień dla gracza: " .. tostring(src))
end)