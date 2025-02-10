_G.AutoClicker = true
        while _G.AutoClicker do
            wait()
            pcall(function()
                local Sword = game:GetService'Players'.LocalPlayer.Character:FindFirstChildOfClass'Tool'
                Sword:Activate()
            end)
        end
