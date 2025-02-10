--- SKIDZONE V4
--- Private
--- 26/09/2024
--- Undetected
--- FTI

getgenv().circlesize = 5
getgenv().circle = true -- if false then resize is block
_G.CIRCLETOGGLE = "y"
_G.KeyBindHigherCircle = "z"
_G.KeyBindLowerCircle = "x"
_G.KeyBindVisuals = "l"

-----------------------------------------


------ box, press y to change 
getgenv().reach = 4.4
getgenv().wide = 3
getgenv().height = 1.3
getgenv().visuals = true 


_G.KeyBindHigherWide = "q"
_G.KeyBindLowerWide = "e"
_G.KeyBindHigherReach = "j"
_G.KeyBindLowerReach = "k"

local Mouse = game.Players.LocalPlayer:GetMouse()
    Mouse.KeyDown:Connect(function(key)
        if key == _G.KeyBindVisuals then
                 if visuals then
                 getgenv().visuals = false
                 game.StarterGui:SetCore("SendNotification", {
                 Title = "SKIDZONE V4 - Private";
                 Text = "visuals is "..tostring(getgenv().visuals);
                 Icon = "";
                 Duration = 1;})
                 else
                 getgenv().visuals = true
                 game.StarterGui:SetCore("SendNotification", {
                 Title = "SKIDZONE V4 - Private";
                 Text = "visuals is "..tostring(getgenv().visuals);
                 Icon = "";
                 Duration = 1;})
             end
             end
          end)

local Mouse = game.Players.LocalPlayer:GetMouse()
     Mouse.KeyDown:Connect(function(key) 
        if key == _G.CIRCLETOGGLE then
                 if circle then
                 getgenv().circle = false
                 game.StarterGui:SetCore("SendNotification", {
                 Title = "SKIDZONE V4 - Private";
                 Text = "selectionsphere is "..tostring(getgenv().circle);
                 Icon = "";
                 Duration = 1;})
                 else
                 getgenv().circle = true
                 game.StarterGui:SetCore("SendNotification", {
                 Title = "SKIDZONE V4 - Private";
                 Text = "selectionsphere is "..tostring(getgenv().circle);
                 Icon = "";
                 Duration = 1;})
             end
             end
          end)



local Mouse = game.Players.LocalPlayer:GetMouse()
    Mouse.KeyDown:Connect(function(key)
        if key == _G.KeyBindHigherCircle then
                 circlesize = circlesize + 1
                 game.StarterGui:SetCore("SendNotification", {
                 Title = "SKIDZONE V4 - Private";
                 Text = "Circle Increased ".. circlesize;
                 Icon = "";
                 Duration = 1;})
             end
          end)
     
     
local Mouse = game.Players.LocalPlayer:GetMouse()
    Mouse.KeyDown:Connect(function(key)
        if key == _G.KeyBindLowerCircle then
                 circlesize = circlesize - 1
                 game.StarterGui:SetCore("SendNotification", {
                 Title = "SKIDZONE V4 - Private";
                 Text = "Circle Decreased ".. circlesize;
                 Icon = "";
                 Duration = 1;})
             end
          end)

local Mouse = game.Players.LocalPlayer:GetMouse()
    Mouse.KeyDown:Connect(function(key)
        if key == _G.KeyBindHigherWide then
                 wide = wide + .5
                 game.StarterGui:SetCore("SendNotification", {
                 Title = "SKIDZONE V4 - Private";
                 Text = "Wide Increased ".. wide;
                 Icon = "";
                 Duration = 1;})
             end
          end)
     
     
local Mouse = game.Players.LocalPlayer:GetMouse()
    Mouse.KeyDown:Connect(function(key)
        if key == _G.KeyBindLowerWide then
                 wide = wide - .5
                 game.StarterGui:SetCore("SendNotification", {
                 Title = "SKIDZONE V4 - Private";
                 Text = "Wide Decreased ".. wide;
                 Icon = "";
                 Duration = 1;})
             end
          end)

local Mouse = game.Players.LocalPlayer:GetMouse()
    Mouse.KeyDown:Connect(function(key)
        if key == _G.KeyBindHigherReach then
                 reach = reach + .1
                 game.StarterGui:SetCore("SendNotification", {
                 Title = "SKIDZONE V4 - Private";
                 Text = "Reach Increased ".. reach;
                 Icon = "";
                 Duration = 1;})
             end
          end)
     
     
local Mouse = game.Players.LocalPlayer:GetMouse()
    Mouse.KeyDown:Connect(function(key)
        if key == _G.KeyBindLowerReach then
                 reach = reach - .1
                 game.StarterGui:SetCore("SendNotification", {
                 Title = "SKIDZONE V4 - Private";
                 Text = "Reach Decreased ".. reach;
                 Icon = "";
                 Duration = 1;})
             end
          end)

local function isInsideCircle(position)
    local localPlayer = game.Players.LocalPlayer
    local localCharacter = localPlayer.Character
    if localCharacter then
        local localPosition = localCharacter:WaitForChild("HumanoidRootPart").Position
        local distance = (position - localPosition).Magnitude
        return distance <= reach
    end
    return false
end

local function getClosestPlayerInCircle()
    local localPlayer = game.Players.LocalPlayer
    local localCharacter = localPlayer.Character
    if not localCharacter then
        return nil
    end

    local localPosition = localCharacter:WaitForChild("HumanoidRootPart").Position
    local closestPlayer = nil
    local closestDistance = math.huge

    for _, player in pairs(game.Players:GetPlayers()) do
        if player ~= localPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local position = player.Character.HumanoidRootPart.Position
            local distance = (position - localPosition).Magnitude

            if isInsideCircle(position) and distance < closestDistance and player.Character:FindFirstChildOfClass("Humanoid").Health > 0 then
                closestPlayer = player
                closestDistance = distance
            end
        end
    end

    return closestPlayer
end

while true do
for _, v in pairs(game:GetService('Players').LocalPlayer.Character:GetChildren()) do
        if v:IsA("Tool") then
            for _, child in pairs(v.Handle:GetChildren()) do
                if child:IsA("SelectionBox") then
                    child:Destroy()
                end
                for _, child in pairs(v.Handle:GetChildren()) do
                if child:IsA("SelectionSphere") then
                    child:Destroy()
                end
            end
                if visuals then
                if not circle then
                local vis = Instance.new("SelectionBox", v.Handle)
                vis.Adornee = v.Handle
                vis.Color3 = Color3.fromRGB(128,0,128)
                v.Handle.Massless = true
                v.Handle.Size = Vector3.new(height, wide, reach)  
                end
                end
                if not visuals then
                if not circle then
                v.Handle.Massless = true
                v.Handle.Size = Vector3.new(height, wide, reach)
                end
                end
                if visuals then 
                if circle then 
                local circ = Instance.new("SelectionSphere", v.Handle)
                circ.Adornee = v.Handle
                circ.Color3 = Color3.fromRGB(128,0,128)
                v.Handle.Massless = true
                v.Handle.Size = Vector3.new(circlesize, circlesize, circlesize)  
                end
                end
                if circle then 
                if not visuals then
                v.Handle.Massless = true
                v.Handle.Size = Vector3.new(circlesize, circlesize, circlesize)  
                end
                end
            end
        end
        end
        wait()
end
