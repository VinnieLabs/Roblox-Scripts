local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer

local DASH_FORCE = 80
local DASH_TIME = 0.15
local COOLDOWN = 1

local canDash = true

local function dash(character)
	if not canDash then
		return
	end

	local humanoid = character:FindFirstChildOfClass("Humanoid")
	local rootPart = character:FindFirstChild("HumanoidRootPart")

	if not humanoid or not rootPart then
		return
	end

	canDash = false

	local direction = humanoid.MoveDirection

	if direction.Magnitude == 0 then
		direction = rootPart.CFrame.LookVector
	end

	local velocity = Instance.new("LinearVelocity")
	local attachment = Instance.new("Attachment")

	attachment.Parent = rootPart
	velocity.Attachment0 = attachment
	velocity.MaxForce = math.huge
	velocity.VectorVelocity = direction.Unit * DASH_FORCE
	velocity.Parent = rootPart

	task.wait(DASH_TIME)

	velocity:Destroy()
	attachment:Destroy()

	task.wait(COOLDOWN)
	canDash = true
end

local function setupCharacter(character)
	canDash = true

	UserInputService.InputBegan:Connect(function(input, processed)
		if processed then
			return
		end

		if input.KeyCode == Enum.KeyCode.Q then
			dash(character)
		end
	end)
end

if player.Character then
	setupCharacter(player.Character)
end

player.CharacterAdded:Connect(setupCharacter)
