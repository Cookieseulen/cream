ESX = exports['es_extended']:getSharedObject()

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)


RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

-- Function --

function barman()

  local model = GetEntityModel(GetPlayerPed(-1))

  TriggerEvent('skinchanger:getSkin', function(skin)

      if model == GetHashKey("mp_m_freemode_01") then

-- Pour les Hommes (A vous de config)
          clothesSkin = {
            ['bags_1'] = 0, ['bags_2'] = 0,
            ['tshirt_1'] = 11, ['tshirt_2'] = 0,
            ['torso_1'] = 112, ['torso_2'] = 0,
            ['arms'] = 4,
            ['pants_1'] = 3, ['pants_2'] = 2,
            ['shoes_1'] = 105, ['shoes_2'] = 9,

          }
    else

-- Pour les Femmes (A vous de config)
          clothesSkin = {
            ['bags_1'] = 0, ['bags_2'] = 0,
            ['tshirt_1'] = 0,['tshirt_2'] = 0,
            ['torso_1'] = 0, ['torso_2'] = 0,
            ['arms'] = 0, ['arms_2'] = 0,
            ['pants_1'] = 0, ['pants_2'] = 0,
            ['shoes_1'] = 0, ['shoes_2'] = 0,

          }

      end

      TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)

  end)

end

function vcivil()

ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)

TriggerEvent('skinchanger:loadSkin', skin)

end)

end

-- MENU FUNCTION --

local open = false 
local mainMenu6 = RageUI.CreateMenu('Vestiaire', "Avocat")
mainMenu6.Display.Header = true 
mainMenu6.Closed = function()
  open = false
end

function OpenVestiaire()
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

              RageUI.Separator("↓ ~b~   Vestiaire  ~s~↓")

              RageUI.Button("Reprendre sa tenue", nil, {RightLabel = "→→"}, true , {
                onSelected = function()
                    vcivil()
                  end
                })	

                RageUI.Button("Mettre tenue Avocat", nil, {RightLabel = "→→"}, true , {
                  onSelected = function()
                    barman()
                    end
                  })	
            
            end)
          Wait(0)
         end
      end)
   end
end

----OUVRIR LE MENU------------

local position = {
	{x = -237.7979, y = -925.1292, z = 32.3122}
}

Citizen.CreateThread(function()
    while true do

      local wait = 750

        for k in pairs(position) do
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'avocat' then 
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, position[k].x, position[k].y, position[k].z)
       if dist <= 1.0 then
               wait = 0
                Visual.Subtitle("Appuyer sur ~b~[E]~s~ pour ouvrir le casier", 1) 
                if IsControlJustPressed(1,51) then
                  OpenVestiaire()
            end
        end
      end
    Citizen.Wait(wait)
    end
  end
end)


