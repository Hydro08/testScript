-- Troll GUI for loadstring (Delta compatible)

local player = game:GetService("Players").LocalPlayer

-- Iwas duplicate
if player:FindFirstChild("PlayerGui"):FindFirstChild("TrollGui") then
	return
end

-- Create ScreenGui
local gui = Instance.new("ScreenGui")
gui.Name = "TrollGui"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Create Label
local label = Instance.new("TextLabel")
label.Size = UDim2.new(0.6, 0, 0.2, 0)
label.Position = UDim2.new(0.2, 0, 0.4, 0)
label.Text = "😈 YOU GOT TROLLED! 😈"
label.TextSize = 42
label.Font = Enum.Font.FredokaOne
label.TextColor3 = Color3.new(1, 1, 1)
label.BackgroundColor3 = Color3.new(1, 0, 0)
label.BorderSizePixel = 4
label.TextStrokeTransparency = 0.3
label.TextStrokeColor3 = Color3.new(0, 0, 0)
label.BackgroundTransparency = 0

label.Parent = gui
gui.Parent = player:WaitForChild("PlayerGui")
