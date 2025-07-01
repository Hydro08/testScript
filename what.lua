local player = game:GetService("Players").LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")
local hum = char:WaitForChild("Humanoid")

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "FlyGui"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local toggleBtn = Instance.new("TextButton")
toggleBtn.Size = UDim2.new(0, 100, 0, 50)
toggleBtn.Position = UDim2.new(0.5, -50, 0.85, 0)
toggleBtn.Text = "Fly ON"
toggleBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
toggleBtn.TextColor3 = Color3.fromRGB(1, 1, 1)
toggleBtn.BackgroundTransparency = 0.2
toggleBtn.Parent = gui

-- Flying logic
local flying = false
local bv

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

		-- Update movement each frame
		game:GetService("RunService").Heartbeat:Connect(function()
			if flying and bv and char and hum then
				local moveDir = hum.MoveDirection
				if moveDir.Magnitude > 0 then
					-- Lipad habang gumagalaw
					local velocity = moveDir.Unit * 60
					bv.Velocity = Vector3.new(velocity.X, 60, velocity.Z) -- may pataas na Y
				else
					-- Kapag walang galaw, steady lang sa ere
					bv.Velocity = Vector3.zero
				end
			end
		end)
	end
end)
