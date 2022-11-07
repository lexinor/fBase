ESX = nil

	TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
	
	local PlayerData = {}
	
	RegisterNetEvent('esx:playerLoaded')
	AddEventHandler('esx:playerLoaded', function(xPlayer)
		 PlayerData = xPlayer
	end)
	
	RegisterNetEvent('esx:setJob')
	AddEventHandler('esx:setJob', function(job)  
		PlayerData.job = job  
		Wait(5000) 
	end)
	
	CreateThread(function()
		while ESX == nil do
			TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
			Wait(10)
		end
		while ESX.GetPlayerData().job == nil do
			Wait(10)
		end
		if ESX.IsPlayerLoaded() then
	
			ESX.PlayerData = ESX.GetPlayerData()
	
		end
	end)
	
	RegisterNetEvent('esx:playerLoaded')
	AddEventHandler('esx:playerLoaded', function(xPlayer)
		ESX.PlayerData = xPlayer
	end)
	
	
	RegisterNetEvent('esx:setJob')
	AddEventHandler('esx:setJob', function(job)
		ESX.PlayerData.job = job
	end)
	
	RegisterNetEvent('esx:setJob2')
	AddEventHandler('esx:setJob2', function(job2)
		ESX.PlayerData.job2 = job2
	end)

CreateThread(function()
    if Cartel.jeveuxblips then
        local cartelmap = AddBlipForCoord(Cartel.pos.blips.position.x, Cartel.pos.blips.position.y, Cartel.pos.blips.position.z)
    
        SetBlipSprite(cartelmap, 310)
        SetBlipColour(cartelmap, 0)
        SetBlipScale(cartelmap, 0.80)
        SetBlipAsShortRange(cartelmap, true)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentString("Quartier Cartel")
        EndTextCommandSetBlipName(cartelmap)
    end
    end)

function Coffrecartel()
    local Ccartel = RageUI.CreateMenu("Coffre", "Cartel")
        RageUI.Visible(Ccartel, not RageUI.Visible(Ccartel))
            while Ccartel do
            Wait(0)
            RageUI.IsVisible(Ccartel, true, true, true, function()

                RageUI.Separator("↓ Objet / Arme ↓")

                    RageUI.ButtonWithStyle("Retirer",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            CartelRetirerobjet()
                            RageUI.CloseAll()
                        end
                    end)
                    
                    RageUI.ButtonWithStyle("Déposer",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            CartelDeposerobjet()
                            RageUI.CloseAll()
                        end
                    end)
                end, function()
                end)
            if not RageUI.Visible(Ccartel) then
            Ccartel = RMenu:DeleteType("Ccartel", true)
        end
    end
end

CreateThread(function()
        while true do
            local Timer = 500
            if ESX.PlayerData.job2 and ESX.PlayerData.job2.name == 'cartel' then
            local plycrdjob = GetEntityCoords(PlayerPedId(), false)
            local jobdist = Vdist(plycrdjob.x, plycrdjob.y, plycrdjob.z, Cartel.pos.coffre.position.x, Cartel.pos.coffre.position.y, Cartel.pos.coffre.position.z)
            if jobdist <= 10.0 and Cartel.jeveuxmarker then
                Timer = 0
                DrawMarker(20, Cartel.pos.coffre.position.x, Cartel.pos.coffre.position.y, Cartel.pos.coffre.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 0, 0, 0, 255, 0, 1, 2, 0, nil, nil, 0)
                end
                if jobdist <= 1.0 then
                    Timer = 0
                        RageUI.Text({ message = "Appuyez sur ~u~[E]~s~ pour accéder au coffre", time_display = 1 })
                        if IsControlJustPressed(1,51) then
                        Coffrecartel()
                    end   
                end
            end 
        Wait(Timer)   
    end
end)


-- Garage

function Garagecartel()
  local Gcartel = RageUI.CreateMenu("Garage", "Cartel")
    RageUI.Visible(Gcartel, not RageUI.Visible(Gcartel))
        while Gcartel do
            Wait(0)
                RageUI.IsVisible(Gcartel, true, true, true, function()
                    RageUI.ButtonWithStyle("Ranger la voiture", nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
                        if (Selected) then   
                        local veh,dist4 = ESX.Game.GetClosestVehicle(playerCoords)
                        if dist4 < 4 then
                            DeleteEntity(veh)
                            RageUI.CloseAll()
                            end 
                        end
                    end) 

                    for k,v in pairs(Gcartelvoiture) do
                    RageUI.ButtonWithStyle(v.nom, nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
                        if (Selected) then
                        Wait(1)  
                            spawnuniCarcartel(v.modele)
                            RageUI.CloseAll()
                            end
                        end)
                    end
                end, function()
                end)
            if not RageUI.Visible(Gcartel) then
            Gcartel = RMenu:DeleteType("Garage", true)
        end
    end
