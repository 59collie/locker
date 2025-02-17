--  _   __     __            
-- | | / /_ __/ /______ ____ 
-- | |/ / // / / __/ _ `/ _ \
-- |___/\_,_/_/\__/\_,_/_//_/

-- Made by 59Collie

--Keybinds:
--Z: Toggle
--U: Autoclicker
--N: Notifications
--J: Increase Amp
--K: Decrease Amp
--Q: Increase Distance
--E: Decrease Distance
                           



local amp = 5
local players = game:GetService("Players")
local localPlayer = players.LocalPlayer
local keyDown = true
local distance = 9
local showNotifications = true
local autoclicker = false

-- Whitelisted limbs
local limbWhitelist = {
    ["Head"] = true,
    ["LeftArm"] = true,
    ["RightArm"] = true,
    ["LeftLeg"] = true,
    ["RightLeg"] = true,
    ["Torso"] = true,
    ["UpperTorso"] = true,
    ["LowerTorso"] = true,
    ["HumanoidRootPart"] = true 
}

game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessedEvent)
    if input.KeyCode == Enum.KeyCode.Z and not gameProcessedEvent then
        keyDown = not keyDown
        if showNotifications then
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "Vulcan 1.0";
                Text = "Toggled = " .. (keyDown and "On" or "Off");
            })
        end
    elseif input.KeyCode == Enum.KeyCode.K and not gameProcessedEvent then
        amp = math.max(0, amp - 3)
        if showNotifications then
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "Vulcan 1.0";
                Text = "Amp = " .. amp;
            })
        end
    elseif input.KeyCode == Enum.KeyCode.J and not gameProcessedEvent then
        amp = amp + 3
        if showNotifications then
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "Vulcan 1.0";
                Text = "Amp = " .. amp;
            })
        end
    elseif input.KeyCode == Enum.KeyCode.Q and not gameProcessedEvent then
        distance = distance + 1
        if showNotifications then
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "Vulcan 1.0";
                Text = "Distance = " .. distance;
            })
        end
    elseif input.KeyCode == Enum.KeyCode.E and not gameProcessedEvent then
        distance = math.max(0, distance - 1)
        if showNotifications then
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "Vulcan 1.0";
                Text = "Distance = " .. distance;
            })
        end
    elseif input.KeyCode == Enum.KeyCode.N and not gameProcessedEvent then
        showNotifications = not showNotifications
    elseif input.KeyCode == Enum.KeyCode.U and not gameProcessedEvent then
        autoclicker = not autoclicker
        if showNotifications then
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "Vulcan 1.0";
                Text = "Autoclicker = " .. (autoclicker and "On" or "Off");
            })
        end
    end
end)

game:GetService("RunService").RenderStepped:Connect(function()
    if keyDown then
        local s, e = pcall(function()
            if autoclicker then
                localPlayer.Character:FindFirstChildOfClass("Tool"):Activate()
            end
            for _, player in pairs(players:GetPlayers()) do
                if player ~= localPlayer and (player.Character.Head.Position - localPlayer.Character.Head.Position).magnitude <= distance then
                    for _, limb in pairs(player.Character:GetChildren()) do
                        if limb:IsA("BasePart") and limbWhitelist[limb.Name] then
                            for i = 1, amp do
                                firetouchinterest(localPlayer.Character:FindFirstChildOfClass("Tool").Handle, limb, 0)
                                firetouchinterest(localPlayer.Character:FindFirstChildOfClass("Tool").Handle, limb, 1)
                            end
                        end
                    end
                end
            end
        end)
        if not s then
            warn(e)
        end
    end
end)
