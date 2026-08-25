-- [[ COOL HUB | MOBILE LIGHTWEIGHT DEFINITIVE EDITION ]] --
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local VirtualUser = game:GetService("VirtualUser")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CommF = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("CommF_")

if CoreGui:FindFirstChild("CoolHubMobileSystem") then 
    CoreGui.CoolHubMobileSystem:Destroy() 
end

_G.AutoFarm, _G.WeaponSelect, _G.AutoRoll, _G.AutoStore, _G.TweenToFruits, _G.WalkOnWater, _G.TweenSpeed, _G.KillHub = false, "Melee", false, false, false, true, 250, false

local QuestDatabase = {
    {MinLevel = 0,    QuestName = "BanditQuest1", QuestID = 1, NPC = "Bandit"},
    {MinLevel = 10,   QuestName = "JungleQuest",   QuestID = 1, NPC = "Monkey"},
    {MinLevel = 15,   QuestName = "JungleQuest",   QuestID = 2, NPC = "Gorilla"},
    {MinLevel = 30,   QuestName = "PirateQuest",   QuestID = 1, NPC = "Pirate"},
    {MinLevel = 625,  QuestName = "FountainQuest", QuestID = 1, NPC = "Galley Pirate"},
    {MinLevel = 700,  QuestName = "Area1Quest",    QuestID = 1, NPC = "Raider"},
    {MinLevel = 1425, QuestName = "ForgottenQuest",QuestID = 1, NPC = "Sea Soldier"},
    {MinLevel = 1500, QuestName = "PortQuest",     QuestID = 1, NPC = "Pirate Millionaire"},
    {MinLevel = 2500, QuestName = "TikiQuest1",    QuestID = 1, NPC = "Island Outlaw"}
}

local MobileGui = Instance.new("ScreenGui")
MobileGui.Name = "CoolHubMobileSystem"; MobileGui.Parent = CoreGui; MobileGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local ToggleBadge = Instance.new("ImageButton")
ToggleBadge.Name = "MobileToggleBadge"; ToggleBadge.Parent = MobileGui; ToggleBadge.Position = UDim2.new(0.05, 0, 0.25, 0); ToggleBadge.Size = UDim2.new(0, 55, 0, 55); ToggleBadge.BackgroundColor3 = Color3.fromRGB(15, 15, 22); ToggleBadge.Image = "rbxassetid://6031243531"; ToggleBadge.ImageColor3 = Color3.fromRGB(0, 255, 204)
Instance.new("UICorner", ToggleBadge).CornerRadius = UDim.new(1, 0)
local BadgeStroke = Instance.new("UIStroke", ToggleBadge); BadgeStroke.Color = Color3.fromRGB(0, 255, 204); BadgeStroke.Thickness = 2.5

local MainPanel = Instance.new("Frame")
MainPanel.Name = "MainWindowFrame"; MainPanel.Parent = MobileGui; MainPanel.Position = UDim2.new(0.3, 0, 0.2, 0); MainPanel.Size = UDim2.new(0, 280, 0, 320); MainPanel.BackgroundColor3 = Color3.fromRGB(12, 12, 18); MainPanel.Visible = true
Instance.new("UICorner", MainPanel).CornerRadius = UDim.new(0, 10)
local PanelStroke = Instance.new("UIStroke", MainPanel); PanelStroke.Color = Color3.fromRGB(28, 28, 40); PanelStroke.Thickness = 1.5

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Parent = MainPanel; TitleLabel.Size = UDim2.new(1, 0, 0, 45); TitleLabel.BackgroundColor3 = Color3.fromRGB(18, 18, 26); TitleLabel.Font = Enum.Font.GothamBold; TitleLabel.Text = "✦ COOL HUB MOBILE ✦"; TitleLabel.TextColor3 = Color3.fromRGB(0, 255, 204); TitleLabel.TextSize = 16
Instance.new("UICorner", TitleLabel).CornerRadius = UDim.new(0, 10)

local function buildMenuButton(name, posY, color)
    local obj = Instance.new("TextButton", MainPanel)
    obj.Position = UDim2.new(0.07, 0, 0, posY); obj.Size = UDim2.new(0, 240, 0, 42); obj.BackgroundColor3 = Color3.fromRGB(20, 20, 30); obj.Font = Enum.Font.GothamBold; obj.Text = name; obj.TextColor3 = color; obj.TextSize = 13
    Instance.new("UICorner", obj).CornerRadius = UDim.new(0, 6)
    local stroke = Instance.new("UIStroke", obj); stroke.Color = Color3.fromRGB(35, 35, 50); stroke.Thickness = 1
    return obj
end

local FarmButton = buildMenuButton("Level Farm: OFF", 65, Color3.fromRGB(255, 100, 100))
local FruitButton = buildMenuButton("Fruit Hunter: OFF", 125, Color3.fromRGB(255, 100, 100))
local WaterButton = buildMenuButton("Walk On Water: ON", 185, Color3.fromRGB(0, 255, 204))
local CloseButton = buildMenuButton("🔴 PANIC CLOSE HUB", 250, Color3.fromRGB(255, 255, 255))
CloseButton.BackgroundColor3 = Color3.fromRGB(180, 50, 50)

