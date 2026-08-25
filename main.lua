local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local rootPart = character:WaitForChild("HumanoidRootPart")

-- UI Elements (Adjust paths to match your actual hierarchy)
local gui = script.Parent
local toggleBtn = gui:WaitForChild("ToggleBttn")
local sliderBar = gui:WaitForChild("SliderBar")
local sliderHandle = sliderBar:WaitForChild("SliderHandle")

local toggled = false
local tweenSpeed = 150 -- default speed units (studs per second)
local currentTween = nil

-- Simple Slider Logic
local dragging = false
sliderHandle.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
    end
end)

game:GetService("UserInputService").InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

game:GetService("RunService").RenderStepped:Connect(function()
    if dragging then
        local mouse = player:GetMouse()
        local relX = math.clamp((mouse.X - sliderBar.AbsolutePosition.X) / sliderBar.AbsoluteSize.X, 0, 1)
        sliderHandle.Position = UDim2.new(relX, -10, sliderHandle.Position.Y.Scale, sliderHandle.Position.Y.Offset)
        -- Map relX (0 to 1) to speed range, e.g., 50 to 350 studs/sec
        tweenSpeed = 50 + (relX * 300)
    end
end)

-- Find Closest Chest Function
local function getClosestChest()
    local closest = nil
    local shortestDist = math.huge
    
    for _, obj in ipairs(Workspace:GetChildren()) do
        -- Blox Fruits chests are generally named "Chest" or contain "Chest"
        if obj:IsA("Model") and string.find(obj.Name, "Chest") then
            local part = obj.PrimaryPart or obj:FindFirstChild("HumanoidRootPart") or obj:FindFirstChildWhichIsA("BasePart")
            if part then
                local dist = (rootPart.Position - part.Position).Magnitude
                if dist < shortestDist then
                    shortestDist = dist
                    closest = part
                end
            end
        end
    end
    return closest
end

-- Toggle Button Event
toggleBtn.MouseButton1Click:Connect(function()
    toggled = not toggled
    toggleBtn.Text = toggled and "Status: ON" or "Status: OFF"
    
    if not toggled and currentTween then
        currentTween:Cancel()
    end
end)

-- Main Loop
task.spawn(function()
    while true do
        task.wait(0.1)
        if toggled then
            local chest = getClosestChest()
            if chest then
                local dist = (rootPart.Position - chest.Position).Magnitude
                local timeTaken = dist / tweenSpeed
                
                local info = TweenInfo.new(timeTaken, Enum.EasingStyle.Linear)
                currentTween = TweenService:Create(rootPart, info, {CFrame = chest.CFrame + Vector3.new(0, 3, 0)})
                currentTween:Play()
                
                local finished = false
                currentTween.Completed:Connect(function()
                    finished = true
                end)
                
                while not finished and toggled do
                    task.wait()
                end
            end
        end
    end
end)

