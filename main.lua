-- [[ INITIALIZE LINORIA LIBRARY ]] --
local Repo = 'https://githubusercontent.com'
local Library = loadstring(game:HttpGet(Repo .. 'Library.lua'))()

-- [[ SYSTEM SERVICES ]] --
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local VirtualUser = game:GetService("VirtualUser")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CommF = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("CommF_")

-- [[ FULL COMPREHENSIVE QUEST DATA MATRIX ]] --
local QuestDatabase = {
    {MinLevel = 0,    QuestName = "BanditQuest1", QuestID = 1, NPC = "Bandit"},
    {MinLevel = 10,   QuestName = "JungleQuest",   QuestID = 1, NPC = "Monkey"},
    {MinLevel = 15,   QuestName = "JungleQuest",   QuestID = 2, NPC = "Gorilla"},
    {MinLevel = 30,   QuestName = "PirateQuest",   QuestID = 1, NPC = "Pirate"},
    {MinLevel = 625,  GoldenQuest = "FountainQuest", QuestID = 1, NPC = "Galley Pirate"},
    {MinLevel = 700,  QuestName = "Area1Quest",    QuestID = 1, NPC = "Raider"},
    {MinLevel = 1425, QuestName = "ForgottenQuest",QuestID = 1, NPC = "Sea Soldier"},
    {MinLevel = 1500, QuestName = "PortQuest",     QuestID = 1, NPC = "Pirate Millionaire"},
    {MinLevel = 2500, QuestName = "TikiQuest1",    QuestID = 1, NPC = "Island Outlaw"}
}

-- [[ UI ENGINE WINDOW SETUP ]] --
local Window = Library:CreateWindow({ 
    Title = '✦ COOL HUB | MOBILE EDITION ✦', 
    Center = true, 
    AutoShow = true,
    TabPadding = 10
})

-- Cyberpunk Matrix Palette Overrides
Library.BackgroundColor = Color3.fromRGB(8, 8, 12)       
Library.MainColor = Color3.fromRGB(14, 14, 20)             
Library.AccentColor = Color3.fromRGB(0, 255, 204)          
Library.AccentColorDark = Color3.fromRGB(168, 50, 247)     
Library.OutlineColor = Color3.fromRGB(24, 24, 36)          
Library.FontColor = Color3.fromRGB(245, 245, 250)         

-- [[ INITIALIZE ALL TABS ]] --
local Tabs = { 
    Main = Window:AddTab('⚡ NEXUS ENGINE'), 
    Combat = Window:AddTab('⚔ WEAPONS'),
    Fruits = Window:AddTab('🍇 FRUIT MANAGER'),
    Raids = Window:AddTab('🌋 RAID SYSTEM'),
    Misc = Window:AddTab('🔮 MISC & WORLD'),
    Settings = Window:AddTab('⚙ SETTINGS')
}

-- 1. TAB: NEXUS ENGINE (LEVEL FARMING)
local FarmGroupBox = Tabs.Main:AddLeftGroupbox('⚡ AUTOMATION LOOPS')
FarmGroupBox:AddToggle('AutoFarm', { Text = 'ACTIVATE TWEEN FARM ENGINE', Default = false })
FarmGroupBox:AddDropdown('WeaponSelect', { Values = { 'Melee', 'Sword', 'Blox Fruit' }, Default = 1, Text = 'PRIMARY COMBAT STRATEGY' })

-- 2. TAB: WEAPONS (SHOPPING SYSTEM)
local CombatGroupBox = Tabs.Combat:AddLeftGroupbox('⚔ WEAPON FORGE VENDORS')
CombatGroupBox:AddDropdown('SelectedStyle', { Values = {'Dark Step', 'Electric', 'Water Kung Fu', 'Superhuman', 'Godhuman'}, Default = 1, Text = 'FIGHTING STYLE TARGET' })
CombatGroupBox:AddToggle('AutoGetStyle', { Text = 'AUTO UNLOCK SELECTED STYLE', Default = false })

-- 3. TAB: FRUIT MANAGER
local FruitGroupBox = Tabs.Fruits:AddLeftGroupbox('🔮 FRUIT REPLICATION ARCHIVE')
FruitGroupBox:AddToggle('AutoRoll', { Text = 'AUTOMATED GACHA ROLL', Default = false })
FruitGroupBox:AddToggle('AutoStore', { Text = 'INSTANT INVENTORY STORAGE', Default = false })
FruitGroupBox:AddToggle('TweenToFruits', { Text = 'TWEEN TO SPAWNED WORLD FRUITS', Default = false })

-- 4. TAB: RAID SYSTEM
local RaidGroupBox = Tabs.Raids:AddLeftGroupbox('🌋 RAID MOTORS')
RaidGroupBox:AddToggle('AutoRaid', { Text = 'AUTO RUN ACTIVE RAID ROOM', Default = false })

-- 5. TAB: MISC & WORLD (WALK ON WATER)
local MiscGroupBox = Tabs.Misc:AddLeftGroupbox('🌊 ENVIRONMENT MODIFIERS')
MiscGroupBox:AddToggle('WalkOnWater', { Text = 'WALK ON WATER PROTOCOL', Default = true }) 

-- 6. TAB: SETTINGS & SLIDERS
local SettingsGroupBox = Tabs.Settings:AddLeftGroupbox('🎛 QUANTUM SYSTEM MECHANICS')
SettingsGroupBox:AddSlider('TweenSpeed', { Text = 'VELOCITY PROPULSION VECTOR', Default = 250, Min = 50, Max = 400, Round = 0 })

