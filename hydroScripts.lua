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
