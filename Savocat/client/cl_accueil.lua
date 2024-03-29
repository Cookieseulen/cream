ESX = exports['es_extended']:getSharedObject()

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)


RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

function KeyboardInput(TextEntry, ExampleText, MaxStringLenght)

    AddTextEntry('FMMC_KEY_TIP1', TextEntry) 
    
    blockinput = true 
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "Somme", ExampleText, "", "", "", MaxStringLenght) 
    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do 
        Citizen.Wait(0)
    end 
         
    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult()
        Citizen.Wait(500) 
        blockinput = false
        return result 
    else
        Citizen.Wait(500) 
        blockinput = false 
        return nil 
    end
end

--- MENU ---

local open = false 
local mainMenu = RageUI.CreateMenu('Accueil', 'Avocat') 
local subMenu1 = RageUI.CreateMenu('Rendez Vous', 'Avocat') 
mainMenu.Display.Header = true 
mainMenu.Closed = function()
  open = false
  nomprenom = nil
  numero = nil
  heurerdv = nil
  rdvmotif = nil
end

--- FUNCTION OPENMENU ---

function OpenMenuAccueilAvocat() 
    if open then 
		open = false
		RageUI.Visible(mainMenu, false)
		return
	else
		open = true 
		RageUI.Visible(mainMenu, true)
		CreateThread(function()
		while open do 
        RageUI.IsVisible(mainMenu, function()

        RageUI.Button("Appeler un Avocat", nil, {RightLabel = "→→"}, not codesCooldown5 , {
            onSelected = function()
            codesCooldown5 = true 
        TriggerServerEvent('Appel:avocat')
        ESX.ShowNotification('~g~Votre message a bien été envoyé aux avocats.')
        Citizen.SetTimeout(5000, function() codesCooldown5 = false end)
       end 
    })

        RageUI.Button("Prendre Rendez-Vous", nil, {RightLabel = "→→"}, true , {
            onSelected = function()
            end
        }, subMenu1)     


        end)    
         
        RageUI.IsVisible(subMenu1, function()    

            RageUI.Button("Nom & Prénom", nil, {RightLabel = nomprenom}, true , {
                onSelected = function()
                DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "Prénom & Nom", "Prénom & Nom", "", "", "", 20)
                while (UpdateOnscreenKeyboard() == 0) do
                    DisableAllControlActions(0);
                   Citizen.Wait(1)
                end
                if (GetOnscreenKeyboardResult()) then
                    nomprenom = GetOnscreenKeyboardResult() 
                end
            end
			})

            RageUI.Button("Numéro de Téléphone", nil, {RightLabel = numero}, true , {
                onSelected = function()
                    DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "555-", "555-", "", "", "", 10)
                    while (UpdateOnscreenKeyboard() == 0) do
                        DisableAllControlActions(0);
                       Citizen.Wait(1)
                    end
                    if (GetOnscreenKeyboardResult()) then
                        numero = GetOnscreenKeyboardResult()  
            		end
                end
                })

            RageUI.Button("Heure du Rendez-vous", nil, {RightLabel = heurerdv}, true , {
                onSelected = function()
                    DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "15h40", "15h40", "", "", "", 10)
                    while (UpdateOnscreenKeyboard() == 0) do
                        DisableAllControlActions(0);
                       Citizen.Wait(1)
                    end
                    if (GetOnscreenKeyboardResult()) then
                        heurerdv = GetOnscreenKeyboardResult()  
                    end
                end
                })
            
            RageUI.Button("Motif du Rendez-vous", nil, {RightLabel = "→→"}, true , {
                onSelected = function()
                    DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "Motif", "Motif", "", "", "", 120)
                    while (UpdateOnscreenKeyboard() == 0) do
                        DisableAllControlActions(0);
                       Citizen.Wait(1)
                    end
                    if (GetOnscreenKeyboardResult()) then
                        rdvmotif = GetOnscreenKeyboardResult()  
                    end
                end
                })

            RageUI.Button("Valider la Demande", "~o~Merci de respecter les Avocats.", { Color = {BackgroundColor = { 76, 175, 80, 50}} }, true, {
                onSelected = function()
                    if (nomprenom == nil or nomprenom == '') then
                        ESX.ShowNotification('~r~Vous n\'a pas rempli ton Nom/Prénom')
                    elseif (numero == nil or numero == '') then
                        ESX.ShowNotification('~r~Vous n\'a pas rempli ton Numéro')
                    elseif (heurerdv == nil or heurerdv == '') then
                        ESX.ShowNotification('~r~Vous n\'a pas rempli l\'heure de Rendez-vous')
                    elseif (rdvmotif == nil or rdvmotif == '' or rdvmotif == "Motif") then
                        ESX.ShowNotification('~r~Vous n\'a pas rempli le motif du rendez-vous')
                else
                    RageUI.CloseAll()
                    TriggerServerEvent("Rdv:AmbulanceMotif", nomprenom, numero, heurerdv, rdvmotif)
                    ESX.ShowNotification("~b~Cabinet d'Avocat~s~\nVotre Demande de Rendez-vous a bien été envoyée")
                    nomprenom = nil
                    numero = nil
                    heurerdv = nil
                    rdvmotif = nil
                end
            end
			}) 



		end)			
		Wait(0)
	   end
	end)
 end
end


Citizen.CreateThread(function()
    while true do 
        local wait = 750
        
            for k in pairs(Position.Accueil) do 
                local plyCoords = GetEntityCoords(PlayerPedId(), false)
                local pos = Position.Accueil
                local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, pos[k].x, pos[k].y, pos[k].z)
  
                if dist <= 2.0 then 
                    wait = 0
                    Visual.Subtitle(TextAccueil, 1)
                    if IsControlJustPressed(1,51) then
                        OpenMenuAccueilAvocat()
                    end
                end
            end
    Citizen.Wait(wait)
   end
end)
  
local npc = {
    {hash="a_m_y_business_02", x = -235.27, y = -922.15, z = 32.31, a = 338.16},
}

Citizen.CreateThread(function()
    for _, item2 in pairs(npc) do
        local hash = GetHashKey(item2.hash)
        while not HasModelLoaded(hash) do
        RequestModel(hash)
        Wait(20)
        end
        ped2 = CreatePed("PED_TYPE_CIVFEMALE", item2.hash, item2.x, item2.y, item2.z-0.92, item2.a, false, true)
        SetBlockingOfNonTemporaryEvents(ped2, true)
        FreezeEntityPosition(ped2, true)
        SetEntityInvincible(ped2, true)
    end
 end)  

Position = { Accueil = {vector3(-235.27, -922.15, 32.31)}
}
