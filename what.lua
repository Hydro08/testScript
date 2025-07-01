local player = game:GetService("Players").LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")

local gui = Instance.new("ScreenGui")
gui.Name = "FlyGui"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.Parent = player:WaitForChild("PlayerGui")

local function createButton(name, pos, text)
	local btn = Instance.new("TextButton")
	btn.Name = name
	btn.Size = UDim2.new(0, 60, 0, 60)
	btn.Position = pos
	btn.Text = text
	btn.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
	btn.TextColor3 = Color3.new(1, 1, 1)
	btn.TextScaled = true
	btn.BorderSizePixel = 0
	btn.BackgroundTransparency = 0.2
	btn.Parent = gui
	return btn
end

local flying = false
local bv
local speed = 50
local moveDir = Vector3.zero

local btnToggle = createButton("FlyToggle", UDim2.new(0.8, 0, 0.8, 0), "Fly ON")
local btnUp = createButton("Up", UDim2.new(0.8, 0, 0.6, 0), "↑")
local btnDown = createButton("Down", UDim2.new(0.8, 0, 0.9, 0), "↓")

btnToggle.MouseButton1Click:Connect(function()
	if flying then
		flying = false
		btnToggle.Text = "Fly ON"
		if bv then bv:Destroy() end
	else
		flying = true
		btnToggle.Text = "Fly OFF"
		bv = Instance.new("BodyVelocity", hrp)
		bv.MaxForce = Vector3.new(1e5, 1e5, 1e5)
		bv.Velocity = Vector3.zero
	end
end)

btnUp.MouseButton1Click:Connect(function()
	moveDir = Vector3.new(0, 1, 0)
end)
btnDown.MouseButton1Click:Connect(function()
	moveDir = Vector3.new(0, -1, 0)
end)

game:GetService("RunService").RenderStepped:Connect(function()
	if flying and bv then
		bv.Velocity = moveDir * speed
	end
end)
