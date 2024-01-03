ESX = exports['es_extended']:getSharedObject()

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)


RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

local open = false 
local avocatMain2 = RageUI.CreateMenu('Avocat', 'Interaction')
local subMenu5 = RageUI.CreateSubMenu(avocatMain2, "Annonces", "Interaction")
avocatMain2.Display.Header = true 
avocatMain2.Closed = function()
  open = false
end

function OpenMenuavocat()
	if open then 
		open = false
		RageUI.Visible(avocatMain2, false)
		return
	else
		open = true 
		RageUI.Visible(avocatMain2, true)
		CreateThread(function()
		while open do 
		   RageUI.IsVisible(avocatMain2,function() 

			RageUI.Separator("↓ Annonces ↓")
			RageUI.Button("Annonces", nil, {RightLabel = "→→"}, true , {
				onSelected = function()
				end
			}, subMenu5)


			RageUI.Separator("↓ Facture ↓")
			RageUI.Button("Faire une Facture", nil, {RightLabel = "→→"}, true , {
				onSelected = function()
					OpenBillingMenu2()
                    RageUI.CloseAll()
				end
			})

			end)
			

			RageUI.IsVisible(subMenu5,function() 

				RageUI.Button("Annonce ~g~[Ouvertures]~s~", nil, {RightLabel = "→"}, true , {
					onSelected = function()
						TriggerServerEvent('Ouvre:avocat')
					end
				})
	
				RageUI.Button("Annonce ~r~[Fermetures]~r~", nil, {RightLabel = "→"}, true , {
					onSelected = function()
						TriggerServerEvent('Ferme:avocat')
					end
				})

				RageUI.Button("Annonce ~b~[Recrutement]", nil, {RightLabel = "→"}, true , {
					onSelected = function()
						TriggerServerEvent('Recru:avocat')
					end
				})


				end)
		 Wait(0)
		end
	 end)
  end
end

function OpenBillingMenu2()

	ESX.UI.Menu.Open(
	  'dialog', GetCurrentResourceName(), 'billing',
	  {
		title = "Facture"
	  },
	  function(data, menu)
	  
		local amount = tonumber(data.value)
		local player, distance = ESX.Game.GetClosestPlayer()
  
		if player ~= -1 and distance <= 3.0 then
  
		  menu.close()
		  if amount == nil then
			  ESX.ShowNotification("~r~Problèmes~s~: Montant invalide")
		  else
			local playerPed        = PlayerPedId()
			TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TIME_OF_DEATH', 0, true)
			Citizen.Wait(5000)
			  TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(player), 'society_avocat', ('avocat'), amount)
			  Citizen.Wait(100)
			  ESX.ShowNotification("~r~Vous avez bien envoyer la facture")
		  end
  
		else
		  ESX.ShowNotification("~r~Problèmes~s~: Aucun joueur à proximitée")
		end
  
	  end,
	  function(data, menu)
		  menu.close()
	  end
	)
  end

Keys.Register('F6', 'Avocat', 'Ouvrir le menu avocat', function()
	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'avocat' then
    	OpenMenuavocat()
	end
end)