end

CreateThread(function()
        while true do
            local Timer = 500
            if ESX.PlayerData.job2 and ESX.PlayerData.job2.name == 'cartel' then
            local plyCoords3 = GetEntityCoords(PlayerPedId(), false)
            local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, Cartel.pos.garage.position.x, Cartel.pos.garage.position.y, Cartel.pos.garage.position.z)
            if dist3 <= 10.0 and Cartel.jeveuxmarker then
                Timer = 0
                DrawMarker(20, Cartel.pos.garage.position.x, Cartel.pos.garage.position.y, Cartel.pos.garage.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 0, 0, 0, 255, 0, 1, 2, 0, nil, nil, 0)
                end
                if dist3 <= 3.0 then
                Timer = 0   
                    RageUI.Text({ message = "Appuyez sur ~u~[E]~s~ pour accéder au garage", time_display = 1 })
                    if IsControlJustPressed(1,51) then           
                        Garagecartel()
                    end   
                end
            end 
        Wait(Timer)
     end
end)

function spawnuniCarcartel(car)
    local car = GetHashKey(car)

    RequestModel(car)
    while not HasModelLoaded(car) do
        RequestModel(car)
        Wait(0)
    end

    local x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), false))
    local vehicle = CreateVehicle(car, Cartel.pos.spawnvoiture.position.x, Cartel.pos.spawnvoiture.position.y, Cartel.pos.spawnvoiture.position.z, Cartel.pos.spawnvoiture.position.h, true, false)
    SetEntityAsMissionEntity(vehicle, true, true)
    local plaque = "Cartel"..math.random(1,9)
    SetVehicleNumberPlateText(vehicle, plaque) 
    SetPedIntoVehicle(PlayerPedId(),vehicle,-1)
    SetVehicleCustomPrimaryColour(vehicle, 0, 0, 0)
    SetVehicleCustomSecondaryColour(vehicle, 0, 0, 0)
    SetVehicleMaxMods(vehicle)
end

itemstock = {}
function CartelRetirerobjet()
    local Stockcartel = RageUI.CreateMenu("Coffre", "Cartel")
    ESX.TriggerServerCallback('fcartel:getStockItems', function(items) 
    itemstock = items
   
    RageUI.Visible(Stockcartel, not RageUI.Visible(Stockcartel))
        while Stockcartel do
            Wait(0)
                RageUI.IsVisible(Stockcartel, true, true, true, function()
                        for k,v in pairs(itemstock) do 
                            if v.count > 0 then
                            RageUI.ButtonWithStyle(v.label, nil, {RightLabel = v.count}, true, function(Hovered, Active, Selected)
                                if Selected then
                                    local count = KeyboardInput("Combien ?", "", 3)
                                    TriggerServerEvent('fcartel:getStockItem', v.name, tonumber(count))
                                    CartelRetirerobjet()
                                end
                            end)
                        end
                    end
                end, function()
                end)
            if not RageUI.Visible(Stockcartel) then
            Stockcartel = RMenu:DeleteType("Coffre", true)
        end
    end
     end)
end

local PlayersItem = {}
function CartelDeposerobjet()
    local StockPlayer = RageUI.CreateMenu("Coffre", "Cartel")
    ESX.TriggerServerCallback('fcartel:getPlayerInventory', function(inventory)
        RageUI.Visible(StockPlayer, not RageUI.Visible(StockPlayer))
    while StockPlayer do
        Wait(0)
            RageUI.IsVisible(StockPlayer, true, true, true, function()
                for i=1, #inventory.items, 1 do
                    if inventory ~= nil then
                         local item = inventory.items[i]
                            if item.count > 0 then
                                        RageUI.ButtonWithStyle(item.label, nil, {RightLabel = item.count}, true, function(Hovered, Active, Selected)
                                            if Selected then
                                            local count = KeyboardInput("Combien ?", '' , 3)
                                            TriggerServerEvent('fcartel:putStockItems', item.name, tonumber(count))
                                            CartelDeposerobjet()
                                        end
                                    end)
                                end
                            else
                                RageUI.Separator('Chargement en cours')
                            end
                        end
                    end, function()
                    end)
                if not RageUI.Visible(StockPlayer) then
                StockPlayer = RMenu:DeleteType("Coffre", true)
            end
        end
    end)
end

Keys.Register('F7', 'cartel', 'Ouvrir le menu cartel', function()
    if ESX.PlayerData.job2 and ESX.PlayerData.job2.name == 'cartel' then    
    TriggerEvent('fellow:MenuFouille')
end
end)

