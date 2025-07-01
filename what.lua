-- Simple ESP Script (Head Label ESP)

local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer

function createESP(player)
	if player == localPlayer then return end
	
	local function addBillboard()
		local character = player.Character
		if not character then return end
		local head = character:FindFirstChild("Head")
		if not head then return end

		if head:FindFirstChild("ESPLabel") then return end

		local bbGui = Instance.new("BillboardGui")
		bbGui.Name = "ESPLabel"
		bbGui.Adornee = head
		bbGui.Size = UDim2.new(0, 100, 0, 30)
		bbGui.AlwaysOnTop = true

		local label = Instance.new("TextLabel", bbGui)
		label.Size = UDim2.new(1, 0, 1, 0)
		label.Text = player.Name
		label.TextColor3 = Color3.new(1, 0, 0)
		label.BackgroundTransparency = 1
		label.TextStrokeTransparency = 0.5

		bbGui.Parent = head
	end

	player.CharacterAdded:Connect(function()
		wait(1)
		addBillboard()
	end)

	if player.Character then
		addBillboard()
	end
end

for _, player in ipairs(Players:GetPlayers()) do
	createESP(player)
end

Players.PlayerAdded:Connect(function(player)
	createESP(player)
end)
