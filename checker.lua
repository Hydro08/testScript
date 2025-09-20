local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")

-- GUI setup
local gui = Instance.new("ScreenGui", player.PlayerGui)

-- TextBox para sa pangalan ng target
local box = Instance.new("TextBox", gui)
box.Size = UDim2.new(0, 200, 0, 50)
box.Position = UDim2.new(0.5, -100, 0.7, 0)
box.PlaceholderText = "Enter player name..."
box.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
box.TextColor3 = Color3.fromRGB(255, 255, 255)
box.TextScaled = true

-- Button para i-teleport
local btn = Instance.new("TextButton", gui)
btn.Size = UDim2.new(0, 200, 0, 50)
btn.Position = UDim2.new(0.5, -100, 0.8, 0)
btn.Text = "Teleport"
btn.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
btn.TextColor3 = Color3.fromRGB(255, 255, 255)
btn.TextScaled = true

-- Function kapag pinindot
btn.MouseButton1Click:Connect(function()
    local targetName = box.Text
    local target = game.Players:FindFirstChild(targetName)
    if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
        hrp.CFrame = target.Character.HumanoidRootPart.CFrame + Vector3.new(2, 0, 0)
    else
        btn.Text = "Player not found!"
        task.wait(1.5)
        btn.Text = "Teleport"
    end
end)
