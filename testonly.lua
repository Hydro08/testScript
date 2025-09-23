-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- GUI Setup
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui") -- ✅ para gumana sa mobile

-- Toggle Button
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Parent = ScreenGui
ToggleBtn.Size = UDim2.new(0, 120, 0, 50)
ToggleBtn.Position = UDim2.new(0.5, -60, 0.1, 0)
ToggleBtn.Text = "Hitbox: OFF"
ToggleBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.Font = Enum.Font.SourceSansBold
ToggleBtn.TextSize = 20

-- Plus Button
local PlusBtn = Instance.new("TextButton")
PlusBtn.Parent = ScreenGui
PlusBtn.Size = UDim2.new(0, 50, 0, 50)
PlusBtn.Position = UDim2.new(0.5, 70, 0.1, 0)
PlusBtn.Text = "+"
PlusBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 255)
PlusBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
PlusBtn.Font = Enum.Font.SourceSansBold
PlusBtn.TextSize = 30

-- Minus Button
local MinusBtn = Instance.new("TextButton")
MinusBtn.Parent = ScreenGui
MinusBtn.Size = UDim2.new(0, 50, 0, 50)
MinusBtn.Position = UDim2.new(0.5, 130, 0.1, 0)
MinusBtn.Text = "-"
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
