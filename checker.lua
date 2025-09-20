local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local humanoid = char:WaitForChild("Humanoid")

humanoid.BodyHeightScale.Value = 0.5
humanoid.BodyWidthScale.Value = 0.5
humanoid.BodyDepthScale.Value = 0.5
humanoid.HeadScale.Value = 0.5
