local QBCore = exports['qbx-core']:GetCoreObject()

local marketPrices = {
    ["pan"] = 10,
    ["agua"] = 5,
    ["combustible"] = 50
}

-- Aplicar fluctuaciones de precios
local function UpdateMarketPrices()
    for item, price in pairs(marketPrices) do
        local change = math.random(Config.MarketFluctuation.min * 100, Config.MarketFluctuation.max * 100) / 100
        marketPrices[item] = math.floor(price + (price * change))
    end
    TriggerClientEvent('economy:updatePrices', -1, marketPrices)
end

-- Aplicar impuestos a transacciones
local function ApplyTax(amount, taxRate)
    local tax = math.floor(amount * taxRate)
    return amount - tax, tax
end

-- Pago de salarios con impuestos
local function PaySalaries()
    for _, player in pairs(QBCore.Functions.GetPlayers()) do
        local xPlayer = QBCore.Functions.GetPlayer(player)
        if xPlayer then
            local job = xPlayer.PlayerData.job.name
            local baseSalary = Config.BaseSalaries[job] or 300
            local salary, tax = ApplyTax(baseSalary, Config.TaxRates.salary)
            
            xPlayer.Functions.AddMoney('bank', salary, "Salario recibido")
            TriggerClientEvent('economy:receiveSalary', player, salary, tax)
        end
    end
end

-- Evento de compra de vehículo con impuestos
RegisterNetEvent('economy:buyVehicle', function(price)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)

    local finalPrice, tax = ApplyTax(price, Config.TaxRates.vehiclePurchase)

    if xPlayer.Functions.GetMoney('bank') >= finalPrice then
        xPlayer.Functions.RemoveMoney('bank', finalPrice, "Compra de vehículo")
        TriggerClientEvent('chat:addMessage', src, { args = {"^2[Economía]", "Has comprado un vehículo por $" .. finalPrice .. " (+ $" .. tax .. " impuestos)"} })
    else
        TriggerClientEvent('chat:addMessage', src, { args = {"^1[Error]", "No tienes suficiente dinero"} })
    end
end)

-- Iniciar economía dinámica
CreateThread(function()
    while true do
        Wait(Config.EconomyUpdateInterval * 60000)
        UpdateMarketPrices()
        PaySalaries()
    end
end)
