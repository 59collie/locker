local TweenService = game:GetService("TweenService")

local screenGui = Instance.new("ScreenGui")
screenGui.ResetOnSpawn = false

local gradientBorderFrame = Instance.new("Frame")
local gradientBorderCorner = Instance.new("UICorner")
local frame = Instance.new("Frame")
local frameCorner = Instance.new("UICorner")
local toggleButton = Instance.new("ImageButton")

local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
screenGui.Parent = playerGui

-- Button and layout properties
local buttonWidth = 400
local separatorHeight = 1
local buttonPadding = 5
local numberOfButtons = 6
local padding = 10
local sidebarSpacing = 50

-- Calculate frameHeight
local originalButtonHeight = 40
local frameHeight = (originalButtonHeight + buttonPadding) * numberOfButtons + sidebarSpacing

-- Adjust buttonHeight
local buttonHeight = (frameHeight - sidebarSpacing) / numberOfButtons - buttonPadding

local frameWidth = buttonWidth + 20

-- Gradient border frame properties
gradientBorderFrame.Size = UDim2.new(0, frameWidth + 4, 0, frameHeight + 4)
gradientBorderFrame.Position = UDim2.new(0.5, -(frameWidth + 4) / 2, 0.5, -(frameHeight + 4) / 2)
gradientBorderFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
gradientBorderFrame.BorderSizePixel = 0
gradientBorderFrame.Parent = screenGui

gradientBorderCorner.CornerRadius = UDim.new(0.1, 0)
gradientBorderCorner.Parent = gradientBorderFrame

-- Add a gradient to the border frame
local borderGradient = Instance.new("UIGradient")
borderGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0.0, Color3.fromRGB(0, 0, 255)),
    ColorSequenceKeypoint.new(1.0, Color3.fromRGB(128, 0, 128))
})
borderGradient.Rotation = 45
borderGradient.Parent = gradientBorderFrame

-- Tween to animate the gradient rotation
local tweenInfo = TweenInfo.new(
    4, -- Duration in seconds
    Enum.EasingStyle.Linear, -- Easing style
    Enum.EasingDirection.InOut, -- Easing direction
    -1, -- Repeat count (-1 for infinite)
    false, -- Don't reverse
    0 -- Delay time
)

local tween = TweenService:Create(borderGradient, tweenInfo, {Rotation = 405})
tween:Play()

-- Main frame properties
frame.Size = UDim2.new(0, frameWidth, 0, frameHeight)
frame.Position = UDim2.new(0, 2, 0, 2)
frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
frame.BorderSizePixel = 0
frame.Parent = gradientBorderFrame

frameCorner.CornerRadius = UDim.new(0.1, 0)
frameCorner.Parent = frame

-- Setup for the ImageButton
toggleButton.Size = UDim2.new(0, 50, 0, 50)
toggleButton.Position = UDim2.new(0, 10, 1, -360)
toggleButton.BackgroundTransparency = 1
toggleButton.Image = "rbxassetid://6035078897"
toggleButton.Parent = screenGui

local isOpen = false
toggleButton.MouseButton1Click:Connect(function()
    isOpen = not isOpen
    gradientBorderFrame.Visible = isOpen
    toggleButton.Image = isOpen and "rbxassetid://6035078897" or "rbxassetid://6035078897"

    -- Tween animation for the button size
    local expandTween = TweenService:Create(toggleButton, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(0, 60, 0, 60)})
    local shrinkTween = TweenService:Create(toggleButton, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Size = UDim2.new(0, 50, 0, 50)})
    
    expandTween:Play()
    expandTween.Completed:Connect(function()
        shrinkTween:Play()
    end)
end)

-- Page content container
local contentFrame = Instance.new("Frame")
contentFrame.Size = UDim2.new(1, -20, 1, -(sidebarSpacing + padding))
contentFrame.Position = UDim2.new(0, 10, 0, padding)
contentFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
contentFrame.BorderSizePixel = 0
contentFrame.Parent = frame

local layout = Instance.new("UIListLayout")
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Padding = UDim.new(0, buttonPadding)
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
layout.VerticalAlignment = Enum.VerticalAlignment.Top
layout.Parent = contentFrame

-- Function to create pages
local pages = {}
local function createPage(name)
    local page = Instance.new("Frame")
    page.Size = UDim2.new(1, -20, 1, -20)
    page.Position = UDim2.new(0, 10, 0, 10)
    page.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    page.BorderSizePixel = 0
    page.Visible = false
    page.Parent = contentFrame

    local layout = Instance.new("UIListLayout")
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, buttonPadding)
    layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    layout.VerticalAlignment = Enum.VerticalAlignment.Top
    layout.Parent = page

    pages[name] = page
end

-- Create pages
createPage("Home")
createPage("Scripts")
createPage("Settings")

-- Add a TextLabel to the Settings page for ASCII art
local settingsPage = pages["Settings"]

