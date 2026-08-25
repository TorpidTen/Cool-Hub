-- [[ COOL HUB | SCROLL & AUTO-FARM SEAMLESS FIX ]] --
local P = game:GetService("Players") local LP = P.LocalPlayer local CG = game:GetService("CoreGui") local TS = game:GetService("TweenService") local VU = game:GetService("VirtualUser") local UIS = game:GetService("UserInputService") local RS = game:GetService("ReplicatedStorage") local CF = RS:WaitForChild("Remotes"):WaitForChild("CommF_")
if CG:FindFirstChild("CoolHubMobileSystem") then CG:FindFirstChild("CoolHubMobileSystem"):Destroy() end

_G.AutoFarm, _G.WeaponSelect, _G.AutoRoll, _G.AutoStore, _G.TweenToFruits, _G.WalkOnWater, _G.AutoGetStyle, _G.AutoGetSword, _G.AutoGetGun, _G.TweenSpeed, _G.KillHub = false, "Melee", false, false, false, true, false, false, false, 250, false

local ST = {"Dark Step","Electric","Water Kung Fu","Dragon Breath","Superhuman","Death Step","Sharkman Karate","Electric Claw","Dragon Talon","Godhuman","Sanguine Art"}
local SW = {"Katana","Cutlass","Dual Katana","Iron Mace","Triple Katana","Pipe","Soul Cane","Bisento","Saber","Koko"}
local GN = {"Musket","Flintlock","Refined Musket","Refined Flintlock","Cannon"}
local QD = {{L=0,Q="BanditQuest1",I=1,N="Bandit"},{L=10,Q="JungleQuest",I=1,N="Monkey"},{L=15,Q="JungleQuest",I=2,N="Gorilla"},{L=30,Q="PirateQuest",I=1,N="Pirate"},{L=625,Q="FountainQuest",I=1,N="Galley Pirate"},{L=700,Q="Area1Quest",I=1,N="Raider"},{L=1425,Q="ForgottenQuest",I=1,N="Sea Soldier"},{L=1500,Q="PortQuest",I=1,N="Pirate Millionaire"},{L=2500,Q="TikiQuest1",I=1,N="Island Outlaw"}}

local MG = Instance.new("ScreenGui", CG) MG.Name = "CoolHubMobileSystem"; MG.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
local TB = Instance.new("ImageButton", MG) TB.Name = "MobileToggleBadge"; TB.Position = UDim2.new(0.05, 0, 0.25, 0); TB.Size = UDim2.new(0, 55, 0, 55); TB.BackgroundColor3 = Color3.fromRGB(15, 15, 22); TB.Image = "rbxassetid://6031243531"; TB.ImageColor3 = Color3.fromRGB(0, 255, 204)
Instance.new("UICorner", TB).CornerRadius = UDim.new(1, 0) local BS = Instance.new("UIStroke", TB); BS.Color = Color3.fromRGB(0, 255, 204); BS.Thickness = 2.5

local MP = Instance.new("Frame", MG) MP.Name = "MainWindowFrame"; MP.Position = UDim2.new(0.3, 0, 0.15, 0); MP.Size = UDim2.new(0, 290, 0, 350); MP.BackgroundColor3 = Color3.fromRGB(12, 12, 18); MP.Active = true; MP.Selectable = true; MP.Visible = true
Instance.new("UICorner", MP).CornerRadius = UDim.new(0, 10) local PS = Instance.new("UIStroke", MP); PS.Color = Color3.fromRGB(28, 28, 40); PS.Thickness = 1.5

local TL = Instance.new("TextLabel", MP) TL.Size = UDim2.new(1, 0, 0, 45); TL.BackgroundColor3 = Color3.fromRGB(18, 18, 26); TL.Font = Enum.Font.GothamBold; TL.Text = "✦ COOL HUB UNLIMITED ✦"; TL.TextColor3 = Color3.fromRGB(0, 255, 204); TL.TextSize = 14
Instance.new("UICorner", TL).CornerRadius = UDim.new(0, 10)

-- ADVANCED SCROLLING WINDOW (FINALLY SECURED FOR MOUSE WHEEL SCROLL)
local CT = Instance.new("ScrollingFrame", MP) CT.Position = UDim2.new(0, 10, 0, 50); CT.Size = UDim2.new(1, -20, 1, -60); CT.BackgroundTransparency = 1; CT.CanvasSize = UDim2.new(0, 0, 0, 500); CT.ScrollBarThickness = 6; CT.ScrollingDirection = Enum.ScrollingDirection.Y; CT.Active = true; CT.Selectable = true

local LL = Instance.new("UIListLayout", CT) LL.Padding = UDim.new(0, 8); LL.HorizontalAlignment = Enum.HorizontalAlignment.Center; LL.SortOrder = Enum.SortOrder.LayoutOrder

local function bT(n, g)
    local b = Instance.new("TextButton", CT) b.Size = UDim2.new(1, -10, 0, 38); b.BackgroundColor3 = Color3.fromRGB(20, 20, 30); b.Font = Enum.Font.GothamBold; b.Text = n .. ": OFF"; b.TextColor3 = Color3.fromRGB(255, 100, 100); b.TextSize = 12; b.Active = true; b.Selectable = true
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6) Instance.new("UIStroke", b).Color = Color3.fromRGB(35, 35, 50)
    b.MouseButton1Click:Connect(function() _G[g] = not _G[g]; b.Text = _G[g] and n .. ": ACTIVE" or n .. ": OFF"; b.TextColor3 = _G[g] and Color3.fromRGB(0, 255, 204) or Color3.fromRGB(255, 100, 100) end)
end