-- Kill Engine Function
SettingsGroupBox:AddButton('KILL EXECUTION ENGINE (CLOSE HUB)', function()
    _G.KillHub = true
    for _, toggle in pairs(Toggles) do if toggle.SetValue then toggle:SetValue(false) end end
    if CoreGui:FindFirstChild("CoolHubMobileSystem") then CoreGui.CoolHubMobileSystem:Destroy() end
    Library:Unload()
end)

-- [[ MOBILE FLOATING DRAGGABLE ICON SYSTEM ]] --
local MobileGui = Instance.new("ScreenGui")
local IconButton = Instance.new("ImageButton")
local UICorner = Instance.new("UICorner")
local UIStroke = Instance.new("UIStroke")

MobileGui.Name = "CoolHubMobileSystem"
MobileGui.Parent = CoreGui
MobileGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

IconButton.Name = "MobileIcon"
IconButton.Parent = MobileGui
IconButton.Position = UDim2.new(0.1, 0, 0.2, 0) 
IconButton.Size = UDim2.new(0, 50, 0, 50) 
IconButton.BackgroundColor3 = Color3.fromRGB(14, 14, 20)
IconButton.Image = "rbxassetid://6031243531" 
IconButton.ImageColor3 = Color3.fromRGB(0, 255, 204)
IconButton.Visible = true 

UICorner.CornerRadius = UDim.new(1, 0) 
UICorner.Parent = IconButton

UIStroke.Color = Color3.fromRGB(0, 255, 204)
UIStroke.Thickness = 2
UIStroke.Parent = IconButton

-- Smooth Mobile Dragging Script Logic
local dragging, dragInput, dragStart, startPos
local function update(input)
    local delta = input.Position - dragStart
    IconButton.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

IconButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = IconButton.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then dragging = false end
        end)
    end
end)

IconButton.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then update(input) end
end)

-- Tap Icon To Open/Close Menu Toggle
IconButton.MouseButton1Click:Connect(function()
    Library:SetOpen(not Library.Open)
end)

-- [[ BACK-END UTILITY MOTOR CODES ]] --
local currentTween = nil
local function toTarget(targetCFrame)
    if _G.KillHub then return end
    local character = player.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then return end
    
    local rootPart = character.HumanoidRootPart
    local distance = (rootPart.Position - targetCFrame.Position).Magnitude
    local speed = Options.TweenSpeed.Value
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

-- Walk on Water Motor
task.spawn(function()
    while true do
        task.wait(0.2)
        if _G.KillHub then break end
        pcall(function()
            if Toggles.WalkOnWater and Toggles.WalkOnWater.Value then
                local sea = workspace:FindFirstChild("Sea") or workspace:FindFirstChild("Water")
                if sea then
                    sea.CanCollide = true
                    sea.TouchSize = Vector3.new(2048, 2, 2048)
                end
            end
        end)
    end
end)

-- Main Farm Engine (Fixed and closed completely here)
task.spawn(function()
    while true do
        task.wait()
        if _G.KillHub then break end
        if Toggles.AutoFarm and Toggles.AutoFarm.Value then
            pcall(function()
                local target = nil
                local myLevel = player.Data.Level.Value
                for _, data in ipairs(QuestDatabase) do
                    if myLevel >= data.MinLevel then target = data end
                end
                if not target then return end
                
                if player.PlayerGui.Main.Quest.Visible == false then
                    CommF:InvokeServer("StartQuest", target.QuestName, target.QuestID)
                end
                
                for _, npc in pairs(workspace.Enemies:GetChildren()) do
                    if npc.Name == target.NPC and npc:FindFirstChild("Humanoid") and npc.Humanoid.Health > 0 then
                        while Toggles.AutoFarm.Value and npc.Humanoid.Health > 0 and not _G.KillHub do
                            for _, tool in pairs(player.Backpack:GetChildren()) do
                                if tool:IsA("Tool") and tool.ToolTip == Options.WeaponSelect.Value then
                                    player.Character.Humanoid:EquipTool(tool)
                                    break
                                end
                            end
                            toTarget(npc.HumanoidRootPart.CFrame * CFrame.new(0, 5, 0))
                            VirtualUser:CaptureController()
                            VirtualUser:ClickButton1(Vector2.new(0,0))
                            task.wait()
                        end
                    end
                end
            end)
        end
    end
end)

-- Fruit Systems Loop
task.spawn(function()
    while true do
        task.wait(2)
        if _G.KillHub then break end
        if Toggles.TweenToFruits and Toggles.TweenToFruits.Value then
            for _, item in pairs(workspace:GetChildren()) do
                if item:IsA("Tool") and string.find(item.Name, "Fruit") then
                    toTarget(item.Handle.CFrame)
                end
            end
        end
        if Toggles.AutoRoll and Toggles.AutoRoll.Value then 
            CommF:InvokeServer("Cousin", "Buy") 
        end
        if Toggles.AutoStore and Toggles.AutoStore.Value then
            for _, tool in pairs(player.Backpack:GetChildren()) do
                if tool:IsA("Tool") and string.find(tool.Name, "Fruit") then
                    CommF:InvokeServer("StoreFruit", tool.Name, tool)
                end
            end
        end
    end
end)

Library:Notify({ Text = "⚡ COOL HUB MOBILE INJECTED.", Duration = 4 })
