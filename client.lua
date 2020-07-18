local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
func = Tunnel.getInterface("nation_nitro")

local nitro = 0
local incar = false
local car

RegisterNetEvent("nation:nitro")
AddEventHandler("nation:nitro", function()
	local ped = PlayerPedId()
	if not IsPedInAnyVehicle(ped,false) then
		local veh = vRP.getNearestVehicle(7)
		if DoesEntityExist(veh) then
			local class = GetVehicleClass(veh)
			if IsEntityAVehicle(veh) and class ~= 8 and class ~= 13 and class ~= 14 and class ~= 15 then
				if func.takeNitro() then
					local vehicle = VehToNet(veh)
					SetVehicleDoorOpen(veh,4,0,0)
					TaskTurnPedToFaceCoord(ped, GetEntityCoords(veh), -1)
					Citizen.Wait(1000)
					TaskStartScenarioInPlace(ped, "PROP_HUMAN_BUM_BIN", 0, 1)
					TriggerEvent("progress",10000,"Instalando Nitro")
					Citizen.Wait(10000)
					ClearPedTasks(ped)
					SetVehicleDoorShut(veh,4,0)
					func.updateNitros(vehicle,100)
					TriggerEvent("Notify","importante","Nitro NOS instalado com sucesso.")
				end
			else
				TriggerEvent("Notify","aviso","Este veículo não suporta o nitro NOS!")
			end
		end
	else
		TriggerEvent("Notify","aviso","Saia do veículo para fazer isso.")
	end
end)

Citizen.CreateThread(function()
	while true do 
		local idle = 500
		local ped = PlayerPedId()
		if not incar then
			if IsPedInAnyVehicle(ped,false) and GetPedInVehicleSeat(GetVehiclePedIsIn(ped),-1) == ped then
				local vehicle = VehToNet(GetVehiclePedIsIn(ped,false))
				nitro = func.getNitro(vehicle)
				incar = true
				car = vehicle
			end
		else
			if not IsPedInAnyVehicle(ped,false) then
				func.updateNitros(car,nitro)
				nitro = 0
				incar = false
				car = nil
			end
		end
		Citizen.Wait(idle)
	end
end)	

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if nitro > 0 then
			if IsControlPressed(1,73) and GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId()),-1) == PlayerPedId() then
				local vehicle = GetVehiclePedIsIn(PlayerPedId(),false)
				local speed = GetEntitySpeed(vehicle)
				speed = speed + (speed * 0.05)
				SetVehicleBoostActive(vehicle, 1, 0)
				SetVehicleForwardSpeed(vehicle, speed)
				StartScreenEffect("RaceTurbo", 100, 0)
				SetVehicleBoostActive(vehicle, 0, 0)
				nitro = nitro-0.5
			end
		end
	end
end)

local toggle = false

Citizen.CreateThread(function()
	while true do
		local idle = 500
		local playerPed = GetPlayerPed(-1)
		if IsPedInAnyVehicle(playerPed, false) and not IsPauseMenuActive() and nitro and nitro > 0 then
			idle = 150
			local playerVeh = GetVehiclePedIsIn(playerPed, false)
			if toggle == false then
				toggle = true
				SendNUIMessage({action = "toggleCar", show = true})
			end
		else
			idle = 500
			if toggle == true then
				toggle = false
				SendNUIMessage({action = "toggleCar", show = false})
			end
		end
		Citizen.Wait(idle)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(100)
		local Ped = GetPlayerPed(-1)
		if(IsPedInAnyVehicle(Ped, false)) and nitro then
			local PedCar = GetVehiclePedIsIn(Ped, false)
			SendNUIMessage({
				showhud = true,
				speed = parseInt(nitro)
			})
		end
	end
end)
