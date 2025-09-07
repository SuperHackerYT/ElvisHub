-- Load UI Library
local summitLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/SuperHackerYT/ElvisHub/refs/heads/main/UILibarySummit.lua"))()

-- Main Window
local window = summitLib:CreateWindow({
    Name = "Elvis Hub V3",
    AccentColor3 = Color3.new(0, 0.6, 1)
})

-- Player Tab
local PlayerTab = window:CreateTab({
    Name = "Player",
    Icon = "rbxassetid://7743875962"
})

---------------------------------------------------
-- WalkSpeed
PlayerTab:CreateSlider({
    Text = "WalkSpeed",
    Default = 16,
    Minimum = 16,
    Maximum = 200,
    Callback = function(Value)
        local hum = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if hum then hum.WalkSpeed = Value end
    end
})

---------------------------------------------------
-- JumpPower
PlayerTab:CreateSlider({
    Text = "JumpPower",
    Default = 50,
    Minimum = 16,
    Maximum = 300,
    Callback = function(Value)
        local hum = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if hum then hum.JumpPower = Value end
    end
})

---------------------------------------------------
-- Gravity
PlayerTab:CreateSlider({
    Text = "Gravity",
    Default = 196.2,
    Minimum = 0,
    Maximum = 400,
    Callback = function(Value)
        workspace.Gravity = Value
    end
})

---------------------------------------------------
-- Infinite Jump
local InfiniteJump = false
PlayerTab:CreateToggle({
    Text = "Infinite Jump",
    Default = false,
    Callback = function(Value) InfiniteJump = Value end
})

game:GetService("UserInputService").JumpRequest:Connect(function()
    if InfiniteJump then
        local hum = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if hum then hum:ChangeState("Jumping") end
    end
end)

---------------------------------------------------
-- Fly (PC + Mobile)
local flyToggle = false
local flySpeed = 1
local FLYING = false
local flyKeyDown, flyKeyUp, mfly1, mfly2
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local lp = Players.LocalPlayer

-- PC Fly
local function sFLY()
    repeat task.wait() until lp and lp.Character and lp.Character:WaitForChild("HumanoidRootPart") and lp.Character:FindFirstChildOfClass("Humanoid")
    if flyKeyDown or flyKeyUp then flyKeyDown:Disconnect(); flyKeyUp:Disconnect() end

    local T = lp.Character:WaitForChild("HumanoidRootPart")
    local CONTROL = {F=0,B=0,L=0,R=0,Q=0,E=0}
    local lCONTROL = {F=0,B=0,L=0,R=0,Q=0,E=0}
    local SPEED = flySpeed

    local function FLY()
        FLYING = true
        local BG = Instance.new('BodyGyro', T)
        local BV = Instance.new('BodyVelocity', T)
        BG.P = 9e4
        BG.MaxTorque = Vector3.new(9e9,9e9,9e9)
        BG.CFrame = T.CFrame
        BV.MaxForce = Vector3.new(9e9,9e9,9e9)
        BV.Velocity = Vector3.new(0,0,0)

        task.spawn(function()
            while FLYING do
                task.wait()
                if not flyToggle and lp.Character:FindFirstChildOfClass('Humanoid') then
                    lp.Character:FindFirstChildOfClass('Humanoid').PlatformStand = true
                end
                if CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0 or CONTROL.Q + CONTROL.E ~= 0 then
                    SPEED = flySpeed
                else
                    SPEED = 0
                end
                if SPEED ~= 0 then
                    BV.Velocity = ((workspace.CurrentCamera.CFrame.LookVector * (CONTROL.F + CONTROL.B)) +
                                  ((workspace.CurrentCamera.CFrame * CFrame.new(CONTROL.L + CONTROL.R, (CONTROL.F + CONTROL.B + CONTROL.Q + CONTROL.E) * 0.2,0).p) -
                                  workspace.CurrentCamera.CFrame.p)) * SPEED
                    lCONTROL = {F=CONTROL.F,B=CONTROL.B,L=CONTROL.L,R=CONTROL.R}
                else
                    BV.Velocity = Vector3.new(0,0,0)
                end
                BG.CFrame = workspace.CurrentCamera.CFrame
            end
            BG:Destroy()
            BV:Destroy()
            if lp.Character:FindFirstChildOfClass('Humanoid') then
                lp.Character:FindFirstChildOfClass('Humanoid').PlatformStand = false
            end
        end)
    end

    flyKeyDown = UserInputService.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Keyboard then
            local KEY = input.KeyCode.Name
            if KEY=="W" then CONTROL.F=flySpeed
            elseif KEY=="S" then CONTROL.B=-flySpeed
            elseif KEY=="A" then CONTROL.L=-flySpeed
            elseif KEY=="D" then CONTROL.R=flySpeed
            elseif KEY=="E" then CONTROL.Q=flySpeed*2
            elseif KEY=="Q" then CONTROL.E=-flySpeed*2 end
        end
    end)

    flyKeyUp = UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Keyboard then
            local KEY = input.KeyCode.Name
            if KEY=="W" then CONTROL.F=0
            elseif KEY=="S" then CONTROL.B=0
            elseif KEY=="A" then CONTROL.L=0
            elseif KEY=="D" then CONTROL.R=0
            elseif KEY=="E" then CONTROL.Q=0
            elseif KEY=="Q" then CONTROL.E=0 end
        end
    end)

    FLY()
