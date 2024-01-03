local anti_trigger = {}
anti_trigger['root'] = nil 
anti_trigger['events:handled'] = {} 
anti_trigger['events:cancel'] = { -- you can put here all the events to not protect (we recommand to put the events that are used way to much)
    ['esx:triggerServerCallback'] = true,
}
anti_trigger['events:default'] = {
    -- Don't remove these events

    ['__cfx_internal:httpResponse'] = true, 
    ['__cfx_internal:commandFallback'] = true,
    ['weaponDamageEvent'] = true, 
    ['entityCreating'] = true, 
    ['entityCreated'] = true, 
    ['playerDropped'] = true, 
    ['giveWeaponEvent'] = true, 
    ['removeWeaponEvent'] = true, 
    ['removeAllWeaponsEvent'] = true, 
    ['entityRemoved'] = true, 
    ['clearPedTasksEvent'] = true, 
    ['fireEvent'] = true, 
    ['ptFxEvent'] = true, 
    ['startProjectileEvent'] = true, 
    ['chatMessage'] = true, 
    ['explosionEvent'] = true, 
    ['playerJoining'] = true, 
    ['playerConnecting'] = true, 
    ['onResourceListRefresh'] = true,
    ['onResourceStarting'] = true,
    ['onResourceStart'] = true,
    ['playerEnteredScope'] = true,
    ['onResourceStop'] = true,
    ['onServerResourceStart'] = true,
    ['onServerResourceStop'] = true,
    ['playerLeftScope'] = true
}

anti_trigger['root:handle'] = AddEventHandler
anti_trigger['root:register&handle'] = RegisterNetEvent
anti_trigger['root:trigger'] = TriggerServerEvent
anti_trigger['root:trigger:local'] = TriggerEvent
anti_trigger['root:check'] = function(source)
    source = tonumber(source)
    if source == nil or source == '' or source == 0 then 
        return false 
    end
    return true 
end
AD_TRIGGER_OLD_FUNCTION = anti_trigger['root:trigger'] -- don't remove this

if IsDuplicityVersion() then 
    for k,v in pairs( { '__RegisterNetEvent' } ) do 
        _ENV[v] = function(eventName, handle)
            if anti_trigger['events:cancel'][eventName] then 
                anti_trigger['root:register&handle'](eventName)
                anti_trigger['root:handle'](eventName, handle)
                return 
            end
            if anti_trigger['events:default'][eventName] or string.find(eventName, '__cfx_export_') then 
                return anti_trigger['root:handle'](eventName, handle)
            end
            anti_trigger['events:handled'][eventName] = anti_trigger['events:handled'][eventName] or {}
            if type(handle) == 'function' then
                anti_trigger['events:handled'][eventName]['handler'] = handle
            end
            if not anti_trigger['events:handled'][eventName]['protected'] then 
                anti_trigger['events:handled'][eventName]['protected'] = true 
                anti_trigger['root:register&handle'](eventName)
                anti_trigger['root:handle'](eventName, function(...)
                    local source = source 
                    if anti_trigger['root:check'](source)  then 
                        anti_trigger['root:trigger:local']('aerodefence.local.ban', source, 'TRIGGER INJECTION', {eventName, 1})
                    end
                end)
            end
        end
    end
    anti_trigger['root:handle']('aerodefence.event', function(eventName, source, ...)
        if anti_trigger['events:handled'][eventName] == nil then return end 
        if anti_trigger['events:handled'][eventName]['handler'] then 
            anti_trigger['events:handled'][eventName]['handler'](source, ...)
        end
    end)
else
    local loaded = promise.new()
    __TriggerServerEvent = function(eventName, ...)
        if anti_trigger['events:cancel'][eventName] then 
            return anti_trigger['root:trigger'](eventName, ...)
        end
        Citizen.Await(loaded)
        anti_trigger['root'](eventName, ...) 
    end
    Citizen.CreateThread(function()
        while anti_trigger['root'] == nil do 
            anti_trigger['root:trigger:local']('aerodefence.anti.trigger', function(obj)
                if obj ~= nil then 
                    anti_trigger['root'] = obj
                    loaded:resolve(true) 
                    __TriggerServerEvent = function(eventName, ...)
                        if anti_trigger['events:cancel'][eventName] then 
                            return anti_trigger['root:trigger'](eventName, ...)
                        end
                        anti_trigger['root'](eventName, ...)
                    end
                end
            end)
            Citizen.Wait(1)
        end
    end)
end