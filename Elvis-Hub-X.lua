local player = game.Players.LocalPlayer
local uis = game:GetService("UserInputService")
local runService = game:GetService("RunService")
local workspace = game:GetService("Workspace")

local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "ElvisScript_UI"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local main = Instance.new("Frame")
main.Size = UDim2.new(0, 300, 0, 260)
main.Position = UDim2.new(0.5, -150, 0.5, -130)
main.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
main.Visible = false
main.Active = true
main.Draggable = true
main.Parent = gui
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 12)
Instance.new("UIStroke", main).Color = Color3.fromRGB(80, 80, 100)

local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1, 0, 0, 30)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundTransparency = 1
title.Text = "🥶 Elvis Hub X"
title.Font = Enum.Font.SourceSansBold
title.TextSize = 20
title.TextColor3 = Color3.new(1, 1, 1)

local tabFrame = Instance.new("Frame", main)
tabFrame.Size = UDim2.new(1, -20, 0, 30)
tabFrame.Position = UDim2.new(0, 10, 0, 35)
tabFrame.BackgroundTransparency = 1

local tabButtons = {}
local tabContents = {}
local tabs = {"Main", "Visual", "Games"}
for i, name in ipairs(tabs) do
	local btn = Instance.new("TextButton", tabFrame)
	btn.Size = UDim2.new(0, 90, 1, 0)
	btn.Position = UDim2.new(0, (i - 1) * 95, 0, 0)
	btn.BackgroundColor3 = Color3.fromRGB(50, 50, 80)
	btn.Text = name
	btn.Font = Enum.Font.GothamBold
	btn.TextSize = 14
	btn.TextColor3 = Color3.new(1, 1, 1)
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
	tabButtons[name] = btn

	local content = Instance.new("ScrollingFrame", main)
	content.Size = UDim2.new(1, -20, 1, -80)
	content.Position = UDim2.new(0, 10, 0, 70)
	content.BackgroundTransparency = 1
	content.Visible = (i == 1)
	content.ScrollBarThickness = 6
	content.ScrollingDirection = Enum.ScrollingDirection.Y
	content.AutomaticCanvasSize = Enum.AutomaticSize.Y
	content.CanvasSize = UDim2.new(0, 0, 0, 0)

	local layout = Instance.new("UIListLayout", content)
	layout.Padding = UDim.new(0, 10)
	layout.SortOrder = Enum.SortOrder.LayoutOrder

	tabContents[name] = content
end

for name, btn in pairs(tabButtons) do
	btn.MouseButton1Click:Connect(function()
		for otherName, content in pairs(tabContents) do
			content.Visible = (otherName == name)
		end
	end)
end

-- Infinite Jump
local infJump = false
local infBtn = Instance.new("TextButton", tabContents["Main"])
infBtn.Size = UDim2.new(1, -20, 0, 40)
infBtn.Text = "Infinite Jump 🔼"
infBtn.Font = Enum.Font.GothamBold
infBtn.TextSize = 16
infBtn.TextColor3 = Color3.new(1, 1, 1)
infBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 80)
infBtn.LayoutOrder = 1
Instance.new("UICorner", infBtn).CornerRadius = UDim.new(0, 8)

infBtn.MouseButton1Click:Connect(function()
	infJump = not infJump
	infBtn.BackgroundColor3 = infJump and Color3.fromRGB(30, 200, 30) or Color3.fromRGB(50, 50, 80)
end)

uis.JumpRequest:Connect(function()
	if infJump and player.Character then
		local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
		if humanoid then
			humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
		end
	end
end)

-- Noclip
local noclip = false
local noclipBtn = Instance.new("TextButton", tabContents["Main"])
noclipBtn.Size = UDim2.new(1, -20, 0, 40)
noclipBtn.Text = "Noclip 🚪"
noclipBtn.Font = Enum.Font.GothamBold
noclipBtn.TextSize = 16
noclipBtn.TextColor3 = Color3.new(1, 1, 1)
noclipBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 80)
noclipBtn.LayoutOrder = 2
Instance.new("UICorner", noclipBtn).CornerRadius = UDim.new(0, 8)

noclipBtn.MouseButton1Click:Connect(function()
	noclip = not noclip
	noclipBtn.BackgroundColor3 = noclip and Color3.fromRGB(30, 200, 30) or Color3.fromRGB(50, 50, 80)
end)

runService.Stepped:Connect(function()
	if noclip and player.Character and player.Character:FindFirstChild("Humanoid") then
		for _, part in pairs(player.Character:GetDescendants()) do
			if part:IsA("BasePart") then
				part.CanCollide = false
			end
		end
	end
end)

-- Godmode
local godmode = false
local godBtn = Instance.new("TextButton", tabContents["Main"])
godBtn.Size = UDim2.new(1, -20, 0, 40)
godBtn.Text = "Godmode 💙"
godBtn.Font = Enum.Font.GothamBold
godBtn.TextSize = 16
godBtn.TextColor3 = Color3.new(1, 1, 1)
godBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 80)
godBtn.LayoutOrder = 3
Instance.new("UICorner", godBtn).CornerRadius = UDim.new(0, 8)

godBtn.MouseButton1Click:Connect(function()
	godmode = not godmode
	godBtn.BackgroundColor3 = godmode and Color3.fromRGB(30, 200, 30) or Color3.fromRGB(50, 50, 80)
end)

runService.Heartbeat:Connect(function()
	if godmode and player.Character then
		local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
		if humanoid then
			if humanoid.Health < humanoid.MaxHealth then
				humanoid.Health = humanoid.MaxHealth
			end
			if not humanoid:FindFirstChild("NoDamage") then
				local noDamage = Instance.new("BoolValue")
				noDamage.Name = "NoDamage"
				noDamage.Parent = humanoid
				humanoid.TakeDamage = function() end
			end
		end
	end
end)

