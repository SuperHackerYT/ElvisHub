if not game:IsLoaded() then
    game.Loaded:Wait()
end

local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

local Confirmed = false
WindUI:Popup({
    Title = "Elvis Hub | Build A Plane",
    Icon = "zap",
    IconThemed = true,
    Content = "Elvis Hub - A keyless hub you been looking for! (Please wait 3 - 5 seconds as the UI loading)",
    Buttons = {
        { Title = "Exit", Variant = "Secondary", Callback = function() game.Players.LocalPlayer:Kick("Why did you click Exit? <=3") end, },
        { Title = "Continue", Icon = "arrow-right", Callback = function() Confirmed = true end, Variant = "Primary" }
    }
})
repeat task.wait() until Confirmed

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
    Title = "Build a Plane",
    Icon = "zap", 
    Author = "Elvis",
    Folder = "Elvis Hub",
    Size = UDim2.fromOffset(500, 350),
    Transparent = getgenv().TransparencyEnabled,
    Theme = "Midnight Blue",
    Resizable = true,
    SideBarWidth = 150,
    BackgroundImageTransparency = 0.8,
    HideSearchBar = true,
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
                Duration = 2,
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
            
            WindUI:Notify({
                Title = "Transparency", 
                Content = "Transparency disabled",
                Duration = 3,
                Icon = "eye"
            })
            print("Transparency = false")
        else
            getgenv().TransparencyEnabled = true
            pcall(function() Window:ToggleTransparency(true) end)
            
            WindUI:Notify({
                Title = "Transparency",
                Content = "Transparency enabled", 
                Duration = 3,
                Icon = "eye-off"
            })
            print(" Transparency = true")
        end
        
        warn("Transparency state:", getgenv().TransparencyEnabled)
    end, 990)
end)

pcall(function()
    Window:EditOpenButton({
        Title = "Build a Plane",
        Icon = "zap",
        CornerRadius = UDim.new(0, 16),
        StrokeThickness = 2,
        Color = ColorSequence.new(
            Color3.fromHex("87E0FF"), 
            Color3.fromHex("60EFFF")
        ),
        OnlyMobile = false,
        Enabled = true,
        Draggable = true,
    })
end)

task.wait(5)
WindUI:Notify({
                Title = "Info", 
                Content = "Made By Elvis. Subscribe to Elvis Gaming. @elvisgamingroblox on YouTube. ",
                Duration = 15,
                Icon = "badge-info"
            })

-- Tabs
local MainTab = Window:Tab({ Title = "Auto", Icon = "arrow-right-left" })
local ShopTab = Window:Tab({ Title = "Shop", Icon = "shopping-cart" })
local PlayerTab = Window:Tab({ Title = "Plane", Icon = "plane" })
local MiscTab = Window:Tab({ Title = "Misc", Icon = "file-cog" })

Window:SelectTab(1)

-- =======================
-- VARIABLES
-- =======================

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TeleportService = game:GetService("TeleportService")
local VirtualUser = game:GetService("VirtualUser")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local Terrain = workspace.Terrain

local lp = Players.LocalPlayer

local baseSpeed = 50

local boostedSeats = {}
local boostLoopActive = false

local autoStartRunning = false
local autoFarmRunning = false 
local autoFarmRunning2 = false 
local autoFarmRunning3 = false

local farmPositions = {
    ["100k"] = CFrame.new(90000, 100, 90000),
    ["infinite"] = CFrame.new(100000, 100, 100000),
    ["10m"] = CFrame.new(700000, 100, 700000),
}

local initialCFrame = nil

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local localPlayer = Players.LocalPlayer

local PlaneGodMode = false
local godModeConnection = nil
local lastPlane = nil
local originalCanCollideStates = {}

local LocalPlayer = Players.LocalPlayer

-- =======================
-- FUNCTIONS
-- =======================

local function getRainbowColor(t)
    local f = 2
    local r = math.floor(math.sin(f * t + 0) * 127 + 128)
    local g = math.floor(math.sin(f * t + 2) * 127 + 128)
    local b = math.floor(math.sin(f * t + 4) * 127 + 128)
    return Color3.fromRGB(r, g, b)
