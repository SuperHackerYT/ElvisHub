if not game:IsLoaded() then
    game.Loaded:Wait()
end

local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

WindUI:AddTheme({
    Name = "Dark",
    Accent = "#18181b",
    Dialog = "#18181b", 
    Outline = "#FFFFFF",
    Text = "#FFFFFF",
    Placeholder = "#999999",
    Background = "#0e0e10",
    Button = "#52525b",
    Icon = "#a1a1aa",
})

WindUI:AddTheme({
    Name = "Light",
    Accent = "#f4f4f5",
    Dialog = "#f4f4f5",
    Outline = "#000000", 
    Text = "#000000",
    Placeholder = "#666666",
    Background = "#ffffff",
    Button = "#e4e4e7",
    Icon = "#52525b",
})

WindUI:AddTheme({
    Name = "Gray",
    Accent = "#374151",
    Dialog = "#374151",
    Outline = "#d1d5db", 
    Text = "#f9fafb",
    Placeholder = "#9ca3af",
    Background = "#1f2937",
    Button = "#4b5563",
    Icon = "#d1d5db",
})

WindUI:AddTheme({
    Name = "Blue",
    Accent = "#1e40af",
    Dialog = "#1e3a8a",
    Outline = "#93c5fd", 
    Text = "#f0f9ff",
    Placeholder = "#60a5fa",
    Background = "#1e293b",
    Button = "#3b82f6",
    Icon = "#93c5fd",
})

WindUI:AddTheme({
    Name = "Green",
    Accent = "#059669",
    Dialog = "#047857",
    Outline = "#6ee7b7", 
    Text = "#ecfdf5",
    Placeholder = "#34d399",
    Background = "#064e3b",
    Button = "#10b981",
    Icon = "#6ee7b7",
})

WindUI:AddTheme({
    Name = "Purple",
    Accent = "#7c3aed",
    Dialog = "#6d28d9",
    Outline = "#c4b5fd", 
    Text = "#faf5ff",
    Placeholder = "#a78bfa",
    Background = "#581c87",
    Button = "#8b5cf6",
    Icon = "#c4b5fd",
})

WindUI:AddTheme({
    Name = "Red",
    Accent = "#dc2626",
    Dialog = "#b91c1c",
    Outline = "#fca5a5", 
    Text = "#fef2f2",
    Placeholder = "#f87171",
    Background = "#7f1d1d",
    Button = "#ef4444",
    Icon = "#fca5a5",
})

WindUI:AddTheme({
    Name = "Midnight Blue",
    Accent = "#1e3a8a",
    Dialog = "#1e40af",
    Outline = "#60a5fa", 
    Text = "#dbeafe",
    Placeholder = "#3b82f6",
    Background = "#0c1e3e",
    Button = "#2563eb",
    Icon = "#93c5fd",
})

WindUI:AddTheme({
    Name = "Dark Blue",
    Accent = "#1d4ed8",
    Dialog = "#1e40af",
    Outline = "#93c5fd", 
    Text = "#eff6ff",
    Placeholder = "#60a5fa",
    Background = "#172554",
    Button = "#3b82f6",
    Icon = "#bfdbfe",
})

WindUI:SetNotificationLower(true)

local themes = {"Dark", "Light", "Gray", "Blue", "Green", "Purple", "Red", "Midnight Blue", "Dark Blue"}
local currentThemeIndex = 1

if not getgenv().TransparencyEnabled then
    getgenv().TransparencyEnabled = false
end

local Window = WindUI:CreateWindow({
    Title = "Hunty Zombie",
    Icon = "zap", 
    Author = "Elvis Hub",
    Folder = "AxsHub",
    Size = UDim2.fromOffset(500, 350),
    Transparent = getgenv().TransparencyEnabled,
    Theme = "Dark",
    Resizable = true,
    SideBarWidth = 150,
    BackgroundImageTransparency = 0.8,
    HideSearchBar = false,
    ScrollBarEnabled = true,
    User = {
        Enabled = true,
        Anonymous = false,
        Callback = function()
            currentThemeIndex = currentThemeIndex + 1
            if currentThemeIndex > #themes then
                currentThemeIndex = 1
            end
            
            local newTheme = themes[currentThemeIndex]
            WindUI:SetTheme(newTheme)
           
            WindUI:Notify({
                Title = "Theme Changed",
                Content = "Switched to " .. newTheme .. " theme!",
                Duration = 1.5,
                Icon = "palette"
            })
            print("Switched to " .. newTheme .. " theme")
        end,
    },
})

Window:SetToggleKey(Enum.KeyCode.V)

pcall(function()
    Window:CreateTopbarButton("TransparencyToggle", "eye", function()
        if getgenv().TransparencyEnabled then
            getgenv().TransparencyEnabled = false
            pcall(function() Window:ToggleTransparency(false) end)
        else
            getgenv().TransparencyEnabled = true
            pcall(function() Window:ToggleTransparency(true) end)
        end
        
        warn("Debug Current Transparency state:", getgenv().TransparencyEnabled)
    end, 990)
end)

Window:EditOpenButton({
    Title = "Hunty Zombie",
    Icon = "zap",
    CornerRadius = UDim.new(0, 6),
    StrokeThickness = 2,
    Color = ColorSequence.new(Color3.fromRGB(138, 43, 226), Color3.fromRGB(173, 216, 230)),
    Draggable = true,
})

local MainSection = Window:Section({
    Title = "Main",
    Icon = "align-justify",
    Opened = true,
})

local CombatTab = MainSection:Tab({
    Title = "Combat",
    Icon = "swords",
    Description = "Elvis"
})

local EspTab = MainSection:Tab({
    Title = "Esp",
    Icon = "eye",
    Description = "Elvis"
})

