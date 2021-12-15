--Author: Simbba

local Ragdoll = false
ragdol = true

---------------------------------
--KeyMapping Register
---------------------------------

RegisterKeyMapping('rdoll', 'Toggle Ragdoll', 'keyboard', 'u')

---------------------------------
--Ragdoll Toggle
---------------------------------

RegisterCommand('rdoll', function()
    TriggerEvent("Ragdoll", source)
end, false)
TriggerEvent( "chat:addSuggestion", "/rdoll", "Chat command for enabling and disabling ragdoll. (Can also add a keybind in Setting/Key Bindings/FiveM) Default keybind is u." )


RegisterNetEvent("Ragdoll")
AddEventHandler("Ragdoll", function()
    if (ragdol) then
        setRagdoll(true)
        ragdol = false
    else
        setRagdoll(false)
        ragdol = true
    end
end)

---------------------------------
--fuctions
---------------------------------

function setRagdoll(rag)
	Ragdoll = rag
	if Ragdoll then
		Citizen.CreateThread(function()
			while Ragdoll do 
				Citizen.Wait(0)

				vehCheck() 

				if Ragdoll then
					SetPedToRagdoll(GetPlayerPed(-1), 1000, 1000, 0, 0, 0, 0)
					if ragdol then
						Ragdoll = false
					end
				end
			end
		end)
	end
end

function vehCheck()
    if Ragdoll then
        if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
            Ragdoll = false
            notify("~r~You can't ragdoll while in a vehicle!")
        end
    end
end

function notify(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(true, true)
end