function Theoriecartel()
    local Tcartel = RageUI.CreateMenu("Craft Théorie", "Cartel")
      RageUI.Visible(Tcartel, not RageUI.Visible(Tcartel))
          while Tcartel do
              Wait(0)
                  RageUI.IsVisible(Tcartel, true, true, true, function()
                    for k,v in pairs(Cartel.craft) do
                        RageUI.ButtonWithStyle(v.name, nil, {RightLabel = "?"},true, function(Hovered, Active, Selected)
                        if (Selected) then   
                            RageUI.Popup({message = "Pour craft le/la "..v.name.." vous avez besoin de :"})
                            if v.metaux ~= nil then
                            RageUI.Popup({message = "x"..v.metaux.. " Métaux"})
                            end
                            if v.poudre ~= nil then
                            RageUI.Popup({message = "x"..v.poudre.. "Poudre à canon"})
                            end
                            if v.meche ~= nil then
                            RageUI.Popup({message = "x"..v.meche.. " Mèche"})
                            end
                            if v.ruban ~= nil then
                            RageUI.Popup({message = "x"..v.ruban.. " Ruban adhésif"})
                            end
                            end
                        end)
                    end
                end, function()
                end)
              if not RageUI.Visible(Tcartel) then
              Tcartel = RMenu:DeleteType("Craft Théorie", true)
          end
      end
  end

CreateThread(function()
while true do
    local Timer = 500
    if ESX.PlayerData.job2 and ESX.PlayerData.job2.name == 'cartel' then
    local plyCoords3 = GetEntityCoords(PlayerPedId(), false)
    local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, Cartel.pos.theorie.position.x, Cartel.pos.theorie.position.y, Cartel.pos.theorie.position.z)
    if dist3 <= 10.0 and Cartel.jeveuxmarker then
        Timer = 0
        DrawMarker(20, Cartel.pos.theorie.position.x, Cartel.pos.theorie.position.y, Cartel.pos.theorie.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 0, 0, 0, 255, 0, 1, 2, 0, nil, nil, 0)
        end
        if dist3 <= 3.0 then
        Timer = 0   
            RageUI.Text({ message = "Appuyez sur ~u~[E]~s~ pour interagir avec la table", time_display = 1 })
            if IsControlJustPressed(1,51) then           
                Theoriecartel()
            end   
        end
    end 
Wait(Timer)
end
end)

