local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local hrpSize = 30
local enabled = false
local noclip = false
local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

-- update character kapag respawn
LocalPlayer.CharacterAdded:Connect(function(char)
    character = char
end)

-- GUI Setup
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.ResetOnSpawn = false

local success, hui = pcall(function() return gethui() end)
if not success or not hui then
    hui = game:GetService("CoreGui")
end

if syn and syn.protect_gui then
    pcall(function() syn.protect_gui(ScreenGui) end)
end

ScreenGui.Parent = hui

local cornerPanel = Instance.new("UICorner")

-- Main Panel
local Panel = Instance.new("Frame")
Panel.Parent = ScreenGui
Panel.Size = UDim2.new(0, 360, 0, 300)
Panel.Position = UDim2.new(0.5, -180, 0.1, 0)
Panel.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Panel.BackgroundTransparency = 0.3
Panel.BorderSizePixel = 2
Panel.Active = true
Panel.Draggable = true

cornerPanel.CornerRadius = UDim.new(0, 15)
cornerPanel.Parent = Panel

-- Minimize button
local MinBtn = Instance.new("TextButton")
MinBtn.Parent = Panel
MinBtn.Size = UDim2.new(0, 25, 0, 25)
MinBtn.Position = UDim2.new(1, -60, 0, 5)
MinBtn.Text = "-"
MinBtn.BackgroundColor3 = Color3.fromRGB(200, 200, 0)
MinBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
MinBtn.Font = Enum.Font.SourceSansBold
MinBtn.TextSize = 20

-- Exit button
local ExitBtn = Instance.new("TextButton")
ExitBtn.Parent = Panel
ExitBtn.Size = UDim2.new(0, 25, 0, 25)
ExitBtn.Position = UDim2.new(1, -30, 0, 5)
ExitBtn.Text = "X"
ExitBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
ExitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ExitBtn.Font = Enum.Font.SourceSansBold
ExitBtn.TextSize = 20

ExitBtn.MouseButton1Click:Connect(function()
    Panel.Visible = false
end)

-- Title
local Label = Instance.new("TextLabel")
Label.Size = UDim2.new(0.8, -20, 0, 25)
Label.Position = UDim2.new(0, 0, 0, 5)
Label.TextColor3 = Color3.fromRGB(255,255,255)
Label.Text = "Hydro Script"
Label.TextScaled = true
Label.BackgroundTransparency = 1
Label.Parent = Panel

-- Minimize logic
local minimized = false
MinBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    if minimized then
        for _, child in pairs(Panel:GetChildren()) do
            if child ~= MinBtn and child ~= Label and child ~= ExitBtn then
                child.Visible = false
            end
        end
        Panel.Size = UDim2.new(0, 360, 0, 40)
        MinBtn.Text = "+"
    else
        for _, child in pairs(Panel:GetChildren()) do
            child.Visible = true
        end
        Panel.Size = UDim2.new(0, 360, 0, 300)
        MinBtn.Text = "-"
    end
end)

-- Hitbox toggle
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Parent = Panel
ToggleBtn.Size = UDim2.new(0, 120, 0, 40)
ToggleBtn.Position = UDim2.new(0.5, -60, 0, 40)
ToggleBtn.Text = "Hitbox: OFF"
ToggleBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.Font = Enum.Font.SourceSansBold
ToggleBtn.TextSize = 20

-- Hitbox size controls
local PlusBtn = Instance.new("TextButton")
PlusBtn.Parent = Panel
PlusBtn.Size = UDim2.new(0, 50, 0, 40)
PlusBtn.Position = UDim2.new(0.5, 70, 0, 40)
PlusBtn.Text = "+"
PlusBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
PlusBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
PlusBtn.Font = Enum.Font.SourceSansBold
PlusBtn.TextSize = 24

local MinusBtn = Instance.new("TextButton")
MinusBtn.Parent = Panel
MinusBtn.Size = UDim2.new(0, 50, 0, 40)
MinusBtn.Position = UDim2.new(0.5, -120, 0, 40)
MinusBtn.Text = "-"
MinusBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
MinusBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinusBtn.Font = Enum.Font.SourceSansBold
MinusBtn.TextSize = 24

local SizeLabel = Instance.new("TextLabel")
SizeLabel.Parent = Panel
SizeLabel.Size = UDim2.new(0, 150, 0, 30)
SizeLabel.Position = UDim2.new(0.5, -75, 0, 85)
SizeLabel.Text = "Size: "..hrpSize
SizeLabel.BackgroundTransparency = 0.5
SizeLabel.TextColor3 = Color3.fromRGB(255,255,255)
SizeLabel.Font = Enum.Font.SourceSans
SizeLabel.TextSize = 18

