local player = game:GetService("Players").LocalPlayer

local gui = Instance.new("ScreenGui")
gui.Name = "TrollGui"
gui.ResetOnSpawn = false

local label = Instance.new("TextLabel")
label.Size = UDim2.new(0.6, 0, 0.2, 0)
label.Position = UDim2.new(0.2, 0, 0.4, 0)
label.Text = "YOU GOT TROLLED!"
label.TextSize = 40
label.Font = Enum.Font.FredokaOne
label.TextColor3 = Color3.new(1, 1, 1)
label.BackgroundColor3 = Color3.new(1, 0, 0)
label.Parent = gui

gui.Parent = player:WaitForChild("PlayerGui")
