local QBCore = exports['qbx-core']:GetCoreObject()

-- Recibir actualización de precios
RegisterNetEvent('economy:updatePrices', function(prices)
    for item, price in pairs(prices) do
        TriggerEvent('chat:addMessage', { args = {"^2[Economía]", "El precio de " .. item .. " ha cambiado a $" .. price} })
    end
end)

-- Notificación de salario recibido
RegisterNetEvent('economy:receiveSalary', function(amount, tax)
    TriggerEvent('chat:addMessage', { args = {"^2[Economía]", "Has recibido tu salario: $" .. amount .. " (- $" .. tax .. " impuestos)"} })
end)