local PlayerMiscTab = MainSection:Tab({
    Title = "PlayerMisc",
    Icon = "user",
    Description = "Elvis"
})

local LobbySection = Window:Section({
    Title = "Lobby",
    Icon = "align-left",
    Opened = true,
})

local CodesTab = LobbySection:Tab({
    Title = "Codes",
    Icon = "code",
    Locked = false,
})

local InfoTab = Window:Tab({
    Title = "Information",
    Icon = "badge-info",
    Description = "Elvis"
})

local Tabs = {
	Combat = CombatTab,
	Esp = EspTab,
    PlayerMisc = PlayerMiscTab,
    Codes = CodesTab,
    Info = InfoTab
}

Window:SelectTab(5) -- Number of Tab

-- ==============STATUS INFO===================

Info = Tabs["Info"]

        Info:Button({
            Title = "Copy Discord Invite",
            Callback = function()
                setclipboard("https://discord.gg/" .. InviteCode)
                WindUI:Notify({
                    Title = "Copied!",
                    Content = "Discord invite copied to clipboard",
                    Duration = 2,
                    Icon = "clipboard-check",
                })
            end
        })

Info:Divider()
Info:Section({ 
    Title = "Elvis Hub",
    TextXAlignment = "Center",
    TextSize = 17,
})
Info:Divider()

local Owner = Info:Paragraph({
    Title = "Main Founder",
    Desc = "Elvis",
    Image = "rbxassetid://77933782593847",
    ImageSize = 30,
    Thumbnail = "",
    ThumbnailSize = 0,
    Locked = false,
})

local CoOwner = Info:Paragraph({
    Title = "Elvis Hub",
    Desc = "Developed by Elvis",
    Image = "rbxassetid://129542787176629",
    ImageSize = 30,
    Thumbnail = "",
    ThumbnailSize = 0,
    Locked = false,
})

local Discord = Info:Paragraph({
    Title = "Discord",
    Desc = "Join our discord for more scripts!",
    Image = "",
    ImageSize = 30,
    Thumbnail = "",
    ThumbnailSize = 0,
    Locked = false,
    Buttons = {
        {
            Icon = "copy",
            Title = "Copy Link",
            Callback = function()
                setclipboard("https://discord.gg/7zyT99D7S3")
            end,
        }
    }
})
-- ==============STATUS INFO===================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local flyToggle = false
local flySpeed = 1
local FLYING = false
local flyKeyDown, flyKeyUp, mfly1, mfly2
local noclipConnection 

local hitAuraEnabled = false
local hitAuraConnection = nil

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

local activeESPs = {}
local entitiesConnection

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local ESPEnabled = false
local ESPObjects = {}

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")

local AutoFightEnabled = false
local AutoFightConnection
local HitAuraConnection
local currentIndex = 1

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LoopEnabled = false
local LoopConnection

local AutoCollectEnabled = false
local AutoCollectConnection

local BringAllEnabled = false
local bringConnection

local savedPosition = nil

local RadioPos = CFrame.new(-46, -17, -123) 

local loopEnabled = false
local loopConnection

local loopEnabled2 = false
local loopConnection2

local loopEnabled3 = false
local loopConnection3
-- =================================FUNCTION HERE NIGGA==================
local function FuckingHitAura()
    local args = {
	buffer.fromstring("\b\001\000")
}
game:GetService("ReplicatedStorage"):WaitForChild("ByteNetReliable"):FireServer(unpack(args))
end

local function FuckingHitAura2()
    local args = {
	buffer.fromstring("\b\001\000")
}
game:GetService("ReplicatedStorage"):WaitForChild("ByteNetReliable"):FireServer(unpack(args))
end

local function startLoop()
    if LoopEnabled then return end
    
    LoopEnabled = true
    
    LoopConnection = RunService.Heartbeat:Connect(function()
        if LoopEnabled then
            FuckingHitAura2()
        end
    end)
end

local function stopLoop()
    if not LoopEnabled then return end
    
    LoopEnabled = false
    
    if LoopConnection then
        LoopConnection:Disconnect()
        LoopConnection = nil
    end
end


