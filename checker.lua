--// Simple Teleport GUI by Name
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Create ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = game.CoreGui

-- Create Frame
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 250, 0, 120)
frame.Position = UDim2.new(0.5, -125, 0.4, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
frame.Parent = screenGui

-- Create TextBox
local textBox = Instance.new("TextBox")
textBox.Size = UDim2.new(0, 200, 0, 30)
textBox.Position = UDim2.new(0.5, -100, 0.2, 0)
textBox.PlaceholderText = "Enter username/displayname"
textBox.Text = ""
textBox.TextScaled = true
textBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
textBox.TextColor3 = Color3.fromRGB(255, 255, 255)
textBox.Parent = frame
textBox.Draggabe = true

-- Create Teleport Button
local button = Instance.new("TextButton")
button.Size = UDim2.new(0, 200, 0, 35)
button.Position = UDim2.new(0.5, -100, 0.55, 0)
button.Text = "Teleport"
button.TextScaled = true
button.BackgroundColor3 = Color3.fromRGB(70, 130, 180)
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.Parent = frame
button.Draggable = true

-- Status Label
local status = Instance.new("TextLabel")
status.Size = UDim2.new(0, 200, 0, 20)
status.Position = UDim2.new(0.5, -100, 0.85, 0)
status.Text = ""
status.TextScaled = true
status.BackgroundTransparency = 1
status.TextColor3 = Color3.fromRGB(200, 200, 200)
status.Parent = frame

-- Teleport Function
local function teleportToPlayer(nameInput)
    for _, player in ipairs(Players:GetPlayers()) do
        if string.lower(player.Name) == string.lower(nameInput) 
        or string.lower(player.DisplayName) == string.lower(nameInput) then
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                LocalPlayer.Character:MoveTo(player.Character.HumanoidRootPart.Position)
                status.Text = "Teleported to " .. player.Name
                return
            end
        end
    end
    status.Text = "Player not found!"
end

-- Button Click
button.MouseButton1Click:Connect(function()
    if textBox.Text ~= "" then
        teleportToPlayer(textBox.Text)
    else
        status.Text = "Enter a name first!"
    end
end)