end

-- Stop fly
local function NOFLY()
    FLYING = false
    if flyKeyDown then flyKeyDown:Disconnect() end
    if flyKeyUp then flyKeyUp:Disconnect() end
    if mfly1 then mfly1:Disconnect() end
    if mfly2 then mfly2:Disconnect() end
    if lp.Character:FindFirstChildOfClass('Humanoid') then
        lp.Character:FindFirstChildOfClass('Humanoid').PlatformStand = false
    end
end

-- Mobile Fly
local function MobileFly()
    NOFLY()
    FLYING = true
    local root = lp.Character:WaitForChild("HumanoidRootPart")
    local camera = workspace.CurrentCamera
    local controlModule = require(lp.PlayerScripts:WaitForChild("PlayerModule"):WaitForChild("ControlModule"))
    local v3inf = Vector3.new(9e9,9e9,9e9)
    local v3none = Vector3.new(0,0,0)

    local bv = Instance.new("BodyVelocity", root)
    bv.Name = "BodyVelocity"
    bv.MaxForce = v3none
    bv.Velocity = v3none

    local bg = Instance.new("BodyGyro", root)
    bg.Name = "BodyGyro"
    bg.MaxTorque = v3inf
    bg.P = 1000
    bg.D = 50

    mfly2 = RunService.RenderStepped:Connect(function()
        root = lp.Character:WaitForChild("HumanoidRootPart")
        camera = workspace.CurrentCamera
        if lp.Character:FindFirstChildWhichIsA("Humanoid") and root and root:FindFirstChild("BodyVelocity") and root:FindFirstChild("BodyGyro") then
            local humanoid = lp.Character:FindFirstChildWhichIsA("Humanoid")
            local VelocityHandler = root:FindFirstChild("BodyVelocity")
            local GyroHandler = root:FindFirstChild("BodyGyro")
            VelocityHandler.MaxForce = v3inf
            GyroHandler.MaxTorque = v3inf
            humanoid.PlatformStand = true
            GyroHandler.CFrame = camera.CFrame
            VelocityHandler.Velocity = v3none
            local direction = controlModule:GetMoveVector()
            VelocityHandler.Velocity = VelocityHandler.Velocity + camera.CFrame.RightVector * (direction.X * (flySpeed*50))
            VelocityHandler.Velocity = VelocityHandler.Velocity - camera.CFrame.LookVector * (direction.Z * (flySpeed*50))
        end
    end)
end

-- Toggle
PlayerTab:CreateToggle({
    Text = "Enable Fly",
    Default = false,
    Callback = function(state)
        flyToggle = state
        if flyToggle then
            if UserInputService.TouchEnabled then
                MobileFly()
            else
                sFLY()
            end
        else
            -- STOP EVERYTHING
            FLYING = false

            -- Disconnect key binds
            if flyKeyDown then flyKeyDown:Disconnect() flyKeyDown=nil end
            if flyKeyUp then flyKeyUp:Disconnect() flyKeyUp=nil end
            if mfly1 then mfly1:Disconnect() mfly1=nil end
            if mfly2 then mfly2:Disconnect() mfly2=nil end

            -- Remove fly objects
            local root = lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")
            if root then
                if root:FindFirstChild("BodyVelocity") then root.BodyVelocity:Destroy() end
                if root:FindFirstChild("BodyGyro") then root.BodyGyro:Destroy() end
            end

            -- Restore humanoid control
            local humanoid = lp.Character and lp.Character:FindFirstChildWhichIsA("Humanoid")
            if humanoid then
                humanoid.PlatformStand = false
            end
        end
    end
})

