Config = {}

-- Impuestos
Config.TaxRates = {
    salary = 0.05,      -- 5% de impuestos sobre salarios
    vehiclePurchase = 0.10, -- 10% sobre compra de vehículos
    housePurchase = 0.07, -- 7% sobre compra de casas
    marketSales = 0.02  -- 2% sobre ventas en tiendas
}

-- Fluctuaciones del mercado
Config.MarketFluctuation = {
    min = -0.1, -- -10% mínimo
    max = 0.15  -- +15% máximo
}

-- Salarios base por trabajo
Config.BaseSalaries = {
    police = 500,
    ems = 450,
    mechanic = 400,
    trucker = 350
}

-- Intervalo de actualización de economía (minutos)
Config.EconomyUpdateInterval = 10
