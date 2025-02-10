local screenGui = Instance.new("ScreenGui")
screenGui.ResetOnSpawn = false -- Prevents the GUI from disappearing on death

local frame = Instance.new("Frame")
local toggleButton = Instance.new("TextButton")

-- Parent to the PlayerGui
local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
screenGui.Parent = playerGui

-- Frame properties
frame.Size = UDim2.new(0, 300, 0, 350) -- Adjusted size to fit the buttons comfortably
frame.Position = UDim2.new(0.5, -150, 0.5, -175) -- Position it in the center
frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
frame.Visible = false -- Initially hidden
frame.Parent = screenGui

-- Toggle button properties
toggleButton.Size = UDim2.new(0, 100, 0, 50)
toggleButton.Position = UDim2.new(0, 10, 1, -360) -- Keep the same position
toggleButton.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
toggleButton.Text = "Open Menu"
toggleButton.Parent = screenGui

-- Toggle menu visibility
local isOpen = false
toggleButton.MouseButton1Click:Connect(function()
    isOpen = not isOpen
    frame.Visible = isOpen
    toggleButton.Text = isOpen and "Close Menu" or "Open Menu"
end)

-- List of scripts with 2 additional options
local scripts = {
      {name = "cbringAC", code = "loadstring(game:HttpGet('https://raw.githubusercontent.com/59collie/locker/main/Reach.lua'))()" },
    {name = "cbring", code = "loadstring(game:HttpGet('https://raw.githubusercontent.com/59collie/locker/main/ReachNOAC.lua'))()" },
    {name = "Ludicrous Laughter", code = "loadstring(game:HttpGet('https://raw.githubusercontent.com/59collie/locker/main/LLV1'))()" },
    {name = "ESP", code = "loadstring(game:HttpGet('https://raw.githubusercontent.com/59collie/locker/main/sfesp.lua'))()" }, -- New script 1
    {name = "Autoclicker", code = "loadstring(game:HttpGet('https://raw.githubusercontent.com/59collie/locker/main/ac.lua'))()" } -- New script 2
}

-- Create buttons for each script
local layout = Instance.new("UIListLayout")
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Padding = UDim.new(0, 5)
layout.Parent = frame

-- Update the frame size based on the number of scripts
frame.Size = UDim2.new(0, 300, 0, 50 * #scripts + 10) -- Dynamically adjust frame size

for _, script in ipairs(scripts) do
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0.9, 0, 0, 50) -- Button size adjusted to fit inside the frame
    button.BackgroundColor3 = Color3.fromRGB(100, 255, 100)
    button.Text = script.name
    button.Parent = frame

    button.MouseButton1Click:Connect(function()
        local success, err = pcall(function()
            loadstring(script.code)()
        end)
        if not success then
            warn("Error executing " .. script.name .. ": " .. err)
        end
    end)
end
