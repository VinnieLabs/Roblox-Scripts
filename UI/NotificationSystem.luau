local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer

local NotificationSystem = {}

local function getGui()
	local playerGui = player:WaitForChild("PlayerGui")

	local gui = playerGui:FindFirstChild("VinnieNotifications")

	if not gui then
		gui = Instance.new("ScreenGui")
		gui.Name = "VinnieNotifications"
		gui.ResetOnSpawn = false
		gui.Parent = playerGui
	end

	return gui
end

function NotificationSystem.Show(title, message, duration)
	duration = duration or 3

	local gui = getGui()

	local notification = Instance.new("Frame")
	notification.Size = UDim2.fromOffset(320, 80)
	notification.Position = UDim2.new(1, 20, 0, 80)
	notification.BackgroundTransparency = 0.1
	notification.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
	notification.Parent = gui

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 12)
	corner.Parent = notification

	local titleLabel = Instance.new("TextLabel")
	titleLabel.Size = UDim2.new(1, -20, 0, 25)
	titleLabel.Position = UDim2.fromOffset(10, 8)
	titleLabel.BackgroundTransparency = 1
	titleLabel.Text = title or "Notification"
	titleLabel.TextColor3 = Color3.new(1, 1, 1)
	titleLabel.TextSize = 18
	titleLabel.Font = Enum.Font.GothamBold
	titleLabel.TextXAlignment = Enum.TextXAlignment.Left
	titleLabel.Parent = notification

	local messageLabel = Instance.new("TextLabel")
	messageLabel.Size = UDim2.new(1, -20, 0, 35)
	messageLabel.Position = UDim2.fromOffset(10, 35)
	messageLabel.BackgroundTransparency = 1
	messageLabel.Text = message or ""
	messageLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
	messageLabel.TextSize = 14
	messageLabel.Font = Enum.Font.Gotham
	messageLabel.TextWrapped = true
	messageLabel.TextXAlignment = Enum.TextXAlignment.Left
	messageLabel.Parent = notification

	local showTween = TweenService:Create(
		notification,
		TweenInfo.new(0.35, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
		{Position = UDim2.new(1, -340, 0, 80)}
	)

	showTween:Play()

	task.wait(duration)

	local hideTween = TweenService:Create(
		notification,
		TweenInfo.new(0.35, Enum.EasingStyle.Quint, Enum.EasingDirection.In),
		{Position = UDim2.new(1, 20, 0, 80)}
	)

	hideTween:Play()
	hideTween.Completed:Wait()

	notification:Destroy()
end

return NotificationSystem
