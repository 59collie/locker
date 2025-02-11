local player = game.Players.LocalPlayer
local reach = 0
local keyBindHigher = "z"
local keyBindLower = "x"
local reachOff = false
local autoClicker = false

-- Function to manage reach functionality
local function manageReach()
    game:GetService("RunService").Stepped:Connect(function()
        if reachOff then return end
        pcall(function()
            local sword = player.Character:FindFirstChildOfClass("Tool") and player.Character:FindFirstChildOfClass("Tool").Handle
            if sword then
                for _, v in pairs(game.Players:GetPlayers()) do
                    if v ~= player and v.Character:FindFirstChild("Left Arm") then
                        if (player.Character.Torso.Position - v.Character.Torso.Position).Magnitude <= reach then
                            for _, limb in ipairs({"Left Arm", "Left Leg"}) do
                                local part = v.Character:FindFirstChild(limb)
                                if part then
                                    part:BreakJoints()
                                    part.Transparency = 1
                                    part.CanCollide = false
                                    part.CFrame = player.Character.HumanoidRootPart.CFrame * CFrame.new(1, 0, -3.5)
                                end
                            end
                        end
                    end
                end
            end
        end)
    end)
end

-- Function to handle keybinds for reach adjustment
local function handleKeyBinds()
    local mouse = player:GetMouse()
    mouse.KeyDown:Connect(function(key)
        if key == keyBindHigher then
            reach = reach + 1
            game.StarterGui:SetCore("SendNotification", {
                Title = "Reach",
                Text = "Reach set to " .. reach,
                Icon = "",
                Duration = 1
            })
        elseif key == keyBindLower then
            reach = reach - 1
            game.StarterGui:SetCore("SendNotification", {
                Title = "Reach",
                Text = "Reach set to " .. reach,
                Icon = "",
                Duration = 1
            })
        end
    end)
end

-- Function to handle auto-clicker functionality
local function startAutoClicker()
    autoClicker = true
    while autoClicker do
        wait()
        pcall(function()
            local sword = player.Character:FindFirstChildOfClass("Tool")
            if sword then
                sword:Activate()
            end
        end)
    end
end

-- Function to destroy specific objects in ReplicatedStorage
local function destroyReplicatedStorageObjects()
    for _, objectName in ipairs({"ClientAlert", "ServerAlert", "CheckAdmin", "WarnRemote"}) do
        local object = game:GetService("ReplicatedStorage"):FindFirstChild(objectName)
        if object then
            object:Destroy()
        end
    end
end

-- Function to execute the script when the button is clicked
local function executeScript()
    manageReach()
    handleKeyBinds()
    startAutoClicker()
    destroyReplicatedStorageObjects()
end

-- Assuming you have a button setup, connect it here
-- Replace `yourButton` with the actual button reference
-- yourButton.MouseButton1Click:Connect(executeScript)