-- Speed Hack
local speedOn = false
local speedBtn = Instance.new("TextButton", tabContents["Main"])
speedBtn.Size = UDim2.new(1, -20, 0, 40)
speedBtn.Text = "Speed Up 🏃"
speedBtn.Font = Enum.Font.GothamBold
speedBtn.TextSize = 16
speedBtn.TextColor3 = Color3.new(1, 1, 1)
speedBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 80)
speedBtn.LayoutOrder = 4
Instance.new("UICorner", speedBtn).CornerRadius = UDim.new(0, 8)

speedBtn.MouseButton1Click:Connect(function()
	speedOn = not speedOn
	speedBtn.BackgroundColor3 = speedOn and Color3.fromRGB(30, 200, 30) or Color3.fromRGB(50, 50, 80)

	local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
	if humanoid then
		humanoid.WalkSpeed = speedOn and 50 or 16
	end
end)

-- Seraphic Blade
local scriptOn = false
local scriptBtn = Instance.new("TextButton", tabContents["Main"])
scriptBtn.Size = UDim2.new(1, -20, 0, 40)
scriptBtn.Text = "Seraphic Blade 💎"
scriptBtn.Font = Enum.Font.GothamBold
scriptBtn.TextSize = 16
scriptBtn.TextColor3 = Color3.new(1, 1, 1)
scriptBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 80)
Instance.new("UICorner", scriptBtn).CornerRadius = UDim.new(0, 8)

scriptBtn.MouseButton1Click:Connect(function()
	scriptOn = not scriptOn
	scriptBtn.BackgroundColor3 = scriptOn and Color3.fromRGB(30, 200, 30) or Color3.fromRGB(50, 50, 80)

	if scriptOn then
		loadstring(game:HttpGet("https://pastefy.app/59mJGQGe/raw"))()
	end
end)

-- Touch Fling
local tfOn = false

local tfBtn = Instance.new("TextButton", tabContents["Main"])
tfBtn.Size = UDim2.new(1, -20, 0, 40)
tfBtn.Text = "Touch Fling 🤏💥"
tfBtn.Font = Enum.Font.GothamBold
tfBtn.TextSize = 16
tfBtn.TextColor3 = Color3.new(1, 1, 1)
tfBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 80)
Instance.new("UICorner", tfBtn).CornerRadius = UDim.new(0, 8)

tfBtn.MouseButton1Click:Connect(function()
	tfOn = not tfOn
	tfBtn.BackgroundColor3 = tfOn and Color3.fromRGB(30, 200, 30) or Color3.fromRGB(50, 50, 80)

	if tfOn then
		loadstring(game:HttpGet("https://pastebin.com/raw/LgZwZ7ZB",true))()
	end
end)

-- FE Grab Part Single-Click Button
local grabPartBtn = Instance.new("TextButton", tabContents["Main"])
grabPartBtn.Size = UDim2.new(1, -20, 0, 40)
grabPartBtn.Text = "FE Grab Part 🧲"
grabPartBtn.Font = Enum.Font.GothamBold
grabPartBtn.TextSize = 16
grabPartBtn.TextColor3 = Color3.new(1, 1, 1)
grabPartBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 80)
Instance.new("UICorner", grabPartBtn).CornerRadius = UDim.new(0, 8)

grabPartBtn.MouseButton1Click:Connect(function()
	loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Grab-Unanchored-Parts-20642"))()
end)

-- Quiz Bot 🤖📚 Single Click Button
local quizBotBtn = Instance.new("TextButton", tabContents["Main"])
quizBotBtn.Size = UDim2.new(1, -20, 0, 40)
quizBotBtn.Text = "Quiz Bot 🤖📚"
quizBotBtn.Font = Enum.Font.GothamBold
quizBotBtn.TextSize = 16
quizBotBtn.TextColor3 = Color3.new(1, 1, 1)
quizBotBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 80)
Instance.new("UICorner", quizBotBtn).CornerRadius = UDim.new(0, 8)

quizBotBtn.MouseButton1Click:Connect(function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/Damian-11/quizbot/master/quizbot.luau"))()
end)

-- Game Tool Giver 🧰🎮 Single Click Button
local gameToolBtn = Instance.new("TextButton", tabContents["Main"])
gameToolBtn.Size = UDim2.new(1, -20, 0, 40)
gameToolBtn.Text = "Game Tool Giver 🧰🎮"
gameToolBtn.Font = Enum.Font.GothamBold
gameToolBtn.TextSize = 16
gameToolBtn.TextColor3 = Color3.new(1, 1, 1)
gameToolBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 80)
Instance.new("UICorner", gameToolBtn).CornerRadius = UDim.new(0, 8)

gameToolBtn.MouseButton1Click:Connect(function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/yofriendfromschool1/Sky-Hub-Backup/main/gametoolgiver.lua"))()
end)

-- FE Hamster Ball 🐹⚽ Single Click Button
local hamsterBallBtn = Instance.new("TextButton", tabContents["Main"])
hamsterBallBtn.Size = UDim2.new(1, -20, 0, 40)
hamsterBallBtn.Text = "FE Hamster Ball 🐹⚽"
hamsterBallBtn.Font = Enum.Font.GothamBold
hamsterBallBtn.TextSize = 16
hamsterBallBtn.TextColor3 = Color3.new(1, 1, 1)
hamsterBallBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 80)
Instance.new("UICorner", hamsterBallBtn).CornerRadius = UDim.new(0, 8)