bT("Auto Level Grind", "AutoFarm"); bT("Auto Acquire All Melee", "AutoGetStyle"); bT("Auto Purchase All Swords", "AutoGetSword"); bT("Auto Purchase All Guns", "AutoGetGun"); bT("Auto Fruit Sniper", "TweenToFruits"); bT("Auto Gacha Roller", "AutoRoll"); bT("Auto Fruit Storer", "AutoStore"); bT("Walk On Water Physics", "WalkOnWater")

local KB = Instance.new("TextButton", CT) KB.Size = UDim2.new(1, -10, 0, 38); KB.BackgroundColor3 = Color3.fromRGB(160, 45, 45); KB.Font = Enum.Font.GothamBold; KB.Text = "🔴 PANIC CLOSE HUB"; KB.TextColor3 = Color3.fromRGB(255, 255, 255); KB.TextSize = 12; KB.Active = true; KB.Selectable = true
Instance.new("UICorner", KB).CornerRadius = UDim.new(0, 6) KB.MouseButton1Click:Connect(function() _G.KillHub = true; _G.AutoFarm, _G.TweenToFruits, _G.WalkOnWater, _G.AutoGetStyle, _G.AutoGetSword, _G.AutoGetGun = false, false, false, false, false, false; MG:Destroy() end)

local dg, di, ds, sp; TB.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then dg = true; ds = i.Position; sp = TB.Position; i.Changed:Connect(function() if i.UserInputState == Enum.UserInputState.End then dg = false end end) end end) TB.InputChanged:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch then di = i end end) UIS.InputChanged:Connect(function(i) if i == di and dg then local d = i.Position-ds; TB.Position = UDim2.new(sp.X.Scale, sp.X.Offset + d.X, sp.Y.Scale, sp.Y.Offset + d.Y) end end) TB.MouseButton1Click:Connect(function() MP.Visible = not MP.Visible end)

local cT = nil local function tT(tCF) if _G.KillHub then return end local c = LP.Character if not c or not c:FindFirstChild("HumanoidRootPart") then return end local rp = c.HumanoidRootPart local d = (rp.Position - tCF.Position).Magnitude local du = d / _G.TweenSpeed if cT then cT:Cancel() end cT = TS:Create(rp, TweenInfo.new(du, Enum.EasingStyle.Linear), {CFrame = tCF}) cT:Play() local bv = rp:FindFirstChild("BodyVelocity") or Instance.new("BodyVelocity", rp) bv.Velocity = Vector3.new(0, 0, 0) task.wait(du) if bv then bv:Destroy() end end

task.spawn(function() while true do task.wait(0.5) if _G.KillHub then break end if _G.WalkOnWater then pcall(function() local s = workspace:FindFirstChild("Sea") or workspace:FindFirstChild("Water") if s then s.CanCollide = true; s.TouchSize = Vector3.new(2048, 2, 2048) end end) end end end)

-- FIXED ACTIVE LEVEL FARM MOTOR ENGINE
task.spawn(function()
    while true do task.wait(0.1)
        if _G.KillHub then break end 
        if _G.AutoFarm then pcall(function()
            local target = nil 
            for _, d in ipairs(QD) do if LP.Data.Level.Value >= d.L then target = d end end 
            if not target then return end
            
            -- Checks GUI elements directly to make sure quest isn't duplicated
            local questGui = LP.PlayerGui:FindFirstChild("Main") and LP.PlayerGui.Main:FindFirstChild("Quest")
            if questGui and questGui.Visible == false then 
                CF:InvokeServer("StartQuest", target.Q, target.I) 
                task.wait(0.5)
            end 
            
            for _, n in pairs(workspace.Enemies:GetChildren()) do 
                if n.Name == target.N and n:FindFirstChild("Humanoid") and n.Humanoid.Health > 0 then 
                    while _G.AutoFarm and n.Humanoid.Health > 0 and not _G.KillHub do 
                        for _, tl in pairs(LP.Backpack:GetChildren()) do 
                            if tl:IsA("Tool") and tl.ToolTip == _G.WeaponSelect then LP.Character.Humanoid:EquipTool(tl); break end 
                        end 
                        tT(n.HumanoidRootPart.CFrame * CFrame.new(0, 5, 0)) 
                        VU:CaptureController(); VU:ClickButton1(Vector2.new(0, 0)) 
                        task.wait() 
                    end 
                end 
            end 
        end) end 
    end 
end)

task.spawn(function()
    while true do task.wait(2) if _G.KillHub then break end 
        if _G.TweenToFruits then pcall(function() for _, i in pairs(workspace:GetChildren()) do if i:IsA("Tool") and string.find(i.Name, "Fruit") then tT(i.Handle.CFrame) end end end) end 
        if _G.AutoRoll then pcall(function() CF:InvokeServer("Cousin", "Buy") end) end 
        if _G.AutoStore then pcall(function() for _, tl in pairs(LP.Backpack:GetChildren()) do if tl:IsA("Tool") and string.find(tl.Name, "Fruit") then CF:InvokeServer("StoreFruit", tl.Name, tl) end end end) end 
        if _G.AutoGetStyle then pcall(function() for _, n in ipairs(ST) do if not LP.Backpack:FindFirstChild(n) and not LP.Character:FindFirstChild(n) then CF:InvokeServer("Buy" .. n:gsub(" ", ""), n) end end end) end 
        if _G.AutoGetSword then pcall(function() for _, n in ipairs(SW) do if not LP.Backpack:FindFirstChild(n) and not LP.Character:FindFirstChild(n) then CF:InvokeServer("BuySword", n) end end end) end 
        if _G.AutoGetGun then pcall(function() for _, n in ipairs(GN) do if not LP.Backpack:FindFirstChild(n) and not LP.Character:FindFirstChild(n) then CF:InvokeServer("BuyGun", n) end end end) end 
    end 
end)