end

local function smoothTeleport(hrp, targetCFrame, duration)
    if not hrp then return end
    duration = duration or 3
    local startPos = hrp.Position
    local endPos = targetCFrame.Position
    local startTime = os.clock()
    local endTime = startTime + duration

    while os.clock() < endTime do
        local now = os.clock()
        local alpha = math.clamp((now - startTime) / duration, 0, 1)
        local newPos = startPos:Lerp(endPos, alpha)
        hrp.CFrame = CFrame.new(newPos)
        task.wait()
    end
    hrp.CFrame = targetCFrame
end

local function storeInitialCFrame()
    if initialCFrame then return end
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if hrp then
        initialCFrame = hrp.CFrame
        print("[Elvis] Initial position saved.")
    else
        warn("[Elvis] Cannot save initial position: HumanoidRootPart not found.")
    end
end

local function teleportBack()
    if not initialCFrame then return end
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if hrp then
        hrp.CFrame = initialCFrame
    end
end

-- Trash
local function createFarmGui(name, titleText)
    local gui = Instance.new("ScreenGui", game.CoreGui)
    gui.Name = name
    gui.ResetOnSpawn = false
    gui.IgnoreGuiInset = true

    local black = Instance.new("Frame", gui)
    black.Size = UDim2.new(1, 0, 1, 0)
    black.BackgroundColor3 = Color3.new(0, 0, 0)
    black.BackgroundTransparency = 0.4

    local mainFrame = Instance.new("Frame", gui)
    mainFrame.Name = "mainFrame"
    mainFrame.Size = UDim2.new(0.4, 0, 0.2, 0)
    mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    mainFrame.BackgroundTransparency = 1

    local title = Instance.new("TextLabel", mainFrame)
    title.Size = UDim2.new(0.8, 0, 0.3, 0)
    title.Position = UDim2.new(0.5, 0, 0.1, 0)
    title.AnchorPoint = Vector2.new(0.5, 0)
    title.BackgroundTransparency = 1
    title.Text = titleText
    title.TextColor3 = Color3.new(1, 1, 1)
    title.TextScaled = true
    title.Font = Enum.Font.SourceSansBold

    RunService.RenderStepped:Connect(function()
        title.TextColor3 = getRainbowColor(tick())
    end)

    local bondCount = Instance.new("TextLabel", mainFrame)
    bondCount.Name = name .. "Count"
    bondCount.Size = UDim2.new(0.6, 0, 0.2, 0)
    bondCount.Position = UDim2.new(0.5, 0, 0.6, 0)
    bondCount.AnchorPoint = Vector2.new(0.5, 0)
    bondCount.BackgroundTransparency = 1
    bondCount.Text = "Distance: 0"
    bondCount.TextColor3 = Color3.new(1, 1, 1)
    bondCount.TextScaled = true
    bondCount.Font = Enum.Font.SourceSans

    Instance.new("BlurEffect", game:GetService("Lighting")).Size = 12

    return gui
end

-- fly
local flyToggle = false
local flySpeed = 1
local FLYING = false
local flyKeyDown, flyKeyUp, mfly1, mfly2
local IYMouse = game:GetService("UserInputService")

