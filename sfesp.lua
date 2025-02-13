local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer
local ESP = {}
local ESPEnabled = true

-- Function to create the GUI with only the ESP toggle button
local function CreateGUI()
    if ScreenGui then ScreenGui:Destroy() end
    
    ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
    
    -- ESP Toggle Button
    local ESPButton = Instance.new("TextButton", ScreenGui)
    ESPButton.Size = UDim2.new(0, 100, 0, 50)
    ESPButton.Position = UDim2.new(0, 10, 1, -60)
    ESPButton.Text = "ESP Off"
    ESPButton.BackgroundColor3 = Color3.new(0, 0, 0)
    ESPButton.TextColor3 = Color3.new(1, 1, 1)
    
    ESPButton.MouseButton1Click:Connect(function()
        ESPEnabled = not ESPEnabled
        ESPButton.Text = ESPEnabled and "ESP On" or "ESP Off"
    end)
end

-- Recreate GUI when resetting
LocalPlayer.CharacterAdded:Connect(CreateGUI)
CreateGUI()

function CreateESP(player)
    if player == LocalPlayer then return end -- Don't create ESP for self

    local function ApplyESP()
        if not player.Character then return end

        local highlight = Instance.new("Highlight")
        highlight.FillTransparency = 1 -- Outline only
        highlight.OutlineTransparency = 0
        highlight.OutlineColor = Color3.new(1, 1, 1) -- Default white
        highlight.Parent = player.Character

        local nameTag = Drawing.new("Text")
        nameTag.Size = 16
        nameTag.Color = Color3.new(1, 1, 1)
        nameTag.Outline = true
        nameTag.Center = true
        nameTag.Visible = false

        ESP[player] = {highlight = highlight, nameTag = nameTag}
        
        -- Update highlight when team changes
        player:GetPropertyChangedSignal("Team"):Connect(function()
            if ESP[player] and ESP[player].highlight then
                ESP[player].highlight.OutlineColor = player.Team and player.Team.TeamColor.Color or Color3.new(1, 1, 1)
            end
        end)
    end
    
    ApplyESP()
    player.CharacterAdded:Connect(ApplyESP) -- Reapply ESP when player respawns
    
    -- Remove ESP when character is removed (player dies)
    player.CharacterRemoving:Connect(function()
        if ESP[player] then
            ESP[player].highlight:Destroy()
            ESP[player].nameTag:Remove()
            ESP[player] = nil
        end
    end)
end

function UpdateESP()
    if not ESPEnabled then
        for _, player in pairs(Players:GetPlayers()) do
            if ESP[player] then
                ESP[player].nameTag.Visible = false
                if ESP[player].highlight.Parent then
                    ESP[player].highlight.Parent = nil
                end
            end
        end
        return
    end
    
    for _, player in pairs(Players:GetPlayers()) do
        if ESP[player] and player.Character and player.Character:FindFirstChild("Head") and player.Character:FindFirstChild("Humanoid") then
            local head = player.Character.Head
            local humanoid = player.Character.Humanoid
            local vector, onScreen = Camera:WorldToViewportPoint(head.Position + Vector3.new(0, 1.5, 0))
            
            local highlight = ESP[player].highlight
            local nameTag = ESP[player].nameTag
            
            if not highlight.Parent then
                highlight.Parent = player.Character
            end

            if onScreen then
                nameTag.Visible = true
                local distance = (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")) and (LocalPlayer.Character.HumanoidRootPart.Position - head.Position).Magnitude or 0
                nameTag.Position = Vector2.new(vector.X, vector.Y - 25)
                nameTag.Text = string.format("%s | %d HP | %.1f Studs", player.Name, math.floor(humanoid.Health), distance)
                
                local teamColor = player.Team and player.Team.TeamColor.Color or Color3.new(1, 1, 1)
                highlight.OutlineColor = teamColor
                nameTag.Color = teamColor
            else
                nameTag.Visible = false
            end
        end
    end
end

Players.PlayerAdded:Connect(CreateESP)
Players.PlayerRemoving:Connect(function(player)
    if ESP[player] then
        ESP[player].highlight:Destroy()
        ESP[player].nameTag:Remove()
        ESP[player] = nil
    end
end)

RunService.RenderStepped:Connect(UpdateESP)

for _, player in pairs(Players:GetPlayers()) do
    CreateESP(player)
end
