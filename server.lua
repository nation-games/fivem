local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
func = {}
Tunnel.bindInterface("nation_nitro",func)

local nitros = {}

vRP._prepare("vRP/update_nitro","UPDATE vrp_user_vehicles SET nitro = @nitro WHERE user_id = @user_id AND vehicle = @vehicle")
vRP._prepare("vRP/get_nitro","SELECT nitro FROM vrp_user_vehicles WHERE user_id = @user_id AND vehicle = @vehicle")


function func.updateNitros(veh, nitro)
	local source = source
	local placa,vname = vRPclient.ModelName2(source)
	if not placa then
		placa,vname = vRPclient.ModelName(source,7)
	end
	local user_id = vRP.getUserByRegistration(placa)
	if user_id and vname then
		vRP.execute("vRP/update_nitro", {user_id = user_id, vehicle = vname, nitro = nitro})
	end
	for k,v in pairs(nitros) do
		if v.vehicle == veh then
			nitros[k].nitro = nitro
			return
		end
	end
	table.insert(nitros, {vehicle = veh, nitro = nitro})
end

function func.getNitro(vehicle)
	local source = source
	local placa,vname = vRPclient.ModelName2(source)
	local user_id = vRP.getUserByRegistration(placa)
	if user_id and vname then
		local rows = vRP.query("vRP/get_nitro", {user_id = user_id, vehicle = vname})
		if rows and rows[1] and rows[1].nitro then
			return rows[1].nitro
		end
	end
	for k,v in pairs(nitros) do
		if v.vehicle == vehicle then
			return v.nitro
		end
	end
	return 0
end

function func.takeNitro()
	local source = source
	local user_id = vRP.getUserId(source)
	if vRP.tryGetInventoryItem(user_id,"nitronos",1) then
		return true
	end
	return false
end

