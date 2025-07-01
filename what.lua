local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")
local hum = char:WaitForChild("Humanoid")

-- GUI Setup
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "FlyGui"
gui.ResetOnSpawn = false

local btn = Instance.new("TextButton")
btn.Size = UDim2.new(0, 100, 0, 50)
btn.Position = UDim2.new(0.5, -50, 0.85, 0)
btn.Text = "Fly ON"
btn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
btn.TextColor3 = Color3.fromRGB(255, 255, 255)
btn.BackgroundTransparency = 0.3
btn.Parent = gui

-- Fly logic
local flying = false
local bv

btn.MouseButton1Click:Connect(function()
	if flying then
		flying = false
		btn.Text = "Fly ON"
		if bv then bv:Destroy() end
	else
		flying = true
		btn.Text = "Fly OFF"

		bv = Instance.new("BodyVelocity", hrp)
		bv.MaxForce = Vector3.new(1e5, 1e5, 1e5)
		bv.Velocity = Vector3.zero

		-- Movement logic
		game:GetService("RunService").Heartbeat:Connect(function()
			if flying and bv then
				local moveDir = hum.MoveDirection
				local cam = workspace.CurrentCamera
				local direction = cam.CFrame:VectorToWorldSpace(moveDir)
				bv.Velocity = direction.Unit * 60
			end
		end)
	end
end)
