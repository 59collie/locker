local screenGui = Instance.new("ScreenGui")
screenGui.ResetOnSpawn = false 

local frame = Instance.new("Frame")
local toggleButton = Instance.new("TextButton")
local frameCorner = Instance.new("UICorner")

local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
screenGui.Parent = playerGui

-- Frame properties
local frameWidth = 600
local frameHeight = 550 
frame.Size = UDim2.new(0, frameWidth, 0, frameHeight)
frame.Position = UDim2.new(0.5, -frameWidth / 2, 0.5, -frameHeight / 2) 
frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
frame.BorderSizePixel = 0 -- Removes outlines
frame.Visible = false
frame.Parent = screenGui

frameCorner.CornerRadius = UDim.new(0, 10)
frameCorner.Parent = frame

toggleButton.Size = UDim2.new(0, 100, 0, 50)
toggleButton.Position = UDim2.new(0, 10, 1, -360)
toggleButton.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
toggleButton.Text = "Open Menu"
toggleButton.Parent = screenGui

local isOpen = false
toggleButton.MouseButton1Click:Connect(function()
    isOpen = not isOpen
    frame.Visible = isOpen
    toggleButton.Text = isOpen and "Close Menu" or "Open Menu"
end)

-- Sidebar frame (for page selection)
local sidebar = Instance.new("Frame")
sidebar.Size = UDim2.new(0, 150, 1, 0)
sidebar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
sidebar.BorderSizePixel = 0 -- Removes outlines
sidebar.Parent = frame

local sidebarLayout = Instance.new("UIListLayout")
sidebarLayout.SortOrder = Enum.SortOrder.LayoutOrder
sidebarLayout.Padding = UDim.new(0, 10)
sidebarLayout.Parent = sidebar

-- Page content container
local contentFrame = Instance.new("Frame")
contentFrame.Size = UDim2.new(0, frameWidth - 160, 1, -20)
contentFrame.Position = UDim2.new(0, 150, 0, 10)
contentFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
contentFrame.BorderSizePixel = 0 -- Removes outlines
contentFrame.Parent = frame

-- Function to create pages
local pages = {}
local function createPage(name)
    local page = Instance.new("ScrollingFrame")
    page.Size = UDim2.new(1, -20, 1, -20)
    page.Position = UDim2.new(0, 10, 0, 10)
    page.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    page.BorderSizePixel = 0 -- Removes outlines
    page.ScrollBarThickness = 8
    page.CanvasSize = UDim2.new(0, 0, 0, 0)
    page.Visible = false
    page.Parent = contentFrame

    local layout = Instance.new("UIListLayout")
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 10)
    layout.Parent = page

    pages[name] = page
end

-- Create pages
createPage("Scripts")
createPage("Settings")
createPage("Info")

-- Function to switch pages
local function showPage(pageName)
    for name, page in pairs(pages) do
        page.Visible = (name == pageName)
    end
end
showPage("Scripts") -- Default to Scripts page

-- Create sidebar buttons
local pageList = { "Scripts", "Settings", "Info" }
for _, pageName in ipairs(pageList) do
    local pageButton = Instance.new("TextButton")
    local buttonCorner = Instance.new("UICorner")

    pageButton.Size = UDim2.new(1, -20, 0, 50)
    pageButton.Position = UDim2.new(0.5, 0, 0, 0) -- Centering horizontally
    pageButton.AnchorPoint = Vector2.new(0.5, 0) -- Anchor to center
    pageButton.BackgroundColor3 = Color3.fromRGB(0, 0, 139) -- Dark Blue
    pageButton.TextColor3 = Color3.fromRGB(255, 255, 255) -- White text
    pageButton.Text = pageName
    pageButton.BorderSizePixel = 0 -- Removes outlines
    pageButton.Parent = sidebar

    buttonCorner.CornerRadius = UDim.new(0, 8)
    buttonCorner.Parent = pageButton

    pageButton.MouseButton1Click:Connect(function()
        showPage(pageName)
    end)
end

-- Scripts page content
local scripts = {
    {name = "cbringAC", code = "loadstring(game:HttpGet('https://raw.githubusercontent.com/59collie/locker/main/Reach.lua'))()" },
    {name = "cbring", code = "loadstring(game:HttpGet('https://raw.githubusercontent.com/59collie/locker/main/ReachNOAC.lua'))()" },
    {name = "Ludicrous Amp", code = "loadstring(game:HttpGet('https://raw.githubusercontent.com/59collie/locker/main/LLV1'))()" },
    {name = "ESP", code = "loadstring(game:HttpGet('https://raw.githubusercontent.com/59collie/locker/main/sfesp.lua'))()" },
    {name = "Autoclicker", code = "loadstring(game:HttpGet('https://raw.githubusercontent.com/59collie/locker/main/ac.lua'))()" }
}

-- Add buttons to Scripts page
for _, script in ipairs(scripts) do
    local scriptButton = Instance.new("TextButton")
    local buttonCorner = Instance.new("UICorner")

    scriptButton.Size = UDim2.new(1, -20, 0, 50) 
    scriptButton.Position = UDim2.new(0.5, 0, 0, 0) -- Centering horizontally
    scriptButton.AnchorPoint = Vector2.new(0.5, 0) -- Anchor to center
    scriptButton.BackgroundColor3 = Color3.fromRGB(0, 0, 139) 
    scriptButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    scriptButton.Text = script.name
    scriptButton.BorderSizePixel = 0 -- Removes outlines
    scriptButton.Parent = pages["Scripts"]

    buttonCorner.CornerRadius = UDim.new(0, 8)
    buttonCorner.Parent = scriptButton

    scriptButton.MouseButton1Click:Connect(function()
        local success, err = pcall(function()
            loadstring(script.code)()
        end)
        if not success then
            warn("Error executing " .. script.name .. ": " .. err)
        end
    end)
end

-- Adjust ScrollingFrame's CanvasSize for scripts page
task.wait(0.1)
pages["Scripts"].CanvasSize = UDim2.new(0, 0, 0, pages["Scripts"]:FindFirstChildOfClass("UIListLayout").AbsoluteContentSize.Y)
