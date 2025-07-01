local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")
local hum = char:WaitForChild("Humanoid")

-- GUI Setup
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "FlyGUI"
gui.ResetOnSpawn = false

local function createBtn(text, pos)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(0, 60, 0, 60)
	btn.Position = pos
	btn.Text = text
	btn.TextScaled = true
	btn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	btn.TextColor3 = Color3.new(1, 1, 1)
	btn.BackgroundTransparency = 0.3
	btn.Parent = gui
	return btn
end

-- Buttons
local flyBtn = createBtn("Fly OFF", UDim2.new(0.85, 0, 0.75, 0))
local upBtn = createBtn("⬆️", UDim2.new(0.85, 0, 0.6, 0))
local downBtn = createBtn("⬇️", UDim2.new(0.85, 0, 0.9, 0))

-- Vars
local flying = false
local bv
local yDir = 0

-- Button logic
upBtn.MouseButton1Click:Connect(function()
	yDir = 60
	wait(0.1)
	yDir = 0
end)

downBtn.MouseButton1Click:Connect(function()
	yDir = -60
	wait(0.1)
	yDir = 0
end)

flyBtn.MouseButton1Click:Connect(function()
	if flying then
		flying = false
		flyBtn.Text = "Fly OFF"
		flyBtn.Color = "White"
		if bv then bv:Destroy() end
	else
		flying = true
		flyBtn.Text = "Fly ON"
		bv = Instance.new("BodyVelocity", hrp)
		bv.MaxForce = Vector3.new(1e5, 1e5, 1e5)
		bv.Velocity = Vector3.zero

		game:GetService("RunService").RenderStepped:Connect(function()
			if flying and bv and char and hum then
				local dir = hum.MoveDirection
				local vel = Vector3.new(dir.X, yDir, dir.Z)
				if vel.Magnitude > 0 then
					bv.Velocity = vel.Unit * 60
				else
					bv.Velocity = Vector3.zero
				end
			end
		end)
	end
end)
