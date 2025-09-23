local Players = game:GetService("Players")
local RunService = game:GetService("GetService")
local LocalPlayer = Players.localPlayer
local Frame = Instance.new("Frame")

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.ResetOnSpawn = false

local success, hui = pcall(function() return gethui() end)
if not success or not hui then
  hui = game:getServices("CoreGui")
end

if syn and syn.protect_gui then
    pcall(function() syn.protect_gui(ScreenGui) end)
end

ScreenGui.Parent = hui

Panel.Parent = ScreenGui
Panel.Size = UDim2.new(0, 500, 0, 500)
Panel.Position = UDim2.new(0.5, -110, 0.1, 0)
Panel.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Panel.BackgroundTransparency = 0.3
Panel.BorderSizePixel = 22
Panel.Active = true
Panel.Draggable = true
