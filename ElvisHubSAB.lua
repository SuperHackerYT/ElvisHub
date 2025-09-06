local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()

-- loc
WindUI:Localization({
    Enabled = true,
    Prefix = "loc:",
    DefaultLanguage = "en",
    Translations = {
        ["ru"] = {
            ["WINDUI_EXAMPLE"] = "WindUI Пример",
            ["WELCOME"] = "Добро пожаловать в WindUI!",
            ["HOME"] = "дом",
            ["LIB_DESC"] = "Библиотека для создания красивых интерфейсов",
            ["SETTINGS"] = "Настройки",
            ["APPEARANCE"] = "Внешний вид",
            ["FEATURES"] = "Функционал",
            ["UTILITIES"] = "Инструменты",
            ["ANTICHEATBYPASS"] = "Обход античита",
            ["MAIN_FEATURES"] = "Основные характеристики",
            ["CONFIGURATION"] = "Конфигурация",
            ["SAVE_CONFIG"] = "Сохранить конфигурацию",
            ["LOAD_CONFIG"] = "Загрузить конфигурацию",
            ["THEME_SELECT"] = "Выберите тему",
            ["TRANSPARENCY"] = "Прозрачность окна"
        },
        ["en"] = {
            ["WINDUI_EXAMPLE"] = "WindUI Example",
            ["WELCOME"] = "Welcome to WindUI!",
            ["HOME"] = "Home",
            ["LIB_DESC"] = "Beautiful UI library for Roblox",
            ["SETTINGS"] = "Settings",
            ["APPEARANCE"] = "Appearance",
            ["FEATURES"] = "Features",
            ["UTILITIES"] = "Utilities",
            ["ANTICHEATBYPASS"] = "AntiCheat-Bypass",
            ["MAIN_FEATURES"] = "MainFeatures",
            ["CONFIGURATION"] = "Configuration",
            ["SAVE_CONFIG"] = "Save Configuration",
            ["LOAD_CONFIG"] = "Load Configuration",
            ["THEME_SELECT"] = "Select Theme",
            ["TRANSPARENCY"] = "Window Transparency"
        }
    }
})

WindUI.TransparencyValue = 0.2
WindUI:SetTheme("Dark")

