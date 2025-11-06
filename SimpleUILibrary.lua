-- SimpleUI
local SimpleUI = {}
SimpleUI.__index = SimpleUI

local UIS = game:GetService("UserInputService")
local player = game:GetService("Players").LocalPlayer
local gui = Instance.new("ScreenGui")
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
	frame.ClipsDescendants = true
	frame.Parent = self.ScreenGui

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 8)
	corner.Parent = frame

	local titleBar = Instance.new("Frame")
	titleBar.Size = UDim2.new(1, 0, 0, 40)
	titleBar.BackgroundTransparency = 1
	titleBar.Parent = frame

	local titleLabel = Instance.new("TextLabel")
	titleLabel.Size = UDim2.new(1, -80, 1, 0)
	titleLabel.BackgroundTransparency = 1
	titleLabel.Text = title
	titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	titleLabel.Font = Enum.Font.GothamBold
	titleLabel.TextSize = 18
	titleLabel.TextXAlignment = Enum.TextXAlignment.Left
	titleLabel.Position = UDim2.new(0, 10, 0, 0)
	titleLabel.Parent = titleBar

	local minimize = Instance.new("TextButton")
	minimize.Size = UDim2.new(0, 30, 0, 30)
	minimize.Position = UDim2.new(1, -70, 0, 5)
	minimize.BackgroundTransparency = 1
	minimize.Text = "−"
	minimize.TextColor3 = Color3.fromRGB(255, 255, 255)
	minimize.Font = Enum.Font.GothamBold
	minimize.Parent = titleBar

	local close = Instance.new("TextButton")
	close.Size = UDim2.new(0, 30, 0, 30)
	close.Position = UDim2.new(1, -35, 0, 5)
	close.BackgroundTransparency = 1
	close.Text = "X"
	close.TextColor3 = Color3.fromRGB(255, 100, 100)
	close.Font = Enum.Font.GothamBold
	close.Parent = titleBar

	local container = Instance.new("ScrollingFrame")
	container.Size = UDim2.new(1, -10, 1, -50)
	container.Position = UDim2.new(0, 5, 0, 45)
	container.BackgroundTransparency = 1
	container.ScrollBarThickness = 6
	container.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100)
	container.CanvasSize = UDim2.new(0, 0, 0, 0)
	container.Visible = true
	container.Parent = frame

	local layout = Instance.new("UIListLayout")
	layout.Padding = UDim.new(0, 8)
	layout.Parent = container
	layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		container.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 10)
	end)

	-- Draggable (fixed shared InputChanged)
	local dragging = false
	local startPos, startInput
	titleBar.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			startPos = frame.Position
			startInput = input.Position
			local conn
			conn = UIS.InputChanged:Connect(function(i)
				if dragging and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
					local delta = i.Position - startInput
					frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
				end
			end)
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
					conn:Disconnect()
				end
			end)
		end
	end)

	-- Minimize Icon (fixed shared InputChanged)
	local icon = Instance.new("TextButton")
	icon.Size = UDim2.new(0, 50, 0, 50)
	icon.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	icon.Text = title:sub(1,1)
	icon.TextColor3 = Color3.fromRGB(255, 255, 255)
	icon.Font = Enum.Font.GothamBold
	icon.TextSize = 20
	icon.Visible = false
	icon.Parent = self.ScreenGui
	local ic = Instance.new("UICorner", icon); ic.CornerRadius = UDim.new(0, 8)

	local iconDrag = false
	local iconStart, iconInput
	icon.InputBegan:Connect(function(i)
		if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
			iconDrag = true
			iconStart = icon.Position
			iconInput = i.Position
			local conn
			conn = UIS.InputChanged:Connect(function(inp)
				if iconDrag and (inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch) then
					local d = inp.Position - iconInput
					icon.Position = UDim2.new(iconStart.X.Scale, iconStart.X.Offset + d.X, iconStart.Y.Scale, iconStart.Y.Offset + d.Y)
				end
			end)
			i.Changed:Connect(function()
				if i.UserInputState == Enum.UserInputState.End then
					iconDrag = false
					conn:Disconnect()
				end
			end)
		end
	end)

	minimize.MouseButton1Click:Connect(function()
		frame.Visible = false
		icon.Visible = true
		icon.Position = frame.Position
	end)
	icon.MouseButton1Click:Connect(function()
		icon.Visible = false
		frame.Visible = true
		frame.Position = icon.Position
	end)
	close.MouseButton1Click:Connect(function()
		frame:Destroy()
		icon:Destroy()
	end)

	return {Frame = frame, Container = container, Icon = icon}
end

-- Button: prevent double-fire
function SimpleUI:AddButton(window, text, callback)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(1, -10, 0, 40)
	btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	btn.Text = text
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.Font = Enum.Font.Gotham
	btn.TextSize = 16
	btn.AutoButtonColor = false
	btn.Parent = window.Container

	local c = Instance.new("UICorner", btn); c.CornerRadius = UDim.new(0, 6)

	local clicking = false
	btn.MouseButton1Down:Connect(function()
		clicking = true
	end)
	btn.MouseButton1Up:Connect(function()
		if clicking and UIS:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) == false then
			callback()
		end
		clicking = false
	end)
	btn.TouchTap:Connect(callback)
end

