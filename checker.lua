local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")

local gui = Instance.new("ScreenGui", player.PlayerGui)
local btn = Instance.new("TextButton", gui)

btn.Size = UDim2.new(0, 200, 0, 50)
btn.Position = UDim2.new(0.5, -100, 0.8, 0)
btn.Text = "Teleport!"
btn.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
btn.TextColor3 = Color3.fromRGB(255,255,255)
btn.TextScaled = true

btn.MouseButton1Click:Connect(function()
    hrp.CFrame = CFrame.new(100, 0, 0) -- Teleport sa taas
end)
