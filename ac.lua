    -- Auto-clicker functionality
    spawn(function()
        while autoClicker do
            wait()
            pcall(function()
                local sword = player.Character:FindFirstChildOfClass("Tool")
                if sword then
                    sword:Activate()
                end
            end)
        end
    end)
