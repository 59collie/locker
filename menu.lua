-- Create a ScreenGui and a simple UI
local screenGui = Instance.new("ScreenGui")
local frame = Instance.new("Frame")
local toggleButton = Instance.new("TextButton")

-- Parent to the PlayerGui
local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
screenGui.Parent = playerGui

-- Frame properties
frame.Size = UDim2.new(0, 300, 0, 300)
frame.Position = UDim2.new(0, 10, 1, -310) -- Bottom left corner
frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
frame.Visible = false -- Initially hidden
frame.Parent = screenGui

-- Toggle button properties
toggleButton.Size = UDim2.new(0, 100, 0, 50)
toggleButton.Position = UDim2.new(0, 10, 1, -360) -- Above the frame
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

-- List of scripts
local scripts = {
    {name = "cbringAC", code = "loadstring(game:HttpGet('https://raw.githubusercontent.com/59collie/locker/main/Reach.lua'))()" },
    {name = "cbring", code = "loadstring(game:HttpGet('https://raw.githubusercontent.com/59collie/locker/main/ReachNOAC.lua'))()" },
    {name = "Ludicrous", code = "loadstring(game:HttpGet('https://raw.githubusercontent.com/59collie/locker/main/LLV1'))()" }
}

-- Create buttons for each script
for i, script in ipairs(scripts) do
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0.9, 0, 0.2, 0)
    button.Position = UDim2.new(0.05, 0, 0.05 + (i - 1) * 0.25, 0)
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