local function gradient(text, startColor, endColor)
    local result = ""
    for i = 1, #text do
        local t = (i - 1) / (#text - 1)
        local r = math.floor((startColor.R + (endColor.R - startColor.R) * t) * 255)
        local g = math.floor((startColor.G + (endColor.G - startColor.G) * t) * 255)
        local b = math.floor((startColor.B + (endColor.B - startColor.B) * t) * 255)
        result = result .. string.format('<font color="rgb(%d,%d,%d)">%s</font>', r, g, b, text:sub(i, i))
    end
    return result
end

WindUI:Popup({
    Title = gradient("Zynoxis Scripts", Color3.fromHex("#6A11CB"), Color3.fromHex("#2575FC")),
    Icon = "zap",
    Content = "loc:Elvis Hub - Steal A Brainrot",
    Buttons = {
        {
            Title = "Get Started",
            Icon = "arrow-right",
            Variant = "Primary",
            Callback = function() end
        }
    }
})

local Window = WindUI:CreateWindow({
    Title = "loc:Elvis Hub",
    Icon = "zap",
    Author = "loc:By Elvis Gaming",
    Folder = "WindUI_Example",
    Size = UDim2.fromOffset(400, 337.5),
    Theme = "Dark",
    -- Background = WindUI:Gradient({
    --     ["0"] = { Color = Color3.fromHex("#0f0c29"), Transparency = 1 },
    --     ["100"] = { Color = Color3.fromHex("#302b63"), Transparency = 0.9 },
    -- }, {
    --     Rotation = 45,
    -- }),
    --Background = "video:https://cdn.discordapp.com/attachments/1337368451865645096/1402703845657673878/VID_20250616_180732_158.webm?ex=68958a01&is=68943881&hm=164c5b04d1076308b38055075f7eb0653c1d73bec9bcee08e918a31321fe3058&",
    User = {
        Enabled = true,
        Anonymous = true,
        Callback = function()
            WindUI:Notify({
                Title = ".",
                Content = ".",
                Duration = 1
            })
        end
    },
    SideBarWidth = 200,
    -- KeySystem = { -- <- ↓ remove this all, if you dont neet the key system
    --     -- Key = { "1234", "5678" },  
    --     Note = "Example Key System. With platoboost, etc.",
    --     -- URL = "https://github.com/Footagesus/WindUI",
    --     -- Thumbnail = {
    --     --     Image = "rbxassetid://",
    --     --     Title = "Thumbnail",
    --     -- },
    --     API = {
    --         {   
    --             -- Title = "Platoboost", -- optional 
    --             -- Desc = "Click to copy.", -- optional
    --             -- Icon = "rbxassetid://", -- optional
                
    --             Type = "platoboost", -- type: platoboost, ...
    --             ServiceId = 5541, -- service id
    --             Secret = "1eda3b70-aab4-4394-82e4-4e7f507ae198", -- platoboost secret
    --         },
    --         {   
    --             -- Title = "Other service", -- optional 
    --             -- Desc = nil, -- optional
    --             -- Icon = "rbxassetid://", -- optional
                
    --             Type = "pandadevelopment", -- type: platoboost, ...
    --             ServiceId = "windui", -- service id
    --         },
    --         {   
    --             Type = "luarmor",
    --             ScriptId = "...",
    --             Discord = "https://discord.com/invite/...",
    --         },
    --         { -- Custom service ( ↑↑ look at line 73 ↑↑ )
    --             Type = "mysuperservicetogetkey",
    --             ServiceId = 42,
    --         }
    --     },
    --     SaveKey = true,
    -- },
})

Window:Tag({
    Title = "ELVIS",
    Color = Color3.fromHex("#315dff")
})
local TimeTag = Window:Tag({
    Title = "00:00",
    Color = Color3.fromHex("#000000")
})

local hue = 0

task.spawn(function()
	while true do
		local now = os.date("*t")
		local hours = string.format("%02d", now.hour)
		local minutes = string.format("%02d", now.min)
		
		hue = (hue + 0.01) % 1
		local color = Color3.fromHSV(hue, 1, 1)
		
		TimeTag:SetTitle(hours .. ":" .. minutes)
		TimeTag:SetColor(color)

		task.wait(0.06)
	end
end)


Window:CreateTopbarButton("theme-switcher", "moon", function()
    WindUI:SetTheme(WindUI:GetCurrentTheme() == "Dark" and "Light" or "Dark")
    WindUI:Notify({
        Title = "Theme Changed",
        Content = "Current theme: "..WindUI:GetCurrentTheme(),
        Duration = 2
    })
end, 990)

-- tabs thingy 

local Tabs = {
    Main = Window:Section({ Title = "loc:FEATURES", Opened = true }),
    Settings = Window:Section({ Title = "loc:APPEARANCE", Opened = true }),
    Utilities = Window:Section({ Title = "loc:CONFIGURATION", Opened = true }),
}

local TabHandles = {
    Home = Tabs.Main:Tab({
        Title = "loc:HOME",
        Icon = "house",
        Desc = "Home Tab",
    }),
    
    MainFeatures = Tabs.Main:Tab({
        Title = "loc:MAIN_FEATURES",
        Icon = "layout-grid",
        Desc = "Main Hacks",
    }),

    AntiCheatBypass = Tabs.Main:Tab({
        Title = "loc:ANTICHEATBYPASS",
        Icon = "ruler-dimension-line",
        Desc = "Enables Anti-Kick",
    }),

    Appearance = Tabs.Settings:Tab({
        Title = "loc:APPEARANCE",
        Icon = "brush",
    }),

    Config = Tabs.Utilities:Tab({
        Title = "loc:CONFIGURATION",
        Icon = "settings",
    }),
}

-- start

local stealPos, lockBasePos
local noclipEnabled = false
local speedHackEnabled = false
local speedBoostEnabled = false
local runConn

-- idk

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local VirtualInputManager = game:GetService("VirtualInputManager")

local player = Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hum = char:WaitForChild("Humanoid")
local hrp = char:WaitForChild("HumanoidRootPart")

local airWalkEnabled = false
local antiRagdollEnabled = false
local doubleJumpEnabled = false

local platform = Instance.new("Part")
platform.Size = Vector3.new(50,1,50)
platform.Anchored = true
platform.Transparency = 1
platform.CanCollide = true
platform.Parent = workspace

local canDoubleJump = false

-- fts

TabHandles.Home:Paragraph({
    Title = "Info",
    Desc = "Script developers of Elvis Hub:\nElvis. Owner: Elvis.",
    Image = "info",
    ImageSize = 20
})

TabHandles.Home:Paragraph({
    Title = "Changelog",
    Desc = "Version1.0:\nPublic release of the script",
    Image = "album",
    ImageSize = 20
})

-- ft1
if not getgenv().AutoSetSettings then
    getgenv().AutoSetSettings = {
        Enabled = false,
        TriggerDistance = 15,
        Cooldown = 1,
        TouchTrigger = true,
        DistanceTrigger = true
    }
end

local autoSetConnection = nil
local lastClick = 0

local function performMouseClick()
    local currentTime = tick()
    if currentTime - lastClick < getgenv().AutoSetSettings.Cooldown then
        return
    end

    VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 1)
    task.wait(0.05)
    VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 1)

    lastClick = currentTime
