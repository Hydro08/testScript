-- Variables
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- Hitbox Size
local hrpSize = 30
local enabled = false

-- GUI Setup (para gumana sa cp gamit Delta)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.ResetOnSpawn = false

local success, hui = pcall(function() return gethui() end)
if not success or not hui then
    hui = game:GetService("CoreGui")
end
ScreenGui.Parent = hui

-- Toggle Button
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Parent = ScreenGui
ToggleBtn.Size = UDim2.new(0, 120, 0, 40)
ToggleBtn.Position = UDim2.new(0.5, -60, 0.1, 0)
ToggleBtn.Text = "Hitbox: OFF"
ToggleBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.Font = Enum.Font.SourceSansBold
ToggleBtn.TextSize = 20
ToggleBtn.Draggable = true

-- + Button
local PlusBtn = Instance.new("TextButton")
PlusBtn.Parent = ScreenGui
PlusBtn.Size = UDim2.new(0, 50, 0, 40)
PlusBtn.Position = UDim2.new(0.5, 70, 0.1, 0)
PlusBtn.Text = "+"
PlusBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
PlusBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
PlusBtn.Font = Enum.Font.SourceSansBold
PlusBtn.TextSize = 24
PlusBtn.Draggable = true

-- - Button
local MinusBtn = Instance.new("TextButton")
MinusBtn.Parent = ScreenGui
MinusBtn.Size = UDim2.new(0, 50, 0, 40)
MinusBtn.Position = UDim2.new(0.5, -120, 0.1, 0)
MinusBtn.Text = "-"
MinusBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
MinusBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinusBtn.Font = Enum.Font.SourceSansBold
MinusBtn.TextSize = 24
MinusBtn.Draggable = true

-- Toggle Logic
ToggleBtn.MouseButton1Click:Connect(function()
    enabled = not enabled
    if enabled then
        ToggleBtn.Text = "Hitbox: ON"
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
    else
        ToggleBtn.Text = "Hitbox: OFF"
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        -- Reset HRP size kapag naka OFF
        for _, v in pairs(Players:GetPlayers()) do
            if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                local hrp = v.Character.HumanoidRootPart
                hrp.Size = Vector3.new(2, 2, 1)
                hrp.Transparency = 1
                hrp.Material = Enum.Material.Plastic
                hrp.CanCollide = true
                hrp.BrickColor = BrickColor.new("Medium stone grey")
            end
        end
    end
end)

-- Plus Button Logic
PlusBtn.MouseButton1Click:Connect(function()
    hrpSize = hrpSize + 1
    print("Hitbox Size: " .. hrpSize)
end)

-- Minus Button Logic
MinusBtn.MouseButton1Click:Connect(function()
    hrpSize = math.max(1, hrpSize - 1) -- bawal maging 0 o negative
    print("Hitbox Size: " .. hrpSize)
end)

-- Hitbox Loop
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
end)MinusBtn.Text = "-"
MinusBtn.BackgroundColor3 = Color3.fromRGB(255, 165, 0)
MinusBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinusBtn.Font = Enum.Font.SourceSansBold
MinusBtn.TextSize = 30

-- Logic
local enabled = false
local hrpSize = Vector3.new(30, 30, 30) -- default size

ToggleBtn.MouseButton1Click:Connect(function()
	enabled = not enabled
	if enabled then
		ToggleBtn.Text = "Hitbox: ON"
		ToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
	else
		ToggleBtn.Text = "Hitbox: OFF"
		ToggleBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)

		-- reset lahat ng HRP kapag OFF
		for _, v in pairs(Players:GetPlayers()) do
			if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
				local hrp = v.Character.HumanoidRootPart
				hrp.Size = Vector3.new(2, 2, 1)
				hrp.Transparency = 1
				hrp.Material = Enum.Material.Plastic
				hrp.CanCollide = true
				hrp.BrickColor = BrickColor.new("Medium stone grey")
			end
		end
	end
end)

-- Palaki
PlusBtn.MouseButton1Click:Connect(function()
	hrpSize = hrpSize + Vector3.new(1, 1, 1)
	print("New Hitbox Size:", hrpSize)
end)

-- Paliit
MinusBtn.MouseButton1Click:Connect(function()
	hrpSize = hrpSize - Vector3.new(1, 1, 1)
	if hrpSize.X < 2 then
		hrpSize = Vector3.new(2, 2, 2) -- minimum size
	end
	print("New Hitbox Size:", hrpSize)
end)

-- Hitbox Loop
RunService.Heartbeat:Connect(function()
	if enabled then
		for _, v in pairs(Players:GetPlayers()) do
			if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
				local hrp = v.Character.HumanoidRootPart
				pcall(function()
					hrp.Size = hrpSize
					hrp.Transparency = 0.5
					hrp.Material = Enum.Material.ForceField
					hrp.CanCollide = false
					hrp.BrickColor = BrickColor.new("Bright red")
				end)
			end
		end
	end
end)ToggleBtn.MouseButton1Click:Connect(function()
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
                hrp.Size = Vector3.new(2, 2, 1)
                hrp.Transparency = 1
                hrp.Material = Enum.Material.Plastic
                hrp.CanCollide = true
                hrp.BrickColor = BrickColor.new("Medium stone grey")
            end
        end
    end
end)

-- Plus button para palakihin
PlusBtn.MouseButton1Click:Connect(function()
    hrpSize = hrpSize + Vector3.new(1,1,1) -- dagdag 1 sa lahat ng axis
    print("New Hitbox Size:", hrpSize)
end)

-- Hitbox Loop
RunService.Heartbeat:Connect(function()
    if enabled then
        for _, v in pairs(Players:GetPlayers()) do
            if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                local hrp = v.Character.HumanoidRootPart
                pcall(function()
                    hrp.Size = hrpSize
                    hrp.Transparency = 0.5
                    hrp.Material = Enum.Material.ForceField
                    hrp.CanCollide = false
                    hrp.BrickColor = BrickColor.new("Bright red")
                end)
            end
        end
    end
end)                hrp.Material = Enum.Material.Plastic
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
