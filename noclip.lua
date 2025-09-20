-- Mobile-friendly Noclip (LocalScript)
-- Toggle gamit ang on-screen button (touch)
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local noclip = false

-- Create ScreenGui in PlayerGui (mobile friendly)
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MobileNoclipGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = PlayerGui
screenGui.IgnoreGuiInset = true -- para mas malapit sa edges sa mobile

-- Frame container (draggable)
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 160, 0, 56)
frame.Position = UDim2.new(0.5, -80, 0.02, 0)
frame.BackgroundTransparency = 0.18
frame.BackgroundColor3 = Color3.fromRGB(22,22,22)
frame.BorderSizePixel = 0
frame.Parent = screenGui
frame.Active = true

-- Title
local title = Instance.new("TextLabel")
title.Size = UDim2.new(0, 120, 0, 18)
title.Position = UDim2.new(0, 8, 0, 4)
title.BackgroundTransparency = 1
title.Text = "Noclip"
title.TextColor3 = Color3.fromRGB(255,255,255)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 14
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = frame

-- Toggle Button (touch friendly, big)
local btn = Instance.new("TextButton")
btn.Size = UDim2.new(0, 140, 0, 34)
btn.Position = UDim2.new(0, 10, 0, 18)
btn.Text = "OFF"
btn.Font = Enum.Font.SourceSansBold
btn.TextSize = 16
btn.TextColor3 = Color3.fromRGB(255,255,255)
btn.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
btn.AutoButtonColor = true
btn.Parent = frame

-- Make frame draggable (touch-friendly)
do
    local dragging = false
    local dragStart
    local startPos

    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement then
            -- store move input for InputChanged on UIS
        end
    end)

    UIS.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement) then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
                                       startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

-- Toggle function (updates button text/color)
local function setNoclip(state)
    noclip = state
    btn.Text = noclip and "ON" or "OFF"
    btn.BackgroundColor3 = noclip and Color3.fromRGB(0,170,0) or Color3.fromRGB(170,0,0)

    if not noclip then
        -- kapag OFF, subukan natin i-restore CanCollide (best-effort)
        local char = LocalPlayer.Character
        if char then
            for _, part in pairs(char:GetChildren()) do
                if part:IsA("BasePart") then
                    pcall(function() part.CanCollide = true end)
                end
            end
        end
    end
end

-- Button touch
btn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        setNoclip(not noclip)
    end
end)

-- Main loop: apply noclip when enabled
RunService.Stepped:Connect(function()
    if noclip then
        local char = LocalPlayer.Character
        if char then
            for _, part in pairs(char:GetChildren()) do
                if part:IsA("BasePart") then
                    -- set CanCollide false while noclip ON (client-side)
                    pcall(function() part.CanCollide = false end)
                end
            end
        end
    end
end)

-- Safety: kapag nag-respawn, auto off para hindi mag-stay
LocalPlayer.CharacterAdded:Connect(function()
    setNoclip(false)
end)