-- local P,LP,TS,VU,UIS,RS=game:GetService("Players"),game.Players.LocalPlayer,game:GetService("TweenService"),game:GetService("VirtualUser"),game:GetService("UserInputService"),game:GetService("ReplicatedStorage")local CF=RS:WaitForChild("Remotes"):WaitForChild("CommF_")local PG=LP:WaitForChild("PlayerGui")if PG:FindFirstChild("CoolHubMobileSystem")then PG.CoolHubMobileSystem:Destroy()end
-- _G.AutoFarm,_G.WeaponSelect,_G.AutoRoll,_G.AutoStore,_G.TweenToFruits,_G.WalkOnWater,_G.AutoGetStyle,_G.AutoGetSword,_G.AutoGetGun,_G.TweenSpeed,_G.KillHub=false,"Melee",false,false,false,true,false,false,false,250,false _G.ChosenStyle,_G.ChosenSword,_G.ChosenGun="Dark Step","Katana","Musket"
-- local ST,SW,GN={"Dark Step","Electric","Water Kung Fu","Dragon Breath","Superhuman","Death Step","Sharkman Karate","Electric Claw","Dragon Talon","Godhuman"},{"Katana","Cutlass","Dual Katana","Iron Mace","Triple Katana","Pipe","Soul Cane","Bisento","Saber","Koko","Rengoku","Shisui"},{"Musket","Flintlock","Refined Musket","Refined Flintlock","Cannon","Kabucha"}
-- local QD={{L=0,Q="BanditQuest1",I=1,N="Bandit"},{L=10,Q="JungleQuest",I=1,N="Monkey"},{L=15,Q="JungleQuest",I=2,N="Gorilla"},{L=30,Q="PirateQuest",I=1,N="Pirate"},{L=625,Q="FountainQuest",I=1,N="Galley Pirate"},{L=700,Q="Area1Quest",I=1,N="Raider"},{L=1425,Q="ForgottenQuest",I=1,N="Sea Soldier"},{L=1500,Q="PortQuest",I=1,N="Pirate Millionaire"},{L=2500,Q="TikiQuest1",I=1,N="Island Outlaw"}}
-- local MG=Instance.new("ScreenGui",PG)MG.Name="CoolHubMobileSystem";MG.ZIndexBehavior=Enum.ZIndexBehavior.Sibling local TB=Instance.new("ImageButton",MG)TB.Name="MobileToggleBadge";TB.Position=UDim2.new(0.05,0,0.25,0);TB.Size=UDim2.new(0,55,0,55);TB.BackgroundColor3=Color3.fromRGB(8,8,12);TB.Image="rbxassetid://6031243531";TB.ImageColor3=Color3.fromRGB(0,255,204)Instance.new("UICorner",TB).CornerRadius=UDim.new(1,0);local BS=Instance.new("UIStroke",TB)BS.Color,BS.Thickness=Color3.fromRGB(0,255,204),2.5
-- local MP=Instance.new("Frame",MG)MP.Name="MainWindowFrame";MP.Position=UDim2.new(0.3,0,0.1,0);MP.Size=UDim2.new(0,310,0,420);MP.BackgroundColor3=Color3.fromRGB(10,10,15);MP.Active,MP.Selectable,MP.Visible=true,true,true Instance.new("UICorner",MP).CornerRadius=UDim.new(0,12);local PS=Instance.new("UIStroke",MP)PS.Color,PS.Thickness=Color3.fromRGB(255,0,128),2
-- local TL=Instance.new("TextLabel",MP)TL.Size=UDim2.new(1,0,0,45);TL.BackgroundColor3=Color3.fromRGB(18,11,26);TL.Font=Enum.Font.GothamBold;TL.Text="⚡ COOL HUB PREMIUM ⚡";TL.TextColor3=Color3.fromRGB(0,255,204);TL.TextSize=14 Instance.new("UICorner",TL).CornerRadius=UDim.new(0,12)local TS1=Instance.new("UIStroke",TL)TS1.Color,TS1.Thickness=Color3.fromRGB(0,255,204),1
-- local CT=Instance.new("ScrollingFrame",MP)CT.Position=UDim2.new(0,10,0,55);CT.Size=UDim2.new(1,-20,1,-65);CT.BackgroundTransparency=1;CT.CanvasSize=UDim2.new(0,0,0,760);CT.ScrollBarThickness=4;CT.ScrollingDirection=Enum.ScrollingDirection.Y;CT.Active=true local LL=Instance.new("UIListLayout",CT)LL.Padding=UDim.new(0,8)LL.HorizontalAlignment,LL.SortOrder=Enum.HorizontalAlignment.Center,Enum.SortOrder.LayoutOrder
-- local function bT(n,g)local b=Instance.new("TextButton",CT)b.Size=UDim2.new(1,-10,0,38);b.BackgroundColor3=Color3.fromRGB(18,18,28);b.Font=Enum.Font.GothamBold;b.Text="⚡ "..n.." [OFF]";b.TextColor3=Color3.fromRGB(255,0,128);b.TextSize=11 Instance.new("UICorner",b).CornerRadius=UDim.new(0,8);local s=Instance.new("UIStroke",b)s.Color,s.Thickness=Color3.fromRGB(50,30,60),1.5
-- b.MouseButton1Click:Connect(function()_G[g]=not _G[g]b.Text=_G[g]and"✨ "..n.." [ACTIVE]"or"⚡ "..n.." [OFF]"b.TextColor3=_G[g]and Color3.fromRGB(0,255,204)or Color3.fromRGB(255,0,128)s.Color=_G[g]and Color3.fromRGB(0,255,204)or Color3.fromRGB(50,30,60)end)end
-- local function bD(t,o,g)local f=Instance.new("Frame",CT)f.Size=UDim2.new(1,-10,0,38);f.BackgroundColor3=Color3.fromRGB(20,20,32)Instance.new("UICorner",f).CornerRadius=UDim.new(0,8)local sk=Instance.new("UIStroke",f)sk.Color,sk.Thickness=Color3.fromRGB(120,0,255),1 local m=Instance.new("TextButton",f)m.Size=UDim2.new(1,0,0,38);m.BackgroundTransparency=1;m.Font=Enum.Font.GothamBold;m.Text="🔮 "..t.." • ".._G[g];m.TextColor3=Color3.fromRGB(240,240,255);m.TextSize=11
-- local l=Instance.new("Frame",CT)l.Size=UDim2.new(1,-10,0,0);l.BackgroundColor3=Color3.fromRGB(12,12,20);l.Visible=false;l.ClipsDescendants=true;Instance.new("UICorner",l).CornerRadius=UDim.new(0,8);local ly=Instance.new("UIListLayout",l)ly.Padding=UDim.new(0,2)
-- for _,op in ipairs(o)do local ob=Instance.new("TextButton",l)ob.Size=UDim2.new(1,0,0,30);ob.BackgroundColor3=Color3.fromRGB(28,20,40);ob.Font=Enum.Font.GothamBold;ob.Text=op;ob.TextColor3=Color3.fromRGB(0,255,204);ob.TextSize=11
-- ob.MouseButton1Click:Connect(function()_G[g]=op;m.Text="🔮 "..t.." • "..op;l.Visible=false;l.Size=UDim2.new(1,-10,0,0)end)end m.MouseButton1Click:Connect(function()local oS=not l.Visible;l.Visible=oS;l.Size=oS and UDim2.new(1,-10,0,(#o*32))or UDim2.new(1,-10,0,0)end)end
-- bT("Auto Level Grind","AutoFarm");bT("Select Weapon Type: Melee","WeaponSelect")bD("Choose Melee",ST,"ChosenStyle");bT("Auto Purchase Chosen Melee","AutoGetStyle")bD("Choose Sword",SW,"ChosenSword");bT("Auto Purchase Chosen Sword","AutoGetSword")bD("Choose Gun",GN,"ChosenGun");bT("Auto Purchase Chosen Gun","AutoGetGun")bT("Auto Fruit Sniper","TweenToFruits")bT("Auto Gacha Roller","AutoRoll")bT("Auto Fruit Storer","AutoStore")bT("Walk On Water Physics","WalkOnWater")
-- local KB=Instance.new("TextButton",CT)KB.Size=UDim2.new(1,-10,0,40);KB.BackgroundColor3=Color3.fromRGB(40,10,20);KB.Font=Enum.Font.GothamBold;KB.Text="🛑 SYSTEM SHUTDOWN";KB.TextColor3=Color3.fromRGB(255,255,255);KB.TextSize=12 Instance.new("UICorner",KB).CornerRadius=UDim.new(0,8);local ks=Instance.new("UIStroke",KB)ks.Color,ks.Thickness=Color3.fromRGB(255,0,128),1.5 KB.MouseButton1Click:Connect(function()_G.KillHub=true;_G.AutoFarm,_G.TweenToFruits,_G.WalkOnWater,_G.AutoGetStyle,_G.AutoGetSword,_G.AutoGetGun=false,false,false,false,false,false;MG:Destroy()end)
-- local dg,di,ds,sp;TB.InputBegan:Connect(function(i)if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then dg=true;ds=i.Position;sp=TB.Position;i.Changed:Connect(function()if i.UserInputState==Enum.UserInputState.End then dg=false endend)endend)TB.InputChanged:Connect(function(i)if i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch then di=i endend)UIS.InputChanged:Connect(function(i)if i==di and dg then local d=i.Position-ds;TB.Position=UDim2.new(sp.X.Scale,sp.X.Offset+d.X,sp.Y.Scale,sp.Y.Offset+d.Y)endend)TB.MouseButton1Click:Connect(function()MP.Visible=not MP.Visibleend)
-- local cT=nil local function tT(tCF)if _G.KillHub then return end local c=LP.Character if not c or not c:FindFirstChild("HumanoidRootPart")then return end local rp=c.HumanoidRootPart local d=(rp.Position-tCF.Position).Magnitude local du=d/_G.TweenSpeed if cT then cT:Cancel()end cT=TS:Create(rp,TweenInfo.new(du,Enum.EasingStyle.Linear),{CFrame=tCF})cT:Play()local bv=rp:FindFirstChild("BodyVelocity")or Instance.new("BodyVelocity",rp)bv.Velocity=Vector3.new(0,0,0)task.wait(du)if bv then bv:Destroy()endend
-- task.spawn(function()while true do task.wait(0.5)if _G.KillHub then break end if _G.WalkOnWater then pcall(function()local s=workspace:FindFirstChild("Sea")or workspace:FindFirstChild("Water")if s then s.CanCollide=true;s.TouchSize=Vector3.new(2048,2,2048)endend)end end end)
-- task.spawn(function()while true do task.wait(0.1)if _G.KillHub then break end if _G.AutoFarm then pcall(function()local t=nil for _,d in ipairs(QD)do if LP.Data.Level.Value>=d.L then t=d end end if not t then return end local qG=LP.PlayerGui:FindFirstChild("Main")and LP.PlayerGui.Main:FindFirstChild("Quest")if qG and qG.Visible==false then CF:InvokeServer("StartQuest",t.Q,t.I)task.wait(0.5)end local eF=false local eFd=workspace:FindFirstChild("Enemies")if eFd then for _,n in pairs(eFd:GetChildren())do if n.Name==t.N and n:FindFirstChild("Humanoid")and n.Humanoid.Health>0 and n:FindFirstChild("HumanoidRootPart")then eF=true while _G.AutoFarm and n.Humanoid.Health>0 and n.Parent==eFd and not _G.KillHub do local tS=_G.WeaponSelect=="Melee"and"Melee"or"Sword"for _,tl in pairs(LP.Backpack:GetChildren())do if tl:IsA("Tool")and tl.ToolTip==tS then LP.Character.Humanoid:EquipTool(tl);break end end tT(n.HumanoidRootPart.CFrame*CFrame.new(0,5,0))VU:CaptureController();VU:ClickButton1(Vector2.new(0,0))task.wait()end end end end if not eF then local sF=workspace:FindFirstChild("EnemySpawns")or workspace:FindFirstChild("Spawns")if sF then for _,sp in pairs(sF:GetChildren())do if string.find(sp.Name,t.N)or sp.Name==t.N then tT(sp.CFrame*CFrame.new(0,10,0))break end end end end end)end end end)
-- task.spawn(function()while true do task.wait(2)if _G.KillHub then break end if _G.TweenToFruits then pcall(function()for _,i in pairs(workspace:GetChildren())do if i:IsA("Tool")and string.find(i.Name,"Fruit")then tT(i.Handle.CFrame)end end end)end if _G.AutoRoll then pcall(function()CF:InvokeServer("Cousin","Buy")end)end if _G.AutoStore then pcall(function()for _,tl in pairs(LP.Backpack:GetChildren())do if tl:IsA("Tool")and string.find(tl.Name,"Fruit")then CF:InvokeServer("StoreFruit",tl.Name,tl)end end end)end if _G.AutoGetStyle then pcall(function()if not LP.Backpack:FindFirstChild(_G.ChosenStyle)and not LP.Character:FindFirstChild(_G.ChosenStyle)then CF:InvokeServer("Buy".._G.ChosenStyle:gsub(" ",""),_G.ChosenStyle)end end)end if _G.AutoGetSword then pcall(function()if not LP.Backpack:FindFirstChild(_G.ChosenSword)and not LP.Character:FindFirstChild(_G.ChosenSword)then CF:InvokeServer("BuySword",_G.ChosenSword)end end)end if _G.AutoGetGun then pcall(function()if not LP.Backpack:FindFirstChild(_G.ChosenGun)and not LP.Character:FindFirstChild(_G.ChosenGun)then CF:InvokeServer("BuyGun",_G.ChosenGun)end end)end end end)
