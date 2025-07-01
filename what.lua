local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()

-- Enable noclip
game:GetService("RunService").Stepped:Connect(function()
	for _, part in pairs(char:GetDescendants()) do
		if part:IsA("BasePart") then
			part.CanCollide = false
		end
	end
end)