hamsterBallBtn.MouseButton1Click:Connect(function()
	local UserInputService = game:GetService("UserInputService")
	local RunService = game:GetService("RunService")
	local Camera = workspace.CurrentCamera

	local SPEED_MULTIPLIER = 30
	local JUMP_POWER = 60
	local JUMP_GAP = 0.3

	local character = game.Players.LocalPlayer.Character

	for i,v in ipairs(character:GetDescendants()) do
		if v:IsA("BasePart") then
			v.CanCollide = false
		end
	end

	local ball = character.HumanoidRootPart
	ball.Shape = Enum.PartType.Ball
	ball.Size = Vector3.new(5,5,5)
	local humanoid = character:WaitForChild("Humanoid")
	local params = RaycastParams.new()
	params.FilterType = Enum.RaycastFilterType.Blacklist
	params.FilterDescendantsInstances = {character}

	local tc = RunService.RenderStepped:Connect(function(delta)
		ball.CanCollide = true
		humanoid.PlatformStand = true
		if UserInputService:GetFocusedTextBox() then return end
		if UserInputService:IsKeyDown("W") then
			ball.RotVelocity -= Camera.CFrame.RightVector * delta * SPEED_MULTIPLIER
		end
		if UserInputService:IsKeyDown("A") then
			ball.RotVelocity -= Camera.CFrame.LookVector * delta * SPEED_MULTIPLIER
		end
		if UserInputService:IsKeyDown("S") then
			ball.RotVelocity += Camera.CFrame.RightVector * delta * SPEED_MULTIPLIER
		end
		if UserInputService:IsKeyDown("D") then
			ball.RotVelocity += Camera.CFrame.LookVector * delta * SPEED_MULTIPLIER
		end
	end)

	UserInputService.JumpRequest:Connect(function()
		local result = workspace:Raycast(
			ball.Position,
			Vector3.new(0, -((ball.Size.Y/2)+JUMP_GAP), 0),
			params
		)
		if result then
			ball.Velocity = ball.Velocity + Vector3.new(0,JUMP_POWER,0)
		end
	end)

	Camera.CameraSubject = ball
	humanoid.Died:Connect(function() tc:Disconnect() end)
end)

-- Hat Hub 🎩🧢 Single Click Button
local hatHubBtn = Instance.new("TextButton", tabContents["Main"])
hatHubBtn.Size = UDim2.new(1, -20, 0, 40)
hatHubBtn.Text = "Hat Hub 🎩🧢"
hatHubBtn.Font = Enum.Font.GothamBold
hatHubBtn.TextSize = 16
hatHubBtn.TextColor3 = Color3.new(1, 1, 1)
hatHubBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 80)
Instance.new("UICorner", hatHubBtn).CornerRadius = UDim.new(0, 8)

hatHubBtn.MouseButton1Click:Connect(function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/inkdupe/hat-scripts/refs/heads/main/updatedhathub.lua"))()
end)

-- Telekinesis
local tOn = false

local tBtn = Instance.new("TextButton", tabContents["Main"])
tBtn.Size = UDim2.new(1, -20, 0, 40)
tBtn.Text = "Telekinesis (V5) 🤯"
tBtn.Font = Enum.Font.GothamBold
tBtn.TextSize = 16
tBtn.TextColor3 = Color3.new(1, 1, 1)
tBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 80)
Instance.new("UICorner", tBtn).CornerRadius = UDim.new(0, 8)

tBtn.MouseButton1Click:Connect(function()
	tOn = not tOn
	tBtn.BackgroundColor3 = tOn and Color3.fromRGB(30, 200, 30) or Color3.fromRGB(50, 50, 80)

	if tOn then
		loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Fe-Telekinesis-V5-21542"))()
	end
end)

-- F3X Panel
local btnf3x = Instance.new("TextButton", tabContents["Main"])
btnf3x.Size = UDim2.new(1, -20, 0, 40)
btnf3x.Text = "FE F3X Panel 🛠"
btnf3x.Font = Enum.Font.GothamBold
btnf3x.TextSize = 16
btnf3x.TextColor3 = Color3.new(1, 1, 1)
btnf3x.BackgroundColor3 = Color3.fromRGB(50, 50, 80)
btnf3x.LayoutOrder = 1
Instance.new("UICorner", btnf3x).CornerRadius = UDim.new(0, 8)

local clicked = false

btnf3x.MouseButton1Click:Connect(function()
	if clicked then return end
	clicked = true

	loadstring(game:HttpGet("https://raw.githubusercontent.com/SkireScripts/F3X-Panel/main/Main.lua"))()
end)

-- R15 Master GUI ⏹️ Single Click Button
local r15GuiBtn = Instance.new("TextButton", tabContents["Main"])
r15GuiBtn.Size = UDim2.new(1, -20, 0, 40)
r15GuiBtn.Text = "R15 Master GUI ⏹️"
r15GuiBtn.Font = Enum.Font.GothamBold
r15GuiBtn.TextSize = 16
r15GuiBtn.TextColor3 = Color3.new(1, 1, 1)
r15GuiBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 80)
Instance.new("UICorner", r15GuiBtn).CornerRadius = UDim.new(0, 8)

r15GuiBtn.MouseButton1Click:Connect(function()
	loadstring(game:HttpGet("https://gitlab.com/Tsuniox/lua-stuff/-/raw/master/R15GUI.lua"))()
end)

-- R6 Anim GUI ⏹️ Single Click Button
local r6GuiBtn = Instance.new("TextButton", tabContents["Main"])
r6GuiBtn.Size = UDim2.new(1, -20, 0, 40)
r6GuiBtn.Text = "R6 Animations GUI ⏹️"
r6GuiBtn.Font = Enum.Font.GothamBold
r6GuiBtn.TextSize = 16
r6GuiBtn.TextColor3 = Color3.new(1, 1, 1)
r6GuiBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 80)
Instance.new("UICorner", r6GuiBtn).CornerRadius = UDim.new(0, 8)