end

local function isPlayerNear()
    if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        return false
    end

    local playerPosition = LocalPlayer.Character.HumanoidRootPart.Position
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local distance = (playerPosition - player.Character.HumanoidRootPart.Position).Magnitude
            if distance <= getgenv().AutoSetSettings.TriggerDistance then
                return true
            end
        end
    end
    return false
end

local function setupPlayerTouchDetection(player)
    if player == LocalPlayer then return end
    local function onCharacterAdded(character)
        character:WaitForChild("HumanoidRootPart")
        for _, part in pairs(character:GetChildren()) do
            if part:IsA("BasePart") then
                part.Touched:Connect(function(hit)
                    if not getgenv().AutoSetSettings.Enabled then return end
                    if not getgenv().AutoSetSettings.TouchTrigger then return end
                    if hit.Parent == LocalPlayer.Character then
                        performMouseClick()
                    end
                end)
            end
        end
    end
    if player.Character then
        onCharacterAdded(player.Character)
    end
    player.CharacterAdded:Connect(onCharacterAdded)
end

local function startAutoSet()
    if autoSetConnection then return end
    for _, player in pairs(Players:GetPlayers()) do
        setupPlayerTouchDetection(player)
    end
    autoSetConnection = RunService.Heartbeat:Connect(function()
        if not getgenv().AutoSetSettings.Enabled then return end
        if not getgenv().AutoSetSettings.DistanceTrigger then return end
        if isPlayerNear() then
            performMouseClick()
        end
    end)
    Players.PlayerAdded:Connect(setupPlayerTouchDetection)
end

local function stopAutoSet()
    if autoSetConnection then
        autoSetConnection:Disconnect()
        autoSetConnection = nil
    end
end

TabHandles.MainFeatures:Toggle({
    Title = "AutoHit",
    Desc = "Equip Tungbat to automatically hit players nearby",
    Type = "Checkbox",
    Default = getgenv().AutoSetSettings.Enabled,
    Callback = function(state)
        getgenv().AutoSetSettings.Enabled = state
        if state then
            startAutoSet()
        else
            stopAutoSet()
        end
    end
})

TabHandles.MainFeatures:Toggle({
    Title = "Float Walk",
    Desc = "Try jumping and walk on air :)",
    Type = "Checkbox",
    Default = false,
    Callback = function(state)
        airWalkEnabled = state
        platform.Position = hrp.Position - Vector3.new(0, 5, 0)
        platform.Enabled = state
    end
})

RunService.Heartbeat:Connect(function()
    char = player.Character
    if not char then return end
    hum = char:FindFirstChildOfClass("Humanoid")
    hrp = char:FindFirstChild("HumanoidRootPart")
    if not hum or not hrp then return end

    if airWalkEnabled then
        platform.Position = hrp.Position - Vector3.new(0, 5, 0)
        hrp.CFrame = CFrame.new(hrp.Position.X, platform.Position.Y + 5, hrp.Position.Z)
    end

    if antiRagdollEnabled then
        if hum:GetState() ~= Enum.HumanoidStateType.Running then
            hum:ChangeState(Enum.HumanoidStateType.Running)
        end
        for _, part in pairs(char:GetDescendants()) do
            if part:IsA("BallSocketConstraint") or part:IsA("HingeConstraint") then
                part.Enabled = true
            end
        end
    end
end)