function MenuCraftcartel()
    local Craftcartel = RageUI.CreateMenu("Craft Théorie", "Cartel")
    local Craftcartelsub = RageUI.CreateSubMenu(Craftcartel, "Craft Théorie", "Cartel")
    ESX.TriggerServerCallback('fcartel:getPlayerInventory', function(inventory)
    choixnbmet = 0
    choixnbmeche = 0
    choixnbpoudre = 0
    choixnbruban = 0
      RageUI.Visible(Craftcartel, not RageUI.Visible(Craftcartel))
          while Craftcartel do
              Wait(0)
                  RageUI.IsVisible(Craftcartel, true, true, true, function()
                    for v = 1, #inventory.items, 1 do
                        if inventory.items[v].name == "metaux" or inventory.items[v].name == "poudre" or inventory.items[v].name == "meche" or inventory.items[v].name == "ruban" then
                            RageUI.ButtonWithStyle(inventory.items[v].label.." ["..inventory.items[v].count.."]", nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
                                if (Selected) then
                                    if inventory.items[v].name == "metaux" then
                                        nbmetaux = KeyboardInput('Veuillez choisir le nombre de métaux pour le craft', '', 3)
                                        if tonumber(nbmetaux) then
                                            if inventory.items[v].count >= tonumber(nbmetaux) then
                                                RageUI.Popup({message = "~g~Montant validé"})
                                                choixnbmet = nbmetaux
                                            else
                                            RageUI.Popup({message = "Montant invalide, veuillez recommencer..."})
                                                choixnbmet = 0
                                            end
                                        else
                                            RageUI.Popup({message = "Vous n'avez pas saisi de nombre"})
                                            nbmetaux = 0
                                        end
                                    end
                                    if inventory.items[v].name == "meche" then
                                        nbmeche = KeyboardInput('Veuillez choisir le nombre de mèche pour le craft', '', 3)
                                        if tonumber(nbmeche) then
                                            if inventory.items[v].count >= tonumber(nbmeche) then
                                                RageUI.Popup({message = "~g~Montant validé"})
                                                choixnbmeche = nbmeche
                                            else
                                                RageUI.Popup({message = "Montant invalide, veuillez recommencer..."})
                                                choixnbmeche = 0
                                            end
                                        else
                                            RageUI.Popup({message = "Vous n'avez pas saisi de nombre"})
                                            nbmeche = 0
                                        end
                                    end
                                    if inventory.items[v].name == "poudre" then
                                        nbpoudre = KeyboardInput('Veuillez choisir le nombre de poudre pour le craft', '', 3)
                                        if tonumber(nbpoudre) then
                                            if inventory.items[v].count >= tonumber(nbpoudre) then
                                                RageUI.Popup({message = "~g~Montant validé"})
                                                choixnbpoudre = nbpoudre
                                            else
                                        RageUI.Popup({message = "Montant invalide, veuillez recommencer..."})
                                                choixnbpoudre = 0
                                            end
                                        else
                                            RageUI.Popup({message = "Vous n'avez pas saisi de nombre"})
                                            nbpoudre = 0
                                        end
                                    end
                                    if inventory.items[v].name == "ruban" then
                                        nbruban = KeyboardInput('Veuillez choisir le nombre de ruban adhésif pour le craft', '', 3)
                                        if tonumber(nbruban) then
                                            if inventory.items[v].count >= tonumber(nbruban) then
                                                RageUI.Popup({message = "~g~Montant validé"})
                                                choixnbruban = nbruban
                                            else
                                        RageUI.Popup({message = "Montant invalide, veuillez recommencer..."})
                                                choixnbruban = 0
                                            end
                                        else
                                            RageUI.Popup({message = "Vous n'avez pas saisi de nombre"})
                                            nbruban = 0
                                        end
                                    end
                                end
                            end)
                        end
                    end
                    RageUI.ButtonWithStyle("Passer au craft", nil, {RightLabel = "→→", Color = {BackgroundColor = RageUI.ItemsColour.Green}},true, function()
                    end, Craftcartelsub)
                        end, function()
                        end)
                        RageUI.IsVisible(Craftcartelsub, true, true, true, function()
                        RageUI.Separator('~b~Résumé :')
                        RageUI.Separator('x'..choixnbmet.." Métaux")
                        RageUI.Separator('x'..choixnbruban.." Ruban adhésif")
                        RageUI.Separator('x'..choixnbmeche.." Mèche")
                        RageUI.Separator('x'..choixnbpoudre.." Poudre à canon")
                        RageUI.ButtonWithStyle("Valider le craft", nil, {RightLabel = "→→→", Color = {BackgroundColor = RageUI.ItemsColour.Green}}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            if tonumber(choixnbmet) == Cartel.craft[1].metaux and tonumber(choixnbmeche) == Cartel.craft[1].meche and tonumber(choixnbpoudre) == Cartel.craft[1].poudre and tonumber(choixnbruban) == Cartel.craft[1].ruban then
                                RageUI.Popup({message = "~g~Le craft a réussi, vous avez perdu tout les matériaux utilisé et vous avez reçu votre arme"})
                                local item = Cartel.craft[1].weapon
                                TriggerServerEvent('cartelcraft:gg', item, tonumber(choixnbmet), tonumber(choixnbmeche), tonumber(choixnbpoudre), tonumber(choixnbruban))
                            elseif tonumber(choixnbmet) == Cartel.craft[2].metaux and tonumber(choixnbmeche) == Cartel.craft[2].meche and tonumber(choixnbpoudre) == Cartel.craft[2].poudre and tonumber(choixnbruban) == Cartel.craft[2].ruban then
                                RageUI.Popup({message = "~g~Le craft a réussi, vous avez perdu tout les matériaux utilisé et vous avez reçu votre arme"})
                                local item = Cartel.craft[2].weapon
                                TriggerServerEvent('cartelcraft:gg', item, tonumber(choixnbmet), tonumber(choixnbmeche), tonumber(choixnbpoudre), tonumber(choixnbruban))
                            elseif tonumber(choixnbmet) == Cartel.craft[3].metaux and tonumber(choixnbmeche) == Cartel.craft[3].meche and tonumber(choixnbpoudre) == Cartel.craft[3].poudre and tonumber(choixnbruban) == Cartel.craft[3].ruban then
                                RageUI.Popup({message = "~g~Le craft a réussi, vous avez perdu tout les matériaux utilisé et vous avez reçu votre arme"})
                                local item = Cartel.craft[3].weapon
                                TriggerServerEvent('cartelcraft:gg', item, tonumber(choixnbmet), tonumber(choixnbmeche), tonumber(choixnbpoudre), tonumber(choixnbruban))
                            elseif tonumber(choixnbmet) == Cartel.craft[4].metaux and tonumber(choixnbmeche) == Cartel.craft[4].meche and tonumber(choixnbpoudre) == Cartel.craft[4].poudre and tonumber(choixnbruban) == Cartel.craft[4].ruban then
                                RageUI.Popup({message = "~g~Le craft a réussi, vous avez perdu tout les matériaux utilisé et vous avez reçu votre arme"})
                                local item = Cartel.craft[4].weapon
                                TriggerServerEvent('cartelcraft:gg', item, tonumber(choixnbmet), tonumber(choixnbmeche), tonumber(choixnbpoudre), tonumber(choixnbruban))
                            elseif tonumber(choixnbmet) == Cartel.craft[5].metaux and tonumber(choixnbmeche) == Cartel.craft[5].meche and tonumber(choixnbpoudre) == Cartel.craft[5].poudre and tonumber(choixnbruban) == Cartel.craft[5].ruban then
                                RageUI.Popup({message = "~g~Le craft a réussi, vous avez perdu tout les matériaux utilisé et vous avez reçu votre arme"})
                                local item = Cartel.craft[5].weapon
                                TriggerServerEvent('cartelcraft:gg', item, tonumber(choixnbmet), tonumber(choixnbmeche), tonumber(choixnbpoudre), tonumber(choixnbruban))
                            elseif tonumber(choixnbmet) == Cartel.craft[6].metaux and tonumber(choixnbmeche) == Cartel.craft[6].meche and tonumber(choixnbpoudre) == Cartel.craft[6].poudre and tonumber(choixnbruban) == Cartel.craft[6].ruban then
                                RageUI.Popup({message = "~g~Le craft a réussi, vous avez perdu tout les matériaux utilisé et vous avez reçu votre arme"})
                                local item = Cartel.craft[6].weapon
                                TriggerServerEvent('cartelcraft:gg', item, tonumber(choixnbmet), tonumber(choixnbmeche), tonumber(choixnbpoudre), tonumber(choixnbruban))
                            elseif tonumber(choixnbmet) == Cartel.craft[7].metaux and tonumber(choixnbmeche) == Cartel.craft[7].meche and tonumber(choixnbpoudre) == Cartel.craft[7].poudre and tonumber(choixnbruban) == Cartel.craft[7].ruban then
                                RageUI.Popup({message = "~g~Le craft a réussi, vous avez perdu tout les matériaux utilisé et vous avez reçu votre arme"})
                                local item = Cartel.craft[7].weapon
                                TriggerServerEvent('cartelcraft:gg', item, tonumber(choixnbmet), tonumber(choixnbmeche), tonumber(choixnbpoudre), tonumber(choixnbruban))
                            elseif tonumber(choixnbmet) == Cartel.craft[8].metaux and tonumber(choixnbmeche) == Cartel.craft[8].meche and tonumber(choixnbpoudre) == Cartel.craft[8].poudre and tonumber(choixnbruban) == Cartel.craft[8].ruban then
                                RageUI.Popup({message = "~g~Le craft a réussi, vous avez perdu tout les matériaux utilisé et vous avez reçu votre arme"})
                                local item = Cartel.craft[8].weapon
                                TriggerServerEvent('cartelcraft:gg', item, tonumber(choixnbmet), tonumber(choixnbmeche), tonumber(choixnbpoudre), tonumber(choixnbruban))
                            elseif tonumber(choixnbmet) == Cartel.craft[9].metaux and tonumber(choixnbmeche) == Cartel.craft[9].meche and tonumber(choixnbpoudre) == Cartel.craft[9].poudre and tonumber(choixnbruban) == Cartel.craft[9].ruban then
                                RageUI.Popup({message = "~g~Le craft a réussi, vous avez perdu tout les matériaux utilisé et vous avez reçu votre arme"})
                                local item = Cartel.craft[9].weapon
                                TriggerServerEvent('cartelcraft:gg', item, tonumber(choixnbmet), tonumber(choixnbmeche), tonumber(choixnbpoudre), tonumber(choixnbruban))
                            elseif tonumber(choixnbmet) == Cartel.craft[10].metaux and tonumber(choixnbmeche) == Cartel.craft[10].meche and tonumber(choixnbpoudre) == Cartel.craft[10].poudre and tonumber(choixnbruban) == Cartel.craft[10].ruban then
                                RageUI.Popup({message = "~g~Le craft a réussi, vous avez perdu tout les matériaux utilisé et vous avez reçu votre arme"})
                                local item = Cartel.craft[10].weapon
                                TriggerServerEvent('cartelcraft:gg', item, tonumber(choixnbmet), tonumber(choixnbmeche), tonumber(choixnbpoudre), tonumber(choixnbruban))
                            elseif tonumber(choixnbmet) == Cartel.craft[11].metaux and tonumber(choixnbmeche) == Cartel.craft[11].meche and tonumber(choixnbpoudre) == Cartel.craft[11].poudre and tonumber(choixnbruban) == Cartel.craft[11].ruban then
                                RageUI.Popup({message = "~g~Le craft a réussi, vous avez perdu tout les matériaux utilisé et vous avez reçu votre arme"})
                                local item = Cartel.craft[11].weapon
                                TriggerServerEvent('cartelcraft:gg', item, tonumber(choixnbmet), tonumber(choixnbmeche), tonumber(choixnbpoudre), tonumber(choixnbruban))
                            else
                                RageUI.Popup({message = "~r~Craft non réussi, vous avez perdu tout les matériaux utilisé!"})
                                TriggerServerEvent('cartel_craft:nonvalider', tonumber(choixnbmet), tonumber(choixnbmeche), tonumber(choixnbpoudre), tonumber(choixnbruban))
                            end
                            RageUI.GoBack()
                            choixnbmet = 0
                            choixnbmeche = 0
                            choixnbpoudre = 0
                            choixnbruban = 0
                            choixnbpou = 0
                        end
                        end)
                        RageUI.ButtonWithStyle("~r~Réinitialiser et retourner en arrière", nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            choixnbmet = 0
                            choixnbmeche = 0
                            choixnbpoudre = 0
                            choixnbruban = 0
                            choixnbpou = 0
                            RageUI.GoBack()
                        end
                        end)
                        end, function()
                        end)
              if not RageUI.Visible(Craftcartel) and not RageUI.Visible(Craftcartelsub) then
              Craftcartel = RMenu:DeleteType("Craft Théorie", true)
          end
      end
    end)
  end