r6GuiBtn.MouseButton1Click:Connect(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/ocfi/R6-Animations-Obfuscated/refs/heads/main/R6%20Animations"))()
end)

-- Admin Commands Abuse
local btnadmin = Instance.new("TextButton", tabContents["Main"])
btnadmin.Size = UDim2.new(1, -20, 0, 40)
btnadmin.Text = "FE Admin Abuse 👨🏻‍💻☠️"
btnadmin.Font = Enum.Font.GothamBold
btnadmin.TextSize = 16
btnadmin.TextColor3 = Color3.new(1, 1, 1)
btnadmin.BackgroundColor3 = Color3.fromRGB(50, 50, 80)
btnadmin.LayoutOrder = 1
Instance.new("UICorner", btnadmin).CornerRadius = UDim.new(0, 8)

local clicked = false

btnadmin.MouseButton1Click:Connect(function()
	if clicked then return end
	clicked = true

	loadstring(game:HttpGet("https://raw.githubusercontent.com/SuperHackerYT/skibidi/refs/heads/main/adminabusegui.lua"))()
end)

-- Console Bypass 👨🏻‍💻🔓 Single Click Button
local consoleBypassBtn = Instance.new("TextButton", tabContents["Main"])
consoleBypassBtn.Size = UDim2.new(1, -20, 0, 40)
consoleBypassBtn.Text = "Console Bypass 👨🏻‍💻🔓"
consoleBypassBtn.Font = Enum.Font.GothamBold
consoleBypassBtn.TextSize = 16
consoleBypassBtn.TextColor3 = Color3.new(1, 1, 1)
consoleBypassBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 80)
Instance.new("UICorner", consoleBypassBtn).CornerRadius = UDim.new(0, 8)

consoleBypassBtn.MouseButton1Click:Connect(function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/Dhelannn/Test/refs/heads/main/TerminalX"))()
end)

-- ESP
local espEnabled = false
local espBtn = Instance.new("TextButton", tabContents["Visual"])
espBtn.Size = UDim2.new(1, -20, 0, 40)
espBtn.Text = "🧿 ESP"
espBtn.Font = Enum.Font.GothamBold
espBtn.TextSize = 16
espBtn.TextColor3 = Color3.new(1, 1, 1)
espBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 80)
espBtn.LayoutOrder = 1
Instance.new("UICorner", espBtn).CornerRadius = UDim.new(0, 8)

local function createESP(plr)
	if plr == player then return end
	local char = plr.Character
	if not char then return end
	local head = char:FindFirstChild("Head")
	if not head then return end
	if head:FindFirstChild("ESP") then return end

	local tag = Instance.new("BillboardGui", head)
	tag.Name = "ESP"
	tag.Size = UDim2.new(0, 100, 0, 30)
	tag.AlwaysOnTop = true
	local label = Instance.new("TextLabel", tag)
	label.Size = UDim2.new(1, 0, 1, 0)
	label.BackgroundTransparency = 1
	label.Text = plr.Name
	label.TextColor3 = Color3.new(1, 0, 0)
	label.TextStrokeTransparency = 0.5
	label.TextScaled = true
end

espBtn.MouseButton1Click:Connect(function()
	espEnabled = not espEnabled
	espBtn.BackgroundColor3 = espEnabled and Color3.fromRGB(30, 200, 30) or Color3.fromRGB(50, 50, 80)

	for _, plr in pairs(game.Players:GetPlayers()) do
		if espEnabled then
			createESP(plr)
		else
			local char = plr.Character
			if char and char:FindFirstChild("Head") then
				local esp = char.Head:FindFirstChild("ESP")
				if esp then esp:Destroy() end
			end
		end
	end
end)

-- lgbt
local rainbowOn = false

local rainbowBtn = Instance.new("TextButton", tabContents["Visual"])
rainbowBtn.Size = UDim2.new(1, -20, 0, 40)
rainbowBtn.Text = "Rainbow World 🌈"
rainbowBtn.Font = Enum.Font.GothamBold
rainbowBtn.TextSize = 16
rainbowBtn.TextColor3 = Color3.new(1, 1, 1)
rainbowBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 80)
Instance.new("UICorner", rainbowBtn).CornerRadius = UDim.new(0, 8)

local lighting = game:GetService("Lighting")
local rainbowLoop

rainbowBtn.MouseButton1Click:Connect(function()
	rainbowOn = not rainbowOn
	rainbowBtn.BackgroundColor3 = rainbowOn and Color3.fromRGB(30, 200, 30) or Color3.fromRGB(50, 50, 80)

	if rainbowOn then
		local hue = 0
		rainbowLoop = game:GetService("RunService").RenderStepped:Connect(function()
			hue = (hue + 0.005) % 1
			local color = Color3.fromHSV(hue, 1, 1)
			lighting.Ambient = color
			lighting.OutdoorAmbient = color
			lighting.ColorShift_Top = color
			lighting.ColorShift_Bottom = color
		end)
	else
		if rainbowLoop then rainbowLoop:Disconnect() end
		lighting.Ambient = Color3.new(0.5, 0.5, 0.5)
		lighting.OutdoorAmbient = Color3.new(0.5, 0.5, 0.5)
		lighting.ColorShift_Top = Color3.new(0, 0, 0)
		lighting.ColorShift_Bottom = Color3.new(0, 0, 0)
	end
end)

-- lgbt
local rgbOn = false

