ESX = exports['es_extended']:getSharedObject()

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)


RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

-- [MENU]

local open = false 
local mainMenu6 = RageUI.CreateMenu('Garage', 'avocat')
mainMenu6.Display.Header = true 
mainMenu6.Closed = function()
  open = false
end

function OpenMenu6()
     if open then 
         open = false
         RageUI.Visible(mainMenu6, false)
         return
     else
         open = true 
         RageUI.Visible(mainMenu6, true)
         CreateThread(function()
         while open do 
            RageUI.IsVisible(mainMenu6,function() 
                RageUI.Separator("↓ ~m~Véhicules ~w~↓")

                RageUI.Button("Oracle", nil, {RightLabel = "→→"}, true , {
                    onSelected = function()
                      local model = GetHashKey("oracle2")
                      RequestModel(model)
                      while not HasModelLoaded(model) do Citizen.Wait(10) end
                      local pos = GetEntityCoords(PlayerPedId())
                      local vehicle = CreateVehicle(model, -227.84, -892.94, 29.70, 253.44, true, true)
                      RageUI.CloseAll()
                    end
                })

            end)
          Wait(0)
         end
      end)
   end
end

local position = {
    {x = -222.91, y = -901.32, z = 29.68}
}

Citizen.CreateThread(function()
    while true do
        NearZone = false

        for k,v in pairs(position) do

			if ESX.PlayerData.job and ESX.PlayerData.job.name == 'avocat' then

				local interval = 1
            	local pos = GetEntityCoords(GetPlayerPed(-1), false)
            	local dest = vector3(v.x, v.y, v.z)
            	local distance = GetDistanceBetweenCoords(pos, dest, true)
            	if distance > 2 then
                	interval = 1
            	else
                	interval = 1

                	local dist = Vdist(pos.x, pos.y, pos.z, position[k].x, position[k].y, position[k].z)
                	NearZone = true 

                	if distance < 2 then
                    	if not InAction then 
						Visual.Subtitle("Appuyer sur ~m~[E]~s~ pour ouvrir le garage", 0) 
                    end
                    if IsControlJustReleased(1,51) then
                        OpenMenu6()
                    end

                end
                break
			end
            end
        end
		if not NearZone then 
            Wait(500)
        else
            Wait(1)
        end
    end
end)

local npc = {
    {hash="cs_movpremmale", x = -222.72, y = -901.23, z = 29.60, a = 355.45},
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

 --- BLIPS AVOCAT---

Citizen.CreateThread(function()

    local blip = AddBlipForCoord(-243.52, -915.98, 32.31) 
  
    SetBlipSprite (blip, 76)
    SetBlipDisplay(blip, 4)
    SetBlipScale  (blip, 0.6)
    SetBlipColour (blip, 37)
    SetBlipAsShortRange(blip, true)
  
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentSubstringPlayerName('Cabinet d\'Avocat')
    EndTextCommandSetBlipName(blip)
  end)