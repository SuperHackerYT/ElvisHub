if not game:IsLoaded() then
    game.Loaded:Wait()
end

local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

local Confirmed = false

local Executors = {"Zenith", "Volcano", "Potassium", "Swift", "Xeno", "Solara", "Xyno", "Bunni", "Ronix", "Codex", "Wave", "JJSploit", "Arceus", "Delta", "Krnl", "Hydrogen", "Fluxus", "Velocity", "Valex"}

local function detectExecutor()
    local detectionMethods = {
        Zenith = function() return ZENITH_LOADED or _G.zenith or getgenv().zenith end,
        Volcano = function() return VOLCANO_LOADED or _G.volcano or getgenv().volcano end,
        Potassium = function() return POTASSIUM_LOADED or _G.potassium or getgenv().potassium end,
        Swift = function() return SWIFT_LOADED or _G.swift or getgenv().swift end,
        Xeno = function() return XENO_LOADED or _G.xeno or getgenv().xeno end,
        Solara = function() return SOLARA_LOADED or _G.solara or getgenv().solara end,
        Xyno = function() return XYNO_LOADED or _G.xyno or getgenv().xyno end,
        Bunni = function() return BUNNI_LOADED or _G.bunni or getgenv().bunni end,
        Ronix = function() return RONIX_LOADED or _G.ronix or getgenv().ronix end,
        Codex = function() return CODEX_LOADED or _G.codex or getgenv().codex end,
        Wave = function() return WAVE_LOADED or _G.wave or getgenv().wave end,
        JJSploit = function() return JJSPLOIT_LOADED or is_jjsploit_function or _G.jjsploit end,
        Arceus = function() return ARCEUS_LOADED or _G.arceus or getgenv().arceus end,
        Delta = function() return DELTA_LOADED or _G.delta or getgenv().delta end,
        Krnl = function() return KRNL_LOADED or krnl or _G.krnl end,
        Hydrogen = function() return HYDROGEN_LOADED or _G.hydrogen or getgenv().hydrogen end,
        Fluxus = function() return FLUXUS_LOADED or _G.fluxus or getgenv().fluxus end,
        Velocity = function() return VELOCITY_LOADED or _G.velocity or getgenv().velocity end,
        Valex = function() return VALEX_LOADED or _G.valex or getgenv().valex end
    }
    
    for _, executorName in pairs(Executors) do
        local checkFunction = detectionMethods[executorName]
        if checkFunction and checkFunction() then
            return executorName
        end
    end
    
    return "Unknown Executor"
end

local function detectUNC()
    local unc_score = 0
    local total_tests = 0
    
    local unc_tests = {
        {name = "getgenv", test = function() return getgenv ~= nil end},
        {name = "getgc", test = function() return getgc ~= nil end},
        {name = "getreg", test = function() return getreg ~= nil end},
        {name = "getloadedmodules", test = function() return getloadedmodules ~= nil end},
        {name = "getconnections", test = function() return getconnections ~= nil end},
        {name = "firetouchinterest", test = function() return firetouchinterest ~= nil end},
        {name = "fireclickdetector", test = function() return fireclickdetector ~= nil end},
        {name = "fireproximityprompt", test = function() return fireproximityprompt ~= nil end},
        {name = "getrawmetatable", test = function() return getrawmetatable ~= nil end},
        {name = "hookmetamethod", test = function() return hookmetamethod ~= nil end},
        {name = "newcclosure", test = function() return newcclosure ~= nil end},
        {name = "islclosure", test = function() return islclosure ~= nil end},
        {name = "iscclosure", test = function() return iscclosure ~= nil end},
        {name = "loadstring", test = function() return loadstring ~= nil end},
        {name = "checkcaller", test = function() return checkcaller ~= nil end},
        {name = "hookfunction", test = function() return hookfunction ~= nil end},
        {name = "isrbxactive", test = function() return isrbxactive ~= nil end},
        {name = "mouse1click", test = function() return mouse1click ~= nil end},
        {name = "mouse1press", test = function() return mouse1press ~= nil end},
        {name = "mouse1release", test = function() return mouse1release ~= nil end},
        {name = "mouse2click", test = function() return mouse2click ~= nil end},
        {name = "mouse2press", test = function() return mouse2press ~= nil end},
        {name = "mouse2release", test = function() return mouse2release ~= nil end},
        {name = "mousemoveabs", test = function() return mousemoveabs ~= nil end},
        {name = "mousemoverel", test = function() return mousemoverel ~= nil end},
        {name = "mousescroll", test = function() return mousescroll ~= nil end},
        {name = "keypress", test = function() return keypress ~= nil end},
        {name = "keyrelease", test = function() return keyrelease ~= nil end},
        {name = "readfile", test = function() return readfile ~= nil end},
        {name = "writefile", test = function() return writefile ~= nil end},
        {name = "appendfile", test = function() return appendfile ~= nil end},
        {name = "makefolder", test = function() return makefolder ~= nil end},
        {name = "delfolder", test = function() return delfolder ~= nil end},
        {name = "delfile", test = function() return delfile ~= nil end},
        {name = "isfile", test = function() return isfile ~= nil end},
        {name = "isfolder", test = function() return isfolder ~= nil end},
        {name = "listfiles", test = function() return listfiles ~= nil end}
    }
    
    for _, test in pairs(unc_tests) do
        total_tests = total_tests + 1
        if pcall(test.test) and test.test() then
            unc_score = unc_score + 1
        end
    end
    
    local unc_percentage = math.floor((unc_score / total_tests) * 100)
    return unc_percentage, unc_score, total_tests
