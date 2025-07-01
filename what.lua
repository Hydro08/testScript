-- Auto-fly for mobile (Delta-safe)

local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")

local flySpeed = 60
local bodyVelocity = Instance.new("BodyVelocity")
bodyVelocity.Velocity = Vector3.new(0, 0, 0)
bodyVelocity.MaxForce = Vector3.new(1e5, 1e5, 1e5)
bodyVelocity.Parent = hrp

-- Auto upward float
game:GetService("RunService").RenderStepped:Connect(function()
	if player and player.Character and hrp then
		bodyVelocity.Velocity = Vector3.new(0, flySpeed, 0) -- float upward
	end
end)
