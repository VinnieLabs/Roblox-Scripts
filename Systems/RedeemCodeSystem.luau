local RedeemCodes = {
	["WELCOME"] = 100,
	["UPDATE"] = 250,
	["RELEASE"] = 500,
}

local RedeemCodeSystem = {}

function RedeemCodeSystem.Redeem(player, code)
	if typeof(code) ~= "string" then
		return false, "Invalid code."
	end

	code = string.upper(code)

	local reward = RedeemCodes[code]

	if not reward then
		return false, "Invalid or expired code."
	end

	-- Replace this with your game's actual currency system.
	local leaderstats = player:FindFirstChild("leaderstats")
	local coins = leaderstats and leaderstats:FindFirstChild("Coins")

	if not coins then
		return false, "Currency system not found."
	end

	coins.Value += reward

	return true, "Code redeemed! +" .. reward .. " Coins"
end

return RedeemCodeSystem
