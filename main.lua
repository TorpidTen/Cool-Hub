-- [[ INITIALIZE LINORIA LIBRARY ]] --
local Repo = 'https://githubusercontent.com'
local Library = loadstring(game:HttpGet(Repo .. 'Library.lua'))()

-- [[ SYSTEM SERVICES ]] --
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local VirtualUser = game:GetService("VirtualUser")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CommF = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("CommF_")

-- [[ FULL COMPREHENSIVE QUEST DATA MATRIX ]] --
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

-- [[ UI ENGINE WINDOW SETUP ]] --
local Window = Library:CreateWindow({ 
    Title = '✦ COOL HUB | THE DEFINITIVE EDITION ✦', 
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
MiscGroupBox:AddToggle('WalkOnWater', { Text = 'WALK ON WATER PROTOCOL', Default = true }) -- True on Spawn

-- 6. TAB: SETTINGS & SLIDERS
local SettingsGroupBox = Tabs.Settings:AddLeftGroupbox('🎛 QUANTUM SYSTEM MECHANICS')
SettingsGroupBox:AddSlider('TweenSpeed', { Text = 'VELOCITY PROPULSION VECTOR', Default = 250, Min = 50, Max = 400, Round = 0 })

-- Add Close Button to Settings to completely shut down the tool safely
SettingsGroupBox:AddButton('KILL EXECUTION ENGINE (CLOSE HUB)', function()
    _G.KillHub = true
    -- Reset Toggles
    for _, toggle in pairs(Toggles) do if toggle.SetValue then toggle:SetValue(false) end end
    -- Delete UI Elements
    if CoreGui:FindFirstChild("CoolHubMinimizeSystem") then CoreGui.CoolHubMinimizeSystem:Destroy() end
    Library:Unload()
end)

-- [[ FLOATING COMPACT WINDOW HUB PROFILE ]] --
local MinimizeGui = Instance.new("ScreenGui")
local ToggleButton = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")
local UIStroke = Instance.new("UIStroke")

MinimizeGui.Name = "CoolHubMinimizeSystem"
MinimizeGui.Parent = CoreGui
MinimizeGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

ToggleButton.Name = "CoolHubBadge"
ToggleButton.Parent = MinimizeGui
ToggleButton.Position = UDim2.new(0.05, 0, 0.1, 0) 
ToggleButton.Size = UDim2.new(0, 140, 0, 45)
ToggleButton.BackgroundColor3 = Color3.fromRGB(14, 14, 20)
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.Text = "⚡ Cool Hub [Open]"
ToggleButton.TextColor3 = Color3.fromRGB(0, 255, 204)
ToggleButton.TextSize = 14
ToggleButton.Visible = false 

UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = ToggleButton

UIStroke.Color = Color3.fromRGB(0, 255, 204)
UIStroke.Thickness = 2
UIStroke.Parent = ToggleButton

-- Minimize/Maximize Logic Interactions
local function setHubState(isOpen)
    Library:SetOpen(isOpen)
    ToggleButton.Visible = not isOpen
end

ToggleButton.MouseButton1Click:Connect(function() setHubState(true) end)
Window:OnClosed(function() setHubState(false) end)

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

-- Walk On Water Physics Overwrite Engine
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

-- Main Dynamic Farm Sequence Loop (Fixed cut-off here)
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

-- Fruit Collections/Roll Management Loop
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
        if Toggles.AutoRoll and Toggles.AutoRoll.Value then CommF:InvokeServer("Cousin", "Buy") end
        if Toggles.AutoStore and Toggles.AutoStore.Value then
            for _, tool in pairs(player.Backpack:GetChildren()) do
                if tool:IsA("Tool") and string.find(tool.Name, "Fruit") then
                    CommF:InvokeServer("StoreFruit", tool.Name, tool)
                end
            end
        end
    end
end)

Library:Notify({ Text = "⚡ COOL HUB RUNNING PROTOCOLS.", Duration = 4 })