---------------------------------------------------
-- NoClip
local NoClip = false

PlayerTab:CreateToggle({
    Text = "NoClip",
    Default = false,
    Callback = function(Value) NoClip = Value end
})

RunService.Stepped:Connect(function()
    if NoClip then
        for _, v in pairs(lp.Character:GetDescendants()) do
            if v:IsA("BasePart") then v.CanCollide = false end
        end
    end
end)

---------------------------------------------------
-- Anti-Void
local AntiVoid = false
PlayerTab:CreateToggle({
    Text = "Anti-Void",
    Default = false,
    Callback = function(Value) AntiVoid = Value end
})

RunService.Heartbeat:Connect(function()
    if AntiVoid then
        local hrp = lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")
        if hrp and hrp.Position.Y < -10 then
            hrp.CFrame = CFrame.new(0, 50, 0)
        end
    end
end)

---------------------------------------------------
-- Anti-Fling Toggle
PlayerTab:CreateButton({
    Text = "Anti Fling (RESET TO DISABLE)",
    Callback = function()
        _G.AntiFlingConfig = {
            disable_rotation = true;
            limit_velocity = true;
            limit_velocity_sensitivity = 150;
            limit_velocity_slow = 0;
            anti_ragdoll = true;
            anchor = false;
            smart_anchor = true;
            anchor_dist = 30;
            teleport = false;
            smart_teleport = true;
            teleport_dist = 30;
        }
        loadstring(game:HttpGet('https://raw.githubusercontent.com/topitbopit/rblx/main/extra/better_antifling.lua'))()
    end
})

---------------------------------------------------
-- Godmode
local Godmode = false
PlayerTab:CreateToggle({
    Text = "Godmode",
    Default = false,
    Callback = function(Value)
        Godmode = Value
    end
})

RunService.Stepped:Connect(function()
    if Godmode then
        local char = lp.Character
        if char then
            for _, part in pairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
    end
end)

---------------------------------------------------
-- Infinite Stamina
local InfiniteStamina = false
PlayerTab:CreateToggle({
    Text = "Infinite Stamina",
    Default = false,
    Callback = function(Value) InfiniteStamina = Value end
})

RunService.Stepped:Connect(function()
    if InfiniteStamina then
        local hum = lp.Character and lp.Character:FindFirstChildOfClass("Humanoid")
        if hum and hum:FindFirstChild("Stamina") then
            hum.Stamina.Value = hum.Stamina.MaxValue
        end
    end
end)

---------------------------------------------------
-- Auto Heal
local AutoHeal = false
PlayerTab:CreateToggle({
    Text = "Auto Heal",
    Default = false,
    Callback = function(Value) AutoHeal = Value end
})

RunService.Stepped:Connect(function()
    if AutoHeal then
        local hum = lp.Character and lp.Character:FindFirstChildOfClass("Humanoid")
        if hum and hum.Health < hum.MaxHealth then
            hum.Health = hum.MaxHealth
        end
    end
end)

-- Combat Tab
local CombatTab = window:CreateTab({
    Name = "Combat",
    Icon = "rbxassetid://7733765307"
})

local Players = game:GetService("Players")
local lp = Players.LocalPlayer
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")

---------------------------------------------------
-- 1. Kill Aura
local KillAuraEnabled = false
local KillAuraRange = 20
CombatTab:CreateToggle({
    Text = "Kill Aura",
    Default = false,
    Callback = function(Value) KillAuraEnabled = Value end
})

CombatTab:CreateSlider({
    Text = "Kill Aura Range",
    Default = 20,
    Minimum = 5,
    Maximum = 100,
    Callback = function(Value) KillAuraRange = Value end
})

RunService.Stepped:Connect(function()
    if KillAuraEnabled then
        local char = lp.Character
        if not char then return end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hrp then return end

        for _, player in pairs(Players:GetPlayers()) do
            if player ~= lp and player.Character and player.Character:FindFirstChild("Humanoid") and player.Character:FindFirstChild("HumanoidRootPart") then
                local targetHRP = player.Character.HumanoidRootPart
                if (hrp.Position - targetHRP.Position).Magnitude <= KillAuraRange then
                    player.Character.Humanoid.Health = 0
                end
            end
        end
    end
end)

---------------------------------------------------
-- 2. Auto Block (for melee)
local AutoBlock = false
CombatTab:CreateToggle({
    Text = "Auto Block",
    Default = false,
    Callback = function(Value) AutoBlock = Value end
})