local rgbBtn = Instance.new("TextButton", tabContents["Visual"])
rgbBtn.Size = UDim2.new(1, -20, 0, 40)
rgbBtn.Text = "RGB Outlines 🔵🟢🔴"
rgbBtn.Font = Enum.Font.GothamBold
rgbBtn.TextSize = 16
rgbBtn.TextColor3 = Color3.new(1, 1, 1)
rgbBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 80)
Instance.new("UICorner", rgbBtn).CornerRadius = UDim.new(0, 8)

local highlight = Instance.new("Highlight")
highlight.FillTransparency = 1
highlight.OutlineTransparency = 0
highlight.Parent = game.CoreGui

local rgbLoop

rgbBtn.MouseButton1Click:Connect(function()
	rgbOn = not rgbOn
	rgbBtn.BackgroundColor3 = rgbOn and Color3.fromRGB(30, 200, 30) or Color3.fromRGB(50, 50, 80)

	if rgbOn then
		highlight.Adornee = game.Players.LocalPlayer.Character
		local hue = 0
		rgbLoop = game:GetService("RunService").RenderStepped:Connect(function()
			hue = (hue + 0.01) % 1
			local color = Color3.fromHSV(hue, 1, 1)
			highlight.OutlineColor = color
		end)
	else
		if rgbLoop then rgbLoop:Disconnect() end
		highlight.Adornee = nil
	end
end)

-- Skibidi Nuke
local nukeBtn = Instance.new("TextButton", tabContents["Visual"])
nukeBtn.Size = UDim2.new(1, -20, 0, 40)
nukeBtn.Text = "💥 Nuke Map"
nukeBtn.Font = Enum.Font.GothamBold
nukeBtn.TextSize = 16
nukeBtn.TextColor3 = Color3.new(1, 1, 1)
nukeBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
nukeBtn.LayoutOrder = 5
Instance.new("UICorner", nukeBtn).CornerRadius = UDim.new(0, 8)

nukeBtn.MouseButton1Click:Connect(function()
	local Model = Instance.new("Model", workspace)
	local Cloud1 = Instance.new("Part")
	local Cloud2 = Instance.new("Part")
	local Cloud1Mesh = Instance.new("SpecialMesh")
	local Cloud2Mesh = Instance.new("SpecialMesh")
	local Sound = Instance.new("Sound", workspace)
	local sky = Instance.new("Sky")
	local NUKE_COLOR = 24
	local CLOUD_TRANSPARENCY = 0.25

	wait(1.5)

	local function radiation(hit)
		local h = hit.Parent:FindFirstChild("Humanoid")
		if h then
			h.WalkSpeed = 5
			pcall(function() h.Parent["Right Leg"]:Destroy() end)
			pcall(function() h.Parent["Left Arm"]:Destroy() end)
			for i = 1, h.MaxHealth do
				h.Health = h.Health - 10
				wait(1)
			end
		end
	end

	local function unanchor(m)
		for _, i in pairs(m:GetDescendants()) do
			if i:IsA("Part") or i:IsA("UnionOperation") or i:IsA("WedgePart") then
				local Fire = Instance.new("Fire", i)
				Fire.Size = math.random(5, 10)
				i.Material = Enum.Material.CorrodedMetal
				i.BrickColor = BrickColor.new(26)
				i:BreakJoints()
				i.Touched:Connect(radiation)
			end
		end
	end
	unanchor(workspace)

	Sound.SoundId = "rbxassetid://2248511"
	Sound.PlaybackSpeed = 0.2
	Sound.Volume = 10
	Sound:Play()

	Model.Name = "Mushroom Cloud"
	Cloud1.Parent = Model
	Cloud1.Anchored = true
	Cloud1.CanCollide = false
	Cloud1Mesh.Parent = Cloud1
	Cloud1Mesh.MeshType = Enum.MeshType.FileMesh
	Cloud1Mesh.MeshId = "rbxassetid://1095708"
	Cloud1Mesh.Scale = Vector3.new(95, 300, 195)

	Cloud2.Parent = Model
	Cloud2.Anchored = true
	Cloud2.CanCollide = false
	Cloud2.Position = Vector3.new(0, 587, 0)
	Cloud2Mesh.Parent = Cloud2
	Cloud2Mesh.MeshType = Enum.MeshType.FileMesh
	Cloud2Mesh.MeshId = "rbxassetid://1095708"
	Cloud2Mesh.Scale = Vector3.new(399, 399, 649)

	Cloud1.Transparency = CLOUD_TRANSPARENCY
	Cloud2.Transparency = CLOUD_TRANSPARENCY
	Cloud1.BrickColor = BrickColor.new(NUKE_COLOR)
	Cloud2.BrickColor = BrickColor.new(NUKE_COLOR)

	sky.Name = "NukeSky"
	sky.Parent = game.Lighting
	sky.CelestialBodiesShown = true
	sky.SkyboxBk = "rbxassetid://1012890"
	sky.SkyboxDn = "rbxassetid://1012891"
	sky.SkyboxFt = "rbxassetid://1012887"
	sky.SkyboxLf = "rbxassetid://1012889"
	sky.SkyboxRt = "rbxassetid://1012888"
	sky.SkyboxUp = "rbxassetid://1014449"

	local explosion = Instance.new("Explosion")
	explosion.Parent = workspace
	explosion.BlastRadius = 9999999999999
	explosion.BlastPressure = 10000000

	game.Lighting.Brightness = 999
	game.Lighting.OutdoorAmbient = Color3.new(1, 0, 0)

	for i = 1, 8 do
		wait(0.25)
		Cloud1Mesh.Scale = Cloud1Mesh.Scale + Vector3.new(0, 200, 0)
	end
	wait(30)

	game.Lighting.Ambient = Color3.new(0, 0, 0)
	game.Lighting.OutdoorAmbient = Color3.new(0.5, 0.5, 0.5)
	sky:Destroy()
	game.Lighting.Brightness = 1

	Cloud1.BrickColor = BrickColor.new(1)
	Cloud2.BrickColor = BrickColor.new(1)

	for _, transparency in ipairs({0.6, 0.7, 0.8, 0.9}) do
		wait(5)
		Cloud1.Transparency = transparency
		Cloud2.Transparency = transparency
	end

	wait(120)
	Cloud1:Destroy()
	Cloud2:Destroy()
end)

