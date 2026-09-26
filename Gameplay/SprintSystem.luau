--[[
    Sprint System
    Hold Left Shift to sprint.
    
    Place this LocalScript in:
    StarterPlayer > StarterPlayerScripts
]]

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer

local NORMAL_SPEED = 16
local SPRINT_SPEED = 26

local function setupCharacter(character)
	local humanoid = character:WaitForChild("Humanoid")

	UserInputService.InputBegan:Connect(function(input, processed)
		if processed then
			return
		end

		if input.KeyCode == Enum.KeyCode.LeftShift then
			humanoid.WalkSpeed = SPRINT_SPEED
		end
	end)

	UserInputService.InputEnded:Connect(function(input)
		if input.KeyCode == Enum.KeyCode.LeftShift then
			humanoid.WalkSpeed = NORMAL_SPEED
		end
	end)
end

if player.Character then
	setupCharacter(player.Character)
end

player.CharacterAdded:Connect(setupCharacter)