TabHandles.MainFeatures:Toggle({
    Title = "Anti-Ragdoll",
    Desc = "Blocks ragdoll states & joints without breaking movement",
    Type = "Checkbox",
    Default = false,
    Callback = function(state)
        antiRagdollEnabled = state
    end
})

TabHandles.MainFeatures:Toggle({
    Title = "Double Jump",
    Desc = "Jump again while mid-air",
    Type = "Checkbox",
    Default = false,
    Callback = function(state)
        doubleJumpEnabled = state
    end
})

UserInputService.JumpRequest:Connect(function()
    if not doubleJumpEnabled then return end
    char = player.Character
    if not char then return end
    hum = char:FindFirstChildOfClass("Humanoid")
    if not hum then return end

    if hum:GetState() == Enum.HumanoidStateType.Freefall and canDoubleJump then
        hum:ChangeState(Enum.HumanoidStateType.Jumping)
        canDoubleJump = false
    elseif hum:GetState() == Enum.HumanoidStateType.Running 
        or hum:GetState() == Enum.HumanoidStateType.Landed then
        canDoubleJump = true
    end
end)

hum.StateChanged:Connect(function(_, newState)
    if newState == Enum.HumanoidStateType.Landed then
        canDoubleJump = true
    end
end)

TabHandles.AntiCheatBypass:Toggle({
    Title = "Anti-Slow",
    Desc = "Prevents WalkSpeed from going below 16",
    Icon = "zap",
    Type = "Checkbox",
    Locked = false,
    Default = false,
    Callback = function(state)
        antiSlowEnabled = state

        if antiSlowEnabled then
            local lp = game.Players.LocalPlayer
            antiSlowConnection = game:GetService("RunService").Heartbeat:Connect(function()
                local char = lp.Character
                if char then
                    local hum = char:FindFirstChildOfClass("Humanoid")
                    if hum and hum.WalkSpeed < 16 then
                        hum.WalkSpeed = 16
                    end
                end
            end)
        else
            if antiSlowConnection then
                antiSlowConnection:Disconnect()
                antiSlowConnection = nil
            end
        end
    end
})

TabHandles.AntiCheatBypass:Button({
    Title = "Anti-Cheat Bypass",
    Desc = "Enables Anti-Kick",
    Locked = false,
    Callback = function()
        local hk = false
        for _, v in pairs(getgc(true)) do
            if typeof(v) == "table" then
                local fn = rawget(v, "observeTag")
                if typeof(fn) == "function" and not hk then
                    hk = true
                    hookfunction(fn, newcclosure(function(_, _)
                        return {Disconnect = function() end, disconnect = function() end}
                    end))
                end
            end
        end
        print("Anti-Cheat Bypass applied!")
    end
})

TabHandles.AntiCheatBypass:Button({
    Title = "Bypass Anti-SpeedHack (beta)",
    Desc = "Bypass movement speed lock",
    Locked = false,
    Callback = function()
        game:GetService("RunService").Heartbeat:Connect(function()
            pcall(function()
                local cam = workspace.CurrentCamera
                local move = Vector3.zero
                local character = game.Players.LocalPlayer.Character
                local root = character and character:FindFirstChild("HumanoidRootPart")
                local forward = Vector3.new(cam.CFrame.LookVector.X, 0, cam.CFrame.LookVector.Z).Unit
                local right = Vector3.new(cam.CFrame.RightVector.X, 0, cam.CFrame.RightVector.Z).Unit
                local UserInputService = game:GetService("UserInputService")
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then move += forward end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then move -= forward end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then move -= right end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then move += right end
                if move.Magnitude > 0 then root.Velocity = move.Unit * 50 end
            end)
        end)
    end
})