-- 1x1x1x1
local btn1x1 = Instance.new("TextButton", tabContents["Main"])
btn1x1.Size = UDim2.new(1, -20, 0, 40)
btn1x1.Text = "1x1x1x1 GUI 😈"
btn1x1.Font = Enum.Font.GothamBold
btn1x1.TextSize = 16
btn1x1.TextColor3 = Color3.new(1, 1, 1)
btn1x1.BackgroundColor3 = Color3.fromRGB(50, 50, 80)
btn1x1.LayoutOrder = 1
Instance.new("UICorner", btn1x1).CornerRadius = UDim.new(0, 8)

local clicked = false

btn1x1.MouseButton1Click:Connect(function()
	if clicked then return end
	clicked = true

	loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-my-1x1x1x1-fe-gui-32050"))()
end)

-- Bounce Unanchored
local btnbc = Instance.new("TextButton", tabContents["Visual"])
btnbc.Size = UDim2.new(1, -20, 0, 40)
btnbc.Text = "Bounce Unanchored 🏏"
btnbc.Font = Enum.Font.GothamBold
btnbc.TextSize = 16
btnbc.TextColor3 = Color3.new(1, 1, 1)
btnbc.BackgroundColor3 = Color3.fromRGB(50, 50, 80)
btnbc.LayoutOrder = 1
Instance.new("UICorner", btnbc).CornerRadius = UDim.new(0, 8)

local clicked = false

btnbc.MouseButton1Click:Connect(function()
	if clicked then return end
	clicked = true

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
end)

-- Explode Everything
local btnexp = Instance.new("TextButton", tabContents["Visual"])
btnexp.Size = UDim2.new(1, -20, 0, 40)
btnexp.Text = "Explode Everything 💥☠️"
btnexp.Font = Enum.Font.GothamBold
btnexp.TextSize = 16
btnexp.TextColor3 = Color3.new(1, 1, 1)
btnexp.BackgroundColor3 = Color3.fromRGB(50, 50, 80)
btnexp.LayoutOrder = 1
Instance.new("UICorner", btnexp).CornerRadius = UDim.new(0, 8)

local clicked = false

btnexp.MouseButton1Click:Connect(function()
	if clicked then return end
	clicked = true

						--// Explode Everything Script
for _, obj in pairs(game.Workspace:GetDescendants()) do
    if obj:IsA("BasePart") then
        local explosion = Instance.new("Explosion")
        explosion.Position = obj.Position
        explosion.BlastRadius = 10
        explosion.BlastPressure = 500000
        explosion.DestroyJointRadiusPercent = 1
        explosion.Parent = game.Workspace
    end
end
end)

-- Skibidi Brightness
local fullBright = false

local fullBrightBtn = Instance.new("TextButton", tabContents["Visual"])
fullBrightBtn.Size = UDim2.new(1, -20, 0, 40)
fullBrightBtn.Text = "Full Bright 💡"
fullBrightBtn.Font = Enum.Font.GothamBold
fullBrightBtn.TextSize = 16
fullBrightBtn.TextColor3 = Color3.new(1, 1, 1)
fullBrightBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 80)
fullBrightBtn.LayoutOrder = 2
Instance.new("UICorner", fullBrightBtn).CornerRadius = UDim.new(0, 8)

local lighting = game:GetService("Lighting")
local originalBrightness = lighting.Brightness
local originalTime = lighting.TimeOfDay
local originalFogEnd = lighting.FogEnd

fullBrightBtn.MouseButton1Click:Connect(function()
	fullBright = not fullBright
	fullBrightBtn.BackgroundColor3 = fullBright and Color3.fromRGB(30, 200, 30) or Color3.fromRGB(50, 50, 80)

	if fullBright then
		lighting.Brightness = 5
		lighting.TimeOfDay = "14:00:00"
		lighting.FogEnd = 100000
	else
		lighting.Brightness = originalBrightness
		lighting.TimeOfDay = originalTime
		lighting.FogEnd = originalFogEnd
	end
end)

-- Helper
local Lighting = game:GetService("Lighting")

-- No Shadows Toggle
local noShadowsOn = false
local noShadowsBtn = Instance.new("TextButton", tabContents["Visual"])
noShadowsBtn.Size = UDim2.new(1, -20, 0, 40)
noShadowsBtn.Text = "No Shadows 🌑"
noShadowsBtn.Font = Enum.Font.GothamBold
noShadowsBtn.TextSize = 16
noShadowsBtn.TextColor3 = Color3.new(1, 1, 1)
noShadowsBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 80)
Instance.new("UICorner", noShadowsBtn).CornerRadius = UDim.new(0, 8)

noShadowsBtn.MouseButton1Click:Connect(function()
	noShadowsOn = not noShadowsOn
	noShadowsBtn.BackgroundColor3 = noShadowsOn and Color3.fromRGB(30, 200, 30) or Color3.fromRGB(50, 50, 80)
	Lighting.GlobalShadows = not noShadowsOn
end)

