local LocalPlayer = game:GetService("Players").LocalPlayer
local TweenService = game:GetService("TweenService")
local HTTPService = game:GetService("HttpService")

local function GetHUI()
	local Success, Result = pcall(function()
		return game:GetService("CoreGui") or gethui() or syn.protect_gui()
	end)

	if Success and Result then
		return Result
	else
		return LocalPlayer:WaitForChild("PlayerGui")
	end
end

-- # Toast Notification
local Notification = {}

-- StarterGui.Intro
Notification["1"] = Instance.new("ScreenGui", GetHUI())
Notification["1"]["Name"] = [[Notification]]
Notification["1"]["ZIndexBehavior"] = Enum.ZIndexBehavior.Sibling
Notification["1"]["Enabled"] = false

-- StarterGui.Intro.UIPadding
Notification["2"] = Instance.new("UIPadding", Notification["1"])
Notification["2"]["PaddingRight"] = UDim.new(0, 5)
Notification["2"]["PaddingBottom"] = UDim.new(0, 60)

-- StarterGui.Intro.Holder
Notification["3"] = Instance.new("Frame", Notification["1"])
Notification["3"]["BorderSizePixel"] = 0
Notification["3"]["BackgroundColor3"] = Color3.fromRGB(44, 44, 44)
Notification["3"]["AnchorPoint"] = Vector2.new(1, 1)
Notification["3"]["Size"] = UDim2.new(0, 360, 0, 108)
Notification["3"]["Position"] = UDim2.new(1, 0, 0.95646, 0)
Notification["3"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
Notification["3"]["Name"] = [[Holder]]
Notification["3"]["BackgroundTransparency"] = 1

-- StarterGui.Intro.Holder.Toast
Notification["4"] = Instance.new("Frame", Notification["3"])
Notification["4"]["BorderSizePixel"] = 0
Notification["4"]["BackgroundColor3"] = Color3.fromRGB(44, 44, 44)
Notification["4"]["AnchorPoint"] = Vector2.new(0.5, 0.5)
Notification["4"]["Size"] = UDim2.new(1, 0, 1, 0)
Notification["4"]["Position"] = UDim2.new(0.5, 0, 0.5, 0)
Notification["4"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
Notification["4"]["Name"] = [[Toast]]

-- StarterGui.Intro.Holder.Toast.UIStroke
Notification["5"] = Instance.new("UIStroke", Notification["4"])
Notification["5"]["Color"] = Color3.fromRGB(255, 255, 255)

-- StarterGui.Intro.Holder.Toast.UIStroke.UIGradient
Notification["6"] = Instance.new("UIGradient", Notification["5"])
Notification["6"]["Rotation"] = 90
Notification["6"]["Offset"] = Vector2.new(0, -0.5)
Notification["6"]["Color"] = ColorSequence.new({
	ColorSequenceKeypoint.new(0.000, Color3.fromRGB(71, 255, 30)),
	ColorSequenceKeypoint.new(1.000, Color3.fromRGB(68, 68, 68)),
})

-- StarterGui.Intro.Holder.Toast.Icon
Notification["7"] = Instance.new("ImageLabel", Notification["4"])
Notification["7"]["ZIndex"] = 2
Notification["7"]["BorderSizePixel"] = 0
Notification["7"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
Notification["7"]["Image"] = [[rbxassetid://82668563249216]]
Notification["7"]["Size"] = UDim2.new(0.08333, 0, 0.27778, 0)
Notification["7"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
Notification["7"]["BackgroundTransparency"] = 1
Notification["7"]["Name"] = [[Icon]]
Notification["7"]["Position"] = UDim2.new(0.04444, 0, 0.12037, 0)

-- StarterGui.Intro.Holder.Toast.Header
Notification["8"] = Instance.new("TextLabel", Notification["4"])
Notification["8"]["TextWrapped"] = true
Notification["8"]["ZIndex"] = 2
Notification["8"]["BorderSizePixel"] = 0
Notification["8"]["TextSize"] = 21
Notification["8"]["TextXAlignment"] = Enum.TextXAlignment.Left
Notification["8"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
Notification["8"]["FontFace"] =
	Font.new([[rbxasset://fonts/families/RobotoMono.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal)
Notification["8"]["TextColor3"] = Color3.fromRGB(255, 255, 255)
Notification["8"]["BackgroundTransparency"] = 1
Notification["8"]["Size"] = UDim2.new(0.78889, 0, 0.22222, 0)
Notification["8"]["ClipsDescendants"] = true
Notification["8"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
Notification["8"]["Text"] = [[Kookahraka]]
Notification["8"]["Name"] = [[Header]]
Notification["8"]["Position"] = UDim2.new(0.16667, 0, 0.13889, 0)

-- StarterGui.Intro.Holder.Toast.Message
Notification["9"] = Instance.new("TextLabel", Notification["4"])
Notification["9"]["TextWrapped"] = true
Notification["9"]["ZIndex"] = 2
Notification["9"]["BorderSizePixel"] = 0
Notification["9"]["TextSize"] = 19
Notification["9"]["TextXAlignment"] = Enum.TextXAlignment.Left
Notification["9"]["TextYAlignment"] = Enum.TextYAlignment.Top
Notification["9"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
Notification["9"]["FontFace"] =
	Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Medium, Enum.FontStyle.Normal)
Notification["9"]["TextColor3"] = Color3.fromRGB(255, 255, 255)
Notification["9"]["BackgroundTransparency"] = 1
Notification["9"]["RichText"] = true
Notification["9"]["Size"] = UDim2.new(0.78889, 0, 0.23148, 0)
Notification["9"]["ClipsDescendants"] = true
Notification["9"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
Notification["9"]["Text"] = [[Written by <font color="#ff75c8">Moeille</font>]]
Notification["9"]["Name"] = [[Message]]
Notification["9"]["Position"] = UDim2.new(0.16667, 0, 0.46296, 0)

-- StarterGui.Intro.Holder.Toast.Pattern
Notification["a"] = Instance.new("ImageLabel", Notification["4"])
Notification["a"]["BorderSizePixel"] = 0
Notification["a"]["ScaleType"] = Enum.ScaleType.Crop
Notification["a"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
Notification["a"]["ImageTransparency"] = 0.49
Notification["a"]["Image"] = [[rbxassetid://118362370693235]]
Notification["a"]["Size"] = UDim2.new(1, 0, 1, 0)
Notification["a"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
Notification["a"]["BackgroundTransparency"] = 1
Notification["a"]["Name"] = [[Pattern]]

-- StarterGui.Intro.Holder.Toast.Pattern.UIGradient1
Notification["b"] = Instance.new("UIGradient", Notification["a"])
Notification["b"]["Rotation"] = 90
Notification["b"]["Name"] = [[UIGradient1]]
Notification["b"]["Offset"] = Vector2.new(0, -0.5)
Notification["b"]["Color"] = ColorSequence.new({
	ColorSequenceKeypoint.new(0.000, Color3.fromRGB(71, 255, 30)),
	ColorSequenceKeypoint.new(1.000, Color3.fromRGB(68, 68, 68)),
})

-- StarterGui.Intro.Holder.Toast.Duration
Notification["c"] = Instance.new("Frame", Notification["4"])
Notification["c"]["BorderSizePixel"] = 0
Notification["c"]["BackgroundColor3"] = Color3.fromRGB(58, 58, 58)
Notification["c"]["AnchorPoint"] = Vector2.new(0, 1)
Notification["c"]["Size"] = UDim2.new(0.13889, 0, 0.09259, 0)
Notification["c"]["Position"] = UDim2.new(0.819, 0, 0.87, 0)
Notification["c"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
Notification["c"]["Name"] = [[Duration]]
Notification["c"]["BackgroundTransparency"] = 0.1

-- StarterGui.Intro.Holder.Toast.Duration.Bar
Notification["d"] = Instance.new("Frame", Notification["c"])
Notification["d"]["BorderSizePixel"] = 0
Notification["d"]["BackgroundColor3"] = Color3.fromRGB(137, 255, 94)
Notification["d"]["Size"] = UDim2.new(1, 0, 1, 0)
Notification["d"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
Notification["d"]["Name"] = [[Bar]]

-- StarterGui.Intro.Holder.Toast.Duration.Bar.UICorner1
Notification["e"] = Instance.new("UICorner", Notification["d"])
Notification["e"]["Name"] = [[UICorner1]]
Notification["e"]["CornerRadius"] = UDim.new(0, 5)

-- StarterGui.Intro.Holder.Toast.Duration.UICorner2
Notification["f"] = Instance.new("UICorner", Notification["c"])
Notification["f"]["Name"] = [[UICorner2]]
Notification["f"]["CornerRadius"] = UDim.new(0, 5)

-- StarterGui.Intro.Holder.Toast.UICorner1
Notification["10"] = Instance.new("UICorner", Notification["4"])
Notification["10"]["Name"] = [[UICorner1]]
Notification["10"]["CornerRadius"] = UDim.new(0, 5)

-- StarterGui.Intro.Holder.UISizeConstraint
Notification["11"] = Instance.new("UISizeConstraint", Notification["3"])
Notification["11"]["MaxSize"] = Vector2.new(360, 108)

-- StarterGui.Intro.Holder.UIAspectRatioConstraint
Notification["12"] = Instance.new("UIAspectRatioConstraint", Notification["3"])
Notification["12"]["AspectRatio"] = 3.33333

-- # Toast Notification Manager
local ToastManager = {}
ToastManager.__index = ToastManager

ToastManager.new = function()
	local self = setmetatable({}, ToastManager)
	self.IsShowing = false
	self.CurrentNotification = nil
	return self
end

-- Save original transparency values for all elements
ToastManager.SaveTransparencies = function(self, toast)
	local elementsToSave = {}

	for _, descendant in ipairs(toast:GetDescendants()) do
		-- Skip the Toast frame itself and the Pattern image
		if descendant == toast or descendant.Name == "Pattern" then
			continue
		end

		local transparencyData = {}

		if descendant:IsA("GuiObject") then
			transparencyData.BackgroundTransparency = descendant.BackgroundTransparency

			if descendant:IsA("TextLabel") or descendant:IsA("TextButton") then
				transparencyData.TextTransparency = descendant.TextTransparency
			elseif descendant:IsA("ImageLabel") or descendant:IsA("ImageButton") then
				transparencyData.ImageTransparency = descendant.ImageTransparency
			end
		elseif descendant:IsA("UIStroke") then
			transparencyData.Transparency = descendant.Transparency
		end

		if next(transparencyData) then
			table.insert(elementsToSave, {
				Element = descendant,
				Data = transparencyData,
			})
		end
	end

	return elementsToSave
end

-- Make all saved elements invisible
ToastManager.MakeInvisible = function(self, savedTransparencies)
	for _, data in ipairs(savedTransparencies) do
		local element = data.Element

		if element:IsA("GuiObject") then
			element.BackgroundTransparency = 1

			if element:IsA("TextLabel") or element:IsA("TextButton") then
				element.TextTransparency = 1
			elseif element:IsA("ImageLabel") or element:IsA("ImageButton") then
				element.ImageTransparency = 1
			end
		elseif element:IsA("UIStroke") then
			element.Transparency = 1
		end
	end
end

-- Fade elements back to original transparency
ToastManager.FadeIn = function(self, savedTransparencies, duration)
	duration = duration or 0.3

	for _, data in ipairs(savedTransparencies) do
		local element = data.Element
		local originalData = data.Data

		if not element or not element.Parent then
			continue
		end

		local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

		if element:IsA("GuiObject") then
			if originalData.BackgroundTransparency then
				TweenService:Create(element, tweenInfo, {
					BackgroundTransparency = originalData.BackgroundTransparency,
				}):Play()
			end

			if originalData.TextTransparency then
				TweenService:Create(element, tweenInfo, {
					TextTransparency = originalData.TextTransparency,
				}):Play()
			end

			if originalData.ImageTransparency then
				TweenService:Create(element, tweenInfo, {
					ImageTransparency = originalData.ImageTransparency,
				}):Play()
			end
		elseif element:IsA("UIStroke") and originalData.Transparency then
			TweenService:Create(element, tweenInfo, {
				Transparency = originalData.Transparency,
			}):Play()
		end
	end
end

-- Fade elements out (reverse of FadeIn)
ToastManager.FadeOut = function(self, savedTransparencies, duration)
	duration = duration or 0.3

	for _, data in ipairs(savedTransparencies) do
		local element = data.Element

		if not element or not element.Parent then
			continue
		end

		local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.In)

		if element:IsA("GuiObject") then
			TweenService:Create(element, tweenInfo, {
				BackgroundTransparency = 1,
			}):Play()

			if element:IsA("TextLabel") or element:IsA("TextButton") then
				TweenService:Create(element, tweenInfo, {
					TextTransparency = 1,
				}):Play()
			elseif element:IsA("ImageLabel") or element:IsA("ImageButton") then
				TweenService:Create(element, tweenInfo, {
					ImageTransparency = 1,
				}):Play()
			end
		elseif element:IsA("UIStroke") then
			TweenService:Create(element, tweenInfo, {
				Transparency = 1,
			}):Play()
		end
	end
end

-- Animate the duration bar countdown
ToastManager.AnimateDurationBar = function(self, bar, duration)
	duration = duration or 5

	-- Reset bar to full width
	bar.Size = UDim2.new(1, 0, 1, 0)

	-- Animate bar shrinking to 0
	local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut)
	local tween = TweenService:Create(bar, tweenInfo, {
		Size = UDim2.new(0, 0, 1, 0),
	})

	tween:Play()
	return tween
end

-- Show notification with animation
ToastManager.Show = function(self, options)
	if self.IsShowing then
		return
	end

	options = options or {}
	local title = options.Title or "Notification"
	local message = options.Message or "This is a notification"
	local duration = options.Duration or 5
	local gradientColor1 = options.Color1 or Color3.fromRGB(71, 255, 30)
	local gradientColor2 = options.Color2 or Color3.fromRGB(68, 68, 68)
	local icon = options.Icon or "rbxassetid://82668563249216"

	self.IsShowing = true

	-- Create a fresh notification GUI by cloning the template
	local screenGui = Notification["1"]:Clone()
	screenGui.Name = HTTPService:GenerateGUID(false)
	screenGui.Parent = GetHUI()
	self.CurrentNotification = screenGui

	-- Get references
	local holder = screenGui.Holder
	local toast = holder.Toast
	local headerLabel = toast.Header
	local messageLabel = toast.Message
	local iconImage = toast.Icon
	local durationBar = toast.Duration.Bar
	local strokeGradient = toast.UIStroke.UIGradient
	local patternGradient = toast.Pattern.UIGradient1

	-- Set content
	headerLabel.Text = title
	messageLabel.Text = message
	iconImage.Image = icon

	-- Set gradient colors
	strokeGradient.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0.000, gradientColor1),
		ColorSequenceKeypoint.new(1.000, gradientColor2),
	})
	patternGradient.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0.000, gradientColor1),
		ColorSequenceKeypoint.new(1.000, gradientColor2),
	})

	-- Step 1: Save original transparencies
	local savedTransparencies = self:SaveTransparencies(toast)

	-- Step 2: Make all elements invisible
	self:MakeInvisible(savedTransparencies)

	-- Step 3: Set toast Y size to 0
	local originalSize = toast.Size
	toast.Size = UDim2.new(originalSize.X.Scale, originalSize.X.Offset, 0, 0)

	-- Enable the GUI
	screenGui.Enabled = true

	-- Step 4: Animate toast size from middle
	local sizeExpandDuration = 0.4
	local sizeTween = TweenService:Create(
		toast,
		TweenInfo.new(sizeExpandDuration, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
		{ Size = originalSize }
	)

	sizeTween:Play()
	sizeTween.Completed:Wait()

	-- Step 5: Fade in all elements after size animation starts
	task.delay(0.1, function()
		self:FadeIn(savedTransparencies, 0.3)
	end)

	-- Step 6: Animate duration bar
	task.delay(sizeExpandDuration, function()
		local barTween = self:AnimateDurationBar(durationBar, duration)

		-- Auto-hide after duration
		task.delay(duration, function()
			self:Hide(savedTransparencies)
		end)
	end)
end

-- Hide notification with animation
ToastManager.Hide = function(self, savedTransparencies)
	if not self.IsShowing then
		return
	end

	local screenGui = self.CurrentNotification
	if not screenGui then
		return
	end

	local holder = screenGui.Holder
	local toast = holder.Toast

	-- Fade out all elements
	self:FadeOut(savedTransparencies or self:SaveTransparencies(toast), 0.3)

	-- Shrink toast
	local shrinkDuration = 0.3
	local sizeTween = TweenService:Create(
		toast,
		TweenInfo.new(shrinkDuration, Enum.EasingStyle.Back, Enum.EasingDirection.In),
		{ Size = UDim2.new(toast.Size.X.Scale, toast.Size.X.Offset, 0, 0) }
	)

	sizeTween:Play()
	sizeTween.Completed:Wait()

	-- Disable GUI and mark as not showing
	screenGui.Enabled = false
	self.IsShowing = false

	-- Destroy the notification GUI
	screenGui:Destroy()
	self.CurrentNotification = nil
end


return ToastManager
