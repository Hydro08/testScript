-- Controllable Fly Script with GUI for Mobile (Delta)

local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")

local flying = false
local bv = nil
local speed = 50
local direction = Vector3.new()

-- GUI Setup
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "FlyGui"

local function createButton(name, pos, text)
	local btn = Instance.new("TextButton")
	btn.Name = name
	btn.Size = UDim2.new(0, 60, 0, 60)
	btn.Position = pos
	btn.Text = text
	btn.BackgroundColor3 = Color3.new(0,0,0)
	btn.TextColor3 = Color3.new(1,1,1)
	btn.BackgroundTransparency = 0.3
	btn.Parent = gui
	return btn
end

-- Direction buttons
local btnUp = createButton("UpBtn", UDim2.new(0.5, -30, 0.6, -100), "↑")
local btnDown = createButton("DownBtn", UDim2.new(0.5, -30, 0.6, 0), "↓")
local btnLeft = createButton("LeftBtn", UDim2.new(0.5, -90, 0.6, -50), "←")
local btnRight = createButton("RightBtn", UDim2.new(0.5, 30, 0.6, -50), "→")
local btnOnOff = createButton("ToggleBtn", UDim2.new(0.5, -40, 0.8, 0), "Fly ON")

-- Movement
btnUp.MouseButton1Down:Connect(function() direction = Vector3.new(0, 1, 0) end)
btnDown.MouseButton1Down:Connect(function() direction = Vector3.new(0, -1, 0) end)
btnLeft.MouseButton1Down:Connect(function() direction = Vector3.new(-1, 0, 0) end)
btnRight.MouseButton1Down:Connect(function() direction = Vector3.new(1, 0, 0) end)

-- Reset direction when button released
local function stopMove() direction = Vector3.new() end
btnUp.MouseButton1Up:Connect(stopMove)
btnDown.MouseButton1Up:Connect(stopMove)
btnLeft.MouseButton1Up:Connect(stopMove)
btnRight.MouseButton1Up:Connect(stopMove)

-- Toggle fly on/off
btnOnOff.MouseButton1Click:Connect(function()
	if flying then
		flying = false
		btnOnOff.Text = "Fly ON"
		if bv then bv:Destroy() end
	else
		flying = true
		btnOnOff.Text = "Fly OFF"
		bv = Instance.new("BodyVelocity", hrp)
		bv.MaxForce = Vector3.new(1e5, 1e5, 1e5)
		bv.Velocity = Vector3.new()
	end
end)

-- Update fly movement
game:GetService("RunService").Heartbeat:Connect(function()
	if flying and bv then
		local cam = workspace.CurrentCamera
		local move = cam.CFrame:VectorToWorldSpace(direction)
		bv.Velocity = move.Unit * speed
	end
end)
