MySQL.Async.execute('UPDATE market_prices SET price = @price WHERE item = @item', {
    ['@price'] = newPrice,
    ['@item'] = item
})
