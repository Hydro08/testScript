-- GUI Setup
local ScreenGui = Instance.new("ScreenGui")
local ToggleBtn = Instance.new("TextButton")

ScreenGui.Parent = game:GetService("CoreGui")

ToggleBtn.Parent = ScreenGui
ToggleBtn.Size = UDim2.new(0, 120, 0, 50)
ToggleBtn.Position = UDim2.new(0.5, -60, 0.1, 0)
ToggleBtn.Text = "Hitbox: OFF"
ToggleBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.Font = Enum.Font.SourceSansBold
ToggleBtn.TextSize = 20
ToggleBtn.Draggable = true

-- Toggle Logic
local enabled = false
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

ToggleBtn.MouseButton1Click:Connect(function()
    enabled = not enabled
    if enabled then
        ToggleBtn.Text = "Hitbox: ON"
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
    else
        ToggleBtn.Text = "Hitbox: OFF"
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        -- ibalik sa normal size kapag OFF
        for _, v in pairs(Players:GetPlayers()) do
            if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                local hrp = v.Character.HumanoidRootPart
                hrp.Size = Vector3.new(2, 2, 1) -- default HRP size
                hrp.Transparency = 1
                hrp.Material = Enum.Material.Plastic
                hrp.CanCollide = true
                hrp.BrickColor = BrickColor.new("Medium stone grey")
            end
        end
    end
end)

-- Hitbox Loop
RunService.Heartbeat:Connect(function()
    if enabled then
        for _, v in pairs(Players:GetPlayers()) do
            if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                local hrp = v.Character.HumanoidRootPart
                pcall(function()
                    hrp.Size = Vector3.new(30, 30, 30) -- laki ng hitbox
                    hrp.Transparency = 0.5 -- para makita
                    hrp.Material = Enum.Material.ForceField -- glowing effect
                    hrp.CanCollide = false
                    hrp.BrickColor = BrickColor.new("Bright red") -- kulay
                end)
            end
        end
    end
end)
