local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer

local MAX_JUMPS = 2
local jumps = 0

local function setupCharacter(character)
	local humanoid = character:WaitForChild("Humanoid")
	jumps = 0

	humanoid.StateChanged:Connect(function(_, newState)
		if newState == Enum.HumanoidStateType.Landed then
			jumps = 0
		end
	end)

	UserInputService.JumpRequest:Connect(function()
		if jumps < MAX_JUMPS then
			jumps += 1
			humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
		end
	end)
end

if player.Character then
	setupCharacter(player.Character)
end

player.CharacterAdded:Connect(setupCharacter)
