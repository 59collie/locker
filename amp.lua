-- Function to encapsulate and manage script functionality
local function executeLudicrousLaughterScript()
    local player = game.Players.LocalPlayer
    local keyDown = true
    local distance = 9
    local amp = 5
    local autoclicker = false
    local showNotifications = true

    -- Function to manage input events
    local function handleInput(input, gameProcessedEvent)
        if gameProcessedEvent then return end

        if input.KeyCode == Enum.KeyCode.Z then
            keyDown = not keyDown
            if showNotifications then
                game:GetService("StarterGui"):SetCore("SendNotification", {
                    Title = "Ludicrous Laughter V1",
                    Text = "Toggled = " .. (keyDown and "On" or "Off")
                })
            end
        elseif input.KeyCode == Enum.KeyCode.K then
            amp = math.max(0, amp - 3)
            if showNotifications then
                game:GetService("StarterGui"):SetCore("SendNotification", {
                    Title = "Ludicrous Laughter V1",
                    Text = "Amp = " .. amp
                })
            end
        elseif input.KeyCode == Enum.KeyCode.J then
            amp = amp + 3
            if showNotifications then
                game:GetService("StarterGui"):SetCore("SendNotification", {
                    Title = "Ludicrous Laughter V1",
                    Text = "Amp = " .. amp
                })
            end
        elseif input.KeyCode == Enum.KeyCode.Q then
            distance = distance + 1
            if showNotifications then
                game:GetService("StarterGui"):SetCore("SendNotification", {
                    Title = "Ludicrous Laughter V1",
                    Text = "Distance = " .. distance
                })
            end
        elseif input.KeyCode == Enum.KeyCode.E then
            distance = math.max(0, distance - 1)
            if showNotifications then
                game:GetService("StarterGui"):SetCore("SendNotification", {
                    Title = "Ludicrous Laughter V1",
                    Text = "Distance = " .. distance
                })
            end
        elseif input.KeyCode == Enum.KeyCode.U then
            autoclicker = not autoclicker
            if showNotifications then
                game:GetService("StarterGui"):SetCore("SendNotification", {
                    Title = "Ludicrous Laughter V1",
                    Text = "Autoclicker = " .. (autoclicker and "On" or "Off")
                })
            end
        end
    end

    -- Function to manage the main loop
    local function mainLoop()
        if keyDown then
            pcall(function()
                if autoclicker then
                    local tool = player.Character:FindFirstChildOfClass("Tool")
                    if tool then tool:Activate() end
                end

                for _, otherPlayer in pairs(game.Players:GetPlayers()) do
                    if otherPlayer ~= player and otherPlayer.Character and otherPlayer.Character:FindFirstChild("Head") then
                        if (otherPlayer.Character.Head.Position - player.Character.Head.Position).Magnitude <= distance then
                            for _, part in pairs(otherPlayer.Character:GetChildren()) do
                                if part:IsA("BasePart") then
                                    for _ = 1, amp do
                                        local toolHandle = player.Character:FindFirstChildOfClass("Tool") and player.Character:FindFirstChildOfClass("Tool").Handle
                                        if toolHandle then
                                            firetouchinterest(toolHandle, part, 0)
                                            firetouchinterest(toolHandle, part, 1)
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end)
        end
    end

    -- Connect input handling
    game:GetService("UserInputService").InputBegan:Connect(handleInput)
    -- Connect main loop
    game:GetService("RunService").RenderStepped:Connect(mainLoop)
end

-- Connect this function to your button
-- Replace `yourButton` with the actual button reference
-- yourButton.MouseButton1Click:Connect(executeLudicrousLaughterScript)
