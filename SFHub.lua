local screenGui = Instance.new("ScreenGui")
screenGui.ResetOnSpawn = false

local frame = Instance.new("Frame")
local frameCorner = Instance.new("UICorner")
local toggleButton = Instance.new("TextButton")

local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
screenGui.Parent = playerGui

-- Frame properties
local frameWidth = 500
local frameHeight = 200
frame.Size = UDim2.new(0, frameWidth, 0, frameHeight)
frame.Position = UDim2.new(0.5, -frameWidth / 2, 0.5, -frameHeight / 2)
frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
frame.BorderSizePixel = 0
frame.Visible = false
frame.Parent = screenGui

frameCorner.CornerRadius = UDim.new(0.1, 0)
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
local sidebarWidth = 60
local sidebar = Instance.new("Frame")
sidebar.Size = UDim2.new(0, sidebarWidth, 1, 0)
sidebar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
sidebar.BorderSizePixel = 0
sidebar.Parent = frame

local sidebarLayout = Instance.new("UIGridLayout")
sidebarLayout.CellSize = UDim2.new(0, 50, 0, 50)  -- Size for circular buttons
sidebarLayout.CellPadding = UDim2.new(0, 5, 0, 5)
sidebarLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
sidebarLayout.VerticalAlignment = Enum.VerticalAlignment.Center
sidebarLayout.Parent = sidebar

-- Page content container
local contentFramePadding = 20
local contentFrame = Instance.new("Frame")
contentFrame.Size = UDim2.new(0, frameWidth - sidebarWidth - contentFramePadding, 1, -contentFramePadding)
contentFrame.Position = UDim2.new(0, sidebarWidth, 0, 10)
contentFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
contentFrame.BorderSizePixel = 0
contentFrame.Parent = frame

-- Function to create pages
local pages = {}
local function createPage(name)
    local page = Instance.new("ScrollingFrame")
    page.Size = UDim2.new(1, -10, 1, -10)
    page.Position = UDim2.new(0, 5, 0, 5)
    page.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    page.BorderSizePixel = 0
    page.ScrollBarThickness = 8
    page.CanvasSize = UDim2.new(0, 0, 0, 0)
    page.Visible = false
    page.Parent = contentFrame

    local layout = Instance.new("UIListLayout")
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 10)
    layout.Parent = page

    layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        page.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 10)
    end)

    pages[name] = page
end

-- Create pages
createPage("Scripts")
-- Removed the call to createPage("Settings")
createPage("Info")

-- Function to switch pages
local function showPage(pageName)
    for name, page in pairs(pages) do
        page.Visible = (name == pageName)
    end
end
showPage("Scripts") -- Default to Scripts page

-- Create sidebar image buttons
local pageList = {
    {name = "Scripts", image = "rbxassetid://6023426923"},  -- Script icon Asset ID
    -- Removed the Settings page from the list
    {name = "Info", image = "rbxassetid://6031075938"}      -- Info icon Asset ID
}

for _, page in ipairs(pageList) do
    local imageButton = Instance.new("ImageButton")
    local buttonCorner = Instance.new("UICorner")

    imageButton.Size = UDim2.new(1, 0, 1, 0)  -- Fill the grid cell
    imageButton.Image = page.image
    imageButton.BackgroundTransparency = 1  -- Make the button background transparent
    imageButton.BorderSizePixel = 0
    imageButton.Parent = sidebar

    buttonCorner.CornerRadius = UDim.new(1, 0)  -- Fully rounded corners for circular buttons
    buttonCorner.Parent = imageButton

    imageButton.MouseButton1Click:Connect(function()
        showPage(page.name)
    end)
end

-- Scripts page content with sliders
local scripts = {
    {name = "cbringAC", code = "https://raw.githubusercontent.com/59collie/locker/main/Reach.lua"},
    {name = "cbring", code = "https://raw.githubusercontent.com/59collie/locker/main/ReachNOAC.lua"},
    {name = "Ludicrous Amp", code = "https://raw.githubusercontent.com/59collie/locker/main/LLV1.lua"},
    {name = "ESP", code = "https://raw.githubusercontent.com/59collie/locker/main/sfesp.lua"},
    {name = "Autoclicker", code = "https://raw.githubusercontent.com/59collie/locker/main/ac.lua"}
}

-- Calculate button width with padding
local buttonPadding = 10
local buttonWidth = frameWidth - sidebarWidth - contentFramePadding - buttonPadding * 2

-- Add sliders to Scripts page
for index, script in ipairs(scripts) do
    local sliderButton = Instance.new("TextButton")
    local buttonCorner = Instance.new("UICorner")
    local statusLight = Instance.new("Frame")
    local lightCorner = Instance.new("UICorner")

    sliderButton.Size = UDim2.new(0, buttonWidth, 0, 40)
    sliderButton.Position = UDim2.new(0, buttonPadding, 0, (index - 1) * 50)
    sliderButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    sliderButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    sliderButton.Text = " " .. script.name  -- Adding a space for padding
    sliderButton.TextXAlignment = Enum.TextXAlignment.Left  -- Align text to the left
    sliderButton.BorderSizePixel = 0
    sliderButton.Parent = pages["Scripts"]

    buttonCorner.CornerRadius = UDim.new(0, 8)
    buttonCorner.Parent = sliderButton

    statusLight.Size = UDim2.new(0, 30, 0, 30)
    statusLight.Position = UDim2.new(1, -35, 0.5, 0)  -- Position on the right-most side of the button
    statusLight.AnchorPoint = Vector2.new(1, 0.5)
    statusLight.BackgroundColor3 = Color3.fromRGB(255, 0, 0) -- Red by default (off)
    statusLight.BorderSizePixel = 0
    statusLight.Parent = sliderButton

    lightCorner.CornerRadius = UDim.new(1, 0)
    lightCorner.Parent = statusLight

    local isEnabled = false
    sliderButton.MouseButton1Click:Connect(function()
        print("Button clicked: " .. script.name)
        
        if not isEnabled then
            local success, result = pcall(function()
                local scriptCode = game:HttpGet(script.code)
                local func = loadstring(scriptCode)
                if func then
                    func()
                else
                    error("Failed to load script code")
                end
            end)
            if success then
                isEnabled = true
                statusLight.BackgroundColor3 = Color3.fromRGB(0, 255, 0) -- Green when enabled
            else
                warn("Error executing " .. script.name .. ": " .. result)
            end
        end
    end)
end