-- Wireframe Mode Toggle
local wireframeOn = false
local wireframeBtn = Instance.new("TextButton", tabContents["Visual"])
wireframeBtn.Size = UDim2.new(1, -20, 0, 40)
wireframeBtn.Text = "Wireframe Mode 🕸️"
wireframeBtn.Font = Enum.Font.GothamBold
wireframeBtn.TextSize = 16
wireframeBtn.TextColor3 = Color3.new(1, 1, 1)
wireframeBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 80)
Instance.new("UICorner", wireframeBtn).CornerRadius = UDim.new(0, 8)

wireframeBtn.MouseButton1Click:Connect(function()
	wireframeOn = not wireframeOn
	wireframeBtn.BackgroundColor3 = wireframeOn and Color3.fromRGB(30, 200, 30) or Color3.fromRGB(50, 50, 80)

	for _, obj in pairs(workspace:GetDescendants()) do
		if obj:IsA("BasePart") then
			pcall(function()
				obj.Material = wireframeOn and Enum.Material.ForceField or Enum.Material.Plastic
			end)
		end
	end
end)

-- Night Mode Toggle
local nightModeOn = false
local nightBtn = Instance.new("TextButton", tabContents["Visual"])
nightBtn.Size = UDim2.new(1, -20, 0, 40)
nightBtn.Text = "Night Mode 🌃"
nightBtn.Font = Enum.Font.GothamBold
nightBtn.TextSize = 16
nightBtn.TextColor3 = Color3.new(1, 1, 1)
nightBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 80)
Instance.new("UICorner", nightBtn).CornerRadius = UDim.new(0, 8)

nightBtn.MouseButton1Click:Connect(function()
	nightModeOn = not nightModeOn
	nightBtn.BackgroundColor3 = nightModeOn and Color3.fromRGB(30, 200, 30) or Color3.fromRGB(50, 50, 80)
	Lighting.ClockTime = nightModeOn and 0 or 14
end)

-- X-Ray Vision Toggle
local xrayOn = false
local xrayBtn = Instance.new("TextButton", tabContents["Visual"])
xrayBtn.Size = UDim2.new(1, -20, 0, 40)
xrayBtn.Text = "X-Ray Vision 🧿"
xrayBtn.Font = Enum.Font.GothamBold
xrayBtn.TextSize = 16
xrayBtn.TextColor3 = Color3.new(1, 1, 1)
xrayBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 80)
Instance.new("UICorner", xrayBtn).CornerRadius = UDim.new(0, 8)

xrayBtn.MouseButton1Click:Connect(function()
	xrayOn = not xrayOn
	xrayBtn.BackgroundColor3 = xrayOn and Color3.fromRGB(30, 200, 30) or Color3.fromRGB(50, 50, 80)

	for _, obj in pairs(workspace:GetDescendants()) do
		if obj:IsA("BasePart") and not obj:IsDescendantOf(game.Players.LocalPlayer.Character) then
			pcall(function()
				obj.LocalTransparencyModifier = xrayOn and 0.8 or 0
			end)
		end
	end
end)

-- Sky Color Changer Toggle
local skyToggleOn = false
local skyBtn = Instance.new("TextButton", tabContents["Visual"])
skyBtn.Size = UDim2.new(1, -20, 0, 40)
skyBtn.Text = "Sky Color 🌈"
skyBtn.Font = Enum.Font.GothamBold
skyBtn.TextSize = 16
skyBtn.TextColor3 = Color3.new(1, 1, 1)
skyBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 80)
Instance.new("UICorner", skyBtn).CornerRadius = UDim.new(0, 8)

-- Optional: custom skybox color settings
local originalSky = Lighting:FindFirstChildOfClass("Sky")
local customSky = Instance.new("Sky")
customSky.SkyboxBk = ""
customSky.SkyboxDn = ""
customSky.SkyboxFt = ""
customSky.SkyboxLf = ""
customSky.SkyboxRt = ""
customSky.SkyboxUp = ""
customSky.SkyboxBk = "http://www.roblox.com/asset/?id=159454299" -- pink nebula
customSky.SkyboxDn = "http://www.roblox.com/asset/?id=159454296"
customSky.SkyboxFt = "http://www.roblox.com/asset/?id=159454293"
customSky.SkyboxLf = "http://www.roblox.com/asset/?id=159454286"
customSky.SkyboxRt = "http://www.roblox.com/asset/?id=159454300"
customSky.SkyboxUp = "http://www.roblox.com/asset/?id=159454288"
customSky.Name = "CustomSky"

skyBtn.MouseButton1Click:Connect(function()
	skyToggleOn = not skyToggleOn
	skyBtn.BackgroundColor3 = skyToggleOn and Color3.fromRGB(30, 200, 30) or Color3.fromRGB(50, 50, 80)

	if skyToggleOn then
		if originalSky then originalSky.Parent = nil end
		customSky.Parent = Lighting
	else
		customSky.Parent = nil
		if originalSky then originalSky.Parent = Lighting end
	end
end)

-- Speedhubx
local s1On = false

local s1Btn = Instance.new("TextButton", tabContents["Games"])
s1Btn.Size = UDim2.new(1, -20, 0, 40)
s1Btn.Text = "Grow A Garden 🌶"
s1Btn.Font = Enum.Font.GothamBold
s1Btn.TextSize = 16
s1Btn.TextColor3 = Color3.new(1, 1, 1)
s1Btn.BackgroundColor3 = Color3.fromRGB(50, 50, 80)
Instance.new("UICorner", s1Btn).CornerRadius = UDim.new(0, 8)

s1Btn.MouseButton1Click:Connect(function()
	s1On = not s1On
	s1Btn.BackgroundColor3 = s1On and Color3.fromRGB(30, 200, 30) or Color3.fromRGB(50, 50, 80)

	if s1On then
		loadstring(game:HttpGet("https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua", true))()
	end
end)