RunService.Stepped:Connect(function()
    if AutoBlock then
        local char = lp.Character
        if char and char:FindFirstChildOfClass("Humanoid") then
            -- Just platform stand as "block" placeholder
            char:FindFirstChildOfClass("Humanoid").PlatformStand = true
        end
    end
end)

---------------------------------------------------
-- 3. Hitbox Expander
local HitboxEnabled = false
local HitboxSize = 5
CombatTab:CreateToggle({
    Text = "Hitbox Expander",
    Default = false,
    Callback = function(Value) HitboxEnabled = Value end
})

CombatTab:CreateSlider({
    Text = "Hitbox Size",
    Default = 5,
    Minimum = 1,
    Maximum = 20,
    Callback = function(Value) HitboxSize = Value end
})

RunService.Stepped:Connect(function()
    if HitboxEnabled then
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= lp and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                player.Character.HumanoidRootPart.Size = Vector3.new(HitboxSize, HitboxSize, HitboxSize)
            end
        end
    end
end)

---------------------------------------------------
-- 4. Auto Weapon Equip
local AutoEquip = false
CombatTab:CreateToggle({
    Text = "Auto Equip",
    Default = false,
    Callback = function(Value) AutoEquip = Value end
})

RunService.Stepped:Connect(function()
    if AutoEquip then
        local backpack = lp:FindFirstChild("Backpack")
        local char = lp.Character
        if backpack and char then
            for _, tool in pairs(backpack:GetChildren()) do
                if tool:IsA("Tool") then
                    tool.Parent = char
                end
            end
        end
    end
end)

---------------------------------------------------
-- 5. No Knockback
local NoKB = false
CombatTab:CreateToggle({
    Text = "No Knockback",
    Default = false,
    Callback = function(Value) NoKB = Value end
})

RunService.Stepped:Connect(function()
    if NoKB then
        local char = lp.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.PlatformStand = true
        end
    end
end)

---------------------------------------------------
-- 6. Auto Heal Combat
local AutoCombatHeal = false
CombatTab:CreateToggle({
    Text = "Auto Heal Combat",
    Default = false,
    Callback = function(Value) AutoCombatHeal = Value end
})

RunService.Stepped:Connect(function()
    if AutoCombatHeal then
        local char = lp.Character
        if char and char:FindFirstChildOfClass("Humanoid") then
            char:FindFirstChildOfClass("Humanoid").Health = char:FindFirstChildOfClass("Humanoid").MaxHealth
        end
    end
end)

---------------------------------------------------
-- 7. Rapid Attack
local RapidAttack = false
local RapidSpeed = 1
CombatTab:CreateToggle({
    Text = "Rapid Attack",
    Default = false,
    Callback = function(Value) RapidAttack = Value end
})

CombatTab:CreateSlider({
    Text = "Attack Speed",
    Default = 1,
    Minimum = 0.1,
    Maximum = 5,
    Callback = function(Value) RapidSpeed = Value end
})

RunService.RenderStepped:Connect(function()
    if RapidAttack then
        local char = lp.Character
        if char and char:FindFirstChildOfClass("Tool") then
            local tool = char:FindFirstChildOfClass("Tool")
            if tool:FindFirstChild("Handle") then
                tool:Activate()
            end
        end
    end
end)

---------------------------------------------------
-- 8. Auto Block Projectiles
local AutoBlockProj = false
CombatTab:CreateToggle({
    Text = "Auto Block Projectiles",
    Default = false,
    Callback = function(Value) AutoBlockProj = Value end
})

RunService.Stepped:Connect(function()
    if AutoBlockProj then
        local char = lp.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.PlatformStand = true
        end
    end
end)

---------------------------------------------------
-- 9. Teleport to Target
local TeleportEnabled = false
local TeleportPlayer = nil
CombatTab:CreatePlayerSelector({
    Text = "Select Player to TP",
    Callback = function(player) TeleportPlayer = player end
})

CombatTab:CreateButton({
    Text = "Teleport",
    Callback = function()
        if TeleportPlayer and lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") then
            lp.Character.HumanoidRootPart.CFrame = TeleportPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(0,3,0)
        end
    end
})

---------------------------------------------------
-- 10. One Hit Kill
local OneHitEnabled = false
CombatTab:CreateToggle({
    Text = "One Hit Kill",
    Default = false,
    Callback = function(Value) OneHitEnabled = Value end
})