TabHandles.MainFeatures:Toggle({
    Title = "High Jump",
    Desc = "Doubles Your Jump Height",
    Icon = "arrow-up",
    Type = "Checkbox",
    Locked = false,
    Default = false,
    Callback = function(state)
        local lp = game.Players.LocalPlayer
        local hum = lp.Character and lp.Character:FindFirstChildOfClass("Humanoid")

        if state then
            if hum then
                hum.JumpPower = 100 -- 🦘 High jump value (default is 50)
            end
            highJumpEnabled = true
        else
            if hum then
                hum.JumpPower = 50 -- back to default
            end
            highJumpEnabled = false
        end
    end
})

TabHandles.MainFeatures:Button({
    Title = "Instant Steal",
    Desc = "No Hold Duration",
    Locked = false,
    Callback = function()
        if runConn then
            runConn:Disconnect()
            runConn = nil
            return
        end
        runConn = game:GetService("RunService").RenderStepped:Connect(function()
            for _, prompt in pairs(workspace:GetDescendants()) do
                if prompt:IsA("ProximityPrompt") then
                    pcall(function()
                        prompt.HoldDuration = 0
                    end)
                end
            end
        end)
    end
})


local speedBoostEnabled = false
local speedLoop
local player = game.Players.LocalPlayer
local runService = game:GetService("RunService")

local function handleSpeedLock(state)
    if state then
        if not speedLoop then
            speedLoop = runService.Heartbeat:Connect(function()
                local char = player.Character
                if char then
                    local hum = char:FindFirstChildOfClass("Humanoid")
                    if hum and hum.WalkSpeed ~= 30 then
                        hum.WalkSpeed = 30
                    end
                end
            end)
        end
    else

        if speedLoop then
            speedLoop:Disconnect()
            speedLoop = nil
        end
        local char = player.Character
        if char then
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then
                hum.WalkSpeed = 16
            end
        end
    end
end

player.CharacterAdded:Connect(function(char)
    char:WaitForChild("Humanoid")
    if speedBoostEnabled then
        handleSpeedLock(true)
    end
end)

TabHandles.MainFeatures:Toggle({
    Title = "Speed Boost",
    Desc = "Only WalkSpeed 30 but undetectable",
    Type = "Checkbox",
    Locked = false,
    Default = false,
    Callback = function(state)
        speedBoostEnabled = state
        handleSpeedLock(state)
    end
})

-- idk

TabHandles.Appearance:Paragraph({
    Title = "Customize Interface",
    Desc = "Personalize your experience",
    Image = "palette",
    ImageSize = 20,
    Color = "White"
})

local themes = {}
for themeName, _ in pairs(WindUI:GetThemes()) do
    table.insert(themes, themeName)
end
table.sort(themes)

local themeDropdown = TabHandles.Appearance:Dropdown({
    Title = "loc:THEME_SELECT",
    Values = themes,
    Value = "Dark",
    Callback = function(theme)
        WindUI:SetTheme(theme)
        WindUI:Notify({
            Title = "Theme Applied",
            Content = theme,
            Icon = "palette",
            Duration = 2
        })
    end
})

local transparencySlider = TabHandles.Appearance:Slider({
    Title = "loc:TRANSPARENCY",
    Value = { 
        Min = 0,
        Max = 1,
        Default = 0.2,
    },
    Step = 0.1,
    Callback = function(value)
        Window:ToggleTransparency(tonumber(value) > 0)
        WindUI.TransparencyValue = tonumber(value)
    end
})

local canchangetheme = true

local ThemeToggle = TabHandles.Appearance:Toggle({
    Title = "Enable Dark Mode",
    Desc = "Use dark color scheme",
    Value = true,
    Callback = function(state)
        if canchangetheme then
            WindUI:SetTheme(state and "Dark" or "Light")
        end
        themeDropdown:Select(state and "Dark" or "Light")
    end
})

WindUI:OnThemeChange(function(theme)
    canchangetheme = false
    ThemeToggle:Set(theme == "Dark")
    canchangetheme = true
end)


TabHandles.Appearance:Button({
    Title = "Create New Theme",
    Icon = "plus",
    Callback = function()
        Window:Dialog({
            Title = "Create Theme",
            Content = "This feature is coming soon!",
            Buttons = {
                {
                    Title = "OK",
                    Variant = "Primary"
                }
            }
        })
    end
})