-- Toggle: prevent double
function SimpleUI:AddToggle(window, text, default, callback)
	local frame = Instance.new("Frame")
	frame.Size = UDim2.new(1, -10, 0, 40)
	frame.BackgroundTransparency = 1
	frame.Parent = window.Container

	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1, -60, 1, 0)
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
	toggle.AutoButtonColor = false
	toggle.Parent = frame

	local c = Instance.new("UICorner", toggle); c.CornerRadius = UDim.new(0, 12)

	local state = default
	local clicking = false
	local function flip()
		state = not state
		toggle.BackgroundColor3 = state and Color3.fromRGB(0, 170, 255) or Color3.fromRGB(100, 100, 100)
		callback(state)
	end
	toggle.MouseButton1Down:Connect(function() clicking = true end)
	toggle.MouseButton1Up:Connect(function()
		if clicking and UIS:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) == false then
			flip()
		end
		clicking = false
	end)
	toggle.TouchTap:Connect(flip)
end

-- Dropdown: prevent double
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
	drop.AutoButtonColor = false
	drop.Parent = frame

	local arrow = Instance.new("TextLabel")
	arrow.Size = UDim2.new(0, 20, 1, 0)
	arrow.Position = UDim2.new(1, -25, 0, 0)
	arrow.BackgroundTransparency = 1
	arrow.Text = "▼"
	arrow.TextColor3 = Color3.fromRGB(200, 200, 200)
	arrow.Font = Enum.Font.Gotham
	arrow.Parent = drop

	local c = Instance.new("UICorner", drop); c.CornerRadius = UDim.new(0, 6)

	local list = Instance.new("ScrollingFrame")
	list.Size = UDim2.new(0.5, 0, 0, math.min(#options, 4) * 35)
	list.Position = UDim2.new(0.5, 0, 1, 5)
	list.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	list.Visible = false
	list.ScrollBarThickness = 4
	list.ClipsDescendants = true
	list.ZIndex = 10
	list.Parent = frame

	local ll = Instance.new("UIListLayout", list)

	for i, opt in ipairs(options) do
		local btn = Instance.new("TextButton")
		btn.Size = UDim2.new(1, 0, 0, 35)
		btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
		btn.Text = opt
		btn.TextColor3 = Color3.fromRGB(255, 255, 255)
		btn.Font = Enum.Font.Gotham
		btn.TextSize = 16
		btn.AutoButtonColor = false
		btn.ZIndex = 11
		btn.Parent = list

		local clicking = false
		btn.MouseButton1Down:Connect(function() clicking = true end)
		btn.MouseButton1Up:Connect(function()
			if clicking and UIS:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) == false then
				drop.Text = opt
				list.Visible = false
				callback(opt, i)
			end
			clicking = false
		end)
		btn.TouchTap:Connect(function()
			drop.Text = opt
			list.Visible = false
			callback(opt, i)
		end)
	end

	local dropClicking = false
	drop.MouseButton1Down:Connect(function() dropClicking = true end)
	drop.MouseButton1Up:Connect(function()
		if dropClicking and UIS:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) == false then
			list.Visible = not list.Visible
		end
		dropClicking = false
	end)
	drop.TouchTap:Connect(function() list.Visible = not list.Visible end)
end

-- Slider & TextInput unchanged (no double issue)
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
	knob.Size = UDim2.new(0, 28, 0, 28)
	knob.Position = UDim2.new(fill.Size.X.Scale - 0.5, -14, 0.5, -14)
	knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	knob.ZIndex = 2
	knob.Parent = track

	local c1 = Instance.new("UICorner", track); c1.CornerRadius = UDim.new(0, 6)
	local c2 = Instance.new("UICorner", fill); c2.CornerRadius = UDim.new(0, 6)
	local c3 = Instance.new("UICorner", knob); c3.CornerRadius = UDim.new(1, 0)

	local dragging = false
	local function update(pos)
		local rel = math.clamp((pos.X - track.AbsolutePosition.X) / track.AbsoluteSize.X, 0, 1)
		local val = math.floor(min + rel * (max - min) + 0.5)
		fill.Size = UDim2.new(rel, 0, 1, 0)
		knob.Position = UDim2.new(rel, -14, 0.5, -14)
		label.Text = text .. ": " .. val
		callback(val)
	end

	track.InputBegan:Connect(function(i)
		if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			update(i.Position)
			local conn
			conn = UIS.InputChanged:Connect(function(inp)
				if dragging and (inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch) then
					update(inp.Position)
				end
			end)
			i.Changed:Connect(function()
				if i.UserInputState == Enum.UserInputState.End then
					dragging = false
					conn:Disconnect()
				end
			end)
		end
	end)
end

function SimpleUI:AddTextInput(window, placeholder, default, callback)
	local frame = Instance.new("Frame")
	frame.Size = UDim2.new(1, -10, 0, 45)
	frame.BackgroundTransparency = 1
	frame.Parent = window.Container

	local box = Instance.new("TextBox")
	box.Size = UDim2.new(1, 0, 1, 0)
	box.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	box.PlaceholderText = placeholder
	box.Text = default or ""
	box.TextColor3 = Color3.fromRGB(255, 255, 255)
	box.Font = Enum.Font.Gotham
	box.TextSize = 16
	box.ClearTextOnFocus = false
	box.Parent = frame

	local c = Instance.new("UICorner", box); c.CornerRadius = UDim.new(0, 6)

	box.FocusLost:Connect(function(enter)
		if enter then callback(box.Text) end
	end)
end

getgenv().SimpleUI = SimpleUI