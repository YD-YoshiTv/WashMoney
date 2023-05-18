ESX = exports["es_extended"]:getSharedObject()
local options = {
    {
        name = 'ox:option1',
        event = 'pulisci:soldi',
        icon = 'fa-solid fa-money-bill-wave',
        label = 'Pulisci Soldi',
    }
}
local modello = { 
    'ig_claypain'
}
exports.ox_target:addModel(modello, options)

-- BLIP IN MAPPA -- 
ydblip = AddBlipForCoord(722.5538, 2330.7517, 51.7504, 5.3307)
    SetBlipSprite(ydblip, 500)
    SetBlipScale(ydblip, 0.8)
    SetBlipColour(ydblip, 1)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Pulizia Soldi Sporchi")
    EndTextCommandSetBlipName(ydblip)

-- MODELLO PED --
Citizen.CreateThread(function()
  if not HasModelLoaded('ig_claypain') then
     RequestModel('ig_claypain')
     while not HasModelLoaded('ig_claypain') do
        Citizen.Wait(5)
     end
  end

npc = CreatePed(4, 'ig_claypain', 722.5538, 2330.7517, 50.7504, 5.3307, false, true)
FreezeEntityPosition(npc, true)
SetEntityInvincible(npc, true)
SetBlockingOfNonTemporaryEvents(npc, true)
end)

RegisterNetEvent('pulisci:soldi', function()
    local soldisporchi = exports.ox_inventory:Search('count', 'black_money')
    if soldisporchi >= 1 then
        local input = lib.inputDialog('YD DEV MONEY WASH', {
            {type = 'number', label = 'Inserisci il numero di quanti soldi vuoi lavare', icon = 'fa-solid fa-sack-dollar'},
        })

        if input and #input > 0 then
            TriggerServerEvent('yd_moneywash', input[1])
        end
        lib.notify({
            title = 'YD DEV MONEY WASH',
            description = 'John sta lavando i soldi attendi',
            type = 'success'
        })
        if lib.progressCircle({
            duration = 5000,
            position = 'botton',
            useWhileDead = false,
            canCancel = true,
        }) then TriggerServerEvent('togli:soldi', input[1]) end
        lib.notify({
            title = 'YD DEV MONEY WASH',
            description = 'John ha lavato i tuoi soldi',
            type = 'success'
        })
    else
      lib.notify({
          title = 'YD DEV MONEY WASH',
          description = 'Non hai soldi da pulire',
          type = 'error'
      })
    end
  end)