local asciiArtLabel = Instance.new("TextLabel")
asciiArtLabel.Size = UDim2.new(0.8, 0, 1, -20)
asciiArtLabel.Position = UDim2.new(0.1, 0, 0, 10)
asciiArtLabel.BackgroundTransparency = 1
asciiArtLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
asciiArtLabel.Font = Enum.Font.Code
asciiArtLabel.TextSize = 14
asciiArtLabel.TextXAlignment = Enum.TextXAlignment.Center
asciiArtLabel.TextYAlignment = Enum.TextYAlignment.Top
asciiArtLabel.TextWrapped = true
asciiArtLabel.Text = [[
.d88888b    dP                     dP     dP           dP       
88.    "'   88                     88     88           88       
`Y88888b. d8888P .d8888b. 88d888b. 88aaaaa88a dP    dP 88d888b. 
      `8b   88   88'  `88 88'  `88 88     88  88    88 88'  `88 
d8'   .8P   88   88.  .88 88       88     88  88.  .88 88.  .88 
 Y88888P    dP   `88888P8 dP       dP     dP  `88888P' 88Y8888' 
                                                                
                                                                                       
]]
asciiArtLabel.Parent = settingsPage

-- Add image and text labels to the Home page
local homePage = pages["Home"]

-- Image setup
local homeImage = Instance.new("ImageLabel")
homeImage.Size = UDim2.new(0, 150, 0, 150)
homeImage.Position = UDim2.new(1, -185, 0.5, -75)
homeImage.AnchorPoint = Vector2.new(1, 0.5)
homeImage.Image = "rbxassetid://6035078897"
homeImage.BackgroundTransparency = 1
homeImage.Parent = homePage

-- Main text label setup
local homeTextLabel = Instance.new("TextLabel")
homeTextLabel.Size = UDim2.new(0, 300, 0, 50)
homeTextLabel.Position = UDim2.new(0.5, -150, 0.5, 0)
homeTextLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
homeTextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
homeTextLabel.Text = "Welcome to StarHub"
homeTextLabel.Font = Enum.Font.GothamBold
homeTextLabel.TextSize = 16
homeTextLabel.BorderSizePixel = 0
homeTextLabel.Parent = homePage

-- Additional text label, moved to the right side of the content frame
local additionalTextLabel = Instance.new("TextLabel")
additionalTextLabel.Size = UDim2.new(0, 100, 0, 20)
additionalTextLabel.Position = UDim2.new(1, -110, 0, 10)
additionalTextLabel.AnchorPoint = Vector2.new(0, 0)
additionalTextLabel.BackgroundTransparency = 1
additionalTextLabel.Text = "Version 1.1"
additionalTextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
additionalTextLabel.Font = Enum.Font.SciFi
additionalTextLabel.TextSize = 12
additionalTextLabel.BorderSizePixel = 0
additionalTextLabel.Visible = false
additionalTextLabel.Parent = contentFrame

-- Apply gradient to the additional text label
local textGradient = Instance.new("UIGradient")
textGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0.0, Color3.fromRGB(0, 0, 255)),
    ColorSequenceKeypoint.new(1.0, Color3.fromRGB(128, 0, 128))
})
textGradient.Rotation = 0
textGradient.Parent = additionalTextLabel

-- Function to switch pages
local function showPage(pageName)
    for name, page in pairs(pages) do
        page.Visible = (name == pageName)
    end
    additionalTextLabel.Visible = (pageName == "Home")
end
showPage("Home")

-- Scripts page content
local scripts = {
    {name = "Reach + AC", code = "https://raw.githubusercontent.com/59collie/locker/main/Reach.lua"},
    {name = "Reach", code = "https://raw.githubusercontent.com/59collie/locker/main/ReachNOAC.lua"},
    {name = "Damage Amplification", code = "https://raw.githubusercontent.com/59collie/locker/main/LLV1.lua"},
    {name = "ESP", code = "https://raw.githubusercontent.com/59collie/locker/main/sfesp.lua"},
    {name = "Autoclicker", code = "https://raw.githubusercontent.com/59collie/locker/main/ac.lua"},
    {name = "TP/Destroy", code = "https://raw.githubusercontent.com/LxckStxp/Utility-Modules/main/ClickUtility.lua"}
}

local totalButtonHeight = (buttonHeight + buttonPadding) * #scripts - buttonPadding

for index, script in ipairs(scripts) do
    local button = Instance.new("TextButton")
    local buttonCorner = Instance.new("UICorner")
    local statusIcon = Instance.new("ImageLabel")

    button.Size = UDim2.new(0, buttonWidth, 0, buttonHeight)
    button.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Text = " " .. script.name
    button.TextXAlignment = Enum.TextXAlignment.Left
    button.Font = Enum.Font.SciFi
    button.TextSize = 16
    button.BorderSizePixel = 0
    button.Parent = pages["Scripts"]

    buttonCorner.CornerRadius = UDim.new(0, 8)
    buttonCorner.Parent = button

    -- Increase the size of the status icon
    statusIcon.Size = UDim2.new(0, 30, 0, 30) -- Adjusted size
    statusIcon.Position = UDim2.new(1, -15, 0.5, 0) -- Adjusted position
    statusIcon.AnchorPoint = Vector2.new(1, 0.5)
    statusIcon.Image = "rbxassetid://11896855899" -- Replace with your "off" image asset ID
    statusIcon.BackgroundTransparency = 1
    statusIcon.Parent = button

    local isEnabled = false
    button.MouseButton1Click:Connect(function()
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
                statusIcon.Image = "rbxassetid://11896842923" -- Replace with your "on" image asset ID
            else
                warn("Error executing " .. script.name .. ": " .. result)
            end
        end
    end)
