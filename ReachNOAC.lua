_G.Reach = 0
_G.KeyBindHigher = "z"
_G.KeyBindLower = "x"
_G.ReachOff = false -- 
 
game:GetService"RunService".Stepped:Connect(function()
    if _G.ReachOff then return end
    pcall(function()
      Sword = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Handle
        for i,v in pairs(game.Players:GetPlayers()) do 
            if v ~= game.Players.LocalPlayer and v.Character:FindFirstChild("Left Arm") then
             if (game.Players.LocalPlayer.Character.Torso.Position - v.Character.Torso.Position).Magnitude <= _G.Reach then
                   v.Character['Left Arm']:BreakJoints()
                   v.Character['Left Arm'].Transparency = 1
                   v.Character['Left Arm'].CanCollide = false
                   v.Character['Left Arm'].CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(1,0,-3.5)
                   v.Character['Left Leg']:BreakJoints()
                   v.Character['Left Leg'].Transparency = 1
                   v.Character['Left Leg'].CanCollide = false
                   v.Character['Left Leg'].CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(1,0,-3.5)
               end
           end
       end
    end)
end)
 
local Mouse = game.Players.LocalPlayer:GetMouse()
    Mouse.KeyDown:Connect(function(key)
        if key == _G.KeyBindHigher then
                 _G.Reach = _G.Reach + 1 
                 game.StarterGui:SetCore("SendNotification", {
                 Title = "Reach";
                 Text = "Reach set to " .. _G.Reach;
                 Icon = "";
                 Duration = 1;})
             end
          end)
 
 
     local Mouse = game.Players.LocalPlayer:GetMouse()
    Mouse.KeyDown:Connect(function(key)
        if key == _G.KeyBindLower then
                 _G.Reach = _G.Reach - 1 
                 game.StarterGui:SetCore("SendNotification", {
                 Title = "Reach";
                 Text = "Reach set to " .. _G.Reach;
                 Icon = "";
                 Duration = 1;})
             end
          end)
 
 
game.Players.Name = "1 Line Bypass"
 
wait(0.5)
 
game:GetService("ReplicatedStorage").ClientAlert:Destroy()
game:GetService("ReplicatedStorage").ServerAlert:Destroy()
game:GetService("ReplicatedStorage").CheckAdmin:Destroy()
game:GetService("ReplicatedStorage").WarnRemote:Destroy()