-- Speedhubx
local s1On = false

local s2Btn = Instance.new("TextButton", tabContents["Games"])
s2Btn.Size = UDim2.new(1, -20, 0, 40)
s2Btn.Text = "Blox Fruits ⚔"
s2Btn.Font = Enum.Font.GothamBold
s2Btn.TextSize = 16
s2Btn.TextColor3 = Color3.new(1, 1, 1)
s2Btn.BackgroundColor3 = Color3.fromRGB(50, 50, 80)
Instance.new("UICorner", s2Btn).CornerRadius = UDim.new(0, 8)

s2Btn.MouseButton1Click:Connect(function()
	s2On = not s2On
	s2Btn.BackgroundColor3 = s2On and Color3.fromRGB(30, 200, 30) or Color3.fromRGB(50, 50, 80)

	if s2On then
		loadstring(game:HttpGet("https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua", true))()
	end
end)

-- Speedhubx
local s3On = false

local s3Btn = Instance.new("TextButton", tabContents["Games"])
s3Btn.Size = UDim2.new(1, -20, 0, 40)
s3Btn.Text = "Fisch 🐠 "
s3Btn.Font = Enum.Font.GothamBold
s3Btn.TextSize = 16
s3Btn.TextColor3 = Color3.new(1, 1, 1)
s3Btn.BackgroundColor3 = Color3.fromRGB(50, 50, 80)
Instance.new("UICorner", s3Btn).CornerRadius = UDim.new(0, 8)

s1Btn.MouseButton1Click:Connect(function()
	s3On = not s3On
	s3Btn.BackgroundColor3 = s3On and Color3.fromRGB(30, 200, 30) or Color3.fromRGB(50, 50, 80)

	if s3On then
		loadstring(game:HttpGet("https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua", true))()
	end
end)

-- Speedhubx
local s5On = false

local s5Btn = Instance.new("TextButton", tabContents["Games"])
s5Btn.Size = UDim2.new(1, -20, 0, 40)
s5Btn.Text = "Pet Sim 99 😺"
s5Btn.Font = Enum.Font.GothamBold
s5Btn.TextSize = 16
s5Btn.TextColor3 = Color3.new(1, 1, 1)
s5Btn.BackgroundColor3 = Color3.fromRGB(50, 50, 80)
Instance.new("UICorner", s5Btn).CornerRadius = UDim.new(0, 8)

s1Btn.MouseButton1Click:Connect(function()
	s5On = not s5On
	s5Btn.BackgroundColor3 = s5On and Color3.fromRGB(30, 200, 30) or Color3.fromRGB(50, 50, 80)

	if s5On then
		loadstring(game:HttpGet("https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua", true))()
	end
end)

-- Dead Rails 🚆
local deadRailsBtn = Instance.new("TextButton", tabContents["Games"])
deadRailsBtn.Size = UDim2.new(1, -20, 0, 40)
deadRailsBtn.Text = "Dead Rails 🚆"
deadRailsBtn.Font = Enum.Font.GothamBold
deadRailsBtn.TextSize = 16
deadRailsBtn.TextColor3 = Color3.new(1, 1, 1)
deadRailsBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 80)
Instance.new("UICorner", deadRailsBtn).CornerRadius = UDim.new(0, 8)

deadRailsBtn.MouseButton1Click:Connect(function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/InfernusScripts/Null-Fire/main/Loader"))()
end)

-- Pressure 👾
local pressureBtn = Instance.new("TextButton", tabContents["Games"])
pressureBtn.Size = UDim2.new(1, -20, 0, 40)
pressureBtn.Text = "Pressure 👾"
pressureBtn.Font = Enum.Font.GothamBold
pressureBtn.TextSize = 16
pressureBtn.TextColor3 = Color3.new(1, 1, 1)
pressureBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 80)
Instance.new("UICorner", pressureBtn).CornerRadius = UDim.new(0, 8)

pressureBtn.MouseButton1Click:Connect(function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/InfernusScripts/Null-Fire/main/Loader"))()
end)

-- lazy
local pressureBtn = Instance.new("TextButton", tabContents["Games"])
pressureBtn.Size = UDim2.new(1, -20, 0, 40)
pressureBtn.Text = "Lazy V4 (The Chosen One)"
pressureBtn.Font = Enum.Font.GothamBold
pressureBtn.TextSize = 16
pressureBtn.TextColor3 = Color3.new(1, 1, 1)
pressureBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 80)
Instance.new("UICorner", pressureBtn).CornerRadius = UDim.new(0, 8)

pressureBtn.MouseButton1Click:Connect(function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/FlavorYT/The-lazy-ONE/main/Made%20by%20leakz%20and%20EvilAlienWare"))()
end)

-- Icon Button
local icon = Instance.new("ImageButton", gui)
icon.Size = UDim2.new(0, 60, 0, 60)
icon.Position = UDim2.new(0.5, -32, 0, 30)
icon.BackgroundTransparency = 1
icon.ImageTransparency = 0
icon.Image = "rbxassetid://6031094678"
icon.ScaleType = Enum.ScaleType.Fit
icon.ImageColor3 = Color3.new(1, 1, 1)

icon.MouseButton1Click:Connect(function()
	main.Visible = not main.Visible
end)

-- Icon Dragging
local dragging = false
local dragOffset
icon.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragOffset = Vector2.new(input.Position.X - icon.AbsolutePosition.X, input.Position.Y - icon.AbsolutePosition.Y)
	end
end)
uis.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = false
	end
end)
uis.InputChanged:Connect(function(input)
	if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
		icon.Position = UDim2.new(0, input.Position.X - dragOffset.X, 0, input.Position.Y - dragOffset.Y)
	end
end)