end

-- Separator visible on all pages
local scriptSeparator = Instance.new("Frame")
scriptSeparator.Size = UDim2.new(1, -20, 0, separatorHeight)
scriptSeparator.Position = UDim2.new(0, 10, 0, totalButtonHeight + 10)
scriptSeparator.BackgroundColor3 = Color3.fromRGB(169, 169, 169)
scriptSeparator.BorderSizePixel = 0
scriptSeparator.Parent = frame

-- Add a gradient to the separator
local separatorGradient = Instance.new("UIGradient")
separatorGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0.0, Color3.fromRGB(0, 0, 255)),
    ColorSequenceKeypoint.new(1.0, Color3.fromRGB(128, 0, 128))
})
separatorGradient.Rotation = 0
separatorGradient.Parent = scriptSeparator

-- Page selector buttons positioned under the script buttons
local pageSelectorContainer = Instance.new("Frame")
pageSelectorContainer.Size = UDim2.new(1, -160, 0, 40)
pageSelectorContainer.Position = UDim2.new(0, 10, 1, -43)
pageSelectorContainer.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
pageSelectorContainer.BackgroundTransparency = 1
pageSelectorContainer.BorderSizePixel = 0
pageSelectorContainer.Parent = frame

local sidebarCorner = Instance.new("UICorner")
sidebarCorner.CornerRadius = UDim.new(0.1, 0)
sidebarCorner.Parent = pageSelectorContainer

local selectorLayout = Instance.new("UIListLayout")
selectorLayout.FillDirection = Enum.FillDirection.Horizontal
selectorLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
selectorLayout.VerticalAlignment = Enum.VerticalAlignment.Center
selectorLayout.Padding = UDim.new(0, 5)
selectorLayout.Parent = pageSelectorContainer

-- Create page selector buttons
local pageList = {
    {name = "Home", image = "rbxassetid://6035153656"},
    {name = "Scripts", image = "rbxassetid://6035202014"},
    {name = "Settings", image = "rbxassetid://6026568210"}
}

for _, page in ipairs(pageList) do
    local button = Instance.new("ImageButton")
    local buttonCorner = Instance.new("UICorner")

    button.Size = UDim2.new(0, 30, 0, 30)
    button.Image = page.image
    button.ImageColor3 = Color3.fromRGB(255, 255, 255)
    button.BackgroundTransparency = 1
    button.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    button.BorderSizePixel = 0
    button.Parent = pageSelectorContainer

    buttonCorner.CornerRadius = UDim.new(0.5, 0)
    buttonCorner.Parent = button

    button.MouseButton1Click:Connect(function()
        showPage(page.name)
        
        -- Tween animation for the button size
        local expandTween = TweenService:Create(button, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(0, 35, 0, 35)})
        local shrinkTween = TweenService:Create(button, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Size = UDim2.new(0, 30, 0, 30)})
        
        expandTween:Play()
        expandTween.Completed:Connect(function()
            shrinkTween:Play()
        end)
    end)
end

-- Create a separate container for the sidebar image and text
local sidebarContent = Instance.new("Frame")
sidebarContent.Size = UDim2.new(0, 160, 0, 40)
sidebarContent.Position = UDim2.new(1, -160, 1, -43)
sidebarContent.BackgroundTransparency = 1
sidebarContent.Parent = frame

-- Sidebar text label
local sidebarText = Instance.new("TextLabel")
sidebarText.Size = UDim2.new(0, 100, 0, 30)
sidebarText.Position = UDim2.new(0, 40, 0.5, 0)
sidebarText.AnchorPoint = Vector2.new(0, 0.5)
sidebarText.BackgroundTransparency = 1
sidebarText.Text = "StarHub"
sidebarText.TextColor3 = Color3.fromRGB(255, 255, 255)
sidebarText.Font = Enum.Font.GothamBold
sidebarText.TextSize = 16
sidebarText.BorderSizePixel = 0
sidebarText.Parent = sidebarContent

-- Apply gradient to the sidebar text label
local sidebarTextGradient = Instance.new("UIGradient")
sidebarTextGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0.0, Color3.fromRGB(0, 0, 255)),
    ColorSequenceKeypoint.new(1.0, Color3.fromRGB(128, 0, 128))
})
sidebarTextGradient.Rotation = 0
sidebarTextGradient.Parent = sidebarText

local sidebarImage = Instance.new("ImageLabel")
sidebarImage.Size = UDim2.new(0, 30, 0, 30)
sidebarImage.Position = UDim2.new(1, -7, 0.5, 0)
sidebarImage.AnchorPoint = Vector2.new(1, 0.5)
sidebarImage.Image = "rbxassetid://6035078897"
sidebarImage.BackgroundTransparency = 1
sidebarImage.Parent = sidebarContent