local function sFLY()
    repeat task.wait() until Players.LocalPlayer and Players.LocalPlayer.Character and Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart") and Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    repeat task.wait() until IYMouse
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
    flyKeyDown = IYMouse.InputBegan:Connect(function(input)
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
    flyKeyUp = IYMouse.InputEnded:Connect(function(input)
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

-- Fly mobile
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

    mfly2 = game:GetService("RunService").RenderStepped:Connect(function()
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

local function getplot()
local plots = workspace.Islands
for i, plot in plots:GetChildren() do
if plot.Important.OwnerID.Value == game.Players.LocalPlayer.UserId then
return plot
end
end
end
local plot = getplot()
repeat task.wait(0.1) until plot:FindFirstChild("SpawnPart")

local godModeEnabled = false
local godModeConnection

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

if not _G.AXS then _G.AXS = {
autofarm = false,
moon = false,
x = 17000,  
y = 500,  
endpos = 1000000, 
} end

local autofarming = false
local automooning = false

local function abs(num)
if num ~= 0 then
return -num
end
return num
end

local function getplot()
local plots = workspace.Islands
for i, plot in plots:GetChildren() do
if plot.Important.OwnerID.Value == game.Players.LocalPlayer.UserId then
return plot
end
end
end

local function alive()
if game.Players.LocalPlayer.Character then
if game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid").Health > 0 then
return true
end
end 
end
return false
end

local function char()
if game.Players.LocalPlayer.Character then
if game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid").Health > 0 then
return game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
end
end 
end
return nil
end

local function plane()
local plot = getplot()
local x = (plot.PlacedBlocks:FindFirstChild("driver_seat_1") or plot.PlacedBlocks:FindFirstChild("driver_seat_2") or plot.PlacedBlocks:FindFirstChild("driver_seat_3") or plot.PlacedBlocks:FindFirstChild("driver_seat_4")) or nil
if x == nil then 
return false
elseif x:FindFirstChild("Hitbox") and x:FindFirstChildOfClass("VehicleSeat") then
if x:FindFirstChildOfClass("VehicleSeat"):FindFirstChild("BodyGyro") then
return true
end
end
return false
end


local plot = getplot()
repeat task.wait(0.1) until plot:FindFirstChild("SpawnPart")
local noclipEnabled = false
local noclipConnection

local playerNoclipConnection = nil

-- =======================
-- MAIN TAB
-- =======================

MainTab:Toggle({
    Title = "Auto Launch",
    Icon = "badge-dollar-sign",
    Default = false,
    Callback = function(state)
        autoStartRunning = state
        if state then
            task.spawn(function()
                while autoStartRunning do
                    local launch = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("LaunchEvents"):WaitForChild("Launch")
                    launch:FireServer()
                    task.wait(3)
                end
            end)
        else
            print("Auto Start stopped.")
        end
    end
})

MainTab:Toggle({
    Title = "Auto Claim Offline rewards",
    Icon = "badge-dollar-sign",
    Default = false,
    Callback = function(state)
        autoClaimRunning = state
        if state then
            task.spawn(function()
                while autoClaimRunning do
                    local claim = game:GetService("ReplicatedStorage")
                        :WaitForChild("Remotes")
                        :WaitForChild("RewardEvents")
                        :WaitForChild("ClaimOffline")

                    claim:InvokeServer()
                    task.wait(3)
                end
            end)
        else
        end
    end
})

local AutoFarmToggle = MainTab:Toggle({
    Title = "AutoFarm",
    Icon = "badge-dollar-sign",
    Default = false,
    Callback = function(state)
        _G.AXS.autofarm = state

        if state then
            task.spawn(function()
                local plot = getplot()
                repeat task.wait(0.1) until plot:FindFirstChild("SpawnPart")

                local spawnpart = plot:FindFirstChild("SpawnPart")
                local spawnpartpos = spawnpart.Position
                local spawnpartcfr = spawnpart.CFrame

                while _G.AXS.autofarm and task.wait(0.1) do
                    if ((not game:GetService("ReplicatedStorage").ActiveEvents.BloodMoonActive.Value and _G.AXS.moon) or not _G.AXS.moon) then
                        repeat task.wait(0.1) until not automooning

                        autofarming = true

                        local aplane = plot.PlacedBlocks
                        local driver = (aplane:FindFirstChild("driver_seat_1")
                            or aplane:FindFirstChild("driver_seat_2")
                            or aplane:FindFirstChild("driver_seat_3"))

                        local launched = plot.Important.Launched
                        local x, z = spawnpartpos.X, spawnpartpos.Z

                        if not alive() then
                            repeat task.wait(0.1) until alive()
                        end

                        if driver == nil then
                            repeat
                                task.wait(1)
                            until (aplane:FindFirstChild("driver_seat_1")
                                or aplane:FindFirstChild("driver_seat_2")
                                or aplane:FindFirstChild("driver_seat_3")) ~= nil
                                or not _G.AXS.autofarm

                            driver = (aplane:FindFirstChild("driver_seat_1")
                                or aplane:FindFirstChild("driver_seat_2")
                                or aplane:FindFirstChild("driver_seat_3"))
                        end

                        if not driver:FindFirstChild("Hitbox") then
                            repeat task.wait(0.05) until driver:FindFirstChild("Hitbox") or not _G.AXS.autofarm
                        end

                        repeat
                            if not launched.Value and alive() then
                                game:GetService("ReplicatedStorage")
                                    :WaitForChild("Remotes")
                                    :WaitForChild("LaunchEvents")
                                    :WaitForChild("Launch")
                                    :FireServer()
                            end
                            task.wait(1)
                        until launched.Value or not _G.AXS.autofarm

                        task.wait(0.35)
                        local abc = true

                        while launched.Value
                            and _G.AXS.autofarm
                            and (plane() and alive())
                            and abc
                            and ((not game:GetService("ReplicatedStorage").ActiveEvents.BloodMoonActive.Value and _G.AXS.moon) or not _G.AXS.moon) do

                            if plane() and alive() then
                                local target = driver:FindFirstChild("Hitbox")
                                    or game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

                                target.CFrame = CFrame.new(
                                    Vector3.new(
                                        target.Position.X + (_G.AXS.x / 100),
                                        _G.AXS.y,
                                        z
                                    ),
                                    Vector3.new(
                                        target.Position.X + ((_G.AXS.x + 10) / 100),
                                        _G.AXS.y,
                                        z
                                    )
                                )

                                if (target.Position.X >= _G.AXS.endpos) then
                                    abc = false
                                    autofarming = false
                                end
                            end

                            task.wait(0.001)
                        end

                        autofarming = false
                        task.wait(1)

                        repeat
                            task.wait(0.1)
                            game:GetService("ReplicatedStorage")
                                :WaitForChild("Remotes")
                                :WaitForChild("LaunchEvents")
                                :WaitForChild("Return")
                                :FireServer()
                        until not alive() or not launched.Value

                        task.wait(0.01)
                    end
                end
            end)
        end
    end
})

local blocksInfo = require(game:GetService("ReplicatedStorage").Modules.Utilities.BlocksUtil).BlockInfo
_G.originalz = _G.originalz or blocksInfo
local localPlayer = game:GetService("Players").LocalPlayer

local function getBlockData(block, key)
    return _G.originalz[block][key]
end

local function modifyBlockData(block, key, value)
    blocksInfo[block][key] = value
end

local function getPlane()
    if localPlayer.Character and localPlayer.Character:FindFirstChild("Humanoid") then
        local planeSeat = localPlayer.Character.Humanoid.SeatPart
        return planeSeat and planeSeat.Parent.PrimaryPart or nil
    end
end

local PlaneGodMode = false



RunService.RenderStepped:Connect(function()
    if PlaneGodMode then
        local plane = getPlane()
        if plane then
            for _, part in ipairs(plane:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
    end
end)

local function getplot()
    local plots = workspace.Islands
    for i, plot in plots:GetChildren() do
        if plot.Important.OwnerID.Value == game.Players.LocalPlayer.UserId then
            return plot
        end
    end
end

local plot = getplot()
local PlaneGodMode = false

local ELVISDUPEToggle = MainTab:Toggle({
    Title = "Auto Farm Money",
    Icon = "badge-dollar-sign",
    Desc = "Use before patch",
    Default = false,
    Callback = function(state)
        _G.ELVISDUPE = _G.ELVISDUPE or {}
        _G.ELVISDUPE.enabled = state

        if state then
            game:GetService("CoreGui").PurchasePromptApp.Enabled = false

            task.spawn(function()
                for i = 1, 300 do
                    task.spawn(function()
                        while _G.ELVISDUPE.enabled and task.wait() do
                            game:GetService("ReplicatedStorage")
                                :WaitForChild("Remotes")
                                :WaitForChild("EventEvents")
                                :WaitForChild("SpawnEvilEye")
                                :InvokeServer()

                            game:GetService("ReplicatedStorage")
                                :WaitForChild("Remotes")
                                :WaitForChild("EventEvents")
                                :WaitForChild("KillEvilEye")
                                :InvokeServer()
                        end
                    end)
                end
            end)

            task.spawn(function()
                for i = 1, 80 do
                    task.spawn(function()
                        while _G.ELVISDUPE.enabled and task.wait() do
                            game:GetService("ReplicatedStorage")
                                :WaitForChild("Remotes")
                                :WaitForChild("SpinEvents")
                                :WaitForChild("PurchaseSpin")
                                :InvokeServer()

                            game:GetService("ReplicatedStorage")
                                :WaitForChild("Remotes")
                                :WaitForChild("SpinEvents")
                                :WaitForChild("PerformSpin")
                                :InvokeServer()
                        end
                    end)
                end
            end)
        else
            game:GetService("CoreGui").PurchasePromptApp.Enabled = true
        end
    end
})

-- =======================
-- PLANE TAB
-- =======================

local plane = getPlane()
local initialY = plane and plane.Position.Y or 0
local currentOffset = 100

local PlaneYSlider = PlayerTab:Slider({
    Title = "Wing Lift",

    Step = 1,
    Value = {
        Min = 0,
        Max = 500,
        Default = currentOffset,
    },

    Callback = function(offsetY)
        currentOffset = offsetY
    end,
})

RunService.RenderStepped:Connect(function()
    local plane = getPlane()
    if plane then
        local pos = plane.Position
        plane.CFrame = CFrame.new(pos.X, initialY + currentOffset, pos.Z) * plane.CFrame.Rotation
    end
end)

PlayerTab:Toggle({
    Title = "Infinite Fuel",
    Icon = "zap",
    Default = false,
    Callback = function(state)
        if state then
            modifyBlockData("fuel_1", "Fuel", 9e9)
            modifyBlockData("fuel_2", "Fuel", 9e9)
            modifyBlockData("fuel_3", "Fuel", 9e9)
        else
            modifyBlockData("fuel_1", "Fuel", getBlockData("fuel_1", "Fuel"))
            modifyBlockData("fuel_2", "Fuel", getBlockData("fuel_2", "Fuel"))
            modifyBlockData("fuel_3", "Fuel", getBlockData("fuel_3", "Fuel"))
        end
    end
})

local PlaneGodModeToggle = PlayerTab:Toggle({
    Title = "GodMode Plane",
    Icon = "heart",
    Default = false,
    Callback = function(state)
        godModeEnabled = state
        if state then
            godModeConnection = task.spawn(function()
                while godModeEnabled do
                    for i, item in plot:FindFirstChild("PlacedBlocks"):GetDescendants() do
                        if (item.ClassName == "Part" or item.ClassName == "MeshPart") 
                        and (item.Parent.Name ~= "driver_seat_1" and item.Name ~= "Part") then
                            if item.CanTouch then
                                item.CanTouch = false
                            end
                        end
                    end
                    task.wait(0.4)
                end
            end)
        else
            for i, item in plot:FindFirstChild("PlacedBlocks"):GetDescendants() do
                if (item.ClassName == "Part" or item.ClassName == "MeshPart") 
                and (item.Parent.Name ~= "driver_seat_1" and item.Name ~= "Part") then
                    item.CanTouch = true
                end
            end
        end
    end
})

local NoclipGodModeToggle = PlayerTab:Toggle({
    Title = "Noclip Plane",
    Icon = "heart",
    Desc = "Enable GOD Mode first",
    Default = false,
    Callback = function(state)
        noclipEnabled = state
        godModeEnabled = state 
        
        if state then
            noclipConnection = RunService.Heartbeat:Connect(function()
                if not plot or not plot:FindFirstChild("PlacedBlocks") then return end
                
                for _, item in pairs(plot.PlacedBlocks:GetDescendants()) do
                    if (item:IsA("Part") or item:IsA("MeshPart")) and 
                       item.Parent.Name ~= "driver_seat_1" and 
                       item.Name ~= "Part" then
                        item.CanCollide = false
                        
                        item.CanTouch = false
                    end
                end
            end)
            
            playerNoclipConnection = RunService.Stepped:Connect(function()
                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                    for _, part in pairs(LocalPlayer.Character:GetChildren()) do
                        if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
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
            
            if playerNoclipConnection then
                playerNoclipConnection:Disconnect()
                playerNoclipConnection = nil
            end
            
            if plot and plot:FindFirstChild("PlacedBlocks") then
                for _, item in pairs(plot.PlacedBlocks:GetDescendants()) do
                    if (item:IsA("Part") or item:IsA("MeshPart")) and 
                       item.Parent.Name ~= "driver_seat_1" and 
                       item.Name ~= "Part" then
                        item.CanCollide = true
                        item.CanTouch = true
                    end
                end
            end
            if LocalPlayer.Character then
                for _, part in pairs(LocalPlayer.Character:GetChildren()) do
                    if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                        part.CanCollide = true
                    end
                end
            end
        end
    end
})

_G.propeler2 = nil

PlayerTab:Slider({
    Title = "Propeller Power",
    Step = 1,
    Value = {
     Min = 0,
     Max = 5000,
     Default = 1,
    },
    Callback = function(v)
        _G.propeler2 = v
        for _, prop in pairs({"propeller_0","propeller_1","propeller_2","propeller_3","propeller_blood"}) do
            modifyBlockData(prop, "Force", v)
        end
    end
})

-- importat
local function runAutoFarmLoop(autoFlag, farmKey, guiName, guiTitle, teleportDuration)
    task.spawn(function()
        local LaunchRemote = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("LaunchEvents"):WaitForChild("Launch")
        local ReturnRemote = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("LaunchEvents"):WaitForChild("Return")
        local player = Players.LocalPlayer

        while _G[autoFlag] do
            local character = player.Character
            local humanoid = character and character:FindFirstChildOfClass("Humanoid")
            local hrp = character and character:FindFirstChild("HumanoidRootPart")

            while _G[autoFlag] and (not character or not humanoid or humanoid.Health <= 0 or not hrp) do
                task.wait(0.5)
                character = player.Character
                humanoid = character and character:FindFirstChildOfClass("Humanoid")
                hrp = character and character:FindFirstChild("HumanoidRootPart")
            end

            if not _G[autoFlag] then break end

            LaunchRemote:FireServer()
            task.wait(1.5)

            if hrp then
                smoothTeleport(hrp, farmPositions[farmKey], teleportDuration)
            end

            local farmGui = createFarmGui(guiName, guiTitle)

            task.wait(teleportDuration * 100)

            teleportBack()
            task.wait(2)

            ReturnRemote:FireServer()
            farmGui:Destroy()

            task.wait(4)
        end
    end)
end

-- =======================
-- SHOP TAB
-- =======================
local ShopList = {
    "All",
    "block_1",
    "block_reinforced",
    "block_metal",
    "tail_1",
    "tail_2",
    "seat_1",
    "fuel_1",
    "fuel_2",
    "fuel_3",
    "wing_1",
    "wing_2",
    "propeller_1",
    "propeller_2",
    "propeller_4",
    "boost_1",
    "missile_1",
    "shield",
    "boost_1",
    "balloon"
}

local ToolList = {
    "All",
    "Paint"
}

local selectedShops = {}
local selectedTools = {}

ShopTab:Toggle({
    Title = "AutoBuy Tools item",
    Icon = "badge-dollar-sign",
    Callback = function(state)
        local toolRemote = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("ShopEvents"):WaitForChild("BuyTool")
        if state then
            task.spawn(function()
                while state do
                    local itemsToBuy = {}

                    if selectedTools and table.find(selectedTools, "All") then
                        for i = 2, #ToolList do
                            table.insert(itemsToBuy, ToolList[i])
                        end
                    else
                        itemsToBuy = SelectedTools
                    end

                    for _, itemName in ipairs(itemsToBuy) do
                      if itemName and itemName ~= "All" then
                        toolRemote:FireServer(unpack({itemName}))
                        task.wait(0.1)
                      end
                    end

                    task.wait(0.5)
                end
            end)
        else
        end
    end
})

ShopTab:Dropdown({
    Title = "Select Tools",
    Multi = true,
    Values = ToolList,
    Callback = function(value)
        selectedTools = value or {}
    end,
})

ShopTab:Toggle({
    Title = "AutoBuy Shop items",
    Icon = "badge-dollar-sign",
    Callback = function(state)
        local shopRemote = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("ShopEvents"):WaitForChild("BuyBlock")
        if state then
            task.spawn(function()
                while state do
                    local itemsToBuy = {}

                    if selectedShops and table.find(selectedShops, "All") then
                        for i = 2, #ShopList do
                            table.insert(itemsToBuy, ShopList[i])
                        end
                    else
                        itemsToBuy = selectedShops
                    end

                    for _, itemName in ipairs(itemsToBuy) do
                        if itemName and itemName ~= "All" then
                            shopRemote:FireServer(itemName)
                            task.wait(0.1)
                        end
                    end

                    task.wait(0.5)
                end
            end)
        else
        end
    end
})

ShopTab:Dropdown({
    Title = "Select Shop",
    Multi = true,
    Values = ShopList,
    Callback = function(value)
        selectedShops = value or {}
    end,
})


-- =======================
-- MISC TAB
-- ======================

MiscTab:Toggle({
    Title = "Enable Fly",
    Value = false,
    Callback = function(state)
        flyToggle = state
        if flyToggle then
            if game:GetService("UserInputService").TouchEnabled then
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

MiscTab:Slider({
    Title = "Fly Speed",
    Value = { Min = 1, Max = 20, Default = 1 },
    Callback = function(value)
        flySpeed = value
        if FLYING then
            task.spawn(function()
                while FLYING do
                    task.wait(0.1)
                    if game:GetService("UserInputService").TouchEnabled then
                        local root = Players.LocalPlayer.Character and Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                        if root and root:FindFirstChild("BodyVelocity") then
                            local bv = root:FindFirstChild("BodyVelocity")
                            bv.Velocity = bv.Velocity.Unit * (flySpeed * 50) -- Adjust velocity magnitude
                        end
                    end
                end
            end)
        end
    end
})

MiscTab:Slider({
    Title = "WalkSpeed",
    Icon = "zap",
    Value = {
     Min = 16,
     Max = 200,
     Default = 16
    },
    Callback = function(value)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = value
    end
})

MiscTab:Toggle({
    Title = "Auto Respawn",
    Icon = "repeat",
    Default = false,
    Callback = function(state)
        if state then
            task.spawn(function()
                while state do
                    local char = LocalPlayer.Character
                    local humanoid = char and char:FindFirstChildOfClass("Humanoid")
                    if humanoid and humanoid.Health <= 0 then
                        task.wait(2)
                        LocalPlayer:LoadCharacter()
                    end
                    task.wait(1)
                end
            end)
        else
        end
    end
})

MiscTab:Toggle({
    Title = "Anti AFK",
    Icon = "activity",
    Default = true,
    Callback = function(state)
        if state then
            task.spawn(function()
                while state do
                    if not LocalPlayer then return end
                    VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
                    VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
                    task.wait(60)
                end
            end)
        else
        end
    end
})

local instantInteractEnabled = false
local instantInteractConnection
local originalHoldDurations = {}

MiscTab:Toggle({
    Title = "Instant ProximityPrompt",
    Icon = "zap",
    Value = false,
    Callback = function(state)
        instantInteractEnabled = state

        if state then
            originalHoldDurations = {}
            instantInteractConnection = task.spawn(function()
                while instantInteractEnabled do
                    for _, obj in ipairs(workspace:GetDescendants()) do
                        if obj:IsA("ProximityPrompt") then
                            if originalHoldDurations[obj] == nil then
                                originalHoldDurations[obj] = obj.HoldDuration
                            end
                            obj.HoldDuration = 0
                        end
                    end
                    task.wait(0.5)
                end
            end)
        else
            if instantInteractConnection then
                instantInteractEnabled = false
            end
            for obj, value in pairs(originalHoldDurations) do
                if obj and obj:IsA("ProximityPrompt") then
                    obj.HoldDuration = value
                end
            end
            originalHoldDurations = {}
        end
    end
})

-- =======================
-- END OF SCRIPT
-- ======================= 