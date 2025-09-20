-- GUI Setup
local ScreenGui = Instance.new("ScreenGui")
local ToggleBtn = Instance.new("TextButton")

ScreenGui.Parent = game:GetService("CoreGui")

ToggleBtn.Parent = ScreenGui
ToggleBtn.Size = UDim2.new(0, 100, 0, 50)
ToggleBtn.Position = UDim2.new(0.5, -50, 0.1, 0)
ToggleBtn.Text = "ESP: OFF"
ToggleBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

-- Toggle Logic
local enabled = false
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

ToggleBtn.MouseButton1Click:Connect(function()
    enabled = not enabled
    if enabled then
        ToggleBtn.Text = "ESP: ON"
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
    else
        ToggleBtn.Text = "ESP: OFF"
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    end
end)

-- ESP Loop
RunService.Heartbeat:Connect(function()
    if enabled then
        for _, v in pairs(Players:GetPlayers()) do
            if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                if not v.Character:FindFirstChild("Highlight") then
                    local highlight = Instance.new("Highlight")
                    highlight.Parent = v.Character
                    highlight.FillColor = Color3.fromRGB(0, 255, 0)
                    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                end
            end
        end
    else
        -- Kapag naka OFF, burahin lahat ng highlight
        for _, v in pairs(Players:GetPlayers()) do
            if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("Highlight") then
                v.Character.Highlight:Destroy()
            end
        end
    end
end)
