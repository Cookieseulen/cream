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
	Citizen.Wait(5000) 
end)

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
    end
    while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
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


Citizen.CreateThread(function()
    if Orpi.jeveuxblips then
    local agentmap = AddBlipForCoord(Orpi.pos.blips.position.x, Orpi.pos.blips.position.y, Orpi.pos.blips.position.z)
    SetBlipSprite(agentmap, 357)
    SetBlipColour(agentmap, 0)
    SetBlipScale(agentmap, 0.6)
    SetBlipAsShortRange(agentmap, true)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString("Orpi")
    EndTextCommandSetBlipName(agentmap)
    end
end)

---f6

function Menuf6Agent()
    local zOrpif6 = RageUI.CreateMenu("Orpi", "Interactions")
    zOrpif6:SetRectangleBanner(0, 0, 11)
    RageUI.Visible(zOrpif6, not RageUI.Visible(zOrpif6))
    while zOrpif6 do
        Citizen.Wait(0)
            RageUI.IsVisible(zOrpif6, true, true, true, function()

                RageUI.Separator("↓ Creationt de Proprieté ↓")

                RageUI.ButtonWithStyle("Creationt de Proprieté",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        ExecuteCommand('openProperty')
                        RageUI.CloseAll()
                    end
                end)

                --[[RageUI.Separator("↓ Gestiont des Client ↓")

                RageUI.ButtonWithStyle("Gestiont des Client",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        ExecuteCommand('clients')
                        RageUI.CloseAll()
                    end
                end)


                RageUI.Separator("↓ Facture ↓")

                RageUI.ButtonWithStyle("Facture",nil, {RightLabel = "→"}, true, function(_,_,s)
                    local player, distance = ESX.Game.GetClosestPlayer()
                    if s then
                        local raison = ""
                        local montant = 0
                        AddTextEntry("FMMC_MPM_NA", "Objet de la facture")
                        DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "Donnez le motif de la facture :", "", "", "", "", 30)
                        while (UpdateOnscreenKeyboard() == 0) do
                            DisableAllControlActions(0)
                            Wait(0)
                        end
                        if (GetOnscreenKeyboardResult()) then
                            local result = GetOnscreenKeyboardResult()
                            if result then
                                raison = result
                                result = nil
                                AddTextEntry("FMMC_MPM_NA", "Montant de la facture")
                                DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "Indiquez le montant de la facture :", "", "", "", "", 30)
                                while (UpdateOnscreenKeyboard() == 0) do
                                    DisableAllControlActions(0)
                                    Wait(0)
                                end
                                if (GetOnscreenKeyboardResult()) then
                                    result = GetOnscreenKeyboardResult()
                                    if result then
                                        montant = result
                                        result = nil
                                        if player ~= -1 and distance <= 3.0 then
                                            TriggerServerEvent('esx_billing:sendBill1', GetPlayerServerId(player), 'society_orpi', ('Orpi'), montant)
                                            TriggerEvent('esx:showAdvancedNotification', 'Fl~g~ee~s~ca ~g~Bank', 'Facture envoyée : ', 'Vous avez envoyé une facture d\'un montant de : ~g~'..montant.. '$ ~s~pour cette raison : ~b~' ..raison.. '', 'CHAR_BANK_FLEECA', 9)
                                        else
                                            ESX.ShowNotification("~r~Probleme~s~: Aucuns joueurs proche")
                                        end
                                    end
                                end
                            end
                        end
                    end
                end)--]]


                RageUI.Separator("↓ Annonce ↓")



                RageUI.ButtonWithStyle("Annonces d'ouverture",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then       
                        TriggerServerEvent('zOrpi:Ouvert')
                    end
                end)
        
                RageUI.ButtonWithStyle("Annonces de fermeture",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then      
                        TriggerServerEvent('zOrpi:Fermer')
                    end
                end)
        
                RageUI.ButtonWithStyle("Personnalisé", nil, {RightLabel = nil}, true, function(Hovered, Active, Selected)
                    if (Selected) then
                        local msg = KeyboardInput("Message", "", 100)
                        TriggerServerEvent('zOrpi:Perso', msg)
                    end
                end)
                end, function() 
                end)
    
                if not RageUI.Visible(zOrpif6) then
                    zOrpif6 = RMenu:DeleteType("Orpi", true)
        end
    end
end

Keys.Register('F6', 'orpi', 'Ouvrir le menu Orpi', function()
	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'orpi' then
    	Menuf6Agent()
	end
end)

-----------Coffre

function Coffreagent()
    local COrpi = RageUI.CreateMenu("Coffre", "Orpi")
    COrpi:SetRectangleBanner(0, 0, 11)
        RageUI.Visible(COrpi, not RageUI.Visible(COrpi))
            while COrpi do
            Citizen.Wait(0)
            RageUI.IsVisible(COrpi, true, true, true, function()

                RageUI.Separator("↓ Objet / Arme ↓")

                    RageUI.ButtonWithStyle("Retirer",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            AgentRetirerobjet()
                            RageUI.CloseAll()
                        end
                    end)
                    
                    RageUI.ButtonWithStyle("Déposer",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            AgentDeposerobjet()
                            RageUI.CloseAll()
                        end
                    end)
                end, function()
                end)
            if not RageUI.Visible(COrpi) then
            COrpi = RMenu:DeleteType("COrpi", true)
        end
    end
end