local dragging, dragInput, dragStart, startPos
ToggleBadge.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true; dragStart = input.Position; startPos = ToggleBadge.Position
        input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragging = false end end)
    end
end)
ToggleBadge.InputChanged:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then dragInput = input end end)
UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        ToggleBadge.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

ToggleBadge.MouseButton1Click:Connect(function() MainPanel.Visible = not MainPanel.Visible end)

FarmButton.MouseButton1Click:Connect(function()
    _G.AutoFarm = not _G.AutoFarm
    FarmButton.Text = _G.AutoFarm and "Level Farm: ACTIVE" or "Level Farm: OFF"
    FarmButton.TextColor3 = _G.AutoFarm and Color3.fromRGB(0, 255, 204) or Color3.fromRGB(255, 100, 100)
end)

FruitButton.MouseButton1Click:Connect(function()
    _G.TweenToFruits = not _G.TweenToFruits; _G.AutoRoll = _G.TweenToFruits; _G.AutoStore = _G.TweenToFruits
    FruitButton.Text = _G.TweenToFruits and "Fruit Hunter: ACTIVE" or "Fruit Hunter: OFF"
    FruitButton.TextColor3 = _G.TweenToFruits and Color3.fromRGB(0, 255, 204) or Color3.fromRGB(255, 100, 100)
end)

WaterButton.MouseButton1Click:Connect(function()
    _G.WalkOnWater = not _G.WalkOnWater
    WaterButton.Text = _G.WalkOnWater and "Walk On Water: ON" or "Walk On Water: OFF"
    WaterButton.TextColor3 = _G.WalkOnWater and Color3.fromRGB(0, 255, 204) or Color3.fromRGB(255, 100, 100)
end)

CloseButton.MouseButton1Click:Connect(function()
    _G.KillHub = true; _G.AutoFarm = false; _G.TweenToFruits = false; _G.WalkOnWater = false; MobileGui:Destroy()
end)

local currentTween = nil
local function toTarget(targetCFrame)
    if _G.KillHub then return end
    local character = player.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then return end
    local rootPart = character.HumanoidRootPart
    local distance = (rootPart.Position - targetCFrame.Position).Magnitude
    local duration = distance / _G.TweenSpeed
    if currentTween then currentTween:Cancel() end
    currentTween = TweenService:Create(rootPart, TweenInfo.new(duration, Enum.EasingStyle.Linear), {CFrame = targetCFrame})
    currentTween:Play()
    local bv = rootPart:FindFirstChild("BodyVelocity") or Instance.new("BodyVelocity", rootPart)
    bv.Velocity = Vector3.new(0,0,0)
    task.wait(duration)
    if bv then bv:Destroy() end
end

task.spawn(function()
    while true do
        task.wait(0.5)
        if _G.KillHub then break end
        if _G.WalkOnWater then
            pcall(function()
                local sea = workspace:FindFirstChild("Sea") or workspace:FindFirstChild("Water")
                if sea then sea.CanCollide = true; sea.TouchSize = Vector3.new(2048, 2, 2048) end
            end)
        end
    end
end)

task.spawn(function()
    while true do
        task.wait()
        if _G.KillHub then break end
        if _G.AutoFarm then
            pcall(function()
                local target = nil
                local myLevel = player.Data.Level.Value
                for _, data in ipairs(QuestDatabase) do if myLevel >= data.MinLevel then target = data end end
                if not target and player.PlayerGui.Main.Quest.Visible == false then return end
                CommF:InvokeServer("StartQuest", target.QuestName, target.QuestID)
                for _, npc in pairs(workspace.Enemies:GetChildren()) do
                    if npc.Name == target.NPC and npc:FindFirstChild("Humanoid") and npc.Humanoid.Health > 0 then
                        while _G.AutoFarm and npc.Humanoid.Health > 0 and not _G.KillHub do
                            for _, tool in pairs(player.Backpack:GetChildren()) do
                                if tool:IsA("Tool") and tool.ToolTip == _G.WeaponSelect then player.Character.Humanoid:EquipTool(tool); break end
                            end
                            toTarget(npc.HumanoidRootPart.CFrame * CFrame.new(0, 5, 0))
                            VirtualUser:CaptureController(); VirtualUser:ClickButton1(Vector2.new(0,0))
                            task.wait()
                        end
                    end
                end
            end)
        end
    end
end)

task.spawn(function()
    while true do
        task.wait(2)
        if _G.KillHub then break end
        if _G.TweenToFruits then
            pcall(function()
                for _, item in pairs(workspace:GetChildren()) do
                    if item:IsA("Tool") and string.find(item.Name, "Fruit") then toTarget(item.Handle.CFrame) end
                end
            end)
        end
        if _G.AutoRoll then pcall(function() CommF:InvokeServer("Cousin", "Buy") end) end
        if _G.AutoStore then
            pcall(function()
                for _, tool in pairs(player.Backpack:GetChildren()) do
                    if tool:IsA("Tool") and string.find(tool.Name, "Fruit") then CommF:InvokeServer("StoreFruit", tool.Name, tool) end
                end
            end)
        end
    end
end)