local function sFLY()
    repeat task.wait() until Players.LocalPlayer and Players.LocalPlayer.Character and Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart") and Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    repeat task.wait() until UserInputService
    if flyKeyDown or flyKeyUp then flyKeyDown:Disconnect(); flyKeyUp:Disconnect() end

    local T = Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart")
    local CONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
    local lCONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
    local SPEED = flySpeed

    local function FLY()
        FLYING = true
        local BG = Instance.new('BodyGyro')
        local BV = Instance.new('BodyVelocity')
        BG.P = 9e4
        BG.Parent = T
        BV.Parent = T
        BG.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
        BG.CFrame = T.CFrame
        BV.Velocity = Vector3.new(0, 0, 0)
        BV.MaxForce = Vector3.new(9e9, 9e9, 9e9)
        task.spawn(function()
            while FLYING do
                task.wait()
                if not flyToggle and Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid') then
                    Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid').PlatformStand = true
                end
                if CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0 or CONTROL.Q + CONTROL.E ~= 0 then
                    SPEED = flySpeed
                elseif not (CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0 or CONTROL.Q + CONTROL.E ~= 0) and SPEED ~= 0 then
                    SPEED = 0
                end
                if (CONTROL.L + CONTROL.R) ~= 0 or (CONTROL.F + CONTROL.B) ~= 0 or (CONTROL.Q + CONTROL.E) ~= 0 then
                    BV.Velocity = ((workspace.CurrentCamera.CoordinateFrame.lookVector * (CONTROL.F + CONTROL.B)) + ((workspace.CurrentCamera.CoordinateFrame * CFrame.new(CONTROL.L + CONTROL.R, (CONTROL.F + CONTROL.B + CONTROL.Q + CONTROL.E) * 0.2, 0).p) - workspace.CurrentCamera.CoordinateFrame.p)) * SPEED
                    lCONTROL = {F = CONTROL.F, B = CONTROL.B, L = CONTROL.L, R = CONTROL.R}
                elseif (CONTROL.L + CONTROL.R) == 0 and (CONTROL.F + CONTROL.B) == 0 and (CONTROL.Q + CONTROL.E) == 0 and SPEED ~= 0 then
                    BV.Velocity = ((workspace.CurrentCamera.CoordinateFrame.lookVector * (lCONTROL.F + lCONTROL.B)) + ((workspace.CurrentCamera.CoordinateFrame * CFrame.new(lCONTROL.L + lCONTROL.R, (lCONTROL.F + lCONTROL.B + CONTROL.Q + CONTROL.E) * 0.2, 0).p) - workspace.CurrentCamera.CoordinateFrame.p)) * SPEED
                else
                    BV.Velocity = Vector3.new(0, 0, 0)
                end
                BG.CFrame = workspace.CurrentCamera.CoordinateFrame
            end
            CONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
            lCONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
            SPEED = 0
            BG:Destroy()
            BV:Destroy()
            if Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid') then
                Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid').PlatformStand = false
            end
        end)
    end
    flyKeyDown = UserInputService.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Keyboard then
            local KEY = input.KeyCode.Name
            if KEY == "W" then
                CONTROL.F = flySpeed
            elseif KEY == "S" then
                CONTROL.B = -flySpeed
            elseif KEY == "A" then
                CONTROL.L = -flySpeed
            elseif KEY == "D" then 
                CONTROL.R = flySpeed
            elseif KEY == "E" then
                CONTROL.Q = flySpeed * 2
            elseif KEY == "Q" then
                CONTROL.E = -flySpeed * 2
            end
            pcall(function() workspace.CurrentCamera.CameraType = Enum.CameraType.Track end)
        end
    end)
    flyKeyUp = UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Keyboard then
            local KEY = input.KeyCode.Name
            if KEY == "W" then
                CONTROL.F = 0
            elseif KEY == "S" then
                CONTROL.B = 0
            elseif KEY == "A" then
                CONTROL.L = 0
            elseif KEY == "D" then
                CONTROL.R = 0
            elseif KEY == "E" then
                CONTROL.Q = 0
            elseif KEY == "Q" then
                CONTROL.E = 0
            end
        end
    end)
    FLY()
end

local function NOFLY()
    FLYING = false
    if flyKeyDown then flyKeyDown:Disconnect() end
    if flyKeyUp then flyKeyUp:Disconnect() end
    if mfly1 then mfly1:Disconnect() end
    if mfly2 then mfly2:Disconnect() end
    if Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid') then
        Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid').PlatformStand = false
    end
    pcall(function() workspace.CurrentCamera.CameraType = Enum.CameraType.Custom end)
end

local function UnMobileFly()
    pcall(function()
        FLYING = false
        local root = Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart")
        if root:FindFirstChild("BodyVelocity") then root:FindFirstChild("BodyVelocity"):Destroy() end
        if root:FindFirstChild("BodyGyro") then root:FindFirstChild("BodyGyro"):Destroy() end
        if Players.LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid") then
            Players.LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid").PlatformStand = false
        end
        if mfly1 then mfly1:Disconnect() end
        if mfly2 then mfly2:Disconnect() end
    end)
end

local function MobileFly()
    UnMobileFly()
    FLYING = true

    local root = Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart")
    local camera = workspace.CurrentCamera
    local v3none = Vector3.new()
    local v3zero = Vector3.new(0, 0, 0)
    local v3inf = Vector3.new(9e9, 9e9, 9e9)

    local controlModule = require(Players.LocalPlayer.PlayerScripts:WaitForChild("PlayerModule"):WaitForChild("ControlModule"))
    local bv = Instance.new("BodyVelocity")
    bv.Name = "BodyVelocity"
    bv.Parent = root
    bv.MaxForce = v3zero
    bv.Velocity = v3zero

    local bg = Instance.new("BodyGyro")
    bg.Name = "BodyGyro"
    bg.Parent = root
    bg.MaxTorque = v3inf
    bg.P = 1000
    bg.D = 50

    mfly1 = Players.LocalPlayer.CharacterAdded:Connect(function()
        local newRoot = Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart")
        local newBv = Instance.new("BodyVelocity")
        newBv.Name = "BodyVelocity"
        newBv.Parent = newRoot
        newBv.MaxForce = v3zero
        newBv.Velocity = v3zero

        local newBg = Instance.new("BodyGyro")
        newBg.Name = "BodyGyro"
        newBg.Parent = newRoot
        newBg.MaxTorque = v3inf
        newBg.P = 1000
        newBg.D = 50
    end)

    mfly2 = RunService.RenderStepped:Connect(function()
        root = Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart")
        camera = workspace.CurrentCamera
        if Players.LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid") and root and root:FindFirstChild("BodyVelocity") and root:FindFirstChild("BodyGyro") then
            local humanoid = Players.LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid")
            local VelocityHandler = root:FindFirstChild("BodyVelocity")
            local GyroHandler = root:FindFirstChild("BodyGyro")

            VelocityHandler.MaxForce = v3inf
            GyroHandler.MaxTorque = v3inf
            humanoid.PlatformStand = true
            GyroHandler.CFrame = camera.CoordinateFrame
            VelocityHandler.Velocity = v3none

            local direction = controlModule:GetMoveVector()
            if direction.X > 0 then
                VelocityHandler.Velocity = VelocityHandler.Velocity + camera.CFrame.RightVector * (direction.X * (flySpeed * 50))
            end
            if direction.X < 0 then
                VelocityHandler.Velocity = VelocityHandler.Velocity + camera.CFrame.RightVector * (direction.X * (flySpeed * 50))
            end
            if direction.Z > 0 then
                VelocityHandler.Velocity = VelocityHandler.Velocity - camera.CFrame.LookVector * (direction.Z * (flySpeed * 50))
            end
            if direction.Z < 0 then
                VelocityHandler.Velocity = VelocityHandler.Velocity - camera.CFrame.LookVector * (direction.Z * (flySpeed * 50))
            end
        end
    end)