Citizen.CreateThread(function()
        while true do
            local Timer = 500
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'orpi' then
            local plycrdjob = GetEntityCoords(GetPlayerPed(-1), false)
            local jobdist = Vdist(plycrdjob.x, plycrdjob.y, plycrdjob.z, Orpi.pos.coffre.position.x, Orpi.pos.coffre.position.y, Orpi.pos.coffre.position.z)
            if jobdist <= 10.0 and Orpi.jeveuxmarker then
                Timer = 0
                DrawMarker(20, Orpi.pos.coffre.position.x, Orpi.pos.coffre.position.y, Orpi.pos.coffre.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 0, 0, 11, 255, 0, 1, 2, 0, nil, nil, 0)
                end
                if jobdist <= 1.0 then
                    Timer = 0
                        RageUI.Text({ message = "Appuyez sur ~y~[E]~s~ pour accéder au coffre", time_display = 1 })
                        if IsControlJustPressed(1,51) then
                        Coffreagent()
                    end   
                end
            end 
        Citizen.Wait(Timer)   
    end
end)


-- Garage

function GarageAgent()
  local GOrpi = RageUI.CreateMenu("Garage", "Orpi")
  GOrpi:SetRectangleBanner(0, 0, 11)
    RageUI.Visible(GOrpi, not RageUI.Visible(GOrpi))
        while GOrpi do
            Citizen.Wait(0)
                RageUI.IsVisible(GOrpi, true, true, true, function()
                    RageUI.ButtonWithStyle("Ranger la voiture", nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
                        if (Selected) then   
                        local veh,dist4 = ESX.Game.GetClosestVehicle(playerCoords)
                        if dist4 < 4 then
                            DeleteEntity(veh)
                            RageUI.CloseAll()
                            end 
                        end
                    end) 

                    for k,v in pairs(GOrpivoiture) do
                    RageUI.ButtonWithStyle(v.nom, nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
                        if (Selected) then
                        Citizen.Wait(1)  
                            spawnuniCarAgent(v.modele)
                            RageUI.CloseAll()
                            end
                        end)
                    end
                end, function()
                end)
            if not RageUI.Visible(GOrpi) then
            GOrpi = RMenu:DeleteType("Garage", true)
        end
    end
end

Citizen.CreateThread(function()
        while true do
            local Timer = 500
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'orpi' then
            local plyCoords3 = GetEntityCoords(GetPlayerPed(-1), false)
            local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, Orpi.pos.garage.position.x, Orpi.pos.garage.position.y, Orpi.pos.garage.position.z)
            if dist3 <= 10.0 and Orpi.jeveuxmarker then
                Timer = 0
                DrawMarker(20, Orpi.pos.garage.position.x, Orpi.pos.garage.position.y, Orpi.pos.garage.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 0, 0, 11, 255, 0, 1, 2, 0, nil, nil, 0)
                end
                if dist3 <= 3.0 then
                Timer = 0   
                    RageUI.Text({ message = "Appuyez sur ~y~[E]~s~ pour accéder au garage", time_display = 1 })
                    if IsControlJustPressed(1,51) then           
                        GarageAgent()
                    end   
                end
            end 
        Citizen.Wait(Timer)
     end
end)

function spawnuniCarAgent(car)
    local car = GetHashKey(car)

    RequestModel(car)
    while not HasModelLoaded(car) do
        RequestModel(car)
        Citizen.Wait(0)
    end

    local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), false))
    local vehicle = CreateVehicle(car, Orpi.pos.spawnvoiture.position.x, Orpi.pos.spawnvoiture.position.y, Orpi.pos.spawnvoiture.position.z, Orpi.pos.spawnvoiture.position.h, true, false)
    SetEntityAsMissionEntity(vehicle, true, true)
    local plaque = "Orpi"..math.random(1,9)
    SetVehicleNumberPlateText(vehicle, plaque) 
    SetPedIntoVehicle(GetPlayerPed(-1),vehicle,-1)
end



itemstock = {}
function AgentRetirerobjet()
    local StockAgent = RageUI.CreateMenu("Coffre", "Orpi")
    StockAgent:SetRectangleBanner(0, 0, 11)
    ESX.TriggerServerCallback('zOrpi:getStockItems', function(items) 
    itemstock = items
   
    RageUI.Visible(StockAgent, not RageUI.Visible(StockAgent))
        while StockAgent do
            Citizen.Wait(0)
                RageUI.IsVisible(StockAgent, true, true, true, function()
                        for k,v in pairs(itemstock) do 
                            if v.count > 0 then
                            RageUI.ButtonWithStyle(v.label, nil, {RightLabel = v.count}, true, function(Hovered, Active, Selected)
                                if Selected then
                                    local count = KeyboardInput("Combien ?", "", 2)
                                    TriggerServerEvent('zOrpi:getStockItem', v.name, tonumber(count))
                                    AgentRetirerobjet()
                                end
                            end)
                        end
                    end
                end, function()
                end)
            if not RageUI.Visible(StockAgent) then
            StockAgent = RMenu:DeleteType("Coffre", true)
        end
    end
     end)
end

local PlayersItem = {}
function AgentDeposerobjet()
    local StockPlayer = RageUI.CreateMenu("Coffre", "Orpi")
    StockPlayer:SetRectangleBanner(0, 0, 11)
    ESX.TriggerServerCallback('zOrpi:getPlayerInventory', function(inventory)
        RageUI.Visible(StockPlayer, not RageUI.Visible(StockPlayer))
    while StockPlayer do
        Citizen.Wait(0)
            RageUI.IsVisible(StockPlayer, true, true, true, function()
                for i=1, #inventory.items, 1 do
                    if inventory ~= nil then
                         local item = inventory.items[i]
                            if item.count > 0 then
                                        RageUI.ButtonWithStyle(item.label, nil, {RightLabel = item.count}, true, function(Hovered, Active, Selected)
                                            if Selected then
                                            local count = KeyboardInput("Combien ?", '' , 8)
                                            TriggerServerEvent('zOrpi:putStockItems', item.name, tonumber(count))
                                            AgentDeposerobjet()
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