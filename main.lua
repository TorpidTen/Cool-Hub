-- [[ INITIALIZE MOBILE-OPTIMIZED RAYFIELD UI ]] --
local Rayfield = loadstring(game:HttpGet('https://sirius.menu'))()

-- [[ SYSTEM SERVICES ]] --
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local VirtualUser = game:GetService("VirtualUser")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CommF = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("CommF_")

-- [[ FULL COMPREHENSIVE QUEST DATA ]] --
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

-- [[ CONFIGURATION VALUES ]] --
getgenv().AutoFarm = false
getgenv().WeaponSelect = "Melee"
getgenv().SelectedStyle = "Dark Step"
getgenv().AutoGetStyle = false
getgenv().AutoRoll = false
getgenv().AutoStore = false
getgenv().TweenToFruits = false
getgenv().WalkOnWater = true
getgenv().TweenSpeed = 250
getgenv().KillHub = false

-- [[ UI ENGING WINDOW SETUP ]] --
local Window = Rayfield:CreateWindow({
   Name = "✦ COOL HUB | MOBILE DEFINITIVE ✦",
   LoadingTitle = "⚡ Loading Cool Hub Protocols...",
   LoadingSubtitle = "by TorpidTen",
   ConfigurationSaving = { Enabled = false }
})

-- [[ ALL TABS CONFIGURATION ]] --
local MainTab = Window:CreateTab("⚡ NEXUS ENGINE")
local CombatTab = Window:CreateTab("⚔ WEAPONS")
local FruitTab = Window:CreateTab("🍇 FRUIT MANAGER")
local MiscTab = Window:CreateTab("🔮 MISC & WORLD")

-- [[ 1. TAB CONTENT: NEXUS ENGINE ]] --
MainTab:CreateToggle({
   Name = "ACTIVATE TWEEN FARM ENGINE",
   CurrentValue = false,
   Callback = function(Value) getgenv().AutoFarm = Value end
})

MainTab:CreateDropdown({
   Name = "PRIMARY COMBAT STRATEGY",
   Options = {"Melee","Sword","Blox Fruit"},
   CurrentOption = {"Melee"},
   MultipleOptions = false,
   Callback = function(Option) getgenv().WeaponSelect = Option[1] end
})

-- [[ 2. TAB CONTENT: WEAPONS ]] --
CombatTab:CreateDropdown({
   Name = "FIGHTING STYLE TARGET",
   Options = {"Dark Step","Electric","Water Kung Fu","Superhuman","Godhuman"},
   CurrentOption = {"Dark Step"},
   MultipleOptions = false,
   Callback = function(Option) getgenv().SelectedStyle = Option[1] end
})

CombatTab:CreateToggle({
   Name = "AUTO UNLOCK SELECTED STYLE",
   CurrentValue = false,
   Callback = function(Value) getgenv().AutoGetStyle = Value end
})

-- [[ 3. TAB CONTENT: FRUIT MANAGER ]] --
FruitTab:CreateToggle({
   Name = "AUTOMATED GACHA ROLL",
   CurrentValue = false,
   Callback = function(Value) getgenv().AutoRoll = Value end
})

FruitTab:CreateToggle({
   Name = "INSTANT INVENTORY STORAGE",
   CurrentValue = false,
   Callback = function(Value) getgenv().AutoStore = Value end
})

FruitTab:CreateToggle({
   Name = "TWEEN TO SPAWNED WORLD FRUITS",
   CurrentValue = false,
   Callback = function(Value) getgenv().TweenToFruits = Value end
})

-- [[ 4. TAB CONTENT: MISC & SETTINGS ]] --
MiscTab:CreateToggle({
   Name = "WALK ON WATER PROTOCOL",
   CurrentValue = true,
   Callback = function(Value) getgenv().WalkOnWater = Value end
})

MiscTab:CreateSlider({
   Name = "VELOCITY PROPULSION VECTOR (SPEED)",
   Min = 50,
   Max = 400,
   CurrentValue = 250,
   Increment = 10,
   Suffix = "SPS",
   Callback = function(Value) getgenv().TweenSpeed = Value end
})

MiscTab:CreateButton({
   Name = "KILL HUB (PANIC CLOSE BUTTON)",
   Callback = function()
       getgenv().KillHub = true
       getgenv().AutoFarm = false
       getgenv().WalkOnWater = false
       Rayfield:Destroy()
   end
})

-- [[ BACK-END SYSTEM UTILITY LOOPS ]] --
local currentTween = nil
local function toTarget(targetCFrame)
    if getgenv().KillHub then return end
    local character = player.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then return end
    
    local rootPart = character.HumanoidRootPart
    local distance = (rootPart.Position - targetCFrame.Position).Magnitude
    local duration = distance / getgenv().TweenSpeed
    
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
local function equipMyWeapon()
    local character = player.Character
    if not character then return end
    for _, tool in pairs(player.Backpack:GetChildren()) do
        if tool:IsA("Tool") and tool.ToolTip == getgenv().WeaponSelect then
            character.Humanoid:EquipTool(tool)
            break
        end
    end
end

-- Loop 1: Walk on Water
task.spawn(function()
    while true do
        task.wait(0.5)
        if getgenv().KillHub then break end
        if getgenv().WalkOnWater then
            pcall(function()
                local sea = workspace:FindFirstChild("Sea") or workspace:FindFirstChild("Water")
                if sea then sea.CanCollide = true; sea.TouchSize = Vector3.new(2048, 2, 2048) end
            end)
        end
    end
end)

-- Loop 2: Auto Level Grind Engine
task.spawn(function()
    while true do
        task.wait()
        if getgenv().KillHub then break end
        if getgenv().AutoFarm then
            pcall(function()
                local target = nil
                local myLevel = player.Data.Level.Value
                for _, data in ipairs(QuestDatabase) do if myLevel >= data.MinLevel then target = data end end
                if not target then return end
                
                if player.PlayerGui.Main.Quest.Visible == false then
                    CommF:InvokeServer("StartQuest", target.QuestName, target.QuestID)
                end
                
                for _, npc in pairs(workspace.Enemies:GetChildren()) do
                    if npc.Name == target.NPC and npc:FindFirstChild("Humanoid") and npc.Humanoid.Health > 0 then
                        while getgenv().AutoFarm and npc.Humanoid.Health > 0 and not getgenv().KillHub do
                            equipMyWeapon()
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

-- Loop 3: Fruit Automatons
task.spawn(function()
    while true do
        task.wait(2)
        if getgenv().KillHub then break end
        if getgenv().TweenToFruits then
            pcall(function()
                for _, item in pairs(workspace:GetChildren()) do
                    if item:IsA("Tool") and string.find(item.Name, "Fruit") then
                        toTarget(item.Handle.CFrame)
                    end
                end
            end)
        end
        if getgenv().AutoRoll then pcall(function() CommF:InvokeServer("Cousin", "Buy") end) end
        if getgenv().AutoStore then
            pcall(function()
                for _, tool in pairs(player.Backpack:GetChildren()) do
                    if tool:IsA("Tool") and string.find(tool.Name, "Fruit") then
                        CommF:InvokeServer("StoreFruit", tool.Name, tool)
                    end
                end
            end)
        end
    end
end)

Rayfield:Notify({
   Title = "Cool Hub Injected!",
   Content = "Enjoy farming on mobile!",
   Duration = 5,
   Image = 4483362458,
})