RunService.Stepped:Connect(function()
    if OneHitEnabled then
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= lp and player.Character and player.Character:FindFirstChild("Humanoid") then
                player.Character.Humanoid.MaxHealth = 1
            end
        end
    end
end)

-- Tools / Items Tab
local ToolsTab = window:CreateTab({
    Name = "Tools",
    Icon = "rbxassetid://7733955511"
})

local lp = game.Players.LocalPlayer
local RunService = game:GetService("RunService")

---------------------------------------------------
-- 1. Auto Pickup Tools
local AutoPickup = false
ToolsTab:CreateToggle({
    Text = "Auto Pickup Tools",
    Default = false,
    Callback = function(Value) AutoPickup = Value end
})

RunService.Stepped:Connect(function()
    if AutoPickup then
        for _, tool in pairs(workspace:GetDescendants()) do
            if tool:IsA("Tool") and tool.Parent ~= lp.Backpack and tool.Parent ~= lp.Character then
                tool.Parent = lp.Backpack
            end
        end
    end
end)

---------------------------------------------------
-- 2. Duplicate Tool
ToolsTab:CreateButton({
    Text = "Duplicate Tool",
    Callback = function()
        local char = lp.Character
        if char then
            for _, tool in pairs(char:GetChildren()) do
                if tool:IsA("Tool") then
                    local clone = tool:Clone()
                    clone.Parent = lp.Backpack
                end
            end
        end
    end
})

---------------------------------------------------
-- 3. Equip Multiple Tools
ToolsTab:CreateButton({
    Text = "Equip All Tools",
    Callback = function()
        local char = lp.Character
        local backpack = lp:FindFirstChild("Backpack")
        if char and backpack then
            for _, tool in pairs(backpack:GetChildren()) do
                if tool:IsA("Tool") then
                    tool.Parent = char
                end
            end
        end
    end
})

---------------------------------------------------
-- 4. Drop Tool Spammer
ToolsTab:CreateButton({
    Text = "Drop All Tools",
    Callback = function()
        local backpack = lp:FindFirstChild("Backpack")
        local char = lp.Character
        if backpack then
            for _, tool in pairs(backpack:GetChildren()) do
                tool.Parent = workspace
            end
        end
        if char then
            for _, tool in pairs(char:GetChildren()) do
                if tool:IsA("Tool") then
                    tool.Parent = workspace
                end
            end
        end
    end
})

---------------------------------------------------
-- 5. Auto Use Tool
local AutoUse = false
ToolsTab:CreateToggle({
    Text = "Auto Use Tool",
    Default = false,
    Callback = function(Value) AutoUse = Value end
})

RunService.Stepped:Connect(function()
    if AutoUse then
        local char = lp.Character
        if char then
            for _, tool in pairs(char:GetChildren()) do
                if tool:IsA("Tool") and tool:FindFirstChild("Handle") then
                    tool:Activate()
                end
            end
        end
    end
end)

---------------------------------------------------
-- 6. Item Stealer
-- Removed Feature Bcuz bug

---------------------------------------------------
-- 7. Backpack Extender (Unlimited Tools)
ToolsTab:CreateButton({
    Text = "Backpack Extender",
    Callback = function()
        local backpack = lp:FindFirstChild("Backpack")
        if backpack then
            for i = 1, 50 do
                local newTool = Instance.new("Tool")
                newTool.Name = "ExtraTool"..i
                newTool.Parent = backpack
            end
        end
    end
})

---------------------------------------------------
-- 8. Dual Wield (Equip Two Tools)
ToolsTab:CreateButton({
    Text = "Dual Wield",
    Callback = function()
        local char = lp.Character
        local backpack = lp:FindFirstChild("Backpack")
        if char and backpack then
            local count = 0
            for _, tool in pairs(backpack:GetChildren()) do
                if tool:IsA("Tool") then
                    tool.Parent = char
                    count = count + 1
                    if count >= 2 then break end
                end
            end
        end
    end
})

---------------------------------------------------
-- 9. Auto Equip Best Tool (placeholder: first tool)
ToolsTab:CreateButton({
    Text = "Auto Equip Best",
    Callback = function()
        local char = lp.Character
        local backpack = lp:FindFirstChild("Backpack")
        if char and backpack then
            for _, tool in pairs(backpack:GetChildren()) do
                if tool:IsA("Tool") then
                    tool.Parent = char
                    break
                end
            end
        end
    end
})