end

if not getgenv().CustomWalkSpeed then
    getgenv().CustomWalkSpeed = 40
end

if not getgenv().WalkSpeedEnabled then
    getgenv().WalkSpeedEnabled = false
end

local player = Players.LocalPlayer
local walkspeedConnection

local function applyCustomWalkspeed()
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.WalkSpeed = getgenv().CustomWalkSpeed
    end
end

local function resetToDefaultWalkspeed()
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.WalkSpeed = 16 
    end
end

local function startApplyingSpeed()
    if walkspeedConnection then
        walkspeedConnection:Disconnect()
    end
    
    applyCustomWalkspeed()
    
    walkspeedConnection = RunService.Heartbeat:Connect(function()
        if getgenv().WalkSpeedEnabled and player.Character and player.Character:FindFirstChild("Humanoid") then
            if player.Character.Humanoid.WalkSpeed ~= getgenv().CustomWalkSpeed then
                player.Character.Humanoid.WalkSpeed = getgenv().CustomWalkSpeed
            end
        end
    end)
end

local function stopApplyingSpeed()
    if walkspeedConnection then
        walkspeedConnection:Disconnect()
        walkspeedConnection = nil
    end
    resetToDefaultWalkspeed()
end

player.CharacterAdded:Connect(function(character)
    character:WaitForChild("Humanoid")
    if getgenv().WalkSpeedEnabled then
        wait(1) 
        applyCustomWalkspeed()
    end
end)

local function CreateESP(zombie)
    if not zombie or not zombie:FindFirstChild("HumanoidRootPart") then
        return
    end
    
    local humanoidRootPart = zombie.HumanoidRootPart
    
    local billboardGui = Instance.new("BillboardGui")
    billboardGui.Name = "EntityESP"
    billboardGui.Adornee = humanoidRootPart
    billboardGui.Size = UDim2.new(0, 75, 0, 17)
    billboardGui.StudsOffset = Vector3.new(0, 2, 0)
    billboardGui.AlwaysOnTop = true
    billboardGui.Parent = humanoidRootPart
    
    local nameTag = Instance.new("TextLabel")
    nameTag.Name = "NameTag"
    nameTag.Size = UDim2.new(1, 0, 1, 0)
    nameTag.BackgroundTransparency = 1
    nameTag.Text = "Entities"
    nameTag.TextColor3 = Color3.new(0.1, 0, 0)
    nameTag.TextScaled = true
    nameTag.Font = Enum.Font.Code
    nameTag.TextStrokeTransparency = 0
    nameTag.TextStrokeColor3 = Color3.new(1, 0, 0)
    nameTag.Parent = billboardGui
    
    local highlight = Instance.new("Highlight")
    highlight.Name = "EntityHighlight"
    highlight.FillColor = Color3.new(1, 0, 0)
    highlight.OutlineColor = Color3.new(1, 0, 0)
    highlight.FillTransparency = 0.5
    highlight.OutlineTransparency = 0
    highlight.Parent = zombie
    
    activeESPs[zombie] = {
        billboard = billboardGui,
        highlight = highlight,
        nameTag = nameTag
    }
end

local function RemoveESP(zombie)
    if activeESPs[zombie] then
        if activeESPs[zombie].billboard then
            activeESPs[zombie].billboard:Destroy()
        end
        if activeESPs[zombie].highlight then
            activeESPs[zombie].highlight:Destroy()
        end
        activeESPs[zombie] = nil
    end
end

local function EnableESP()
    local entitiesFolder = workspace.Entities.Zombie
    if not entitiesFolder then
        warn("Entities.Zombie folder not found!")
        return
    end
    
    for _, zombie in pairs(entitiesFolder:GetChildren()) do
        if zombie:FindFirstChild("HumanoidRootPart") then
            CreateESP(zombie)
        end
    end
    
    if entitiesConnection then
        entitiesConnection:Disconnect()
    end
    
    entitiesConnection = entitiesFolder.ChildAdded:Connect(function(newZombie)
        wait(0.1)
        if newZombie:FindFirstChild("HumanoidRootPart") then
            CreateESP(newZombie)
        end
    end)
end

local function DisableESP()
    for zombie, _ in pairs(activeESPs) do
        RemoveESP(zombie)
    end
    
    if entitiesConnection then
        entitiesConnection:Disconnect()
        entitiesConnection = nil
    end
end

