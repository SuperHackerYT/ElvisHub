-- Executor-Compatible SimpleUI (no PlayerGui wait)

local SimpleUI = {}
SimpleUI.__index = SimpleUI

local player = game:GetService("Players").LocalPlayer
local gui = Instance.new("ScreenGui")
local UIS = game:GetService("UserInputService")
local TS = game:GetService("TouchInputService")
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

function SimpleUI.new()
	local self = setmetatable({}, SimpleUI)
	self.ScreenGui = gui
	return self
end

function SimpleUI:CreateWindow(title)
	local frame = Instance.new("Frame")
	frame.Size = UDim2.new(0, 300, 0, 400)
	frame.Position = UDim2.new(0.5, -150, 0.5, -200)
	frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	frame.BorderSizePixel = 0
	frame.Parent = self.ScreenGui

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 8)
	corner.Parent = frame

	local titleLabel = Instance.new("TextLabel")
	titleLabel.Size = UDim2.new(1, -40, 0, 40)
	titleLabel.BackgroundTransparency = 1
	titleLabel.Text = title
	titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	titleLabel.Font = Enum.Font.GothamBold
	titleLabel.TextSize = 18
	titleLabel.Parent = frame

	local close = Instance.new("TextButton")
	close.Size = UDim2.new(0, 30, 0, 30)
	close.Position = UDim2.new(1, -35, 0, 5)
	close.BackgroundTransparency = 1
	close.Text = "X"
	close.TextColor3 = Color3.fromRGB(255, 100, 100)
	close.Font = Enum.Font.GothamBold
	close.Parent = frame
	close.MouseButton1Click:Connect(function() frame:Destroy() end)

	local container = Instance.new("ScrollingFrame")
	container.Size = UDim2.new(1, -10, 1, -50)
	container.Position = UDim2.new(0, 5, 0, 45)
	container.BackgroundTransparency = 1
	container.ScrollBarThickness = 4
	container.CanvasSize = UDim2.new(0, 0, 0, 0)
	container.Parent = frame

	local layout = Instance.new("UIListLayout")
	layout.Padding = UDim.new(0, 8)
	layout.Parent = container
	layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		container.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 10)
	end)

	local dragging = false
	titleLabel.InputBegan:Connect(function(inp)
		if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			local delta = inp.Position - frame.AbsolutePosition
			local conn
			conn = UIS.InputChanged:Connect(function(i)
				if dragging and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
					frame.Position = UDim2.new(0, i.Position.X - delta.X, 0, i.Position.Y - delta.Y)
				end
			end)
			inp.Changed:Connect(function()
				if inp.UserInputState == Enum.UserInputState.End then
					dragging = false
					conn:Disconnect()
				end
			end)
		end
	end)

	local window = {Frame = frame, Container = container}
	return window
end

function SimpleUI:AddButton(window, text, callback)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(1, -10, 0, 40)
	btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	btn.Text = text
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.Font = Enum.Font.Gotham
	btn.TextSize = 16
	btn.Parent = window.Container

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 6)
	corner.Parent = btn

	btn.MouseButton1Click:Connect(callback)
	btn.TouchTap:Connect(callback)
end

function SimpleUI:AddToggle(window, text, default, callback)
	local frame = Instance.new("Frame")
	frame.Size = UDim2.new(1, -10, 0, 40)
	frame.BackgroundTransparency = 1
	frame.Parent = window.Container

	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1, -50, 1, 0)
	label.BackgroundTransparency = 1
	label.Text = text
	label.TextColor3 = Color3.fromRGB(255, 255, 255)
	label.Font = Enum.Font.Gotham
	label.TextSize = 16
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.Parent = frame

	local toggle = Instance.new("TextButton")
	toggle.Size = UDim2.new(0, 50, 0, 25)
	toggle.Position = UDim2.new(1, -55, 0.5, -12.5)
	toggle.BackgroundColor3 = default and Color3.fromRGB(0, 170, 255) or Color3.fromRGB(100, 100, 100)
	toggle.Text = ""
	toggle.Parent = frame

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 12)
	corner.Parent = toggle

	local state = default
	local function toggleState()
		state = not state
		toggle.BackgroundColor3 = state and Color3.fromRGB(0, 170, 255) or Color3.fromRGB(100, 100, 100)
		callback(state)
	end
	toggle.MouseButton1Click:Connect(toggleState)
	toggle.TouchTap:Connect(toggleState)
end