CreateThread(function()
while true do
    local Timer = 500
    if ESX.PlayerData.job2 and ESX.PlayerData.job2.name == 'cartel' then
    local plyCoords3 = GetEntityCoords(PlayerPedId(), false)
    local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, Cartel.pos.craftmenu.position.x, Cartel.pos.craftmenu.position.y, Cartel.pos.craftmenu.position.z)
    if dist3 <= 10.0 and Cartel.jeveuxmarker then
        Timer = 0
        DrawMarker(20, Cartel.pos.craftmenu.position.x, Cartel.pos.craftmenu.position.y, Cartel.pos.craftmenu.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 0, 0, 0, 255, 0, 1, 2, 0, nil, nil, 0)
        end
        if dist3 <= 3.0 then
        Timer = 0   
            RageUI.Text({ message = "Appuyez sur ~u~[E]~s~ pour craft", time_display = 1 })
            if IsControlJustPressed(1,51) then         
                MenuCraftcartel()
            end   
        end
    end 
Wait(Timer)
end
end)

function cartelRecolteMetaux()
    local ARM = RageUI.CreateMenu("Recolte métaux", "Cartel")
    
    RageUI.Visible(ARM, not RageUI.Visible(ARM))
    
    while ARM do
        Wait(0)
        RageUI.IsVisible(ARM, true, true, true, function()
                RageUI.ButtonWithStyle("Récolte de métaux", nil, {}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    RageUI.CloseAll()
                    recoltemetaux()
                    end
                end)
        end)
    
        if not RageUI.Visible(ARM) then
            ARM = RMenu:DeleteType("ARM", true)
            end
        end
    end