local function createESPHighlight(player)
    local highlight = Instance.new("Highlight")
    highlight.Name = "PlayerESP"
    highlight.Adornee = nil
    highlight.FillColor = Color3.fromRGB(255, 255, 255)
    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
    highlight.FillTransparency = 0.7
    highlight.OutlineTransparency = 0.5
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "ESPNameTag"
    billboard.Size = UDim2.new(0, 70, 0, 20)
    billboard.StudsOffset = Vector3.new(0, 3, 0)
    billboard.Adornee = nil
    
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(1, 0, 1, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = player.Name
    nameLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
    nameLabel.TextScaled = true
    nameLabel.TextStrokeTransparency = 0
    nameLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    nameLabel.Font = Enum.Font.Code
    nameLabel.Parent = billboard
    
    return {
        Highlight = highlight,
        Billboard = billboard,
        Player = player
    }
end

local function updateESP()
    for _, espObject in pairs(ESPObjects) do
        local player = espObject.Player
        local character = player.Character
        
        if character and character:FindFirstChild("HumanoidRootPart") and character:FindFirstChild("Head") then
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            
            if humanoid and humanoid.Health > 0 then
                espObject.Highlight.Adornee = character
                espObject.Billboard.Adornee = character.Head
                espObject.Highlight.Parent = character
                espObject.Billboard.Parent = character.Head
            else
                espObject.Highlight.Adornee = nil
                espObject.Billboard.Adornee = nil
                espObject.Highlight.Parent = nil
                espObject.Billboard.Parent = nil
            end
        else
            espObject.Highlight.Adornee = nil
            espObject.Billboard.Adornee = nil
            espObject.Highlight.Parent = nil
            espObject.Billboard.Parent = nil
        end
    end
end

local function addPlayerESP(player)
    if player == LocalPlayer then return end
    
    local espObject = createESPHighlight(player)
    ESPObjects[player] = espObject
end

local function removePlayerESP(player)
    local espObject = ESPObjects[player]
    if espObject then
        espObject.Highlight:Destroy()
        espObject.Billboard:Destroy()
        ESPObjects[player] = nil
    end
end

local function enableESP()
    if not ESPEnabled then
        ESPEnabled = true
        
        for _, player in pairs(Players:GetPlayers()) do
            addPlayerESP(player)
        end
        
        ESPConnection = RunService.Heartbeat:Connect(updateESP)
        PlayerAddedConnection = Players.PlayerAdded:Connect(addPlayerESP)
        PlayerRemovingConnection = Players.PlayerRemoving:Connect(removePlayerESP)
    end
end

local function disableESP()
    if ESPEnabled then
        ESPEnabled = false
        
        for player, _ in pairs(ESPObjects) do
            removePlayerESP(player)
        end
        
        if ESPConnection then
            ESPConnection:Disconnect()
        end
        if PlayerAddedConnection then
            PlayerAddedConnection:Disconnect()
        end
        if PlayerRemovingConnection then
            PlayerRemovingConnection:Disconnect()
        end
    end
end

Players.PlayerAdded:Connect(function(player)
    if ESPEnabled then
        addPlayerESP(player)
    end
end)

Players.PlayerRemoving:Connect(function(player)
    removePlayerESP(player)
end)

local function RedeemFuckingCoding()
    local args = {"300KLIKES"}
    game:GetService("ReplicatedStorage"):WaitForChild("Packets"):WaitForChild("RedeemCode"):InvokeServer(unpack(args))
end

local function RedeemFuckingCoding2()
    local args = {"WDEV1"}
    game:GetService("ReplicatedStorage"):WaitForChild("Packets"):WaitForChild("RedeemCode"):InvokeServer(unpack(args))
end

local function RedeemFuckingCoding3()
    local args = {"WDEV2"}
    game:GetService("ReplicatedStorage"):WaitForChild("Packets"):WaitForChild("RedeemCode"):InvokeServer(unpack(args))
end

local function RedeemFuckingCoding4()
    local args = {"100KLIKES"}
    game:GetService("ReplicatedStorage"):WaitForChild("Packets"):WaitForChild("RedeemCode"):InvokeServer(unpack(args))
end

local function RedeemFuckingCoding5()
    local args = {"70KLIKES"}
    game:GetService("ReplicatedStorage"):WaitForChild("Packets"):WaitForChild("RedeemCode"):InvokeServer(unpack(args))
end

local function RedeemFuckingCoding6()
    local args = {"6OKLIKES"}
    game:GetService("ReplicatedStorage"):WaitForChild("Packets"):WaitForChild("RedeemCode"):InvokeServer(unpack(args))
end

local function RedeemFuckingCoding7()
    local args = {"20KIN"}
    game:GetService("ReplicatedStorage"):WaitForChild("Packets"):WaitForChild("RedeemCode"):InvokeServer(unpack(args))
end

local function RedeemFuckingCoding8()
    local args = {"sorryfordelay"}
    game:GetService("ReplicatedStorage"):WaitForChild("Packets"):WaitForChild("RedeemCode"):InvokeServer(unpack(args))
end

local function RedeemFuckingCoding9()
    local args = {"50KLIKES"}
    game:GetService("ReplicatedStorage"):WaitForChild("Packets"):WaitForChild("RedeemCode"):InvokeServer(unpack(args))
end

local function RedeemFuckingCoding10()
    local args = {"100KMEMBERS"}
    game:GetService("ReplicatedStorage"):WaitForChild("Packets"):WaitForChild("RedeemCode"):InvokeServer(unpack(args))
end

local function RedeemFuckingCoding11()
    local args = {"40KLIKES"}
    game:GetService("ReplicatedStorage"):WaitForChild("Packets"):WaitForChild("RedeemCode"):InvokeServer(unpack(args))
end

local function RedeemFuckingCoding12()
    local args = {"30KLIKES"}
    game:GetService("ReplicatedStorage"):WaitForChild("Packets"):WaitForChild("RedeemCode"):InvokeServer(unpack(args))
end

local function RedeemFuckingCoding13()
    local args = {"20KLIKES"}
    game:GetService("ReplicatedStorage"):WaitForChild("Packets"):WaitForChild("RedeemCode"):InvokeServer(unpack(args))
end

local function RedeemFuckingCoding14()
    local args = {"10KLIKES"}
    game:GetService("ReplicatedStorage"):WaitForChild("Packets"):WaitForChild("RedeemCode"):InvokeServer(unpack(args))
end

local function RedeemFuckingCoding15()
    local args = {"Release2"}
    game:GetService("ReplicatedStorage"):WaitForChild("Packets"):WaitForChild("RedeemCode"):InvokeServer(unpack(args))
end

local function RedeemFuckingCoding16()
    local args = {"Release"}
    game:GetService("ReplicatedStorage"):WaitForChild("Packets"):WaitForChild("RedeemCode"):InvokeServer(unpack(args))
end

local function RedeemFuckingCoding17()
    local args = {"10KEVENT"}
    game:GetService("ReplicatedStorage"):WaitForChild("Packets"):WaitForChild("RedeemCode"):InvokeServer(unpack(args))
end

local function RedeemFuckingCoding18()
    local args = {"Sorryhaha"}
    game:GetService("ReplicatedStorage"):WaitForChild("Packets"):WaitForChild("RedeemCode"):InvokeServer(unpack(args))
end

local function RedeemFuckingCoding19()
    local args = {"ISCODEWORKING"}
    game:GetService("ReplicatedStorage"):WaitForChild("Packets"):WaitForChild("RedeemCode"):InvokeServer(unpack(args))
end

local function RedeemFuckingCoding20()
    local args = {"LOVEYOU"}
    game:GetService("ReplicatedStorage"):WaitForChild("Packets"):WaitForChild("RedeemCode"):InvokeServer(unpack(args))
end

local function RedeemAllFuckingCodes()
    RedeemFuckingCoding()
    wait(0.1)
    RedeemFuckingCoding2()
    wait(0.1)
    RedeemFuckingCoding3()
    wait(0.1)
    RedeemFuckingCoding4()
    wait(0.1)
    RedeemFuckingCoding5()
    wait(0.1)
    RedeemFuckingCoding6()
    wait(0.1)
    RedeemFuckingCoding7()
    wait(0.1)
    RedeemFuckingCoding8()
    wait(0.1)
    RedeemFuckingCoding9()
    wait(0.1)
    RedeemFuckingCoding10()
    wait(0.1)
    RedeemFuckingCoding11()
    wait(0.1)
    RedeemFuckingCoding12()
    wait(0.1)
    RedeemFuckingCoding13()
    wait(0.1)
    RedeemFuckingCoding14()
    wait(0.1)
    RedeemFuckingCoding15()
    wait(0.1)
    RedeemFuckingCoding16()
    wait(0.1)
    RedeemFuckingCoding17()
    wait(0.1)
    RedeemFuckingCoding18()
    wait(0.1)
    RedeemFuckingCoding19()
    wait(0.1)
    RedeemFuckingCoding20()
end

local function TpToEveryEntities()
    if not AutoFightEnabled then
        return
    end
    
    if not workspace:FindFirstChild("Entities") then
        return
    end
    
    if not workspace.Entities:FindFirstChild("Zombie") then
        return
    end
    
    local zombieFolder = workspace.Entities.Zombie
    local zombieChildren = zombieFolder:GetChildren()
    
    if #zombieChildren == 0 then
        currentIndex = 1
        return
    end
    
    if currentIndex > #zombieChildren then
        currentIndex = 1
    end
    
    local currentZombie = zombieChildren[currentIndex]
    
    if currentZombie and currentZombie:FindFirstChild("Head") then
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local zombieHead = currentZombie.Head
            local playerRoot = LocalPlayer.Character.HumanoidRootPart
            
            local offset = zombieHead.CFrame.LookVector * -2 
            local newPosition = zombieHead.Position + offset + Vector3.new(0, 2, 0) 
            
            local newCFrame = CFrame.lookAt(newPosition, zombieHead.Position)
            
            playerRoot.CFrame = newCFrame
        end
    end
    
    currentIndex = currentIndex + 1
end

local function StartAutoFight()
    if AutoFightEnabled then
    return
    end
    
    AutoFightEnabled = true
    currentIndex = 1
    
    AutoFightConnection = task.spawn(function()
        while AutoFightEnabled do
            TpToEveryEntities()
            task.wait(0.5) 
        end
    end)
    
    HitAuraConnection = task.spawn(function()
        while AutoFightEnabled do
            FuckingHitAura2()
            task.wait(0.1)
        end
    end)
end

local function StopAutoFight()
    if not AutoFightEnabled then 
    return
    end
    
    AutoFightEnabled = false
    
    if AutoFightConnection then
        task.cancel(AutoFightConnection)
        AutoFightConnection = nil
    end
    
    if HitAuraConnection then
        task.cancel(HitAuraConnection)
        HitAuraConnection = nil
    end
end

local function BringAllHumanoidRootParts()
    if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        return
    end
    
    local playerPosition = LocalPlayer.Character.HumanoidRootPart.Position
    
    if workspace:FindFirstChild("Entities") and workspace.Entities:FindFirstChild("Zombie") then
        local zombieFolder = workspace.Entities.Zombie
        for _, zombie in pairs(zombieFolder:GetChildren()) do
            if zombie:FindFirstChild("HumanoidRootPart") then
                zombie.HumanoidRootPart.CFrame = CFrame.new(playerPosition + Vector3.new(math.random(-2, 3), 0, math.random(-5, 5)))
            end
        end
    end
    
    for _, obj in pairs(workspace:GetChildren()) do
        if obj:IsA("Model") and obj ~= LocalPlayer.Character then
            if obj:FindFirstChild("HumanoidRootPart") and obj:FindFirstChild("Humanoid") then
                if not game.Players:GetPlayerFromCharacter(obj) then
                    obj.HumanoidRootPart.CFrame = CFrame.new(playerPosition + Vector3.new(math.random(-5, 5), 0, math.random(-5, 5)))
                end
            end
        end
    end
end

local function StartBringAll()
    if bringConnection then
        bringConnection:Disconnect()
    end
    
    BringAllEnabled = true
    bringConnection = game:GetService("RunService").Heartbeat:Connect(function()
        if BringAllEnabled then
            BringAllHumanoidRootParts()
        end
    end)
end

local function StopBringAll()
    BringAllEnabled = false
    if bringConnection then
        bringConnection:Disconnect()
        bringConnection = nil
    end
end

local function SavePlayerPosition()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        savedPosition = LocalPlayer.Character.HumanoidRootPart.CFrame
    end
end

local function LoadPlayerPosition()
    if savedPosition and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        LocalPlayer.Character.HumanoidRootPart.CFrame = savedPosition
    end
end

local function TpToRadio()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        LocalPlayer.Character.HumanoidRootPart.CFrame = RadioPos
    end
end

local function TriggerRadioPrompt() 
    fireproximityprompt(workspace.School.Rooms.RooftopBoss.RadioObjective.ProximityPrompt)
end

local function AutoRadio() 
    SavePlayerPosition()
    wait(0.5)
    TpToRadio() 
    wait(0.5)
    TriggerRadioPrompt() 
    wait(0.1)
    LoadPlayerPosition()
end

local function FireRemote()
    local args = {
        buffer.fromstring("\b\006\000")
    }
    game:GetService("ReplicatedStorage"):WaitForChild("ByteNetReliable"):FireServer(unpack(args))
end

local function StartLoop()
    if loopConnection then
        loopConnection:Disconnect()
    end
    
    loopEnabled = true
    loopConnection = game:GetService("RunService").Heartbeat:Connect(function()
        if loopEnabled then
            FireRemote()
        end
    end)
end

local function StopLoop()
    loopEnabled = false
    if loopConnection then
        loopConnection:Disconnect()
        loopConnection = nil
    end
end

local function FireRemote2()
    local args = {
        buffer.fromstring("\b\005\000")
    }
    game:GetService("ReplicatedStorage"):WaitForChild("ByteNetReliable"):FireServer(unpack(args))
end

local function StartLoop2()
    if loopConnection2 then
        loopConnection2:Disconnect()
    end
    
    loopEnabled2 = true
    loopConnection2 = game:GetService("RunService").Heartbeat:Connect(function()
        if loopEnabled2 then
            FireRemote2()
        end
    end)
end

local function StopLoop2()
    loopEnabled2 = false
    if loopConnection2 then
        loopConnection2:Disconnect()
        loopConnection2 = nil
    end
end

local function FireRemote3()
    local args = {
        buffer.fromstring("\b\003\000")
    }
    game:GetService("ReplicatedStorage"):WaitForChild("ByteNetReliable"):FireServer(unpack(args))
end

local function StartLoop3()
    if loopConnection3 then
        loopConnection3:Disconnect()
    end
    
    loopEnabled3 = true
    loopConnection3 = game:GetService("RunService").Heartbeat:Connect(function()
        if loopEnabled3 then
            FireRemote3()
        end
    end)
end

local function StopLoop3()
    loopEnabled3 = false
    if loopConnection3 then
        loopConnection3:Disconnect()
        loopConnection3 = nil
    end
end

local function TeleportToAllDropItems()
    if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        return
    end
    
    local dropItemsFolder = workspace:FindFirstChild("DropItems")
    if not dropItemsFolder then
        return
    end
    
    local items = dropItemsFolder:GetChildren()
    if #items == 0 then
        return
    end
    
    local playerRoot = LocalPlayer.Character.HumanoidRootPart
    local itemCount = 0
    
    for _, item in pairs(items) do
        if item:IsA("BasePart") then
            playerRoot.CFrame = CFrame.new(item.Position + Vector3.new(0, 5, 0))
            itemCount = itemCount + 1
            wait(0.5) 
        elseif item:IsA("Model") and item:FindFirstChild("HumanoidRootPart") then
            playerRoot.CFrame = CFrame.new(item.HumanoidRootPart.Position + Vector3.new(0, 5, 0))
            itemCount = itemCount + 1
            wait(0.5)
        elseif item:IsA("Model") then
            local part = item:FindFirstChildWhichIsA("BasePart")
            if part then
                playerRoot.CFrame = CFrame.new(part.Position + Vector3.new(0, 5, 0))
                itemCount = itemCount + 1
                wait(0.5)
            end
        end
    end
   
end

-- =================thisIsWhere all Now=================

-- ==================Stop============================
Tabs.PlayerMisc:Toggle({
    Title = "Enable Fly",
    Value = false,
    Callback = function(state)
        flyToggle = state
        if flyToggle then
            if UserInputService.TouchEnabled then
                MobileFly()
            else
                sFLY()
            end
        else
            NOFLY()
            UnMobileFly()
        end
    end
})

Tabs.PlayerMisc:Slider({
    Title = "Fly Speed",
    Value = { Min = 1, Max = 20, Default = 1 },
    Callback = function(value)
        flySpeed = value
        if FLYING then
            task.spawn(function()
                while FLYING do
                    task.wait(0.1)
                    if UserInputService.TouchEnabled then
                        local root = Players.LocalPlayer.Character and Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                        if root and root:FindFirstChild("BodyVelocity") then
                            local bv = root:FindFirstChild("BodyVelocity")
                            bv.Velocity = bv.Velocity.Unit * (flySpeed * 50) 
                        end
                    end
                end
            end)
        end
    end
})

Tabs.PlayerMisc:Toggle({
    Title = "Enable WalkSpeed",
    Desc = "",
    Icon = "zap",
    Type = "Toggle",
    Default = getgenv().WalkSpeedEnabled,
    Callback = function(state) 
        getgenv().WalkSpeedEnabled = state
        
        if state then
            startApplyingSpeed()
            WindUI:Notify({
                Title = "WalkSpeed Enabled",
                Content = "",
                Duration = 1.5,
                Icon = "check"
            })
        else
            stopApplyingSpeed()
        end
    end
})

Tabs.PlayerMisc:Slider({
    Title = "WalkSpeed",
    Desc = "",
    Step = 1,
    Value = {
        Min = 1,
        Max = 100,
        Default = getgenv().CustomWalkSpeed,
    },
    Callback = function(value)
        getgenv().CustomWalkSpeed = value
        
        if getgenv().WalkSpeedEnabled then
            applyCustomWalkspeed()
        end
    end
})

Tabs.PlayerMisc:Toggle({
    Title = "Noclip",
    Value = false,
    Callback = function(state)
        if state then
            noclipConnection = RunService.Stepped:Connect(function()
                local char = Players.LocalPlayer.Character
                if char then
                    for _, part in ipairs(char:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = false
                        end
                    end
                end
            end)
        else
            if noclipConnection then
                noclipConnection:Disconnect()
                noclipConnection = nil
            end
        end
    end
})

local CombatSection = CombatTab:Section({ 
    Title = "Combat",
    TextXAlignment = "Left",
    TextSize = 20, 
})

CombatTab:Toggle({
    Title = "HitAura",
    Description = "",
    Default = false,
    Callback = function(value)
        hitAuraEnabled = value
        
        if hitAuraEnabled then
            hitAuraConnection = game:GetService("RunService").Heartbeat:Connect(function()
                if hitAuraEnabled then
                   FuckingHitAura()
                end
            end)
            
            WindUI:Notify({
                Title = "HitAura",
                Content = "HitAura enabled!",
                Duration = 3
            })
        else
            if hitAuraConnection then
                hitAuraConnection:Disconnect()
                hitAuraConnection = nil
            end
        end
    end
})

CombatTab:Toggle({
    Title = "Loop Bring All",
    Description = "",
    Default = false,
    Callback = function(enabled)
        if enabled then
            StartBringAll()
            startLoop() 
            WindUI:Notify({
                Title = "LoopBring all",
                Content = "Loop Bring All Enabled",
                Duration = 2,
                Icon = "check"
            })
        else
            StopBringAll()
        end
    end,
})

CombatTab:Button({
    Title = "Collect All DropItems",
    Description = "",
    Callback = function()
        TeleportToAllDropItems()
    end,
})

CombatTab:Button({
    Title = "AutoRadio",
    Description = "",
    Callback = function()
        AutoRadio() 
    end,
})

local CombatSection = CombatTab:Section({ 
    Title = "Auto",
    TextXAlignment = "Left",
    TextSize = 20, 
})

CombatTab:Toggle({
    Title = "AutoFight",
    Description = "",
    Default = false,
    Callback = function(enabled)
        if enabled then
            StartAutoFight()
            WindUI:Notify({
                Title = "AutoFight",
                Content = "AutoFight Enabled",
                Duration = 2,
                Icon = "check"
            })
        else
            StopAutoFight() 
        end
    end,
})

CombatTab:Toggle({
    Title = "AutoUse Skill 3",
    Description = "",
    Default = false,
    Callback = function(enabled)
        if enabled then
            StartLoop()
            WindUI:Notify({
                Title = "AutoSkill 3",
                Content = "AutoSkill 3 Enabled",
                Duration = 2,
                Icon = "check"
            })
        else
            StopLoop()
        end
    end,
})

CombatTab:Toggle({
    Title = "AutoUse Skill 2",
    Description = "",
    Default = false,
    Callback = function(enabled)
        if enabled then
            StartLoop2()
            WindUI:Notify({
                Title = "AutoSkill 2",
                Content = "AutoSkill 2Enabled",
                Duration = 2,
                Icon = "check"
            })
        else
            StopLoop2()
        end
    end,
})

CombatTab:Toggle({
    Title = "AutoUse Skill 1",
    Description = "",
    Default = false,
    Callback = function(enabled)
        if enabled then
            StartLoop3()
            WindUI:Notify({
                Title = "AutoSkill 1",
                Content = "AutoSkill 1 Enabled",
                Duration = 2,
                Icon = "check"
            })
        else
            StopLoop3()
        end
    end,
})


EspTab:Section({ 
    Title = "Entities",
    TextXAlignment = "Left",
    TextSize = 20, 
})

EspTab:Toggle({
    Title = "Esp Enteties",
    Desc = "",
    Icon = "zap",
    Type = "Toggle",
    Default = false,
    Callback = function(state)
        if state then
            EnableESP()
            WindUI:Notify({
                Title = "Esp ",
                Content = "Esp Enabled",
                Duration = 2,
                Icon = "check"
            })
        else
            DisableESP()
        end
    end
})

local EspSection = EspTab:Section({ 
    Title = "Players",
    TextXAlignment = "Left",
    TextSize = 20, 
})

EspTab:Toggle({
    Title = "Esp Players",
    Desc = "",
    Icon = "zap",
    Type = "Toggle",
    Default = false,
    Callback = function(enabled)
        if enabled then
            enableESP()
        else
            DisableESP()
        end
    end
})

CodesTab:Section({ 
    Title = "Codes",
    TextXAlignment = "Left",
    TextSize = 20, 
})

CodesTab:Paragraph({
    Title = "Expired",
    Desc = "Hugecode WDEV1 WDEV2 100KLIKES 70KLIKES 6OKLIKES 20KIN sorryfordelay 50KLIKES 100KMEMBERS 40KLIKES 30KLIKES 20KLIKES 10KLIKES Release2 Release10KEVENT Sorryhaha Press Redeem all button to  Get",
    Locked = false,
    Buttons = {
        {
            Icon = "zap",
            Title = "Redeem All Codes",
            Callback = function() RedeemAllFuckingCodes() end,
        }
    }
}) 

CodesTab:Paragraph({
    Title = "ELV",
    Desc = "if they not working its expired dont worry ill change it everytime they released an new code",
    Locked = false,
    })
