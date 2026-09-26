local XPLevelSystem = {}

local BASE_XP = 100
local XP_PER_LEVEL = 50

function XPLevelSystem.GetRequiredXP(level)
	return BASE_XP + ((level - 1) * XP_PER_LEVEL)
end

function XPLevelSystem.AddXP(player, amount)
	if not player or typeof(amount) ~= "number" or amount <= 0 then
		return false
	end

	local leaderstats = player:FindFirstChild("leaderstats")
	if not leaderstats then
		return false
	end

	local xp = leaderstats:FindFirstChild("XP")
	local level = leaderstats:FindFirstChild("Level")

	if not xp or not level then
		return false
	end

	xp.Value += amount

	while xp.Value >= XPLevelSystem.GetRequiredXP(level.Value) do
		xp.Value -= XPLevelSystem.GetRequiredXP(level.Value)
		level.Value += 1
	end

	return true
end

return XPLevelSystem