local recoltepossible = false
CreateThread(function()
        local playerPed = PlayerPedId()
        while true do
            local Timer = 500
            local plyCoords = GetEntityCoords(PlayerPedId(), false)
            local playerCoords = GetEntityCoords(PlayerPedId())
            zoneDistance = GetDistanceBetweenCoords(playerCoords, Cartel.farm.metaux.position.x, Cartel.farm.metaux.position.y, Cartel.farm.metaux.position.z)
                if IsEntityAtCoord(PlayerPedId(), 0.0, -0.0, -0.0, 1.5, 1.5, 1.5, 0, 1, 0) then 
                    Timer = 0
                        if IsControlJustPressed(1, 51) then
                            cartelRecolteMetaux()
                        end
            end
            if zoneDistance ~= nil then
                if zoneDistance > 1.5 then
                    recoltepossible = false
                end
            end
        Wait(Timer)
    end    
end)

function recoltemetaux()
    if not recoltepossible then
        recoltepossible = true
    while recoltepossible do
        Wait(2000)
        TriggerServerEvent('metaux')
    end
    else
        recoltepossible = false
    end
end

CreateThread(function()
    while true do
        local Timer = 500
        if ESX.PlayerData.job2 and ESX.PlayerData.job2.name == 'cartel' then
        local plyCoords3 = GetEntityCoords(PlayerPedId(), false)
        local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, Cartel.farm.metaux.position.x, Cartel.farm.metaux.position.y, Cartel.farm.metaux.position.z)
        if dist3 <= 10.0 and Cartel.jeveuxmarker then
            Timer = 0
            DrawMarker(20, Cartel.farm.metaux.position.x, Cartel.farm.metaux.position.y, Cartel.farm.metaux.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 0, 0, 0, 255, 0, 1, 2, 0, nil, nil, 0)
            end
            if dist3 <= 1.5 then
                Timer = 0   
                        RageUI.Text({ message = "Appuyez sur ~u~[E]~s~ pour récolter des métaux", time_display = 1 })
                        if IsControlJustPressed(1,51) then           
                            cartelRecolteMetaux()
                    end   
                end
            end 
        Wait(Timer)
    end
