local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")
local hum = char:WaitForChild("Humanoid")

-- GUI Toggle Button
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "FlyGui"

local toggleBtn = Instance.new("TextButton")
toggleBtn.Size = UDim2.new(0, 100, 0, 50)
toggleBtn.Position = UDim2.new(0.5, -50, 0.85, 0)
toggleBtn.Text = "Fly ON"
toggleBtn.BackgroundColor3 = Color3.new(0, 0, 0)
toggleBtn.TextColor3 = Color3.new(1, 1, 1)
toggleBtn.BackgroundTransparency = 0.2
toggleBtn.Parent = gui

local flying = false
local bv

-- Fly Toggle
toggleBtn.MouseButton1Click:Connect(function()
	if flying then
		flying = false
		toggleBtn.Text = "Fly ON"
		if bv then bv:Destroy() end
	else
		flying = true
		toggleBtn.Text = "Fly OFF"
		bv = Instance.new("BodyVelocity", hrp)
		bv.MaxForce = Vector3.new(1e5, 1e5, 1e5)
		bv.Velocity = Vector3.zero

		game:GetService("RunService").Heartbeat:Connect(function()
			if flying and bv and char and hum then
				local dir = hum.MoveDirection
				local y = 0

				-- Check for Jump or Sit as Up/Down signal
				if hum:GetState() == Enum.HumanoidStateType.Jumping then
					y = 60 -- pataas
				elseif hum.Sit then
					y = -60 -- pababa
				end

				local vel = dir.Magnitude > 0 and dir.Unit * 60 or Vector3.zero
				bv.Velocity = Vector3.new(vel.X, y, vel.Z)
			end
		end)
	end
end)
