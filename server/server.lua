ESX = exports["es_extended"]:getSharedObject()

RegisterServerEvent('togli:soldi')
AddEventHandler('togli:soldi', function(quantita)
    local xPlayer = ESX.GetPlayerFromId(source)
    local soldidarimuovere = math.random(1, quantita)
    exports.ox_inventory:RemoveItem(source, 'black_money', quantita)
    xPlayer.addInventoryItem('money', soldidarimuovere)
end)