end)
------------------------------------
function cartelRecoltepoudre()
    local ARC = RageUI.CreateMenu("Recolte poudre à canon", "Cartel")
    
    RageUI.Visible(ARC, not RageUI.Visible(ARC))
    
    while ARC do
        Wait(0)
        RageUI.IsVisible(ARC, true, true, true, function()
                RageUI.ButtonWithStyle("Récolte de poudre à canon", nil, {}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    RageUI.CloseAll()
                    recoltepoudre()
                    end
                end)
        end)
    
        if not RageUI.Visible(ARC) then
            ARC = RMenu:DeleteType("ARC", true)
            end
        end
    end

local recoltepossible = false
CreateThread(function()
        local playerPed = PlayerPedId()
        while true do
            local Timer = 500
            local plyCoords = GetEntityCoords(PlayerPedId(), false)
            local playerCoords = GetEntityCoords(PlayerPedId())
            zoneDistance = GetDistanceBetweenCoords(playerCoords, Cartel.farm.poudre.position.x, Cartel.farm.poudre.position.y, Cartel.farm.poudre.position.z)
                if IsEntityAtCoord(PlayerPedId(), 0.0, -0.0, -0.0, 1.5, 1.5, 1.5, 0, 1, 0) then 
                    Timer = 0
                        if IsControlJustPressed(1, 51) then
                            cartelRecoltepoudre()
                        end
            end
            if zoneDistance ~= nil then
                if zoneDistance > 1.5 then
                    recoltepossible = false
                end
            end
        Wait(Timer)
    end    
end)

function recoltepoudre()
    if not recoltepossible then
        recoltepossible = true
    while recoltepossible do
        Wait(2000)
        TriggerServerEvent('poudre')
    end
    else
        recoltepossible = false
    end
end

CreateThread(function()
    while true do
        local Timer = 500
        if ESX.PlayerData.job2 and ESX.PlayerData.job2.name == 'cartel' then
        local plyCoords3 = GetEntityCoords(PlayerPedId(), false)
        local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, Cartel.farm.poudre.position.x, Cartel.farm.poudre.position.y, Cartel.farm.poudre.position.z)
        if dist3 <= 10.0 and Cartel.jeveuxmarker then
            Timer = 0
            DrawMarker(20, Cartel.farm.poudre.position.x, Cartel.farm.poudre.position.y, Cartel.farm.poudre.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 0, 0, 0, 255, 0, 1, 2, 0, nil, nil, 0)
            end
            if dist3 <= 1.5 then
                Timer = 0   
                        RageUI.Text({ message = "Appuyez sur ~u~[E]~s~ pour récolter de la poudre à canon", time_display = 1 })
                        if IsControlJustPressed(1,51) then           
                            cartelRecoltepoudre()
                    end   
                end
            end 
        Wait(Timer)
    end
end)

--------------------------------
function cartelRecolteMeche()
    local ARM = RageUI.CreateMenu("Recolte mèche", "Cartel")
    
    RageUI.Visible(ARM, not RageUI.Visible(ARM))
    
    while ARM do
        Wait(0)
        RageUI.IsVisible(ARM, true, true, true, function()
                RageUI.ButtonWithStyle("Récolte de mèche", nil, {}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    RageUI.CloseAll()
                    recoltemeche()
                    end
                end)
        end)
    
        if not RageUI.Visible(ARM) then
            ARM = RMenu:DeleteType("ARM", true)
            end
        end
    end

local recoltepossible = false
CreateThread(function()
        local playerPed = PlayerPedId()
        while true do
            local Timer = 500
            local plyCoords = GetEntityCoords(PlayerPedId(), false)
            local playerCoords = GetEntityCoords(PlayerPedId())
            zoneDistance = GetDistanceBetweenCoords(playerCoords, Cartel.farm.meche.position.x, Cartel.farm.meche.position.y, Cartel.farm.meche.position.z)
                if IsEntityAtCoord(PlayerPedId(), 0.0, -0.0, -0.0, 1.5, 1.5, 1.5, 0, 1, 0) then 
                    Timer = 0
                        if IsControlJustPressed(1, 51) then
                            cartelRecolteMeche()
                        end
            end
            if zoneDistance ~= nil then
                if zoneDistance > 1.5 then
                    recoltepossible = false
                end
            end
        Wait(Timer)
    end    
end)

