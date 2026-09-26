local DataStoreService = game:GetService("DataStoreService")

local DataStoreUtility = {}

local store = DataStoreService:GetDataStore("PlayerData_v1")

function DataStoreUtility.Load(player)
	local success, data = pcall(function()
		return store:GetAsync("Player_" .. player.UserId)
	end)

	if success then
		return data
	end

	warn("Failed to load data for " .. player.Name)
	return nil
end

function DataStoreUtility.Save(player, data)
	local success, errorMessage = pcall(function()
		store:SetAsync("Player_" .. player.UserId, data)
	end)

	if not success then
		warn("Failed to save data for " .. player.Name .. ": " .. errorMessage)
		return false
	end

	return true
end

return DataStoreUtility