ToggleBtn.MouseButton1Click:Connect(function()
    enabled = not enabled
    if enabled then
        ToggleBtn.Text = "Hitbox: ON"
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
    else
        ToggleBtn.Text = "Hitbox: OFF"
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    end
end)

PlusBtn.MouseButton1Click:Connect(function()
    hrpSize = hrpSize + 5
    SizeLabel.Text = "Size: "..hrpSize
end)

MinusBtn.MouseButton1Click:Connect(function()
    hrpSize = math.max(1, hrpSize - 5)
    SizeLabel.Text = "Size: "..hrpSize
end)

-- NoClip
local NoClipBtn = Instance.new("TextButton")
NoClipBtn.Parent = Panel
NoClipBtn.Size = UDim2.new(0, 150, 0, 30)
NoClipBtn.Position = UDim2.new(0.5, -75, 0, 130)
NoClipBtn.Text = "No Clip: OFF"
NoClipBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
NoClipBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
NoClipBtn.Font = Enum.Font.SourceSansBold
NoClipBtn.TextSize = 20

NoClipBtn.MouseButton1Click:Connect(function()
    noclip = not noclip
    NoClipBtn.Text = "No Clip: " .. (noclip and "ON" or "OFF")
end)

-- Fling UI
local PlayerFind = Instance.new("TextBox")
PlayerFind.Parent = Panel
PlayerFind.Size = UDim2.new(0, 150, 0, 30)
PlayerFind.Position = UDim2.new(0.5, -120, 0, 170)
PlayerFind.Font = Enum.Font.SourceSansBold
PlayerFind.PlaceholderText = "Enter Name"
PlayerFind.Text = ""
PlayerFind.TextSize = 20

local FlingButton = Instance.new("TextButton")
FlingButton.Parent = Panel
FlingButton.Size = UDim2.new(0, 70, 0, 30)
FlingButton.Position = UDim2.new(0.5, 30, 0, 170)
FlingButton.Text = "Fling"
FlingButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
FlingButton.TextColor3 = Color3.fromRGB(255, 255, 255)
FlingButton.Font = Enum.Font.SourceSansBold
FlingButton.TextSize = 20

-- Player finder
local function findPlayer(partial)
    partial = partial:lower()
    for _, p in ipairs(Players:GetPlayers()) do
        if p.Name:lower():sub(1, #partial) == partial then
            return p
        end
    end
end

-- Fling function
local function flingPlayer(targetName)
    local targetPlayer = findPlayer(targetName)
    if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local hrp = targetPlayer.Character.HumanoidRootPart

        local flingPart = Instance.new("Part")
        flingPart.Size = Vector3.new(5, 5, 5)
        flingPart.Anchored = false
        flingPart.CanCollide = false
        flingPart.Transparency = 1
        flingPart.CFrame = hrp.CFrame
        flingPart.Parent = workspace

        local weld = Instance.new("WeldConstraint")
        weld.Part0 = flingPart
        weld.Part1 = hrp
        weld.Parent = flingPart

        local spin = Instance.new("BodyAngularVelocity")
        spin.MaxTorque = Vector3.new(1e9, 1e9, 1e9)
        spin.AngularVelocity = Vector3.new(0, 5000, 0)
        spin.Parent = flingPart

        local flingForce = Instance.new("BodyVelocity")
        flingForce.Velocity = Vector3.new(0, 200, 0)
        flingForce.MaxForce = Vector3.new(1e9, 1e9, 1e9)
        flingForce.Parent = flingPart

        task.delay(1.5, function()
            flingPart:Destroy()
        end)
    else
        warn("Player not found or no HRP")
    end
end

FlingButton.MouseButton1Click:Connect(function()
    local targetName = PlayerFind.Text
    if targetName ~= "" then
        flingPlayer(targetName)
    end
end)

-- RunService Loops
RunService.Stepped:Connect(function()
    if character then
        for _, part in pairs(character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = not noclip
            end
        end
    end
end)

RunService.Heartbeat:Connect(function()
    if enabled then
        for _, v in pairs(Players:GetPlayers()) do
            if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                local hrp = v.Character.HumanoidRootPart
                pcall(function()
                    hrp.Size = Vector3.new(hrpSize, hrpSize, hrpSize)
                    hrp.Transparency = 0.5
                    hrp.Material = Enum.Material.ForceField
                    hrp.CanCollide = false
                    hrp.BrickColor = BrickColor.new("Bright red")
                end)
            end
        end
    end
end)