function SimpleUI:AddSlider(window, text, min, max, default, callback)
	local frame = Instance.new("Frame")
	frame.Size = UDim2.new(1, -10, 0, 60)
	frame.BackgroundTransparency = 1
	frame.Parent = window.Container

	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1, 0, 0, 20)
	label.BackgroundTransparency = 1
	label.Text = text .. ": " .. default
	label.TextColor3 = Color3.fromRGB(255, 255, 255)
	label.Font = Enum.Font.Gotham
	label.TextSize = 16
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.Parent = frame

	local track = Instance.new("Frame")
	track.Size = UDim2.new(1, 0, 0, 12)
	track.Position = UDim2.new(0, 0, 0, 30)
	track.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
	track.Parent = frame

	local fill = Instance.new("Frame")
	fill.Size = UDim2.new((default - min)/(max - min), 0, 1, 0)
	fill.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
	fill.Parent = track

	local knob = Instance.new("Frame")
	knob.Size = UDim2.new(0, 24, 0, 24)
	knob.Position = UDim2.new(fill.Size.X.Scale - 0.5, -12, 0.5, -12)
	knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	knob.ZIndex = 2
	knob.Parent = track

	local corner1 = Instance.new("UICorner")
	corner1.CornerRadius = UDim.new(0, 6)
	corner1.Parent = track
	local corner2 = Instance.new("UICorner")
	corner2.CornerRadius = UDim.new(0, 6)
	corner2.Parent = fill
	local corner3 = Instance.new("UICorner")
	corner3.CornerRadius = UDim.new(1, 0)
	corner3.Parent = knob

	local dragging = false
	local conn

	local function update(pos)
		local rel = math.clamp((pos.X - track.AbsolutePosition.X) / track.AbsoluteSize.X, 0, 1)
		local value = math.floor(min + rel * (max - min) + 0.5)
		fill.Size = UDim2.new(rel, 0, 1, 0)
		knob.Position = UDim2.new(rel, -12, 0.5, -12)
		label.Text = text .. ": " .. value
		callback(value)
	end

	local function startDrag(inp)
		if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			update(inp.Position)
			if conn then conn:Disconnect() end
			conn = UIS.InputChanged:Connect(function(i)
				if dragging and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
					update(i.Position)
				end
			end)
		end
	end

	local function endDrag(inp)
		if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
			dragging = false
			if conn then conn:Disconnect() end
		end
	end

	track.InputBegan:Connect(startDrag)
	track.InputEnded:Connect(endDrag)
	knob.InputBegan:Connect(startDrag)
	knob.InputEnded:Connect(endDrag)
end

function SimpleUI:AddDropdown(window, text, options, defaultIndex, callback)
	local frame = Instance.new("Frame")
	frame.Size = UDim2.new(1, -10, 0, 40)
	frame.BackgroundTransparency = 1
	frame.Parent = window.Container

	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(0.5, 0, 1, 0)
	label.BackgroundTransparency = 1
	label.Text = text
	label.TextColor3 = Color3.fromRGB(255, 255, 255)
	label.Font = Enum.Font.Gotham
	label.TextSize = 16
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.Parent = frame

	local drop = Instance.new("TextButton")
	drop.Size = UDim2.new(0.5, 0, 1, 0)
	drop.Position = UDim2.new(0.5, 0, 0, 0)
	drop.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	drop.Text = options[defaultIndex or 1]
	drop.TextColor3 = Color3.fromRGB(255, 255, 255)
	drop.Font = Enum.Font.Gotham
	drop.TextSize = 16
	drop.Parent = frame

	local arrow = Instance.new("TextLabel")
	arrow.Size = UDim2.new(0, 20, 1, 0)
	arrow.Position = UDim2.new(1, -25, 0, 0)
	arrow.BackgroundTransparency = 1
	arrow.Text = "▼"
	arrow.TextColor3 = Color3.fromRGB(200, 200, 200)
	arrow.Font = Enum.Font.Gotham
	arrow.Parent = drop

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 6)
	corner.Parent = drop

	local list = Instance.new("ScrollingFrame")
	list.Size = UDim2.new(0.5, 0, 0, math.min(#options, 4) * 35)
	list.Position = UDim2.new(0.5, 0, 1, 5)
	list.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	list.Visible = false
	list.ScrollBarThickness = 3
	list.Parent = frame

	local listLayout = Instance.new("UIListLayout")
	listLayout.Parent = list

	for i, opt in ipairs(options) do
		local btn = Instance.new("TextButton")
		btn.Size = UDim2.new(1, 0, 0, 35)
		btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
		btn.Text = opt
		btn.TextColor3 = Color3.fromRGB(255, 255, 255)
		btn.Font = Enum.Font.Gotham
		btn.TextSize = 16
		btn.Parent = list
		btn.MouseButton1Click:Connect(function()
			drop.Text = opt
			list.Visible = false
			callback(opt, i)
		end)
		btn.TouchTap:Connect(function()
			drop.Text = opt
			list.Visible = false
			callback(opt, i)
		end)
	end

	drop.MouseButton1Click:Connect(function() list.Visible = not list.Visible end)
	drop.TouchTap:Connect(function() list.Visible = not list.Visible end)
end

function SimpleUI:AddTextInput(window, placeholder, default, callback)
	local frame = Instance.new("Frame")
	frame.Size = UDim2.new(1, -10, 0, 45)
	frame.BackgroundTransparency = 1
	frame.Parent = window.Container

	local box = Instance.new("TextBox")
	box.Size = UDim2.new(1, 0, 1, 0)
	box.Position = UDim2.new(0, 0, 0, 0)
	box.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	box.PlaceholderText = placeholder
	box.Text = default or ""
	box.TextColor3 = Color3.fromRGB(255, 255, 255)
	box.Font = Enum.Font.Gotham
	box.TextSize = 16
	box.ClearTextOnFocus = false
	box.Parent = frame

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 6)
	corner.Parent = box

	box.FocusLost:Connect(function(enter)
		if enter then
			callback(box.Text)
		end
	end)
end

return SimpleUI