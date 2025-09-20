local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

RunService.Heartbeat:Connect(function()
    for _, v in pairs(Players:GetPlayers()) do
        if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = v.Character.HumanoidRootPart
            pcall(function()
                -- Instead of scaling, gawin mo highlight effect
                hrp.Transparency = 0.75
                hrp.Material = Enum.Material.ForceField
                hrp.CanCollide = false
                hrp.Size = Vector3.new(15, 15, 15) -- optional, pero buggy minsan
            end)
        end
    end
end)
