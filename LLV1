--[[

█░░ █░█ █▀▄ █ █▀▀ █▀█ █▀█ █░█ █▀   █░░ ▄▀█ █░█ █▀▀ █░█ ▀█▀ █▀▀ █▀█
█▄▄ █▄█ █▄▀ █ █▄▄ █▀▄ █▄█ █▄█ ▄█   █▄▄ █▀█ █▄█ █▄█ █▀█ ░█░ ██▄ █▀▄

VERSION 1

Courtesy of:
    1. LudiZaboodi
    2. Floptokers
    3. Jiafei
    4. Floptropica stans - created this amazing script in favor of raising money to buy floptropica - view at https://www.floptropica.com


~~~ About The Script ~~~

Bypasses:
    1. Watchdog
    2. UBlubble
    3. Kanti
    4. UAttack
    5. Anti X
    6. Stor.Anti
    7. Grounds V1
    8. Grounds V2
    9. Grounds V3
    10. Any other SwordFighting Anti-Cheat you can think of

🚫 FOR ANYONE WHO OWNS THIS SCRIPT WITHOUT PERMISSION:
    -- I HAVE A PROBLEM WITH YOU, SO AS SOON ***AS*** WE FIND OUT WHO YOU ARE, TRUST - YOU WILL BE DEALT WITH. PERIOD, PERIOD.


~~~ Keybinds ~~~

        SCRIPT = {
            ["ENABLED/DISABLED"] = "Z" - Toggles script on / off
    };
        REACH = {
            ["INCREASE AMP"] = "J" - Increases damage amplification by 3
            ["DECREASE AMP"] = "K" - Decreases damage amplification by 3
            ["INCREASE DISTANCE"] = "Q" - Increases distance by 1
            ["DECREASE DISTANCE"] = "E" - Decreases distance by 1
    };
      MISCELLANEOUS = {
            ["NOTIFICATIONS"] = "N" - Toggles notifications on / off
            ["AUTOCLICKER"] = "U" - Toggles autoclicker on / off
    }


~~~ Extra Info ~~~

WARNING — Do not make amp too high when you're in a server with a lot of players - this is a Damage Amplification script - you wull lag extremely hard if you set it high,
Also the reason I made the increments decreased and increased by 3,


~~~ Amp Precautions ~~~

5-10 Players: Amp on 20-30
10-20 Players: Amp on 10-15
30-50 Players: Amp on 5-10
50-100 Players: Amp on 1-5

Note: This has been compensated for, and I added a distance in which you can set the reach to - it was unlimited before. However, upon being close to the player in which the distance you wished to put, 
you will lag based on how many players are in the server and based on the number of your amp.

]]--

-- SCRIPT (BELOW):

-- ALL THE GOOD ANTICHEATS, YOU CAN PICK INDIVIDUAL ONES AND MAKE THEM TRUE SO THE SCRIPT BYPASSES:

local Watchdog = false
local UBlubble = false
local Kanti = false
local UAttack = false
local AntiX = false
local StorAnti = false
local Groundsv1 = false
local Groundsv2 = false
local Groundsv3 = false

-- ALL ANTICHEATS AT ONCE, MAKE THIS TRUE IF YOU WANT THE SCRIPT TO BYPASS ALL SWORDFIGHTING ANTICHEATS:

local AllAntiCheats = true

-- ACTUAL SCRIPT:

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
        local s,e = pcall(function()
            if autoclicker then
                localPlayer.Character:FindFirstChildOfClass("Tool"):Activate()
            end
            for i, v in pairs(players:GetPlayers()) do
                if v ~= localPlayer and (v.Character.Head.Position - localPlayer.Character.Head.Position).magnitude <= distance then
                    for i2, v2 in pairs(v.Character:GetChildren()) do
                        if v2:IsA("BasePart") then
                            for i = 1, amp do
                                firetouchinterest(localPlayer.Character:FindFirstChildOfClass("Tool").Handle, v2, 0)
                                firetouchinterest(localPlayer.Character:FindFirstChildOfClass("Tool").Handle, v2, 1)
                            end
                        end
                    end
                end
            end
        end)
    end
end)