---------------------------------------------------
-- 10. Tool Giver (from external script)
ToolsTab:CreateButton({
    Text = "Tool Giver",
    Callback = function()
        loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Game-tool-giver-12133"))()
    end
})

-- Movement / Teleport Tab
local MoveTab = window:CreateTab({
    Name = "Movement",
    Icon = "rbxassetid://7743871002"
})

local lp = game.Players.LocalPlayer
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")

---------------------------------------------------
-- 1. Teleport to Player
local TPPlayer = nil
MoveTab:CreatePlayerSelector({
    Text = "Select Player to TP",
    Callback = function(player) TPPlayer = player end
})

MoveTab:CreateButton({
    Text = "Teleport",
    Callback = function()
        if TPPlayer and lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") then
            lp.Character.HumanoidRootPart.CFrame = TPPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(0,3,0)
        end
    end
})

---------------------------------------------------
-- 2. Random Teleport
MoveTab:CreateButton({
    Text = "Random Teleport",
    Callback = function()
        local x = math.random(-500,500)
        local y = math.random(5,50)
        local z = math.random(-500,500)
        if lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") then
            lp.Character.HumanoidRootPart.CFrame = CFrame.new(x,y,z)
        end
    end
})

---------------------------------------------------
-- 3. Dash (short speed burst)
local DashSpeed = 50
MoveTab:CreateSlider({
    Text = "Dash Speed",
    Default = 50,
    Minimum = 10,
    Maximum = 100,
    Callback = function(Value) DashSpeed = Value end
})

MoveTab:CreateBind({
    Text = "Dash Keybind",
    Hold = false,
    Default = Enum.KeyCode.LeftShift,
    CallBack = function()
        local char = lp.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            local hrp = char.HumanoidRootPart
            local look = workspace.CurrentCamera.CFrame.LookVector
            hrp.Velocity = look * DashSpeed
        end
    end
})

---------------------------------------------------
-- 4. Hover Mode
local Hover = false
MoveTab:CreateToggle({
    Text = "Hover Mode",
    Default = false,
    Callback = function(Value) Hover = Value end
})

RunService.Stepped:Connect(function()
    if Hover and lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") then
        local hrp = lp.Character.HumanoidRootPart
        hrp.Velocity = Vector3.new(hrp.Velocity.X, 0, hrp.Velocity.Z)
        lp.Character.Humanoid.PlatformStand = true
    elseif lp.Character then
        lp.Character.Humanoid.PlatformStand = false
    end
end)

---------------------------------------------------
-- 5. Wall Climb
local WallClimb = false
MoveTab:CreateToggle({
    Text = "Wall Climb",
    Default = false,
    Callback = function(Value) WallClimb = Value end
})

RunService.Stepped:Connect(function()
    if WallClimb and lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") then
        local hrp = lp.Character.HumanoidRootPart
        local ray = Ray.new(hrp.Position, hrp.CFrame.LookVector*3)
        local part, pos = workspace:FindPartOnRay(ray, lp.Character)
        if part then
            hrp.CFrame = hrp.CFrame + Vector3.new(0,1,0)
        end
    end
end)

---------------------------------------------------
-- 6. Auto Follow Player
local FollowPlayer = nil
local AutoFollow = false
MoveTab:CreatePlayerSelector({
    Text = "Select Player to Follow",
    Callback = function(player) FollowPlayer = player end
})

MoveTab:CreateToggle({
    Text = "Auto Follow",
    Default = false,
    Callback = function(Value) AutoFollow = Value end
})

RunService.Stepped:Connect(function()
    if AutoFollow and FollowPlayer and FollowPlayer.Character and lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") then
        local targetHRP = FollowPlayer.Character:FindFirstChild("HumanoidRootPart")
        lp.Character.HumanoidRootPart.CFrame = targetHRP.CFrame + Vector3.new(0,3,0)
    end
end)

---------------------------------------------------
-- 7. Auto Avoid Players
local AutoAvoid = false
local AvoidDistance = 10
MoveTab:CreateToggle({
    Text = "Auto Avoid Players",
    Default = false,
    Callback = function(Value) AutoAvoid = Value end
})

MoveTab:CreateSlider({
    Text = "Avoid Distance",
    Default = 10,
    Minimum = 5,
    Maximum = 50,
    Callback = function(Value) AvoidDistance = Value end
})

