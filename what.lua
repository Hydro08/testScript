-- Mobile Fly Script with Directional GUI (Delta-Compatible)

local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")

local flying = false
local bv = nil
local speed = 50
local moveDirection = Vector3.zero

-- Create GUI
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "FlyGui"

local function createButton(name, pos, txt)
	local btn = Instance.new("TextButton")
	btn.Name = name
	btn.Size = UDim2.new(0, 60, 0, 60)
	btn.Position = pos
	btn.Text = txt
	btn.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
	btn.TextColor3 = Color3.new(1, 1, 1)
	btn.TextScaled = true
	btn.BackgroundTransparency = 0.3
	btn.Parent = gui
	return btn
end

-- Buttons
local btnUp = createButton("UpBtn", UDim2.new(0.5, -30, 0.6, -100), "↑")
local btnDown = createButton("DownBtn", UDim2.new(0.5, -30, 0.6, 0), "↓")
local btnLeft = createButton("LeftBtn", UDim2.new(0.5, -90, 0.6, -50), "←")
local btnRight = createButton("RightBtn", UDim2.new(0.5, 30, 0.6, -50), "→")
local btnToggle = createButton("ToggleFly", UDim2.new(0.5, -40, 0.8, 0), "Fly ON")

-- Toggle Fly Mode
btnToggle.MouseButton1Click:Connect(function()
	if flying then
		flying = false
		moveDirection = Vector3.zero
		btnToggle.Text = "Fly ON"
		if bv then bv:Destroy() end
	else
		flying = true
		btnToggle.Text = "Fly OFF"
		bv = Instance.new("BodyVelocity")
		bv.MaxForce = Vector3.new(1e5, 1e5, 1e5)
		bv.Velocity = Vector3.zero
		bv.Parent = hrp
	end
end)

-- Toggle Movement per Direction
local toggles = {
	Up = false,
	Down = false,
	Left = false,
	Right = false,
}

local function updateDirection()
	local cam = workspace.CurrentCamera
	local dir = Vector3.zero

	if toggles.Up then dir += cam.CFrame.LookVector end
	if toggles.Down then dir -= cam.CFrame.LookVector end
	if toggles.Left then dir -= cam.CFrame.RightVector end
	if toggles.Right then dir += cam.CFrame.RightVector end

	moveDirection = dir
end

-- Button Events
btnUp.MouseButton1Click:Connect(function()
	toggles.Up = not toggles.Up
	updateDirection()
end)
btnDown.MouseButton1Click:Connect(function()
	toggles.Down = not toggles.Down
	updateDirection()
end)
btnLeft.MouseButton1Click:Connect(function()
	toggles.Left = not toggles.Left
	updateDirection()
end)
btnRight.MouseButton1Click:Connect(function()
	toggles.Right = not toggles.Right
	updateDirection()
end)

-- Movement Loop
game:GetService("RunService").Heartbeat:Connect(function()
	if flying and bv then
		bv.Velocity = moveDirection.Unit * speed
	end
end)