end

local function detectLevel()
    local level = 1
    if getgenv and getgc and getreg then level = 2 end
    if getconnections and firetouchinterest then level = 3 end
    if hookmetamethod and newcclosure then level = 4 end
    if hookfunction and checkcaller then level = 5 end
    if mouse1click and keypress then level = 6 end
    if readfile and writefile then level = 7 end
    if islclosure and iscclosure then level = 8 end
    if getrawmetatable and getloadedmodules then level = 9 end
    
    return level
end

local currentExecutor = detectExecutor()
local unc_percentage, unc_score, total_tests = detectUNC()
local detected_level = detectLevel()

WindUI:Popup({
    Title = "[ELVIS-HUB] Hunty Zombie",
    Icon = "zap",
    IconThemed = true,
    Content = "█▀▀ █░ █░█ █ █▀\n██▄ █▄ ▀▄▀ █ ▄█\n\nClick Continue to Use the Script!\nExecutor: " .. currentExecutor .. "\nLevel: " .. detected_level,
    Buttons = {
    	{ Title = "Copy Discord Link", Variant = "Primary", Callback = function() setclipboard("https://discord.gg/7zyT99D7S3") Confirmed = true end },
        { Title = "Exit", Variant = "Secondary", Callback = function() game.Players.LocalPlayer:Kick("uwu :3") end },
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

WindUI:AddTheme({
    Name = "Crimson",
    Accent = "#b91c1c",
    Dialog = "#991b1b",
    Outline = "#f87171", 
    Text = "#fef2f2",
    Placeholder = "#ef4444",
    Background = "#450a0a",
    Button = "#dc2626",
    Icon = "#fca5a5",
})

WindUI:AddTheme({
    Name = "Orange",
    Accent = "#c2410c",
    Dialog = "#9a3412",
    Outline = "#fdba74", 
    Text = "#fff7ed",
    Placeholder = "#fb923c",
    Background = "#431407",
    Button = "#ea580c",
    Icon = "#fed7aa",
})

WindUI:AddTheme({
    Name = "Yellow",
    Accent = "#a16207",
    Dialog = "#92400e",
    Outline = "#fcd34d", 
    Text = "#fffbeb",
    Placeholder = "#f59e0b",
    Background = "#451a03",
    Button = "#d97706",
    Icon = "#fde68a",
})

WindUI:AddTheme({
    Name = "Emerald",
    Accent = "#047857",
    Dialog = "#065f46",
    Outline = "#6ee7b7", 
    Text = "#ecfdf5",
    Placeholder = "#34d399",
    Background = "#022c22",
    Button = "#059669",
    Icon = "#a7f3d0",
})

WindUI:AddTheme({
    Name = "Teal",
    Accent = "#0f766e",
    Dialog = "#134e4a",
    Outline = "#5eead4", 
    Text = "#f0fdfa",
    Placeholder = "#2dd4bf",
    Background = "#042f2e",
    Button = "#0d9488",
    Icon = "#99f6e4",
})

WindUI:AddTheme({
    Name = "Cyan",
    Accent = "#0e7490",
    Dialog = "#155e75",
    Outline = "#67e8f9", 
    Text = "#ecfeff",
    Placeholder = "#22d3ee",
    Background = "#083344",
    Button = "#0891b2",
    Icon = "#a5f3fc",
})

WindUI:AddTheme({
    Name = "Indigo",
    Accent = "#4338ca",
    Dialog = "#3730a3",
    Outline = "#a5b4fc", 
    Text = "#f0f9ff",
    Placeholder = "#818cf8",
    Background = "#1e1b4b",
    Button = "#5b21b6",
    Icon = "#c7d2fe",
})

WindUI:AddTheme({
    Name = "Pink",
    Accent = "#be185d",
    Dialog = "#9d174d",
    Outline = "#f9a8d4", 
    Text = "#fdf2f8",
    Placeholder = "#ec4899",
    Background = "#500724",
    Button = "#db2777",
    Icon = "#fbcfe8",
})

WindUI:AddTheme({
    Name = "Rose",
    Accent = "#be123c",
    Dialog = "#9f1239",
    Outline = "#fda4af", 
    Text = "#fff1f2",
    Placeholder = "#f43f5e",
    Background = "#4c0519",
    Button = "#e11d48",
    Icon = "#fecdd3",
})

WindUI:AddTheme({
    Name = "Violet",
    Accent = "#7c2d12",
    Dialog = "#6d28d9",
    Outline = "#c4b5fd", 
    Text = "#faf5ff",
    Placeholder = "#a78bfa",
    Background = "#2d1b69",
    Button = "#8b5cf6",
    Icon = "#ddd6fe",
})

WindUI:AddTheme({
    Name = "Forest Green",
    Accent = "#166534",
    Dialog = "#14532d",
    Outline = "#86efac", 
    Text = "#f0fdf4",
    Placeholder = "#4ade80",
    Background = "#052e16",
    Button = "#16a34a",
    Icon = "#bbf7d0",
})

WindUI:AddTheme({
    Name = "Ocean Blue",
    Accent = "#0369a1",
    Dialog = "#0c4a6e",
    Outline = "#7dd3fc", 
    Text = "#f0f9ff",
    Placeholder = "#38bdf8",
    Background = "#082f49",
    Button = "#0284c7",
    Icon = "#bae6fd",
})

WindUI:AddTheme({
    Name = "Sunset Orange",
    Accent = "#ea580c",
    Dialog = "#c2410c",
    Outline = "#fdba74", 
    Text = "#fff7ed",
    Placeholder = "#fb923c",
    Background = "#341a00",
    Button = "#f97316",
    Icon = "#fed7aa",
})

WindUI:AddTheme({
    Name = "Royal Purple",
    Accent = "#6b21a8",
    Dialog = "#581c87",
    Outline = "#d8b4fe", 
    Text = "#faf5ff",
    Placeholder = "#c084fc",
    Background = "#3b0764",
    Button = "#7c3aed",
    Icon = "#e9d5ff",
})

WindUI:AddTheme({
    Name = "Cherry Red",
    Accent = "#dc2626",
    Dialog = "#b91c1c",
    Outline = "#fca5a5", 
    Text = "#fef2f2",
    Placeholder = "#f87171",
    Background = "#7f1d1d",
    Button = "#ef4444",
    Icon = "#fecaca",
})

WindUI:SetNotificationLower(true)

local themes = {"Dark", "Light", "Gray", "Blue", "Green", "Purple", "Red", "Midnight Blue", "Dark Blue", "Crimson", "Orange", "Yellow", "Emerald", "Teal", "Cyan", "Indigo", "Pink", "Rose", "Violet", "Forest Green", "Ocean Blue", "Sunset Orange", "Royal Purple", "Cherry Red"}
local currentThemeIndex = 1

if not getgenv().TransparencyEnabled then
    getgenv().TransparencyEnabled = false
end

local Window = WindUI:CreateWindow({
    Title = "Hunty Zombie",
    Icon = "zap", 
    Author = "AXS-HUB",
    Folder = "AxsHub",
    Size = UDim2.fromOffset(500, 350),
    Transparent = getgenv().TransparencyEnabled,
    Theme = "Midnight Blue",
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
    CornerRadius = UDim.new(0, 8),
    StrokeThickness = 2,
    Color = ColorSequence.new(Color3.fromRGB(138, 43, 226), Color3.fromRGB(173, 216, 230)),
    Draggable = true,
})

local LobbyTab = Window:Tab({
    Title = "Lobby",
    Icon = "earth",
})

local CodeTab = Window:Tab({
    Title = "Code",
    Icon = "code",
})

local GameTab = Window:Tab({
    Title = "Game",
    Icon = "swords",
})

local PlayerMiscTab = Window:Tab({
    Title = "PlayerMisc",
    Icon = "user",
})

local InfoTab = Window:Tab({
    Title = "Information",
    Icon = "badge-info",
})

local SettingTab = Window:Tab({
    Title = "Settings",
    Icon = "settings",
})

Window:SelectTab(3)

-- ==============STATUS INFO===================

Info = InfoTab

if not ui then ui = {} end
if not ui.Creator then ui.Creator = {} end

ui.Creator.Request = function(requestData)
    local HttpService = game:GetService("HttpService")
    
    local success, result = pcall(function()
        if HttpService.RequestAsync then
            local response = HttpService:RequestAsync({
                Url = requestData.Url,
                Method = requestData.Method or "GET",
                Headers = requestData.Headers or {}
            })
            return {
                Body = response.Body,
                StatusCode = response.StatusCode,
                Success = response.Success
            }
        else
            local body = HttpService:GetAsync(requestData.Url)
            return {
                Body = body,
                StatusCode = 200,
                Success = true
            }
        end
    end)
    
    if success then
        return result
    else
        error("HTTP Request failed: " .. tostring(result))
    end
end

local InviteCode = "7zyT99D7S3"
local DiscordAPI = "https://discord.com/api/v10/invites/" .. InviteCode .. "?with_counts=true&with_expiration=true"

local function LoadDiscordInfo()
    local success, result = pcall(function()
        return game:GetService("HttpService"):JSONDecode(ui.Creator.Request({
            Url = DiscordAPI,
            Method = "GET",
            Headers = {
                ["User-Agent"] = "RobloxBot/1.0",
                ["Accept"] = "application/json"
            }
        }).Body)
    end)

    if success and result and result.guild then
        local DiscordInfo = Info:Paragraph({
            Title = result.guild.name,
            Desc = ' <font color="#52525b">●</font> Member Count : ' .. tostring(result.approximate_member_count) ..
                '\n <font color="#16a34a">●</font> Online Count : ' .. tostring(result.approximate_presence_count),
            Image = "https://cdn.discordapp.com/icons/" .. result.guild.id .. "/" .. result.guild.icon .. ".png?size=1024",
            ImageSize = 42,
        })

        Info:Button({
            Title = "Update Info",
            Callback = function()
                local updated, updatedResult = pcall(function()
                    return game:GetService("HttpService"):JSONDecode(ui.Creator.Request({
                        Url = DiscordAPI,
                        Method = "GET",
                    }).Body)
                end)

                if updated and updatedResult and updatedResult.guild then
                    DiscordInfo:SetDesc(
                        ' <font color="#52525b">●</font> Member Count : ' .. tostring(updatedResult.approximate_member_count) ..
                        '\n <font color="#16a34a">●</font> Online Count : ' .. tostring(updatedResult.approximate_presence_count)
                    )
                    
                    WindUI:Notify({
                        Title = "Discord Info Updated",
                        Content = "Successfully refreshed Discord statistics",
                        Duration = 2,
                        Icon = "refresh-cw",
                    })
                else
                    WindUI:Notify({
                        Title = "Update Failed",
                        Content = "Could not refresh Discord info",
                        Duration = 3,
                        Icon = "alert-triangle",
                    })
                end
            end
        })

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
    else
        Info:Paragraph({
            Title = "Error fetching Discord Info",
            Desc = "Oops! Your Executor has Limit\nExecutor: " .. currentExecutor .. "\nLevel: " .. detected_level,
            Image = "rbxassetid://17862288113",
            ImageSize = 60,
            Color = "Red"
        })
        warn("Discord API Error:", result)
    end
end

LoadDiscordInfo()

InfoTab:Input({
    Title = "Report Bug & Suggest",
    Desc = "This will sent to the Discord server and will be read by The Owner",
    Value = "",
    InputIcon = "message-circle",
    Type = "Input",
    Placeholder = "Enter your message.",
    Callback = function(input) 
        if input and input ~= "" then
            local webhookURL = "https://discord.com/api/webhooks/1414941271847469056/p2HDu08aRIb2Cy7Gd_vdAEmgaQjGWNlRjIqPM86pj3Ry57oodtLO3T3I7qtd5tZn3OqM"
            
            local HttpService = game:GetService("HttpService")
            
            local success, result = pcall(function()
                return HttpService:RequestAsync({
                    Url = webhookURL,
                    Method = "POST",
                    Headers = {
                        ["Content-Type"] = "application/json"
                    },
                    Body = HttpService:JSONEncode({
                        content = "**" .. game.Players.LocalPlayer.Name .. "**: " .. input,
                        username = "Roblox Game"
                    })
                })
            end)
            
            if success and result.StatusCode == 204 then
                WindUI:Notify({
                    Title = "Message Sent!",
                    Content = "Your message was sent to Discord",
                    Duration = 3,
                    Icon = "check-circle",
                })
            else
            end
        end
    end
})

Info:Divider()
InfoTab:Section({ 
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
    Title = "Axiora Hub",
    Desc = "Made By Elvis. Made with love <3 >⩊< (credits: viper)",
    Image = "rbxassetid://129542787176629",
    ImageSize = 30,
    Thumbnail = "",
    ThumbnailSize = 0,
    Locked = false,
})

local Discord = Info:Paragraph({
    Title = "Discord",
    Desc = "Join our discord for more scripts!",
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
local VIM = game:GetService("VirtualInputManager")
local Players = game:GetService("Players")
local PlayerGui = Players.LocalPlayer.PlayerGui

local isSpinning = false
local isPerkSpinning = false
local AutoClickOn = false
local AutoClickSure = false
local spinDelay = 4
local SpinPerkDelay = 4
local selectedWeapon = "Axes" 
local selectedPerk = "Undead"

local Weapons = {
    "Baseball", "Axes", "Guitar", "Dual gun", "Katana", "Greatsword" 
}

local Perks = {
    "Berserker", "Healer", "Flame", "Critical", "Undead", "Vampire", "Double Damage"
    }
    
local flyToggle = false
local flySpeed = 1
local FLYING = false
local flyKeyDown, flyKeyUp, mfly1, mfly2
local IYMouse = game:GetService("UserInputService") 

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local noclipConnection

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local autoFarmEnabled = false
local autoFarmConnection
local currentZombieIndex = 1
local stickDelay = 3
local attackHeight = -2
local stuckConnection

-- Variables And Fucker

-- Function <==3
local function findSpinButton()
    local playerGui = game:GetService("Players").LocalPlayer.PlayerGui
    local gui = playerGui:FindFirstChild("GUI")
    
    if not gui then return nil end
    
    for _, child in pairs(gui:GetChildren()) do
        if child:FindFirstChild("SpinButtons") then
            local spinButtons = child.SpinButtons
            if spinButtons:FindFirstChild("Holder") and spinButtons.Holder:FindFirstChild("Normal") then
                return spinButtons.Holder.Normal
            end
        end
    end
    return nil
end

local function findPerkSpinButton()
    local playerGui = game:GetService("Players").LocalPlayer.PlayerGui
    local gui = playerGui:FindFirstChild("GUI")
    
    if not gui then return nil end
    
    local spin = gui:FindFirstChild("Spin")
    if spin and spin:FindFirstChild("SpinButtons") then
        local spinButtons = spin.SpinButtons
        if spinButtons:FindFirstChild("Holder") and spinButtons.Holder:FindFirstChild("Normal") then
            return spinButtons.Holder.Normal
        end
    end
    return nil
end

local function PressJ()
VIM:SendKeyEvent(true, "J", false, game)
wait(0.1)
VIM:SendKeyEvent(false, "J", false, game)
end

local function SpinNormal()
    local spinbutton = findSpinButton()
    if spinbutton then
        firesignal(spinbutton.MouseButton1Click)
    else
        warn("Nigga shutup")
    end
end

local function AutoSpin() 
AutoSpinOn = true
while AutoSpinOn do
SpinNormal() 
wait(spinDelay)
end
end

local function NoAutoSpinNigga() 
AutoSpinOn = false
end

local function CheckForDesiredWeapon()
    local playerGui = game:GetService("Players").LocalPlayer.PlayerGui
    local gui = playerGui:FindFirstChild("GUI")
    
    if not gui then return false end
    
    for _, child in pairs(gui:GetChildren()) do
        local headerTextLabel = child:FindFirstChild("Header")
        if headerTextLabel and headerTextLabel:IsA("TextLabel") then
            local headerText = headerTextLabel.Text
            if headerText:upper():find(selectedWeapon:upper()) then
                return true
            end
        end
    end
    return false
end

local function AutoClick()
    AutoClickOn = true
    spawn(function()
        while AutoClickOn do
            local success, useraskGUI = pcall(function()
                return PlayerGui:WaitForChild("useraskGUI", 1)
            end)
            
            if success and useraskGUI then
                wait(2)
                local button = useraskGUI.USERAGREE.Frame.responseframe.askbutton
                if button then
                    firesignal(button.MouseButton1Click)
                end
                
                repeat wait(0.5) until not PlayerGui:FindFirstChild("useraskGUI")
            else
                wait(1)
            end
        end
    end)
end

local function StopAutoClick()
    AutoClickOn = false
end

local function pressK()
VIM:SendKeyEvent(true, "K", false, game)
wait(0.1)
VIM:SendKeyEvent(false, "K", false, game)
end

local function SpinPerk()
    local perkspinbutton = findPerkSpinButton()
    if perkspinbutton then
        firesignal(perkspinbutton.MouseButton1Click)
    else
        warn("Nil")
    end
end

local function AutoSpinPerk()
isPerkSpinning = true
while isPerkSpinning do
SpinPerk()
wait(SpinPerkDelay)
end
end

local function StopAutoSpinPerk()
isPerkSpinning = false
end

local function AutoClick2()
    AutoClickSure = true
    spawn(function()
        while AutoClickSure do
            local success, useraskGUI = pcall(function()
                return PlayerGui:WaitForChild("useraskGUI", 1)
            end)
            
            if success and useraskGUI then
                wait(2)
                local button = game:GetService("Players").LocalPlayer.PlayerGui.useraskGUI.USERAGREE.Frame.responseframe.askbutton
                if button then
                    firesignal(button.MouseButton1Click)
                end
                
                repeat wait(0.5) until not PlayerGui:FindFirstChild("useraskGUI")
            else
                wait(1)
            end
        end
    end)
end

local function StopAutoClickSure()
AutoClickSure = false
end

local function CheckForDesiredPerks()
    local playerGui = game:GetService("Players").LocalPlayer.PlayerGui
    local gui = playerGui:FindFirstChild("GUI")
    
    if not gui then return false end
    
    local spin = gui:FindFirstChild("Spin")
    if spin then
        local headerTextLabel = spin:FindFirstChild("Header")
        if headerTextLabel and headerTextLabel:IsA("TextLabel") then
            local headerText = headerTextLabel.Text
            print("Current perk:", headerText)
            
            if headerText:upper():find(selectedPerk:upper()) then
                return true
            end
        end
    end
    return false
end

local function Nigga()
local args = {
	"HZCrafting"
}
game:GetService("ReplicatedStorage"):WaitForChild("Packets"):WaitForChild("RedeemCode"):InvokeServer(unpack(args))
end

local function Nigga2()
local args = {
	"HZCrafting2"
}
game:GetService("ReplicatedStorage"):WaitForChild("Packets"):WaitForChild("RedeemCode"):InvokeServer(unpack(args))
end
local function Nigga3()
local args = {
	"B4UPD3"
}
game:GetService("ReplicatedStorage"):WaitForChild("Packets"):WaitForChild("RedeemCode"):InvokeServer(unpack(args))
end

local function Nigga4()
local args = {
	"EMOTEISHERE"
}
game:GetService("ReplicatedStorage"):WaitForChild("Packets"):WaitForChild("RedeemCode"):InvokeServer(unpack(args))
end

local function Nigga5()
local args = {
	"500KLIKES"
}
game:GetService("ReplicatedStorage"):WaitForChild("Packets"):WaitForChild("RedeemCode"):InvokeServer(unpack(args))
end

local function Nigga6()
local args = {
	"200K67"
}
game:GetService("ReplicatedStorage"):WaitForChild("Packets"):WaitForChild("RedeemCode"):InvokeServer(unpack(args))
end

local function AllNigga()
Nigga()
wait(0.5)
Nigga2()
wait(0.5)
Nigga3()
wait(0.5)
Nigga4()
wait(0.5)
Nigga5()
wait(0.5)
Nigga6()
end

local function sFLY()
if not Players.LocalPlayer.Character or not Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        warn("Character or HumanoidRootPart not found")
        return
    end
    
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

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local function enableNoclip()
    if LocalPlayer.Character then
        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") and part.CanCollide then
                part.CanCollide = false
            end
        end
    end
end

local function disableNoclip()
    if LocalPlayer.Character then
        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                part.CanCollide = true
            end
        end
    end
end

local function getAllZombies()
    local zombies = {}
    local entitiesFolder = workspace:FindFirstChild("Entities")
    
    if entitiesFolder then
        local zombieFolder = entitiesFolder:FindFirstChild("Zombie")
        if zombieFolder then
            for _, zombie in pairs(zombieFolder:GetChildren()) do
                if zombie:IsA("Model") and zombie:FindFirstChild("HumanoidRootPart") then
                    table.insert(zombies, zombie)
                end
            end
        end
    end
    
    return zombies
end

local function autoFarmNoclip()
    if LocalPlayer.Character then
        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") and part.CanCollide then
                part.CanCollide = false
            end
        end
    end
end

local function disableAutoFarmNoclip()
    if LocalPlayer.Character then
        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                part.CanCollide = true
            end
        end
    end
end

local function stickToZombie(zombie)
    if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        return false
    end
    
    if not zombie or not zombie:FindFirstChild("HumanoidRootPart") then
        return false
    end
    
    local humanoidRootPart = LocalPlayer.Character.HumanoidRootPart
    local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    
    if stuckConnection then
        stuckConnection:Disconnect()
        stuckConnection = nil
    end
    
    autoFarmNoclip()
    
    local targetPosition = zombie.HumanoidRootPart.Position + Vector3.new(0, attackHeight, 0)
    
    local tweenInfo = TweenInfo.new(
        0.5,
        Enum.EasingStyle.Quint,
        Enum.EasingDirection.Out
    )
    
    local tween = TweenService:Create(
        humanoidRootPart,
        tweenInfo,
        {Position = targetPosition}
    )
    
    tween:Play()
    
    tween.Completed:Connect(function()
        if humanoid then
            humanoid.PlatformStand = true
            humanoid.WalkSpeed = 0
            humanoid.JumpPower = 0
        end
        
        stuckConnection = RunService.Heartbeat:Connect(function()
            if zombie and zombie.Parent and humanoidRootPart and humanoidRootPart.Parent then
                local newTargetPosition = zombie.HumanoidRootPart.Position + Vector3.new(0, attackHeight, 0)
                humanoidRootPart.Position = newTargetPosition
                humanoidRootPart.Velocity = Vector3.new(0, 0, 0)
            else
                if stuckConnection then
                    stuckConnection:Disconnect()
                    stuckConnection = nil
                end
            end
        end)
    end)
    
    return true
end

local function unstickPlayer()
    if stuckConnection then
        stuckConnection:Disconnect()
        stuckConnection = nil
    end
    
    if LocalPlayer.Character then
        local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.PlatformStand = false
            humanoid.WalkSpeed = 16
            humanoid.JumpPower = 50
        end
    end
    
    disableAutoFarmNoclip()
end

local function startAutoFarmZombie()
    autoFarmEnabled = true
    autoFarmNoclip()
    
    autoFarmConnection = task.spawn(function()
        while autoFarmEnabled do
            local zombies = getAllZombies()
            
            if #zombies > 0 then
                if currentZombieIndex > #zombies then
                    currentZombieIndex = 1
                end
                
                local targetZombie = zombies[currentZombieIndex]
                
                if stickToZombie(targetZombie) then
                    WindUI:Notify({
                        Title = "Farming Zombie",
                        Content = "Stuck to " .. targetZombie.Name .. " at height " .. attackHeight,
                        Duration = 1,
                        Icon = "target",
                    })
                    currentZombieIndex = currentZombieIndex + 1
                    wait(stickDelay)
                    unstickPlayer()
                    wait(0.2)
                else
                    currentZombieIndex = currentZombieIndex + 1
                    wait(0.1)
                end
            else
                wait(5)
            end
        end
    end)
end

local function stopAutoFarmZombie()
    autoFarmEnabled = false
    unstickPlayer()
    
    if autoFarmConnection then
        task.cancel(autoFarmConnection)
        autoFarmConnection = nil
    end
    currentZombieIndex = 1
end

LobbyTab:Section({ 
    Title = "Weapon",
    TextXAlignment = "Left",
    TextSize = 15,
})

LobbyTab:Dropdown({
    Title = "Desired  [WEAPON]",
    Values = Weapons,
    Value = "Axes",
    Multi = false,
    AllowNone = true,
    Callback = function(option) 
        selectedWeapon = option
    end
})

LobbyTab:Toggle({
    Title = "AutoSpin [WEAPON]",
    Desc = "AutoSpin Until you get Desired",
    Icon = "swords", 
    Default = false,
    Callback = function(state) 
        if state then
            if selectedWeapon == "" then
                WindUI:Notify({
                    Title = "No Desired Selected",
                    Content = "Select a Desired first!",
                    Duration = 3,
                    Icon = "x",
                })
                return
            end
            
            PressJ()
            wait(0.5)
            isSpinning = true
            wait(0.5)
            AutoClick() 
            
            spawn(function()
                while isSpinning do
                    if CheckForDesiredWeapon() then
                        isSpinning = false
                        StopAutoClick() 
                        WindUI:Notify({
                            Title = "Got Your Desired! NIGGA",
                            Content = "Got " .. selectedWeapon .. "! Nice! ",
                            Duration = 8,
                            Icon = "check",
                        })
                        break
                    end
                    
                    SpinNormal()
                    wait(spinDelay)
                end
            end)
            
            WindUI:Notify({
                Title = "Auto Spin Started",
                Content = "Target: " .. selectedWeapon,
                Duration = 3, 
                Icon = "check",
            })
        else
            isSpinning = false
            StopAutoClick() 
        end
    end
})

LobbyTab:Section({ 
    Title = "Perk",
    TextXAlignment = "Left",
    TextSize = 15,
})

LobbyTab:Dropdown({
    Title = "Desired  [PERK]",
    Values = Perks,
    Value = "Undead",
    Multi = false,
    AllowNone = true,
    Callback = function(option) 
        selectedPerk = option
    end
})

LobbyTab:Toggle({
    Title = "AutoSpin [PERK]",
    Desc = "AutoSpin Until you get Desired",
    Icon = "bookmark-check", 
    Default = false,
    Callback = function(state) 
        if state then
            if selectedPerk == "" then
                WindUI:Notify({
                    Title = "No Desired Selected",
                    Content = "Select a Desired first!",
                    Duration = 3,
                    Icon = "x",
                })
                return
            end
            
            pressK()
            wait(0.5)
            isPerkSpinning = true
            wait(0.5)
            AutoClick2() 
            
            spawn(function()
                while isPerkSpinning do
                    if CheckForDesiredPerks() then
                        isPerkSpinning = false
                        StopAutoClickSure() 
                        WindUI:Notify({
                            Title = "Got Your Desired!",
                            Content = "Got " .. selectedPerk .. "! Nice! ",
                            Duration = 8,
                            Icon = "check",
                        })
                        break
                    end
                    
                    SpinPerk()
                    wait(SpinPerkDelay)
                end
            end)
            
            WindUI:Notify({
                Title = "Auto Spin Started",
                Content = "Target: " .. selectedPerk,
                Duration = 3, 
                Icon = "check",
            })
        else
            isPerkSpinning = false
            StopAutoClickSure() 
        end
    end
})

LobbyTab:Section({ 
    Title = "Settings",
    TextXAlignment = "Left",
    TextSize = 15,
})

LobbyTab:Slider({
    Title = "Spin Delay [WEAPON]",
    Step = 0.1,
    
    Value = {
        Min = 0.1,
        Max = 10,
        Default = 4,
    },
    Callback = function(value)
        spinDelay = value
    end
})

LobbyTab:Slider({
    Title = "Spin Delay [PERK]",
    Step = 0.1,
    
    Value = {
        Min = 0.1,
        Max = 10,
        Default = 4,
    },
    Callback = function(value)
        SpinPerkDelay = value
    end
})

-- Settings

SettingTab:Divider()
SettingTab:Section({ 
    Title = "UI Settings",
    TextXAlignment = "Center",
    TextSize = 20,
})
SettingTab:Divider()

SettingTab:Dropdown({
    Title = "Window Theme",
    Desc = "",
    Values = {"Dark", "Light", "Gray", "Blue", "Green", "Purple", "Red", "Midnight Blue", "Dark Blue", "Crimson", "Orange", "Yellow", "Emerald", "Teal", "Cyan", "Indigo", "Pink", "Rose", "Violet", "Forest Green", "Ocean Blue", "Sunset Orange", "Royal Purple", "Cherry Red"},
    Value = "Dark",
    Multi = false,
    AllowNone = false,
    Callback = function(selectedTheme) 
        if selectedTheme then
            WindUI:SetTheme(selectedTheme)
            
            WindUI:Notify({
                Title = "Theme Changed",
                Content = "Switched to " .. selectedTheme .. " theme!",
                Duration = 2,
                Icon = "palette"
            })
        end
    end
})

SettingTab:Colorpicker({
    Title = "Custom UI Color [COMING SOON]", 
    Default = Color3.fromRGB(138, 43, 226),
    Transparency = 0.5,
    Locked = false,
    Callback = function(color) 
    end
})

SettingTab:Keybind({
    Title = "Change MinimizeKey",
    Desc = "",
    Value = "F",
    Callback = function(v)
        Window:SetToggleKey(Enum.KeyCode[v])
    end
})

SettingTab:Toggle({
    Title = "Transparency",
    Icon = "eye",
    Type = "Toggle",
    Default = getgenv().TransparencyEnabled or false,
    Callback = function(state)
        getgenv().TransparencyEnabled = state
        
        pcall(function() 
            Window:ToggleTransparency(state) 
        end)
    end
})

CodeTab:Code({
    Title = "Codes",
    Code = [[HZCrafting | B4UPD3 | EMOTEISHERE | HZCrafting2 | 200k67 | 500KLIKES]]
})

CodeTab:Button({
    Title = "Redeem All Codes",
    Desc = "",
    Locked = false,
    Callback = function()
        AllNigga()
        WindUI:Notify({
                Title = "Redeem All Codes Successful",
                Content = "",
                Duration = 2,
                Icon = "check"
            })
    end
})

PlayerMiscTab:Slider({
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
                            bv.Velocity = bv.Velocity.Unit * (flySpeed * 50) 
                        end
                    end
                end
            end)
        end
    end
})

PlayerMiscTab:Toggle({
    Title = "Fly",
    Icon = "plane",
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

PlayerMiscTab:Slider({
    Title = "WalkSpeed",
    Value = { Min = 1, Max = 200, Default = 16 },
    Callback = function(value)
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = value
        end
     
        LocalPlayer.CharacterAdded:Connect(function(character)
            local humanoid = character:WaitForChild("Humanoid")
            humanoid.WalkSpeed = value
        end)
    end
})

PlayerMiscTab:Toggle({
    Title = "Noclip",
    Icon = "ghost",
    Callback = function(state)
        if state then
            enableNoclip()
            
            noclipConnection = RunService.Stepped:Connect(function()
                enableNoclip()
            end)
            
            LocalPlayer.CharacterAdded:Connect(function()
                if state then 
                    wait(0.1)
                    enableNoclip()
                end
            end)
            
            WindUI:Notify({
                Title = "Noclip Enabled",
                Content = "!",
                Duration = 2,
                Icon = "check",
            })
        else
            if noclipConnection then
                noclipConnection:Disconnect()
                noclipConnection = nil
            end
            disableNoclip()
        end
    end
})

GameTab:Section({
  Title = "Combat", 
  Icon = "skull"
})

GameTab:Toggle({
    Title = "AutoTeleport to Zombies",
    Desc = "",
    Icon = "sword",
    Callback = function(state)
        if state then
            startAutoFarmZombie()
            WindUI:Notify({
                Title = "AutoTp Started",
                Content = "!",
                Duration = 3,
                Icon = "check",
            })
        else
            stopAutoFarmZombie()
        end
    end
})

GameTab:Slider({
    Title = "Teleport Height",
    Desc = "",
    Value = { Min = -4, Max = 4, Default = -2 },
    Callback = function(value)
        attackHeight = value
    end
})

GameTab:Slider({
    Title = "Teleport Delay",
    Desc = "",
    Step = 0.1,
    Value = { Min = 1, Max = 10, Default = 3 },
    Callback = function(value)
        stickDelay = value
    end
})

Game:Divider()