RunService.Stepped:Connect(function()
    if AutoAvoid and lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") then
        for _, player in pairs(game.Players:GetPlayers()) do
            if player ~= lp and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                local dist = (lp.Character.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude
                if dist < AvoidDistance then
                    local moveDir = (lp.Character.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Unit
                    lp.Character.HumanoidRootPart.CFrame = lp.Character.HumanoidRootPart.CFrame + moveDir * 5
                end
            end
        end
    end
end)

-- AC Bypassed Hacks Tab

---------------------------------------------------
-- Speed Bypass
local wsBypassEnabled = false
local wsBypassSpeed = 16
local wsPushPart
local wsConn

local ACBypassTab = window:CreateTab({
    Name = "AC Bypass",
    Icon = "rbxassetid://7743875263"
})

ACBypassTab:CreateSlider({
    Text = "Bypassed Speed Hack (BUGGY)",
    Default = 16,
    Minimum = 16,
    Maximum = 100,
    Callback = function(Value)
        wsBypassSpeed = Value
        if Value > 16 then
            if not wsBypassEnabled then
                wsBypassEnabled = true
                local char = lp.Character or lp.CharacterAdded:Wait()
                local hrp = char:WaitForChild("HumanoidRootPart")
                local hum = char:WaitForChild("Humanoid")

                wsPushPart = Instance.new("Part")
                wsPushPart.Anchored = true
                wsPushPart.Transparency = 1
                wsPushPart.CanCollide = false
                wsPushPart.Size = Vector3.new(2,2,1)
                wsPushPart.Name = "Block-ef0024"
                wsPushPart.Parent = workspace

                wsConn = RunService.Heartbeat:Connect(function()
                    if wsBypassEnabled and hrp and wsPushPart and hum then
                        local moveDir = hum.MoveDirection
                        if moveDir.Magnitude > 0 then
                            local forward = hrp.CFrame.LookVector
                            wsPushPart.CFrame = hrp.CFrame * CFrame.new(0,0,2)
                            hrp.Velocity = hrp.Velocity + (forward * (wsBypassSpeed - 16))
                        end
                    end
                end)
            end
        else
            wsBypassEnabled = false
            if wsPushPart then wsPushPart:Destroy() wsPushPart = nil end
            if wsConn then wsConn:Disconnect() wsConn = nil end
        end
    end
})

---------------------------------------------------
-- Jump Hack Bypass
local jumpBypassEnabled = false
local jumpBoost = 75
local jumpConn

ACBypassTab:CreateToggle({
    Text = "Bypassed High Jump",
    Default = false,
    Callback = function(Value)
        jumpBypassEnabled = Value
        local char = lp.Character or lp.CharacterAdded:Wait()
        local hum = char:WaitForChild("Humanoid")

        if jumpBypassEnabled then
            jumpConn = hum.Jumping:Connect(function(active)
                if active then
                    local hrp = char:WaitForChild("HumanoidRootPart")
                    hrp.Velocity = hrp.Velocity + Vector3.new(0, jumpBoost, 0)
                end
            end)
        else
            if jumpConn then
                jumpConn:Disconnect()
                jumpConn = nil
            end
        end
    end
})

-- Server Tab
local ServerTab = window:CreateTab({
    Name = "Server",
    Icon = "rbxassetid://7733954760"
})

local lp = game.Players.LocalPlayer
local RunService = game:GetService("RunService")
local RS = game:GetService("ReplicatedStorage")
local TeleportService = game:GetService("TeleportService")

---------------------------------------------------
-- 1. Server Hop
ServerTab:CreateButton({
    Text = "Server Hop",
    Callback = function()
        local HttpService = game:GetService("HttpService")
        local PlaceID = game.PlaceId
        local Servers = HttpService:JSONDecode(game:HttpGetAsync("https://games.roblox.com/v1/games/"..PlaceID.."/servers/Public?sortOrder=Asc&limit=100"))
        for _, server in pairs(Servers.data) do
            if server.playing < server.maxPlayers and server.id ~= game.JobId then
                TeleportService:TeleportToPlaceInstance(PlaceID, server.id, lp)
                break
            end
        end
    end
})

---------------------------------------------------
-- 2. Rejoin Server
ServerTab:CreateButton({
    Text = "Rejoin Server",
    Callback = function()
        TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, lp)
    end
})

---------------------------------------------------
-- 3. Auto Reconnect
local AutoReconnect = false
ServerTab:CreateToggle({
    Text = "Auto Reconnect",
    Default = false,
    Callback = function(Value) AutoReconnect = Value end
})

game:GetService("Players").LocalPlayer.OnTeleport:Connect(function(State)
    if AutoReconnect then
        -- handled automatically after teleport
    end
end)

---------------------------------------------------
-- 4. Anti-AFK
local AFKBypass = false
ServerTab:CreateToggle({
    Text = "Anti-AFK",
    Default = false,
    Callback = function(Value) AFKBypass = Value end
})

RunService.Stepped:Connect(function()
    if AFKBypass then
        lp.Character.HumanoidRootPart.CFrame = lp.Character.HumanoidRootPart.CFrame + Vector3.new(0,0.01,0)
    end
end)

---------------------------------------------------
-- 5. Anti-Kick & Anti-Report
ServerTab:CreateButton({
    Text = "Anti-Kick & Anti-Report",
    Callback = function()
        -- Anti-Report
        if game:GetService("ReplicatedStorage"):FindFirstChild("ReportEvent") then
            game:GetService("ReplicatedStorage").ReportEvent:Destroy()
        end
        -- Anti-Kick
        hookfunction(lp.Kick, function() end)
        window:CreateNotification({Title="Protection", Description="Anti-Kick & Anti-Report Enabled", Duration=5})
    end
})

---------------------------------------------------
-- 6. Chat Bypass
ServerTab:CreateButton({
    Text = "Chat Bypass (Need Key)",
    Callback = function()
        loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Synergy-Networks/products/main/BetterBypasser/loader.lua"))()
    end
})

---------------------------------------------------
-- 7. Ping Checker
ServerTab:CreateButton({
    Text = "Check Ping",
    Callback = function()
        local ping = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString()
        window:CreateNotification({Title="Ping", Description="Current Ping: "..ping, Duration=5})
    end
})

---------------------------------------------------
-- 8. FPS Booster
ServerTab:CreateButton({
    Text = "FPS Booster",
    Callback = function()
        for _, item in pairs(workspace:GetDescendants()) do
            if item:IsA("Part") or item:IsA("MeshPart") then
                item.Material = Enum.Material.SmoothPlastic
                item.TextureID = ""
            end
        end
        for _, g in pairs(workspace:GetDescendants()) do
            if g:IsA("ParticleEmitter") or g:IsA("Trail") then
                g:Destroy()
            end
        end
        window:CreateNotification({Title="FPS Boost", Description="Applied SmoothPlastic + Removed Particles", Duration=5})
    end
})

-- Games Tab
local GamesTab = window:CreateTab({
    Name = "Games",
    Icon = "rbxassetid://7733799901"
})

GamesTab:CreateButton({
    Text = "Build A Plane",
    Callback = function()
        loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/SuperHackerYT/ElvisHub/refs/heads/main/ElvisHubBAP.lua"))()
    end
})

GamesTab:CreateButton({
    Text = "Forsaken",
    Callback = function()
        loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/SuperHackerYT/ElvisHub/refs/heads/main/ElvisHubForsaken.lua"))()
    end
})

GamesTab:CreateButton({
    Text = "Grow A Garden",
    Callback = function()
        loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/SuperHackerYT/ElvisHub/refs/heads/main/ElvisHubGAG.lua"))()
    end
})

GamesTab:CreateButton({
    Text = "99 Nights in the Forest",
    Callback = function()
        loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/SuperHackerYT/ElvisHub/refs/heads/main/ElvisHub99NITF.lua"))()
    end
})

GamesTab:CreateButton({
    Text = "Hunty Zombies",
    Callback = function()
        loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/SuperHackerYT/ElvisHub/refs/heads/main/ElvisHubHuntyZombies.lua"))()
    end
})

GamesTab:CreateButton({
    Text = "Steal A Brainrot",
    Callback = function()
        loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/SuperHackerYT/ElvisHub/refs/heads/main/ElvisHubSAB.lua"))()
    end
})

GamesTab:CreateButton({
    Text = "Doors",
    Callback = function()
        loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/SuperHackerYT/ElvisHub/refs/heads/main/ElvisHubDoors.lua"))()
    end
})

GamesTab:CreateButton({
    Text = "BloxFruits",
    Callback = function()
        loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/SuperHackerYT/ElvisHub/refs/heads/main/ElvisHubBloxFruits.lua"))()
    end
})

GameTab:CreateButton({
    Text = "Fisch",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/SuperHackerYT/ElvisHub/refs/heads/main/Fisch.lua"))()
    end
})