function recoltemeche()
    if not recoltepossible then
        recoltepossible = true
    while recoltepossible do
        Wait(2000)
        TriggerServerEvent('meche')
    end
    else
        recoltepossible = false
    end
end

CreateThread(function()
    while true do
        local Timer = 500
        if ESX.PlayerData.job2 and ESX.PlayerData.job2.name == 'cartel' then
        local plyCoords3 = GetEntityCoords(PlayerPedId(), false)
        local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, Cartel.farm.meche.position.x, Cartel.farm.meche.position.y, Cartel.farm.meche.position.z)
        if dist3 <= 10.0 and Cartel.jeveuxmarker then
            Timer = 0
            DrawMarker(20, Cartel.farm.meche.position.x, Cartel.farm.meche.position.y, Cartel.farm.meche.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 0, 0, 0, 255, 0, 1, 2, 0, nil, nil, 0)
            end
            if dist3 <= 1.5 then
                Timer = 0   
                        RageUI.Text({ message = "Appuyez sur ~u~[E]~s~ pour récolter des mèches", time_display = 1 })
                        if IsControlJustPressed(1,51) then           
                            cartelRecolteMeche()
                    end   
                end
            end 
        Wait(Timer)
    end
end)

--------------------------------
function cartelRecolteruban()
    local ARL = RageUI.CreateMenu("Recolte ruban adhésif", "Cartel")
    
    RageUI.Visible(ARL, not RageUI.Visible(ARL))
    
    while ARL do
        Wait(0)
        RageUI.IsVisible(ARL, true, true, true, function()
                RageUI.ButtonWithStyle("Récolte de ruban adhésif", nil, {}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    RageUI.CloseAll()
                    recolteruban()
                    end
                end)
        end)
    
        if not RageUI.Visible(ARL) then
            ARL = RMenu:DeleteType("ARL", true)
            end
        end
    end

local recoltepossible = false
CreateThread(function()
        local playerPed = PlayerPedId()
        while true do
            local Timer = 500
            local plyCoords = GetEntityCoords(PlayerPedId(), false)
            local playerCoords = GetEntityCoords(PlayerPedId())
            zoneDistance = GetDistanceBetweenCoords(playerCoords, Cartel.farm.ruban.position.x, Cartel.farm.ruban.position.y, Cartel.farm.ruban.position.z)
                if IsEntityAtCoord(PlayerPedId(), 0.0, -0.0, -0.0, 1.5, 1.5, 1.5, 0, 1, 0) then 
                    Timer = 0
                        if IsControlJustPressed(1, 51) then
                            cartelRecolteruban()
                        end
            end
            if zoneDistance ~= nil then
                if zoneDistance > 1.5 then
                    recoltepossible = false
                end
            end
        Wait(Timer)
    end    
end)

function recolteruban()
    if not recoltepossible then
        recoltepossible = true
    while recoltepossible do
        Wait(2000)
        TriggerServerEvent('ruban')
    end
    else
        recoltepossible = false
    end
end

CreateThread(function()
    while true do
        local Timer = 500
        if ESX.PlayerData.job2 and ESX.PlayerData.job2.name == 'cartel' then
        local plyCoords3 = GetEntityCoords(PlayerPedId(), false)
        local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, Cartel.farm.ruban.position.x, Cartel.farm.ruban.position.y, Cartel.farm.ruban.position.z)
        if dist3 <= 10.0 and Cartel.jeveuxmarker then
            Timer = 0
            DrawMarker(20, Cartel.farm.ruban.position.x, Cartel.farm.ruban.position.y, Cartel.farm.ruban.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 0, 0, 0, 255, 0, 1, 2, 0, nil, nil, 0)
            end
            if dist3 <= 1.5 then
                Timer = 0   
                        RageUI.Text({ message = "Appuyez sur ~u~[E]~s~ pour récolter des ruban adhésif", time_display = 1 })
                        if IsControlJustPressed(1,51) then           
                            cartelRecolteruban()
                    end   
                end
            end 
        Wait(Timer)
    end
end)

function KeyboardInput(TextEntry, ExampleText, MaxStringLenght)
    AddTextEntry('FMMC_KEY_TIP1', TextEntry)
    blockinput = true
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght)
    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do 
        Wait(0)
    end 
        
    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult()
        Wait(500)
        blockinput = false
        return result
    else
        Wait(500)
        blockinput = false
        return nil
    end
end