TabHandles.Config:Paragraph({
    Title = "Configuration Manager",
    Desc = "Save and load your settings",
    Image = "save",
    ImageSize = 20,
    Color = "White"
})

local configName = "default"
local configFile = nil
local MyPlayerData = {
    name = "Player1",
    level = 1,
    inventory = { "sword", "shield", "potion" }
}

TabHandles.Config:Input({
    Title = "Config Name",
    Value = configName,
    Callback = function(value)
        configName = value or "default"
    end
})

local ConfigManager = Window.ConfigManager
if ConfigManager then
    ConfigManager:Init(Window)
    
    TabHandles.Config:Button({
        Title = "loc:SAVE_CONFIG",
        Icon = "save",
        Variant = "Primary",
        Callback = function()
            configFile = ConfigManager:CreateConfig(configName)
            
            configFile:Register("featureToggle", featureToggle)
            configFile:Register("intensitySlider", intensitySlider)
            configFile:Register("modeDropdown", modeDropdown)
            configFile:Register("themeDropdown", themeDropdown)
            configFile:Register("transparencySlider", transparencySlider)
            
            configFile:Set("playerData", MyPlayerData)
            configFile:Set("lastSave", os.date("%Y-%m-%d %H:%M:%S"))
            
            if configFile:Save() then
                WindUI:Notify({ 
                    Title = "loc:SAVE_CONFIG", 
                    Content = "Saved as: "..configName,
                    Icon = "check",
                    Duration = 3
                })
            else
                WindUI:Notify({ 
                    Title = "Error", 
                    Content = "Failed to save config",
                    Icon = "x",
                    Duration = 3
                })
            end
        end
    })

    TabHandles.Config:Button({
        Title = "loc:LOAD_CONFIG",
        Icon = "folder",
        Callback = function()
            configFile = ConfigManager:CreateConfig(configName)
            local loadedData = configFile:Load()
            
            if loadedData then
                if loadedData.playerData then
                    MyPlayerData = loadedData.playerData
                end
                
                local lastSave = loadedData.lastSave or "Unknown"
                WindUI:Notify({ 
                    Title = "loc:LOAD_CONFIG", 
                    Content = "Loaded: "..configName.."\nLast save: "..lastSave,
                    Icon = "refresh-cw",
                    Duration = 5
                })
                
                TabHandles.Config:Paragraph({
                    Title = "Player Data",
                    Desc = string.format("Name: %s\nLevel: %d\nInventory: %s", 
                        MyPlayerData.name, 
                        MyPlayerData.level, 
                        table.concat(MyPlayerData.inventory, ", "))
                })
            else
                WindUI:Notify({ 
                    Title = "Error", 
                    Content = "Failed to load config",
                    Icon = "x",
                    Duration = 3
                })
            end
        end
    })
else
    TabHandles.Config:Paragraph({
        Title = "Config Manager Not Available",
        Desc = "This feature requires ConfigManager",
        Image = "alert-triangle",
        ImageSize = 20,
        Color = "White"
    })
end


local footerSection = Window:Section({ Title = "Elvis V1.0" })
TabHandles.Config:Paragraph({
    Title = "Info",
    Desc = "Script developers of Elvis Hub:\nElvis. Owner: Elvis.",
    Image = "info",
    ImageSize = 20,
    Color = "Blue",
    Buttons = {
        {
            Title = "Copy Link",
            Icon = "copy",
            Variant = "Tertiary",
            Callback = function()
                setclipboard("https://discord.gg/GzVhuqJRDY")
                WindUI:Notify({
                    Title = "Copied!",
                    Content = "Discord link copied to clipboard",
                    Duration = 2
                })
            end
        }
    }
})

Window:OnClose(function()
    print("Window closed")
    
    if ConfigManager and configFile then
        configFile:Set("playerData", MyPlayerData)
        configFile:Set("lastSave", os.date("%Y-%m-%d %H:%M:%S"))
        configFile:Save()
        print("Config auto-saved on close")
    end
end)

Window:OnDestroy(function()
    print("Window destroyed")
end)
