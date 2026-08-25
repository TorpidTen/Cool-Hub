-- [[ COOL HUB BACKEND MOTOR MODULE ]] --
local Module = {}

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local VirtualUser = game:GetService("VirtualUser")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CommF = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("CommF_")

local currentTween = nil

-- Smooth Tween Engine
function Module.toTarget(targetCFrame, speedSlider)
    if _G.KillHub then return end
    local character = player.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then return end
    
    local rootPart = character.HumanoidRootPart
    local distance = (rootPart.Position - targetCFrame.Position).Magnitude
    local speed = speedSlider or 250
    local duration = distance / speed
    
    if currentTween then currentTween:Cancel() end
    
    local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Linear)
    currentTween = TweenService:Create(rootPart, tweenInfo, {CFrame = targetCFrame})
    currentTween:Play()
    
    local bodyVelocity = rootPart:FindFirstChild("BodyVelocity") or Instance.new("BodyVelocity", rootPart)
    bodyVelocity.Velocity = Vector3.new(0,0,0)
    
    task.wait(duration)
    if bodyVelocity then bodyVelocity:Destroy() end
end

-- Weapon Auto-Equipper
function Module.equipMyWeapon(weaponStyle)
    local character = player.Character
    if not character then return end
    for _, tool in pairs(player.Backpack:GetChildren()) do
        if tool:IsA("Tool") and tool.ToolTip == weaponStyle then
            character.Humanoid:EquipTool(tool)
            break
        end
    end
end

return Module
