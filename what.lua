local ReplicatedStorage = game:GetService("ReplicatedStorage")
local event = ReplicatedStorage:WaitForChild("ShowTrollGui")

event.OnClientEvent:Connect(function()
    if game.Players.LocalPlayer.PlayerGui:FindFirstChild("TrollGui") then return end

    local gui = Instance.new("ScreenGui")
    gui.Name = "TrollGui"

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.6, 0, 0.2, 0)
    label.Position = UDim2.new(0.2, 0, 0.4, 0)
    label.Text = "YOU GOT TROLLED!"
    label.TextSize = 42
    label.TextColor3 = Color3.new(1, 1, 1)
    label.BackgroundColor3 = Color3.new(1, 0, 0)
    label.Font = Enum.Font.FredokaOne
    label.TextStrokeTransparency = 0.3
    label.TextStrokeColor3 = Color3.new(0, 0, 0)

    label.Parent = gui
    gui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
end)
