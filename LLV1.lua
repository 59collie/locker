local function executeScript()
    local Watchdog = false
    local UBlubble = false
    local Kanti = false
    local UAttack = false
    local AntiX = false
    local StorAnti = false
    local Groundsv1 = false
    local Groundsv2 = false
    local Groundsv3 = false

    local AllAntiCheats = true

    local amp = 5
    local players = game:GetService("Players")
    local localPlayer = players.LocalPlayer
    local keyDown = true
    local distance = 9
    local showNotifications = true
    local autoclicker = false

    game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessedEvent)
        if input.KeyCode == Enum.KeyCode.Z and not gameProcessedEvent then
            keyDown = not keyDown
            if showNotifications then
                game:GetService("StarterGui"):SetCore("SendNotification", {
                    Title = "Ludicrous Laughter V1";
                    Text = "Toggled = " .. (keyDown and "On" or "Off");
                })
            end
        elseif input.KeyCode == Enum.KeyCode.K and not gameProcessedEvent then
            amp = math.max(0, amp - 3)
            if showNotifications then
                game:GetService("StarterGui"):SetCore("SendNotification", {
                    Title = "Ludicrous Laughter V1";
                    Text = "Amp = " .. amp;
                })
            end
        elseif input.KeyCode == Enum.KeyCode.J and not gameProcessedEvent then
            amp = amp + 3
            if showNotifications then
                game:GetService("StarterGui"):SetCore("SendNotification", {
                    Title = "Ludicrous Laughter V1";
                    Text = "Amp = " .. amp;
                })
            end
        elseif input.KeyCode == Enum.KeyCode.Q and not gameProcessedEvent then
            distance = distance + 1
            if showNotifications then
                game:GetService("StarterGui"):SetCore("SendNotification", {
                    Title = "Ludicrous Laughter V1";
                    Text = "Distance = " .. distance;
                })
            end
        elseif input.KeyCode == Enum.KeyCode.E and not gameProcessedEvent then
            distance = math.max(0, distance - 1)
            if showNotifications then
                game:GetService("StarterGui"):SetCore("SendNotification", {
                    Title = "Ludicrous Laughter V1";
                    Text = "Distance = " .. distance;
                })
            end
        elseif input.KeyCode == Enum.KeyCode.N and not gameProcessedEvent then
            showNotifications = not showNotifications
        elseif input.KeyCode == Enum.KeyCode.U and not gameProcessedEvent then
            autoclicker = not autoclicker
            if showNotifications then
                game:GetService("StarterGui"):SetCore("SendNotification", {
                    Title = "Ludicrous Laughter V1";
                    Text = "Autoclicker = " .. (autoclicker and "On" or "Off");
                })
            end
        end
    end)

    game:GetService("RunService").RenderStepped:Connect(function()
        if keyDown then
            local success, err = pcall(function()
                if autoclicker then
                    local tool = localPlayer.Character:FindFirstChildOfClass("Tool")
                    if tool then
                        tool:Activate()
                    end
                end
                for _, v in pairs(players:GetPlayers()) do
                    if v ~= localPlayer and v.Character and v.Character:FindFirstChild("Head") and (v.Character.Head.Position - localPlayer.Character.Head.Position).magnitude <= distance then
                        for _, part in pairs(v.Character:GetChildren()) do
                            if part:IsA("BasePart") then
                                for _ = 1, amp do
                                    local toolHandle = localPlayer.Character:FindFirstChildOfClass("Tool") and localPlayer.Character:FindFirstChildOfClass("Tool").Handle
                                    if toolHandle then
                                        firetouchinterest(toolHandle, part, 0)
                                        firetouchinterest(toolHandle, part, 1)
                                    end
                                end
                            end
                        end
                    end
                end
            end)
            if not success then
                warn("Error in script execution: " .. err)
            end
        end
    end)
end

-- Connect this function to your button
-- yourButton.MouseButton1Click:Connect(executeScript)
