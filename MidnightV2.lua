local Library = {
	VisibleFrames = {},
	Signals = {},
	ResizeConfigs = {},
	ResizeHandles = {},
	AccentElements = {},
	ThemeBindings = {},
}

---------------------
-- [[ Locals ]] --
---------------------

local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local RenderStepped = RunService.RenderStepped
local LocalPlayer = game:GetService("Players").LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local HTTPService = game:GetService("HttpService")

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = gethui() or game:GetService("CoreGui")
ScreenGui.Name = HTTPService:GenerateGUID(false)

local Theme = {
	Accent = Color3.fromRGB(133, 118, 224),
	AccentDark = Color3.fromRGB(92, 80, 176),
	AccentSoft = Color3.fromRGB(190, 181, 245),
	Checkmark = Color3.fromRGB(251, 249, 255),
	Surface0 = Color3.fromRGB(238, 236, 245),
	Surface1 = Color3.fromRGB(246, 244, 251),
	Surface2 = Color3.fromRGB(225, 220, 237),
	Surface3 = Color3.fromRGB(202, 196, 220),
	TabBar = Color3.fromRGB(214, 208, 229),
	Outline = Color3.fromRGB(155, 146, 179),
	Text = Color3.fromRGB(44, 40, 60),
	TextMuted = Color3.fromRGB(98, 92, 123),
	Font = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal),
	FontBold = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal),
	FontSemibold = Font.new(
		"rbxasset://fonts/families/Montserrat.json",
		Enum.FontWeight.SemiBold,
		Enum.FontStyle.Normal
	),
}

local ThemePresetFile = "MidnightTheme.json"
local ThemePresets = {
	["Lavender Slate"] = {
		Accent = Color3.fromRGB(133, 118, 224),
		AccentDark = Color3.fromRGB(92, 80, 176),
		AccentSoft = Color3.fromRGB(190, 181, 245),
		Checkmark = Color3.fromRGB(251, 249, 255),
		Surface0 = Color3.fromRGB(238, 236, 245),
		Surface1 = Color3.fromRGB(246, 244, 251),
		Surface2 = Color3.fromRGB(225, 220, 237),
		Surface3 = Color3.fromRGB(202, 196, 220),
		TabBar = Color3.fromRGB(214, 208, 229),
		Outline = Color3.fromRGB(155, 146, 179),
		Text = Color3.fromRGB(44, 40, 60),
		TextMuted = Color3.fromRGB(98, 92, 123),
	},
	["Ocean Mist"] = {
		Accent = Color3.fromRGB(64, 145, 223),
		AccentDark = Color3.fromRGB(42, 105, 173),
		AccentSoft = Color3.fromRGB(153, 205, 248),
		Checkmark = Color3.fromRGB(255, 255, 255),
		Surface0 = Color3.fromRGB(235, 241, 246),
		Surface1 = Color3.fromRGB(245, 249, 252),
		Surface2 = Color3.fromRGB(221, 231, 239),
		Surface3 = Color3.fromRGB(193, 207, 220),
		TabBar = Color3.fromRGB(214, 225, 235),
		Outline = Color3.fromRGB(142, 160, 178),
		Text = Color3.fromRGB(30, 42, 58),
		TextMuted = Color3.fromRGB(90, 107, 126),
	},
	["Matcha Studio"] = {
		Accent = Color3.fromRGB(90, 158, 120),
		AccentDark = Color3.fromRGB(63, 116, 87),
		AccentSoft = Color3.fromRGB(166, 214, 186),
		Checkmark = Color3.fromRGB(247, 252, 248),
		Surface0 = Color3.fromRGB(239, 245, 238),
		Surface1 = Color3.fromRGB(248, 251, 246),
		Surface2 = Color3.fromRGB(223, 233, 221),
		Surface3 = Color3.fromRGB(198, 213, 196),
		TabBar = Color3.fromRGB(214, 226, 212),
		Outline = Color3.fromRGB(143, 162, 141),
		Text = Color3.fromRGB(34, 46, 38),
		TextMuted = Color3.fromRGB(89, 108, 92),
	},
	["Midnight Gold"] = {
		Accent = Color3.fromRGB(224, 177, 77),
		AccentDark = Color3.fromRGB(173, 131, 45),
		AccentSoft = Color3.fromRGB(246, 214, 135),
		Checkmark = Color3.fromRGB(255, 249, 232),
		Surface0 = Color3.fromRGB(21, 23, 28),
		Surface1 = Color3.fromRGB(30, 33, 39),
		Surface2 = Color3.fromRGB(41, 45, 53),
		Surface3 = Color3.fromRGB(58, 63, 74),
		TabBar = Color3.fromRGB(16, 18, 22),
		Outline = Color3.fromRGB(88, 94, 108),
		Text = Color3.fromRGB(241, 237, 226),
		TextMuted = Color3.fromRGB(178, 172, 156),
	},
	["Cobalt Noir"] = {
		Accent = Color3.fromRGB(77, 132, 255),
		AccentDark = Color3.fromRGB(49, 91, 201),
		AccentSoft = Color3.fromRGB(147, 185, 255),
		Checkmark = Color3.fromRGB(244, 248, 255),
		Surface0 = Color3.fromRGB(16, 19, 27),
		Surface1 = Color3.fromRGB(23, 28, 38),
		Surface2 = Color3.fromRGB(32, 39, 52),
		Surface3 = Color3.fromRGB(47, 56, 72),
		TabBar = Color3.fromRGB(12, 15, 22),
		Outline = Color3.fromRGB(76, 89, 111),
		Text = Color3.fromRGB(235, 241, 250),
		TextMuted = Color3.fromRGB(154, 165, 183),
	},
	["Rose Quartz"] = {
		Accent = Color3.fromRGB(225, 118, 159),
		AccentDark = Color3.fromRGB(177, 82, 121),
		AccentSoft = Color3.fromRGB(246, 191, 211),
		Checkmark = Color3.fromRGB(255, 247, 250),
		Surface0 = Color3.fromRGB(247, 239, 243),
		Surface1 = Color3.fromRGB(252, 246, 248),
		Surface2 = Color3.fromRGB(238, 223, 229),
		Surface3 = Color3.fromRGB(219, 198, 207),
		TabBar = Color3.fromRGB(230, 215, 222),
		Outline = Color3.fromRGB(175, 145, 158),
		Text = Color3.fromRGB(71, 45, 57),
		TextMuted = Color3.fromRGB(123, 91, 104),
	},
	["Amber Dusk"] = {
		Accent = Color3.fromRGB(232, 145, 74),
		AccentDark = Color3.fromRGB(181, 101, 42),
		AccentSoft = Color3.fromRGB(247, 201, 153),
		Checkmark = Color3.fromRGB(255, 248, 239),
		Surface0 = Color3.fromRGB(246, 238, 230),
		Surface1 = Color3.fromRGB(251, 245, 239),
		Surface2 = Color3.fromRGB(236, 222, 210),
		Surface3 = Color3.fromRGB(214, 194, 177),
		TabBar = Color3.fromRGB(227, 212, 198),
		Outline = Color3.fromRGB(170, 145, 126),
		Text = Color3.fromRGB(68, 47, 33),
		TextMuted = Color3.fromRGB(120, 97, 80),
	},
	["Frostbyte"] = {
		Accent = Color3.fromRGB(87, 204, 217),
		AccentDark = Color3.fromRGB(49, 149, 163),
		AccentSoft = Color3.fromRGB(171, 236, 242),
		Checkmark = Color3.fromRGB(245, 254, 255),
		Surface0 = Color3.fromRGB(233, 244, 247),
		Surface1 = Color3.fromRGB(242, 249, 251),
		Surface2 = Color3.fromRGB(218, 232, 236),
		Surface3 = Color3.fromRGB(190, 208, 214),
		TabBar = Color3.fromRGB(208, 223, 228),
		Outline = Color3.fromRGB(136, 159, 168),
		Text = Color3.fromRGB(34, 54, 60),
		TextMuted = Color3.fromRGB(88, 111, 118),
	},
	["Crimson Velvet"] = {
		Accent = Color3.fromRGB(214, 79, 102),
		AccentDark = Color3.fromRGB(158, 48, 68),
		AccentSoft = Color3.fromRGB(241, 153, 170),
		Checkmark = Color3.fromRGB(255, 243, 246),
		Surface0 = Color3.fromRGB(31, 20, 26),
		Surface1 = Color3.fromRGB(40, 27, 33),
		Surface2 = Color3.fromRGB(54, 37, 45),
		Surface3 = Color3.fromRGB(74, 51, 60),
		TabBar = Color3.fromRGB(24, 16, 21),
		Outline = Color3.fromRGB(100, 74, 84),
		Text = Color3.fromRGB(247, 232, 236),
		TextMuted = Color3.fromRGB(182, 154, 162),
	},
	["Sakura Night"] = {
		Accent = Color3.fromRGB(255, 150, 196),
		AccentDark = Color3.fromRGB(201, 106, 149),
		AccentSoft = Color3.fromRGB(255, 209, 227),
		Checkmark = Color3.fromRGB(255, 245, 250),
		Surface0 = Color3.fromRGB(22, 20, 29),
		Surface1 = Color3.fromRGB(30, 27, 39),
		Surface2 = Color3.fromRGB(42, 38, 54),
		Surface3 = Color3.fromRGB(60, 54, 77),
		TabBar = Color3.fromRGB(17, 15, 23),
		Outline = Color3.fromRGB(92, 84, 112),
		Text = Color3.fromRGB(245, 236, 242),
		TextMuted = Color3.fromRGB(178, 166, 178),
	},
	["Solarized Sand"] = {
		Accent = Color3.fromRGB(198, 141, 71),
		AccentDark = Color3.fromRGB(148, 101, 45),
		AccentSoft = Color3.fromRGB(229, 196, 142),
		Checkmark = Color3.fromRGB(255, 252, 242),
		Surface0 = Color3.fromRGB(244, 240, 225),
		Surface1 = Color3.fromRGB(250, 247, 236),
		Surface2 = Color3.fromRGB(232, 225, 202),
		Surface3 = Color3.fromRGB(210, 200, 173),
		TabBar = Color3.fromRGB(223, 214, 190),
		Outline = Color3.fromRGB(163, 149, 117),
		Text = Color3.fromRGB(77, 69, 47),
		TextMuted = Color3.fromRGB(124, 114, 88),
	},
	["Mint Circuit"] = {
		Accent = Color3.fromRGB(74, 214, 168),
		AccentDark = Color3.fromRGB(42, 163, 124),
		AccentSoft = Color3.fromRGB(164, 242, 214),
		Checkmark = Color3.fromRGB(240, 255, 249),
		Surface0 = Color3.fromRGB(18, 26, 24),
		Surface1 = Color3.fromRGB(26, 36, 33),
		Surface2 = Color3.fromRGB(36, 49, 45),
		Surface3 = Color3.fromRGB(52, 68, 62),
		TabBar = Color3.fromRGB(14, 20, 19),
		Outline = Color3.fromRGB(78, 102, 94),
		Text = Color3.fromRGB(230, 243, 238),
		TextMuted = Color3.fromRGB(153, 171, 164),
	},
	["Arctic Bloom"] = {
		Accent = Color3.fromRGB(137, 122, 255),
		AccentDark = Color3.fromRGB(94, 81, 204),
		AccentSoft = Color3.fromRGB(199, 191, 255),
		Checkmark = Color3.fromRGB(248, 247, 255),
		Surface0 = Color3.fromRGB(236, 241, 249),
		Surface1 = Color3.fromRGB(244, 247, 252),
		Surface2 = Color3.fromRGB(223, 230, 242),
		Surface3 = Color3.fromRGB(197, 207, 224),
		TabBar = Color3.fromRGB(213, 221, 235),
		Outline = Color3.fromRGB(147, 156, 178),
		Text = Color3.fromRGB(43, 49, 66),
		TextMuted = Color3.fromRGB(96, 104, 129),
	},
	["Copper Smoke"] = {
		Accent = Color3.fromRGB(190, 115, 87),
		AccentDark = Color3.fromRGB(141, 79, 57),
		AccentSoft = Color3.fromRGB(226, 174, 155),
		Checkmark = Color3.fromRGB(255, 245, 240),
		Surface0 = Color3.fromRGB(25, 22, 23),
		Surface1 = Color3.fromRGB(34, 29, 30),
		Surface2 = Color3.fromRGB(46, 39, 41),
		Surface3 = Color3.fromRGB(64, 54, 56),
		TabBar = Color3.fromRGB(20, 18, 18),
		Outline = Color3.fromRGB(92, 79, 81),
		Text = Color3.fromRGB(241, 232, 228),
		TextMuted = Color3.fromRGB(173, 160, 156),
	},
}

local function CopyThemeDefinition(Definition)
	local Copy = {}
	for Key, Value in next, Definition do
		Copy[Key] = Value
	end
	return Copy
end

local function LoadSavedThemePreset()
	if type(isfile) ~= "function" or type(readfile) ~= "function" then
		return nil
	end

	local Success, Result = pcall(function()
		if not isfile(ThemePresetFile) then
			return nil
		end

		local Decoded = HttpService:JSONDecode(readfile(ThemePresetFile))
		if type(Decoded) == "table" then
			return Decoded.Name
		end
	end)

	return Success and Result or nil
end

local function SaveThemePreset(Name)
	if type(writefile) ~= "function" then
		return
	end

	pcall(function()
		writefile(ThemePresetFile, HttpService:JSONEncode({ Name = Name }))
	end)
end

---------------------
-- [[ Functions ]] --
---------------------

function Library:MouseIsOverVisibleFrames()
	for Frame, _ in next, Library.VisibleFrames do
		local AbsPos, AbsSize = Frame.AbsolutePosition, Frame.AbsoluteSize

		if
			Mouse.X >= AbsPos.X
			and Mouse.X <= AbsPos.X + AbsSize.X
			and Mouse.Y >= AbsPos.Y
			and Mouse.Y <= AbsPos.Y + AbsSize.Y
		then
			return true
		end
	end
end

function Library:MakeDraggable(Instance, DragInstance, Cutoff)
	Instance.Active = true
	local DragSmoothness = 0.11

	DragInstance.InputBegan:Connect(function(Input)
		if Input.UserInputType == Enum.UserInputType.MouseButton1 then
			local ObjPos = Vector2.new(Mouse.X - Instance.AbsolutePosition.X, Mouse.Y - Instance.AbsolutePosition.Y)

			if ObjPos.Y > (Cutoff or 40) then
				return
			end

			if Library:IsMouseInResizeZone(Instance, ObjPos) then
				return
			end

			local StartSize = Instance.AbsoluteSize

			while UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) do
				local TargetLeft = Mouse.X - ObjPos.X
				local TargetTop = Mouse.Y - ObjPos.Y
				local MaxX = math.max(0, ScreenGui.AbsoluteSize.X - StartSize.X)
				local MaxY = math.max(0, ScreenGui.AbsoluteSize.Y - StartSize.Y)

				TargetLeft = math.clamp(TargetLeft, 0, MaxX)
				TargetTop = math.clamp(TargetTop, 0, MaxY)

				local CurrentLeft = Instance.AbsolutePosition.X
				local CurrentTop = Instance.AbsolutePosition.Y
				local Left = CurrentLeft + ((TargetLeft - CurrentLeft) * DragSmoothness)
				local Top = CurrentTop + ((TargetTop - CurrentTop) * DragSmoothness)

				Instance.Position = UDim2.fromOffset(
					Left + (StartSize.X * Instance.AnchorPoint.X),
					Top + (StartSize.Y * Instance.AnchorPoint.Y)
				)
				RenderStepped:Wait()
			end
		end
	end)
end

function Library:IsMouseInResizeZone(Instance, LocalMousePosition)
	local ResizeConfig = Library.ResizeConfigs[Instance]
	if not ResizeConfig then
		return false
	end

	local Width = Instance.AbsoluteSize.X
	local Height = Instance.AbsoluteSize.Y
	local EdgeThickness = ResizeConfig.EdgeThickness or 6
	local CornerSize = ResizeConfig.CornerSize or 14

	local X = LocalMousePosition.X
	local Y = LocalMousePosition.Y

	if X <= CornerSize and Y <= CornerSize then
		return true
	end

	if X >= Width - CornerSize and Y <= CornerSize then
		return true
	end

	if X <= CornerSize and Y >= Height - CornerSize then
		return true
	end

	if X >= Width - CornerSize and Y >= Height - CornerSize then
		return true
	end

	if Y <= EdgeThickness or Y >= Height - EdgeThickness then
		return true
	end

	if X <= EdgeThickness or X >= Width - EdgeThickness then
		return true
	end

	return false
end

function Library:MakeResizable(Instance, Config)
	Config = Config or {}

	local MinSize = Config.MinSize or Vector2.new(680, 400)
	local HandleColor = Config.HandleColor or Theme.Accent
	local HoverColor = Config.HoverColor or Theme.Accent
	local HandleTransparency = Config.HandleTransparency
	if HandleTransparency == nil then
		HandleTransparency = 1
	end
	local HoverTransparency = Config.HoverTransparency or 0.1
	local EdgeThickness = Config.EdgeThickness or 6
	local CornerSize = Config.CornerSize or 6

	Library.ResizeConfigs[Instance] = {
		EdgeThickness = EdgeThickness,
		CornerSize = CornerSize,
	}

	local HandleData = {
		Top = {
			Direction = Vector2.new(0, -1),
			Position = UDim2.new(0, 0, 0, -CornerSize),
			Size = UDim2.new(1, 0, 0, CornerSize),
		},
		Bottom = {
			Direction = Vector2.new(0, 1),
			AnchorPoint = Vector2.new(0, 1),
			Position = UDim2.new(0, 0, 1, CornerSize),
			Size = UDim2.new(1, 0, 0, CornerSize),
		},
		Left = {
			Direction = Vector2.new(-1, 0),
			Position = UDim2.new(0, -CornerSize, 0, 0),
			Size = UDim2.new(0, CornerSize, 1, 0),
		},
		Right = {
			Direction = Vector2.new(1, 0),
			AnchorPoint = Vector2.new(1, 0),
			Position = UDim2.new(1, CornerSize, 0, 0),
			Size = UDim2.new(0, CornerSize, 1, 0),
		},
		TopLeft = {
			Direction = Vector2.new(-1, -1),
			Position = UDim2.fromOffset(-CornerSize, -CornerSize),
			Size = UDim2.fromOffset(CornerSize, CornerSize),
		},
		TopRight = {
			Direction = Vector2.new(1, -1),
			AnchorPoint = Vector2.new(1, 0),
			Position = UDim2.new(1, CornerSize, 0, -CornerSize),
			Size = UDim2.fromOffset(CornerSize, CornerSize),
		},
		BottomLeft = {
			Direction = Vector2.new(-1, 1),
			AnchorPoint = Vector2.new(0, 1),
			Position = UDim2.new(0, -CornerSize, 1, CornerSize),
			Size = UDim2.fromOffset(CornerSize, CornerSize),
		},
		BottomRight = {
			Direction = Vector2.new(1, 1),
			AnchorPoint = Vector2.new(1, 1),
			Position = UDim2.new(1, CornerSize, 1, CornerSize),
			Size = UDim2.fromOffset(CornerSize, CornerSize),
		},
	}

	local function ClampToViewport(Left, Top, Width, Height)
		local AbsoluteSize = ScreenGui.AbsoluteSize
		local MaxWidth = math.max(MinSize.X, AbsoluteSize.X)
		local MaxHeight = math.max(MinSize.Y, AbsoluteSize.Y)

		Width = math.clamp(Width, MinSize.X, MaxWidth)
		Height = math.clamp(Height, MinSize.Y, MaxHeight)
		Left = math.clamp(Left, 0, math.max(0, AbsoluteSize.X - Width))
		Top = math.clamp(Top, 0, math.max(0, AbsoluteSize.Y - Height))

		return Left, Top, Width, Height
	end

	local function ApplyBounds(Left, Top, Width, Height)
		Left, Top, Width, Height = ClampToViewport(Left, Top, Width, Height)
		Instance.Size = UDim2.fromOffset(Width, Height)
		Instance.Position =
			UDim2.fromOffset(Left + (Width * Instance.AnchorPoint.X), Top + (Height * Instance.AnchorPoint.Y))
	end

	local IsResizing = false

	for Name, Data in next, HandleData do
		local ResizeHandle = Library:Create("Frame", {
			Name = Name .. "ResizeHandle",
			BackgroundColor3 = HandleColor,
			BackgroundTransparency = HandleTransparency,
			BorderSizePixel = 0,
			AnchorPoint = Data.AnchorPoint or Vector2.zero,
			Position = Data.Position or UDim2.zero,
			Size = Data.Size,
			ZIndex = 10,
			Active = true,
			Parent = Instance,
		})

		-- Store handle reference for theme updates
		if not Library.ResizeHandles[Instance] then
			Library.ResizeHandles[Instance] = {}
		end
		table.insert(Library.ResizeHandles[Instance], ResizeHandle)
		if Config.HandleColor == nil then
			Library:RegisterThemeBinding(ResizeHandle, "BackgroundColor3", "Accent")
		end

		ResizeHandle.MouseEnter:Connect(function()
			local CurrentHoverColor = Config.HoverColor or Theme.Accent
			TweenService:Create(ResizeHandle, TweenInfo.new(0.12), {
				BackgroundColor3 = CurrentHoverColor,
				BackgroundTransparency = HoverTransparency,
			}):Play()
		end)

		ResizeHandle.MouseLeave:Connect(function()
			local CurrentHandleColor = Config.HandleColor or Theme.Accent
			TweenService:Create(ResizeHandle, TweenInfo.new(0.12), {
				BackgroundColor3 = CurrentHandleColor,
				BackgroundTransparency = HandleTransparency,
			}):Play()
		end)

		ResizeHandle.InputBegan:Connect(function(Input)
			if Input.UserInputType ~= Enum.UserInputType.MouseButton1 then
				return
			end
			if IsResizing then
				return
			end
			IsResizing = true

			local StartMouse = Vector2.new(Mouse.X, Mouse.Y)
			local StartPosition = Instance.AbsolutePosition
			local StartSize = Instance.AbsoluteSize
			local StartRight = StartPosition.X + StartSize.X
			local StartBottom = StartPosition.Y + StartSize.Y

			while UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) do
				local Delta = Vector2.new(Mouse.X, Mouse.Y) - StartMouse
				local Left = StartPosition.X
				local Top = StartPosition.Y
				local Width = StartSize.X
				local Height = StartSize.Y

				if Data.Direction.X < 0 then
					Left = StartPosition.X + Delta.X
					Width = StartRight - Left
				elseif Data.Direction.X > 0 then
					Width = StartSize.X + Delta.X
				end

				if Data.Direction.Y < 0 then
					Top = StartPosition.Y + Delta.Y
					Height = StartBottom - Top
				elseif Data.Direction.Y > 0 then
					Height = StartSize.Y + Delta.Y
				end

				if Width < MinSize.X then
					Width = MinSize.X
					if Data.Direction.X < 0 then
						Left = StartRight - Width
					end
				end

				if Height < MinSize.Y then
					Height = MinSize.Y
					if Data.Direction.Y < 0 then
						Top = StartBottom - Height
					end
				end

				ApplyBounds(Left, Top, Width, Height)
				RenderStepped:Wait()
			end
			IsResizing = false
		end)
	end
end

function Library:MapValue(Value, MinA, MaxA, MinB, MaxB)
	return (1 - ((Value - MinA) / (MaxA - MinA))) * MinB + ((Value - MinA) / (MaxA - MinA)) * MaxB
end

function Library:GiveSignal(Signal)
	table.insert(Library.Signals, Signal)
end

function Library:Create(Class, Properties)
	local _Instance = Class

	if type(Class) == "string" then
		_Instance = Instance.new(Class)
	end

	if type(Properties) == "table" and Properties.TextAlignment ~= nil and Properties.TextXAlignment == nil then
		Properties.TextXAlignment = Properties.TextAlignment
		Properties.TextAlignment = nil
	end

	for Property, Value in next, Properties do
		_Instance[Property] = Value
	end

	return _Instance
end

function Library:ApplyTheme(Overrides)
	if type(Overrides) ~= "table" then
		return
	end

	for Key, Value in next, Overrides do
		if Theme[Key] ~= nil then
			Theme[Key] = Value
		end
	end

	for Index = #Library.ThemeBindings, 1, -1 do
		local Binding = Library.ThemeBindings[Index]
		local Element = Binding.Element
		local ThemeValue = Theme[Binding.ThemeKey]

		if not Element or (Element.Parent == nil and not Element:IsDescendantOf(game)) then
			table.remove(Library.ThemeBindings, Index)
		elseif ThemeValue ~= nil then
			Element[Binding.Property] = ThemeValue
		end
	end
end

function Library:RegisterAccentElement(Element)
	table.insert(Library.AccentElements, Element)
end

function Library:RegisterThemeBinding(Element, Property, ThemeKey)
	table.insert(Library.ThemeBindings, {
		Element = Element,
		Property = Property,
		ThemeKey = ThemeKey,
	})

	if Theme[ThemeKey] ~= nil then
		Element[Property] = Theme[ThemeKey]
	end
end

function Library:GetLayoutOrder(Container)
	local Count = 0

	for _, Child in next, Container:GetChildren() do
		if
			not Child:IsA("UIListLayout")
			and not Child:IsA("UIPadding")
			and not Child:IsA("UIGridLayout")
			and not Child:IsA("UICorner")
			and not Child:IsA("UIStroke")
		then
			Count += 1
		end
	end

	return Count + 1
end

function Library:GetRowFrameProps(Container)
	local IsGrid = Container:FindFirstChildOfClass("UIGridLayout") ~= nil

	if IsGrid then
		return {
			Position = UDim2.fromOffset(0, 0),
			Size = UDim2.new(1, 0, 0, 77),
		}
	end

	return {
		Position = UDim2.fromOffset(4, 0),
		Size = UDim2.new(1, -8, 0, 77),
	}
end

function Library:CreateRowShell(Container)
	local RowProps = Library:GetRowFrameProps(Container)

	local RowShell = Library:Create("Frame", {
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Position = RowProps.Position,
		Size = RowProps.Size,
		ZIndex = 1,
		LayoutOrder = Library:GetLayoutOrder(Container),
		Parent = Container,
	})

	local RowCard = Library:Create("Frame", {
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundColor3 = Theme.Surface1,
		BorderSizePixel = 0,
		Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.fromScale(1, 1),
		ZIndex = 1,
		Parent = RowShell,
	})

	Library:RegisterThemeBinding(RowCard, "BackgroundColor3", "Surface1")

	Library:Create("UICorner", {
		CornerRadius = UDim.new(0, 8),
		Parent = RowCard,
	})

	local RowStroke = Library:Create("UIStroke", {
		Color = Theme.Outline,
		Transparency = 0.62,
		Thickness = 1,
		Parent = RowCard,
	})

	Library:RegisterThemeBinding(RowStroke, "Color", "Outline")

	return RowShell, RowCard, RowStroke
end

function Library:AttachRowHover(RowFrame, RowStroke)
	if not RowFrame or not RowStroke then
		return
	end

	RowFrame.Active = true

	local RowScale = Library:Create("UIScale", {
		Scale = 1,
		Parent = RowFrame,
	})

	local Hovering = false

	local function ApplyHoverState(IsHovering)
		Hovering = IsHovering

		local TargetBackground = IsHovering and Theme.Surface2 or Theme.Surface1
		local TargetTransparency = IsHovering and 0.32 or 0.62
		local TargetStrokeColor = IsHovering and Theme.AccentSoft or Theme.Outline
		local TargetScale = IsHovering and 1.015 or 1

		TweenService:Create(RowFrame, TweenInfo.new(0.16, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			BackgroundColor3 = TargetBackground,
		}):Play()

		TweenService:Create(RowStroke, TweenInfo.new(0.16, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			Transparency = TargetTransparency,
			Color = TargetStrokeColor,
		}):Play()

		TweenService:Create(RowScale, TweenInfo.new(0.16, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			Scale = TargetScale,
		}):Play()
	end

	RowFrame.MouseEnter:Connect(function()
		ApplyHoverState(true)
	end)

	RowFrame.MouseLeave:Connect(function()
		ApplyHoverState(false)
	end)

	return {
		SetHovered = ApplyHoverState,
		IsHovered = function()
			return Hovering
		end,
	}
end

---------------------
-- [[  Classes  ]] --
---------------------

local Functions = {}

function Functions:AddButton(Text, Function)
	local Button = {}

	local Container = self.Container
	local ButtonShell, ButtonFrame, ButtonFrameStroke = Library:CreateRowShell(Container)

	local ButtonUnderline = Library:Create("Frame", {
		BackgroundTransparency = 0.15,
		BorderSizePixel = 0,
		BackgroundColor3 = Theme.Accent,
		Size = UDim2.new(0, 3, 0, 46),
		Position = UDim2.fromOffset(0, 15),
		ZIndex = 1,
		Parent = ButtonFrame,
	})

	Library:RegisterAccentElement(ButtonUnderline)
	Library:RegisterThemeBinding(ButtonUnderline, "BackgroundColor3", "Accent")

	Library:Create("UICorner", {
		CornerRadius = UDim.new(1, 0),
		Parent = ButtonUnderline,
	})

	local ClickButton = Library:Create("ImageButton", {
		BackgroundTransparency = 0,
		AnchorPoint = Vector2.new(1, 0.5),
		BackgroundColor3 = Theme.Accent,
		Size = UDim2.fromOffset(38, 38),
		Position = UDim2.new(1, -18, 0.5, 0),
		Image = "",
		ZIndex = 1,
		Parent = ButtonFrame,
	})
	Library:RegisterThemeBinding(ClickButton, "BackgroundColor3", "Accent")

	local ButtonIcon = Library:Create("ImageLabel", {
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundTransparency = 1,
		Image = "rbxassetid://76660779384571",
		ImageColor3 = Theme.Text,
		Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.fromOffset(24, 24),
		ZIndex = 2,
		Parent = ClickButton,
	})
	Library:RegisterThemeBinding(ButtonIcon, "ImageColor3", "Text")

	local ButtonStroke = Library:Create("UIStroke", {
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
		Color = Theme.AccentSoft,
		Thickness = 1,
		Transparency = 0.62,
		Parent = ClickButton,
	})
	Library:RegisterThemeBinding(ButtonStroke, "Color", "AccentSoft")

	local ButtonCorner = Library:Create("UICorner", {
		CornerRadius = UDim.new(0, 10),
		Parent = ClickButton,
	})

	local Option = Library:Create("TextLabel", {
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(0, 0.5),
		Size = UDim2.new(1, -82, 0, 24),
		Position = UDim2.new(0, 20, 0.5, 0),
		Text = Text or "Empty",
		TextColor3 = Theme.Text,
		TextSize = 18,
		TextXAlignment = Enum.TextXAlignment.Left,
		FontFace = Theme.Font,
		ZIndex = 1,
		Parent = ButtonFrame,
	})
	Library:RegisterThemeBinding(Option, "TextColor3", "Text")

	local OptionPadding = Library:Create("UIPadding", {
		PaddingBottom = UDim.new(0, 5),
		PaddingRight = UDim.new(0, 5),
		PaddingLeft = UDim.new(0, 5),
		PaddingTop = UDim.new(0, 5),
		Parent = Option,
	})

	Library:AttachRowHover(ButtonFrame, ButtonFrameStroke)

	ClickButton.MouseEnter:Connect(function()
		TweenService:Create(ButtonStroke, TweenInfo.new(0.15), { Transparency = 0.18, Thickness = 1.5 }):Play()
	end)

	ClickButton.MouseLeave:Connect(function()
		TweenService:Create(ButtonStroke, TweenInfo.new(0.15), { Transparency = 0.62, Thickness = 1 }):Play()
	end)

	ClickButton.Activated:Connect(function()
		if Function then
			Function(Button)
		end
	end)

	if self.UpdateLayout then
		self:UpdateLayout()
	end

	return Button
end

function Functions:AddToggle(Name, Default, Function)
	local Toggle = {
		Value = Default or false,
	}

	local Container = self.Container
	local ToggleShell, ToggleFrame, ToggleFrameStroke = Library:CreateRowShell(Container)

	local ToggleUnderline = Library:Create("Frame", {
		BackgroundTransparency = 0.15,
		BorderSizePixel = 0,
		BackgroundColor3 = Theme.Accent,
		Size = UDim2.new(0, 3, 0, 46),
		Position = UDim2.fromOffset(0, 15),
		ZIndex = 1,
		Parent = ToggleFrame,
	})
	Library:RegisterThemeBinding(ToggleUnderline, "BackgroundColor3", "Accent")

	local Option = Library:Create("TextLabel", {
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(0, 0.5),
		Size = UDim2.new(1, -82, 0, 24),
		Position = UDim2.new(0, 20, 0.5, 0),
		Text = Name or "Empty",
		TextColor3 = Theme.Text,
		TextSize = 18,
		TextXAlignment = Enum.TextXAlignment.Left,
		FontFace = Theme.Font,
		ZIndex = 1,
		Parent = ToggleFrame,
	})
	Library:RegisterThemeBinding(Option, "TextColor3", "Text")

	local OptionPadding = Library:Create("UIPadding", {
		PaddingBottom = UDim.new(0.25, 0),
		PaddingRight = UDim.new(0.01, 0),
		PaddingLeft = UDim.new(0.01, 0),
		PaddingTop = UDim.new(0.25, 0),
		Parent = Option,
	})

	local ToggleButton = Library:Create("TextButton", {
		AnchorPoint = Vector2.new(1, 0.5),
		BackgroundTransparency = 1,
		BackgroundColor3 = Theme.Accent,
		Size = UDim2.fromOffset(34, 34),
		Position = UDim2.new(1, -20, 0.5, 0),
		Text = "",
		Parent = ToggleFrame,
	})
	Library:RegisterThemeBinding(ToggleButton, "BackgroundColor3", "Accent")

	local TickPadding = Library:Create("UIPadding", {
		PaddingBottom = UDim.new(0, 2),
		PaddingLeft = UDim.new(0, 2),
		PaddingRight = UDim.new(0, 2),
		PaddingTop = UDim.new(0, 2),
		Parent = ToggleButton,
	})

	local ToggleTick = Library:Create("ImageLabel", {
		AnchorPoint = Vector2.new(0, 0),
		BackgroundTransparency = 1,
		ImageColor3 = Theme.Checkmark,
		ImageTransparency = 1,
		Image = "rbxassetid://73965231027852",
		Size = UDim2.fromScale(1, 1),
		Parent = ToggleButton,
	})
	Library:RegisterThemeBinding(ToggleTick, "ImageColor3", "Checkmark")

	local ToggleCorner = Library:Create("UICorner", {
		CornerRadius = UDim.new(0.23, 0),
		Parent = ToggleButton,
	})

	local ToggleStroke = Library:Create("UIStroke", {
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
		Color = Theme.Outline,
		Transparency = 0.42,
		Thickness = 1.5,
		Parent = ToggleButton,
	})

	function Toggle:Display()
		if Toggle.Value then
			TweenService:Create(ToggleTick, TweenInfo.new(0.15), { ImageTransparency = 0 }):Play()
			TweenService:Create(ToggleButton, TweenInfo.new(0.15), { BackgroundTransparency = 0 }):Play()
			TweenService
				:Create(
					ToggleStroke,
					TweenInfo.new(0.15),
					{ Thickness = 2, Color = Theme.Checkmark, Transparency = 0.12 }
				)
				:Play()
		else
			TweenService:Create(ToggleTick, TweenInfo.new(0.15), { ImageTransparency = 1 }):Play()
			TweenService:Create(ToggleButton, TweenInfo.new(0.15), { BackgroundTransparency = 1 }):Play()
			TweenService
				:Create(
					ToggleStroke,
					TweenInfo.new(0.15),
					{ Thickness = 1.5, Color = Theme.Outline, Transparency = 0.42 }
				)
				:Play()
		end
	end

	function Toggle:SetValue(Bool)
		Bool = not not Bool

		Toggle.Value = Bool
		Toggle:Display()

		if Function then
			Function(Toggle.Value, Toggle)
		end
	end

	function Toggle:GetValue()
		return Toggle.Value
	end

	ToggleButton.Activated:Connect(function()
		Toggle:SetValue(not Toggle.Value)
	end)

	Toggle:SetValue()
	Toggle:Display()

	Library:AttachRowHover(ToggleFrame, ToggleFrameStroke)

	Library:RegisterAccentElement(ToggleUnderline)

	if self.UpdateLayout then
		self:UpdateLayout()
	end

	return Toggle
end

function Functions:AddToggleAndInput(Name, Info, Function)
	local Toggle = {
		BoolValue = Info.BoolDefault or false,
		InputValue = Info.InputDefault or "",
		Numeric = Info.Numeric or false,
		MinLength = Info.MinLength or 1,
		MaxLength = Info.MaxLength or 8,
		Finished = Info.Finished or false,
	}

	local Container = self.Container
	local ToggleShell, ToggleFrame, ToggleFrameStroke = Library:CreateRowShell(Container)

	local ToggleUnderline = Library:Create("Frame", {
		BackgroundTransparency = 0.15,
		BorderSizePixel = 0,
		BackgroundColor3 = Theme.Accent,
		Size = UDim2.new(0, 3, 0, 46),
		Position = UDim2.fromOffset(0, 15),
		ZIndex = 1,
		Parent = ToggleFrame,
	})
	Library:RegisterThemeBinding(ToggleUnderline, "BackgroundColor3", "Accent")

	local Option = Library:Create("TextLabel", {
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(0, 0.5),
		Size = UDim2.new(1, -196, 0, 24),
		Position = UDim2.new(0, 20, 0.5, 0),
		Text = Name or "Empty",
		TextColor3 = Theme.Text,
		TextSize = 18,
		TextTruncate = Enum.TextTruncate.AtEnd,
		TextXAlignment = Enum.TextXAlignment.Left,
		FontFace = Theme.Font,
		ZIndex = 1,
		Parent = ToggleFrame,
	})
	Library:RegisterThemeBinding(Option, "TextColor3", "Text")

	local OptionPadding = Library:Create("UIPadding", {
		PaddingBottom = UDim.new(0.25, 0),
		PaddingRight = UDim.new(0.01, 0),
		PaddingLeft = UDim.new(0.01, 0),
		PaddingTop = UDim.new(0.25, 0),
		Parent = Option,
	})

	local ToggleButton = Library:Create("TextButton", {
		AnchorPoint = Vector2.new(1, 0.5),
		BackgroundTransparency = 1,
		BackgroundColor3 = Theme.Accent,
		Size = UDim2.fromOffset(32, 32),
		Position = UDim2.new(1, -138, 0.5, 0),
		Text = "",
		Parent = ToggleFrame,
	})
	Library:RegisterThemeBinding(ToggleButton, "BackgroundColor3", "Accent")

	local TickPadding = Library:Create("UIPadding", {
		PaddingBottom = UDim.new(0, 2),
		PaddingLeft = UDim.new(0, 2),
		PaddingRight = UDim.new(0, 2),
		PaddingTop = UDim.new(0, 2),
		Parent = ToggleButton,
	})

	local ToggleTick = Library:Create("ImageLabel", {
		AnchorPoint = Vector2.new(0, 0),
		BackgroundTransparency = 1,
		ImageColor3 = Theme.Checkmark,
		ImageTransparency = 1,
		Image = "rbxassetid://73965231027852",
		Size = UDim2.fromScale(1, 1),
		Parent = ToggleButton,
	})
	Library:RegisterThemeBinding(ToggleTick, "ImageColor3", "Checkmark")

	local ToggleCorner = Library:Create("UICorner", {
		CornerRadius = UDim.new(0.23, 0),
		Parent = ToggleButton,
	})

	local ToggleStroke = Library:Create("UIStroke", {
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
		Color = Theme.Outline,
		Transparency = 0.42,
		Thickness = 1.5,
		Parent = ToggleButton,
	})

	local InputBox = Library:Create("TextBox", {
		AnchorPoint = Vector2.new(1, 0.5),
		BackgroundColor3 = Theme.Surface2,
		BackgroundTransparency = 1,
		Size = UDim2.fromOffset(108, 38),
		PlaceholderColor3 = Theme.TextMuted,
		Position = UDim2.new(1, -18, 0.5, 0),
		Text = "",
		ClearTextOnFocus = false,
		TextColor3 = Theme.Text,
		TextSize = 16,
		TextXAlignment = Enum.TextXAlignment.Center,
		TextTruncate = Enum.TextTruncate.AtEnd,
		FontFace = Theme.FontBold,
		PlaceholderText = "Value",
		Parent = ToggleFrame,
	})
	Library:RegisterThemeBinding(InputBox, "TextColor3", "Text")
	Library:RegisterThemeBinding(InputBox, "PlaceholderColor3", "TextMuted")

	Library:Create("UICorner", {
		CornerRadius = UDim.new(0, 8),
		Parent = InputBox,
	})

	Library:Create("UIStroke", {
		Color = Theme.Outline,
		Transparency = 0.58,
		Thickness = 1,
		Parent = InputBox,
	})

	local InputUnderline = Library:Create("Frame", {
		BackgroundColor3 = Theme.Accent,
		Size = UDim2.new(0, 0, 0.1, 0),
		ZIndex = 1,
		BorderSizePixel = 0,
		AnchorPoint = Vector2.new(0.5, 0),
		Position = UDim2.fromScale(0.5, 1.5),
		Parent = InputBox,
	})
	Library:RegisterThemeBinding(InputUnderline, "BackgroundColor3", "Accent")

	local InputPadding = Library:Create("UIPadding", {
		PaddingBottom = UDim.new(0.25, 0),
		PaddingRight = UDim.new(0.01, 0),
		PaddingLeft = UDim.new(0.01, 0),
		PaddingTop = UDim.new(0.25, 0),
		Parent = InputBox,
	})

	function Toggle:Display()
		if Toggle.BoolValue then
			TweenService:Create(ToggleTick, TweenInfo.new(0.15), { ImageTransparency = 0 }):Play()
			TweenService:Create(ToggleButton, TweenInfo.new(0.15), { BackgroundTransparency = 0 }):Play()
			TweenService
				:Create(
					ToggleStroke,
					TweenInfo.new(0.15),
					{ Thickness = 2, Color = Theme.Checkmark, Transparency = 0.12 }
				)
				:Play()
		else
			TweenService:Create(ToggleTick, TweenInfo.new(0.15), { ImageTransparency = 1 }):Play()
			TweenService:Create(ToggleButton, TweenInfo.new(0.15), { BackgroundTransparency = 1 }):Play()
			TweenService
				:Create(
					ToggleStroke,
					TweenInfo.new(0.15),
					{ Thickness = 1.5, Color = Theme.Outline, Transparency = 0.42 }
				)
				:Play()
		end
	end

	function Toggle:InputDisplay()
		if InputBox.Text:len() > 0 then
			TweenService:Create(InputUnderline, TweenInfo.new(0.2), { Size = UDim2.fromScale(1, 0.1) }):Play()
		else
			TweenService:Create(InputUnderline, TweenInfo.new(0.2), { Size = UDim2.fromScale(0, 0.1) }):Play()
		end
	end

	function Toggle:SetBoolValue(Bool)
		Bool = not not Bool

		Toggle.BoolValue = Bool
		Toggle:Display()

		if Function then
			Function(Toggle.BoolValue, Toggle.InputValue, Toggle)
		end
	end

	function Toggle:SetInputValue(Text)
		if Toggle.MaxLength and #Text > Toggle.MaxLength then
			Text = Text:sub(1, Toggle.MaxLength)
		end

		if Toggle.Numeric then
			if (not tonumber(Text)) and Text:len() > 0 then
				Text = Toggle.InputValue
			end
		end

		Toggle.InputValue = Text
		InputBox.Text = Text
		Toggle:InputDisplay()

		if Function then
			Function(Toggle.BoolValue, Toggle.InputValue, Toggle)
		end
	end

	function Toggle:GetValue()
		return {
			Enabled = Toggle.BoolValue,
			Text = Toggle.InputValue,
		}
	end

	InputBox.Focused:Connect(function(Enter)
		TweenService:Create(InputUnderline, TweenInfo.new(0.2), { Size = UDim2.fromScale(1, 0.1) }):Play()
		if Toggle.Finished then
			if not Enter then
				return
			end
			Toggle:SetInputValue(InputBox.Text)
		end
	end)

	InputBox.FocusLost:Connect(function()
		Toggle:SetInputValue(InputBox.Text)
	end)

	ToggleButton.Activated:Connect(function()
		Toggle:SetBoolValue(not Toggle.BoolValue)
	end)

	Toggle:Display()

	if Info.InputDefault then
		Toggle:SetInputValue(Info.InputDefault)
	end

	Library:AttachRowHover(ToggleFrame, ToggleFrameStroke)

	if self.UpdateLayout then
		self:UpdateLayout()
	end

	Library:RegisterAccentElement(ToggleUnderline)
	Library:RegisterAccentElement(InputUnderline)

	return Toggle
end

function Functions:AddDropdown(Name, Info, Function)
	local Dropdown = {
		Values = Info.Values,
		Value = Info.Multi and {},
		Multi = Info.Multi,
		MaxShow = Info.Multi and math.max(2, Info.MaxShow or 3) or (Info.MaxShow or 3),
		AllowNull = Info.AllowNull or false,
		MaxItems = Info.MaxItems or 5,
	}

	local Container = self.Container
	local DropdownShell, DropdownFrame, DropdownFrameStroke = Library:CreateRowShell(Container)

	local DropdownUnderline = Library:Create("Frame", {
		BackgroundTransparency = 0.15,
		BorderSizePixel = 0,
		BackgroundColor3 = Theme.Accent,
		Size = UDim2.new(0, 3, 0, 46),
		Position = UDim2.fromOffset(0, 15),
		ZIndex = 1,
		Parent = DropdownFrame,
	})
	Library:RegisterThemeBinding(DropdownUnderline, "BackgroundColor3", "Accent")

	local Option = Library:Create("TextLabel", {
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(0, 0.5),
		Size = UDim2.new(1, -240, 0, 24),
		Position = UDim2.new(0, 20, 0.5, 0),
		Text = Name or "Empty",
		TextColor3 = Theme.Text,
		TextSize = 18,
		TextTruncate = Enum.TextTruncate.AtEnd,
		TextXAlignment = Enum.TextXAlignment.Left,
		FontFace = Theme.Font,
		ZIndex = 1,
		Parent = DropdownFrame,
	})
	Library:RegisterThemeBinding(Option, "TextColor3", "Text")

	local OptionPadding = Library:Create("UIPadding", {
		PaddingBottom = UDim.new(0.25, 0),
		PaddingRight = UDim.new(0.01, 0),
		PaddingLeft = UDim.new(0.01, 0),
		PaddingTop = UDim.new(0.25, 0),
		Parent = Option,
	})

	local DropdownButton = Library:Create("ImageButton", {
		AnchorPoint = Vector2.new(1, 0.5),
		BackgroundTransparency = 1,
		ImageTransparency = 0,
		BorderSizePixel = 0,
		Position = UDim2.new(1, -18, 0.5, 0),
		ZIndex = 2,
		Image = "rbxassetid://293296862",
		Size = UDim2.fromOffset(26, 26),
		Parent = DropdownFrame,
	})

	local DropdownHolder = Library:Create("Frame", {
		BackgroundColor3 = Theme.Surface1,
		Size = UDim2.new(0, 245, 0, 168),
		ZIndex = 1,
		Visible = false,
		Position = UDim2.fromScale(-3.9, 1.1),
		Parent = ScreenGui,
	})
	Library:RegisterThemeBinding(DropdownHolder, "BackgroundColor3", "Surface1")

	local DropdownCorner = Library:Create("UICorner", {
		CornerRadius = UDim.new(0.05, 0),
		Parent = DropdownHolder,
	})

	local DropdownHolderStroke = Library:Create("UIStroke", {
		Color = Theme.Outline,
		Transparency = 0.48,
		Thickness = 1,
		Parent = DropdownHolder,
	})
	Library:RegisterThemeBinding(DropdownHolderStroke, "Color", "Outline")

	local DropdownList = Library:Create("ScrollingFrame", {
		BorderSizePixel = 0,
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 1, 0),
		Visible = true,
		ClipsDescendants = true,
		ZIndex = 2,
		ScrollBarThickness = 0,
		CanvasSize = UDim2.new(0, 0, 0, 0),
		AutomaticCanvasSize = Enum.AutomaticSize.Y,
		Parent = DropdownHolder,
	})

	local DropdownLayout = Library:Create("UIListLayout", {
		FillDirection = Enum.FillDirection.Vertical,
		SortOrder = Enum.SortOrder.LayoutOrder,
		HorizontalAlignment = Enum.HorizontalAlignment.Left,
		VerticalAlignment = Enum.VerticalAlignment.Top,
		Padding = UDim.new(0, 5),
		Parent = DropdownList,
	})

	local DropdownPadding = Library:Create("UIPadding", {
		PaddingBottom = UDim.new(0, 7),
		PaddingTop = UDim.new(0, 7),
		PaddingLeft = UDim.new(0.027, 0),
		PaddingRight = UDim.new(0.025, 0),
		Parent = DropdownList,
	})

	local DropdownValue = Library:Create("TextLabel", {
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(1, 0.5),
		Size = UDim2.new(0, 150, 0, 24),
		Position = UDim2.new(1, -48, 0.5, 0),
		Text = "...",
		TextColor3 = Theme.TextMuted,
		RichText = true,
		TextTruncate = Enum.TextTruncate.AtEnd,
		TextSize = 15,
		TextWrapped = false,
		TextXAlignment = Enum.TextXAlignment.Right,
		FontFace = Theme.FontBold,
		ZIndex = 1,
		Parent = DropdownFrame,
	})
	Library:RegisterThemeBinding(DropdownValue, "TextColor3", "TextMuted")

	local DropdownValuePadding = Library:Create("UIPadding", {
		PaddingBottom = UDim.new(0.3, 0),
		PaddingTop = UDim.new(0.3, 0),
		PaddingLeft = UDim.new(0.01, 0),
		PaddingRight = UDim.new(0.01, 0),
		Parent = DropdownValue,
	})

	function Dropdown:Display()
		local Values = Dropdown.Values
		local Str = ""
		local Count = 0

		if Dropdown.Multi then
			local SelectedValues = {}

			for Idx, Value in next, Values do
				if Dropdown.Value[Value] then
					Count += 1
					if Count <= Dropdown.MaxShow then
						table.insert(SelectedValues, Value)
					end
				end
			end

			Str = table.concat(SelectedValues, ", ")

			if Count > Dropdown.MaxShow then
				if Str ~= "" then
					Str = Str .. ", ..."
				else
					Str = "..."
				end
			end
		else
			Str = Dropdown.Value or ""
		end
		DropdownValue.Text = (Str == "" and "..." or Str)
	end

	function Dropdown:GetActiveValues()
		if Dropdown.Multi then
			local T = {}

			for Value, Bool in next, Dropdown.Value do
				table.insert(T, Value)
			end

			return T
		else
			return Dropdown.Value and 1 or 0
		end
	end

	function Dropdown:GetValue()
		if Dropdown.Multi then
			local SelectedValues = {}

			for _, Value in next, Dropdown.Values do
				if Dropdown.Value[Value] then
					table.insert(SelectedValues, Value)
				end
			end

			return SelectedValues
		end

		return Dropdown.Value
	end

	function Dropdown:SetValues()
		local Values = Dropdown.Values
		local Buttons = {}

		for _, Element in next, DropdownList:GetChildren() do
			if not Element:IsA("UIListLayout") and not Element:IsA("UIPadding") then
				Element:Destroy()
			end
		end

		local Count = 0

		for Idx, Value in next, Values do
			local Table = {}

			Count = Count + 1

			local SelectionButton = Library:Create("Frame", {
				BackgroundColor3 = Theme.Surface2,
				BackgroundTransparency = 1,
				Size = UDim2.new(1, 0, 0, 35),
				ZIndex = 1,
				Active = true,
				Parent = DropdownList,
			})
			Library:RegisterThemeBinding(SelectionButton, "BackgroundColor3", "Surface2")

			local SelectionCorner = Library:Create("UICorner", {
				CornerRadius = UDim.new(0.15, 0),
				Parent = SelectionButton,
			})

			local Bar = Library:Create("Frame", {
				BackgroundColor3 = Theme.Accent,
				AnchorPoint = Vector2.new(0, 0.5),
				BorderSizePixel = 0,
				Position = UDim2.fromScale(0.025, 0.5),
				Size = UDim2.new(0, 2, 0, 0),
				ZIndex = 1,
				Parent = SelectionButton,
			})
			Library:RegisterThemeBinding(Bar, "BackgroundColor3", "Accent")

			local SelectionText = Library:Create("TextLabel", {
				BackgroundTransparency = 1,
				AnchorPoint = Vector2.new(0, 0.5),
				Size = UDim2.new(-0.688, 368, 1, 0),
				Position = UDim2.new(0.083, 0, 0.5, 0),
				Text = Value,
				TextColor3 = Theme.Text,
				TextScaled = true,
				RichText = true,
				TextXAlignment = Enum.TextXAlignment.Left,
				FontFace = Theme.FontSemibold,
				ZIndex = 1,
				Parent = SelectionButton,
			})
			Library:RegisterThemeBinding(SelectionText, "TextColor3", "Text")

			local SelectionPadding = Library:Create("UIPadding", {
				PaddingBottom = UDim.new(0.2, 0),
				PaddingTop = UDim.new(0.2, 0),
				PaddingLeft = UDim.new(0.01, 0),
				PaddingRight = UDim.new(0.01, 0),
				Parent = SelectionText,
			})

			local Selected

			if Dropdown.Multi then
				Selected = Dropdown.Value[Value]
			else
				Selected = Dropdown.Value == Value
			end

			local function SetButtonColor(Bool)
				if Bool then
					TweenService:Create(SelectionButton, TweenInfo.new(0.2), { BackgroundTransparency = 0 }):Play()
					TweenService:Create(Bar, TweenInfo.new(0.2), { Size = UDim2.new(0, 2, 0, 25) }):Play()
				else
					TweenService:Create(SelectionButton, TweenInfo.new(0.2), { BackgroundTransparency = 1 }):Play()
					TweenService:Create(Bar, TweenInfo.new(0.2), { Size = UDim2.new(0, 2, 0, 0) }):Play()
				end
			end

			function Table:UpdateButton()
				if Dropdown.Multi then
					Selected = Dropdown.Value[Value]
				else
					Selected = Dropdown.Value == Value
				end
				SetButtonColor((Selected and true) or false)
			end

			SelectionButton.InputBegan:Connect(function(Input)
				if Input.UserInputType == Enum.UserInputType.MouseButton1 then
					local Try = not Selected

					if Dropdown:GetActiveValues() == 1 and not Try and not Dropdown.AllowNull then
					else
						if Info.Multi then
							Selected = Try

							if Selected then
								Dropdown.Value[Value] = true
							else
								Dropdown.Value[Value] = nil
							end
						else
							Selected = Try

							if Selected then
								Dropdown.Value = Value
							else
								Dropdown.Value = nil
							end

							for _, OtherButton in next, Buttons do
								OtherButton:UpdateButton()
							end
						end

						Table:UpdateButton()
						Dropdown:Display()

						if Function then
							Function(Dropdown:GetValue(), Dropdown)
						end
					end
				end
			end)

			Table:UpdateButton()
			Dropdown:Display()

			Buttons[SelectionButton] = Table
		end
		DropdownList.CanvasSize = UDim2.new(0, 0, 0, DropdownLayout.AbsoluteContentSize.Y + 12)
	end

	function Dropdown:OpenDropdown()
		DropdownHolder.Position = UDim2.fromOffset(
			DropdownButton.AbsolutePosition.X - DropdownHolder.Size.X.Offset - 10,
			DropdownButton.AbsolutePosition.Y + 10
		)
		DropdownHolder.Visible = true
		DropdownFrame.ZIndex = 3
		Library.VisibleFrames[DropdownHolder] = true
	end

	function Dropdown:CloseDropdown()
		DropdownHolder.Visible = false
		DropdownFrame.ZIndex = 1
		Library.VisibleFrames[DropdownHolder] = nil
	end

	function Dropdown:SetValue(Val)
		if Dropdown.Multi then
			local nTable = {}

			for Value, Bool in next, Val do
				if table.find(Dropdown.Values, Value) then
					nTable[Value] = true
				end
			end

			Dropdown.Value = nTable
		else
			if not Val then
				Dropdown.Value = nil
			elseif table.find(Dropdown.Values, Val) then
				Dropdown.Value = Val
			end
		end

		Dropdown:SetValues()
		Dropdown:Display()

		if Function then
			Function(Dropdown:GetValue(), Dropdown)
		end
	end

	DropdownButton.Activated:Connect(function()
		if DropdownHolder.Visible then
			Dropdown:CloseDropdown()
		else
			Dropdown:OpenDropdown()
		end
	end)

	local function ClosesIfOutsideOfFrame()
		local AbsPos, AbsSize = DropdownHolder.AbsolutePosition, DropdownHolder.AbsoluteSize
		local ButtonPos, ButtonSize = DropdownButton.AbsolutePosition, DropdownButton.AbsoluteSize

		if
			Mouse.X < AbsPos.X
			or Mouse.X > AbsPos.X + AbsSize.X
			or Mouse.Y < AbsPos.Y
			or Mouse.Y > AbsPos.Y + AbsSize.Y
		then
			if
				Mouse.X < ButtonPos.X
				or Mouse.X > ButtonPos.X + ButtonSize.X
				or Mouse.Y < ButtonPos.Y
				or Mouse.Y > ButtonPos.Y + ButtonSize.Y
			then
				Dropdown:CloseDropdown()
			end
		end
	end

	UserInputService.InputBegan:Connect(function(Input)
		if Input.UserInputType == Enum.UserInputType.MouseButton1 then
			ClosesIfOutsideOfFrame()
		end
	end)

	UserInputService.InputChanged:Connect(function(Input)
		if DropdownHolder.Visible then
			if Input.UserInputType == Enum.UserInputType.MouseWheel then
				ClosesIfOutsideOfFrame()
			end
		end
	end)

	Dropdown:SetValues()
	Dropdown:Display()

	if Info.Default then
		if Dropdown.Multi then
			if type(Info.Default) == "table" then
				for _, Index in next, Info.Default do
					Dropdown.Value[Dropdown.Values[Index]] = true
				end
			else
				Dropdown.Value[Dropdown.Values[Info.Default]] = true
			end
		else
			if type(Info.Default) == "table" then
				Dropdown.Value = Dropdown.Values[Info.Default[1]]
			else
				Dropdown.Value = Dropdown.Values[Info.Default]
			end
		end

		Dropdown:SetValues()
		Dropdown:Display()
	end

	Library:AttachRowHover(DropdownFrame, DropdownFrameStroke)

	if self.UpdateLayout then
		self:UpdateLayout()
	end

	Library:RegisterAccentElement(DropdownUnderline)

	return Dropdown
end

function Functions:AddInput(Name, Info, Function)
	local Input = {
		Value = Info.Default or "",
		Numeric = Info.Numeric or false,
		MinLength = Info.MinLength or 1,
		MaxLength = Info.MaxLength or 8,
		Finished = Info.Finished or false,
	}

	local Container = self.Container
	local InputShell, InputFrame, InputFrameStroke = Library:CreateRowShell(Container)

	local InputUnderline = Library:Create("Frame", {
		BackgroundTransparency = 0.15,
		BorderSizePixel = 0,
		BackgroundColor3 = Theme.Accent,
		Size = UDim2.new(0, 3, 0, 46),
		Position = UDim2.fromOffset(0, 15),
		ZIndex = 1,
		Parent = InputFrame,
	})
	Library:RegisterThemeBinding(InputUnderline, "BackgroundColor3", "Accent")

	local Option = Library:Create("TextLabel", {
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(0, 0.5),
		Size = UDim2.new(0, 220, 0, 24),
		Position = UDim2.new(0, 20, 0.5, 0),
		Text = Name or "Empty",
		TextColor3 = Theme.Text,
		TextSize = 18,
		TextXAlignment = Enum.TextXAlignment.Left,
		FontFace = Theme.Font,
		ZIndex = 1,
		Parent = InputFrame,
	})
	Library:RegisterThemeBinding(Option, "TextColor3", "Text")

	local OptionPadding = Library:Create("UIPadding", {
		PaddingBottom = UDim.new(0.25, 0),
		PaddingRight = UDim.new(0.01, 0),
		PaddingLeft = UDim.new(0.01, 0),
		PaddingTop = UDim.new(0.25, 0),
		Parent = Option,
	})

	local InputBox = Library:Create("TextBox", {
		AnchorPoint = Vector2.new(1, 0.5),
		BackgroundColor3 = Theme.Surface2,
		BackgroundTransparency = 1,
		Size = UDim2.fromOffset(130, 38),
		PlaceholderColor3 = Theme.TextMuted,
		Position = UDim2.new(1, -20, 0.5, 0),
		Text = "",
		ClearTextOnFocus = false,
		TextColor3 = Theme.Text,
		TextSize = 16,
		TextTruncate = Enum.TextTruncate.AtEnd,
		TextXAlignment = Enum.TextXAlignment.Center,
		FontFace = Theme.FontBold,
		PlaceholderText = "Value",
		Parent = InputFrame,
	})
	Library:RegisterThemeBinding(InputBox, "TextColor3", "Text")
	Library:RegisterThemeBinding(InputBox, "PlaceholderColor3", "TextMuted")

	Library:Create("UICorner", {
		CornerRadius = UDim.new(0, 8),
		Parent = InputBox,
	})

	Library:Create("UIStroke", {
		Color = Theme.Outline,
		Transparency = 0.58,
		Thickness = 1,
		Parent = InputBox,
	})

	local InputUnderline = Library:Create("Frame", {
		BackgroundColor3 = Theme.Accent,
		Size = UDim2.new(0, 0, 0.1, 0),
		ZIndex = 1,
		BorderSizePixel = 0,
		AnchorPoint = Vector2.new(0.5, 0),
		Position = UDim2.fromScale(0.5, 1.5),
		Parent = InputBox,
	})
	Library:RegisterThemeBinding(InputUnderline, "BackgroundColor3", "Accent")

	local InputPadding = Library:Create("UIPadding", {
		PaddingBottom = UDim.new(0.25, 0),
		PaddingRight = UDim.new(0.01, 0),
		PaddingLeft = UDim.new(0.01, 0),
		PaddingTop = UDim.new(0.25, 0),
		Parent = InputBox,
	})

	function Input:SetValue(Text)
		if Input.MaxLength and #Text > Input.MaxLength then
			Text = Text:sub(1, Input.MaxLength)
		end

		if Input.Numeric then
			if (not tonumber(Text)) and Text:len() > 0 then
				Text = Input.Value
			end
		end

		Input.Value = Text
		InputBox.Text = Text
		Input:Display()

		if Function then
			Function(Input.Value, Input)
		end
	end

	function Input:GetValue()
		return Input.Value
	end

	function Input:Display()
		if InputBox.Text:len() > 0 then
			TweenService:Create(InputUnderline, TweenInfo.new(0.2), { Size = UDim2.fromScale(1, 0.1) }):Play()
		else
			TweenService:Create(InputUnderline, TweenInfo.new(0.2), { Size = UDim2.fromScale(0, 0.1) }):Play()
		end
	end

	InputBox.Focused:Connect(function(Enter)
		TweenService:Create(InputUnderline, TweenInfo.new(0.2), { Size = UDim2.fromScale(1, 0.1) }):Play()
		if Input.Finished then
			if not Enter then
				return
			end
			Input:SetValue(InputBox.Text)
		end
	end)

	InputBox.FocusLost:Connect(function()
		Input:SetValue(InputBox.Text)
	end)

	Input:Display()

	if Info.Default then
		Input:SetValue(Info.Default)
	end

	Library:AttachRowHover(InputFrame, InputFrameStroke)

	if self.UpdateLayout then
		self:UpdateLayout()
	end

	Library:RegisterAccentElement(InputUnderline)

	return Input
end

function Functions:AddSlider(Name, Info, Function)
	local Slider = {
		Value = Info.Default or 0,
		Min = Info.Min or 0,
		Max = Info.Max or 10,
		Rounding = Info.Rounding or 0,
		Suffix = Info.Suffix or "",
	}

	local Container = self.Container
	local SliderShell, SliderFrame, SliderFrameStroke = Library:CreateRowShell(Container)

	local SliderUnderline = Library:Create("Frame", {
		BackgroundTransparency = 0.15,
		BorderSizePixel = 0,
		BackgroundColor3 = Theme.Accent,
		Size = UDim2.new(0, 3, 0, 46),
		Position = UDim2.fromOffset(0, 15),
		ZIndex = 1,
		Parent = SliderFrame,
	})
	Library:RegisterThemeBinding(SliderUnderline, "BackgroundColor3", "Accent")

	local Option = Library:Create("TextLabel", {
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(0, 0.5),
		Size = UDim2.new(0, 180, 0, 24),
		Position = UDim2.new(0, 20, 0.5, 0),
		Text = Name or "Empty",
		TextColor3 = Theme.Text,
		TextSize = 18,
		TextXAlignment = Enum.TextXAlignment.Left,
		FontFace = Theme.Font,
		ZIndex = 1,
		Parent = SliderFrame,
	})
	Library:RegisterThemeBinding(Option, "TextColor3", "Text")

	local OptionPadding = Library:Create("UIPadding", {
		PaddingBottom = UDim.new(0.25, 0),
		PaddingRight = UDim.new(0.01, 0),
		PaddingLeft = UDim.new(0.01, 0),
		PaddingTop = UDim.new(0.25, 0),
		Parent = Option,
	})

	local Drag = Library:Create("ImageLabel", {
		AnchorPoint = Vector2.new(1, 0.5),
		BackgroundColor3 = Theme.Surface0,
		BackgroundTransparency = 1.000,
		BorderSizePixel = 0,
		Position = UDim2.new(1, -20, 0.5, 0),
		Size = UDim2.new(0, 150, 0, 7),
		Image = "rbxassetid://5825681337",
		ImageColor3 = Theme.Surface3,
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = Rect.new(130, 134, 388, 390),
		Parent = SliderFrame,
	})

	local Bar = Library:Create("ImageLabel", {
		BackgroundColor3 = Color3.fromRGB(1, 1, 1),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Size = UDim2.new(0.5, 0, 1, 0),
		Image = "rbxassetid://5825681337",
		ImageColor3 = Theme.Accent,
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = Rect.new(130, 134, 388, 390),
		Parent = Drag,
	})
	Library:RegisterThemeBinding(Bar, "ImageColor3", "Accent")

	local Dot = Library:Create("ImageLabel", {
		Active = true,
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 1,
		Position = UDim2.new(1, 0, 0.5, 0),
		Selectable = true,
		Size = UDim2.new(0, 30, 0, 30),
		Image = "rbxassetid://4504304159",
		Parent = Bar,
	})

	local Circle = Library:Create("ImageLabel", {
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 1,
		Position = UDim2.new(0.5, 0, 0.5, 0),
		Selectable = true,
		ImageColor3 = Theme.Accent,
		Size = UDim2.new(0.35, 0, 0.35, 0),
		Image = "rbxassetid://10033707044",
		Parent = Dot,
	})
	Library:RegisterThemeBinding(Circle, "ImageColor3", "Accent")

	local ValueBox = Library:Create("TextBox", {
		AnchorPoint = Vector2.new(1, 0.5),
		BackgroundTransparency = 1,
		Size = UDim2.fromOffset(72, 24),
		PlaceholderColor3 = Theme.TextMuted,
		Position = UDim2.new(1, -182, 0.5, 0),
		Text = "",
		TextColor3 = Theme.Text,
		TextSize = 15,
		FontFace = Theme.FontBold,
		TextXAlignment = Enum.TextXAlignment.Center,
		TextTruncate = Enum.TextTruncate.AtEnd,
		PlaceholderText = "Value",
		Parent = SliderFrame,
	})
	Library:RegisterThemeBinding(ValueBox, "TextColor3", "Text")
	Library:RegisterThemeBinding(ValueBox, "PlaceholderColor3", "TextMuted")

	local ValueUnderline = Library:Create("Frame", {
		BackgroundColor3 = Theme.Accent,
		Size = UDim2.new(0, 0, 0.1, 0),
		ZIndex = 1,
		BorderSizePixel = 0,
		AnchorPoint = Vector2.new(0.5, 0),
		Position = UDim2.fromScale(0.5, 1.5),
		Parent = ValueBox,
	})
	Library:RegisterThemeBinding(ValueUnderline, "BackgroundColor3", "Accent")

	local ValuePadding = Library:Create("UIPadding", {
		PaddingBottom = UDim.new(0.3, 0),
		PaddingRight = UDim.new(0.01, 0),
		PaddingLeft = UDim.new(0.01, 0),
		PaddingTop = UDim.new(0.3, 0),
		Parent = ValueBox,
	})

	function Slider:Display()
		local Suffix = Slider.Suffix
		ValueBox.Text = string.format("%s", Slider.Value .. " " .. Suffix)

		local X = math.ceil(Library:MapValue(Slider.Value, Slider.Min, Slider.Max, 0, 150))
		TweenService:Create(Bar, TweenInfo.new(0.2), { Size = UDim2.new(0, X, 1, 0) }):Play()
	end

	local function Round(Value)
		if Slider.Rounding == 0 then
			return math.floor(Value)
		end

		local Str = Value .. ""
		local Dot = Str:find("%.")

		return Dot and tonumber(Str:sub(1, Dot + Slider.Rounding)) or Value
	end

	function Slider:GetValueFromXOffset(X)
		return Round(Library:MapValue(X, 0, 150, Slider.Min, Slider.Max))
	end

	function Slider:SetValue(Str)
		local Num = tonumber(Str)

		if not Num then
			Slider:SetValue(Slider.Value)
			return
		end

		Num = math.clamp(Num, Slider.Min, Slider.Max)

		Slider.Value = Num
		Slider:Display()

		if Function then
			Function(Slider.Value, Slider)
		end
	end

	function Slider:GetValue()
		return Slider.Value
	end

	Dot.InputBegan:Connect(function(Input)
		if Input.UserInputType == Enum.UserInputType.MouseButton1 and not Library:MouseIsOverVisibleFrames() then
			local mPos = Mouse.X
			local gPos = Bar.Size.X.Offset
			local Diff = mPos - (Bar.AbsolutePosition.X + gPos)

			while UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) do
				local nMPos = Mouse.X
				local nX = math.clamp(gPos + (nMPos - mPos) + Diff, 0, 150)

				local nValue = Slider:GetValueFromXOffset(nX)
				local OldValue = Slider.Value
				Slider.Value = nValue

				Slider:Display()

				if Function and OldValue ~= Slider.Value then
					Function(Slider.Value, Slider)
				end

				RenderStepped:Wait()
			end
		end
	end)

	ValueBox.Focused:Connect(function(Enter)
		TweenService:Create(ValueUnderline, TweenInfo.new(0.2), { Size = UDim2.fromScale(1, 0.1) }):Play()
	end)

	ValueBox.FocusLost:Connect(function()
		Slider:SetValue(ValueBox.Text)
		TweenService:Create(ValueUnderline, TweenInfo.new(0.2), { Size = UDim2.fromScale(0, 0.1) }):Play()
	end)

	Slider:Display()

	if Info.Default then
		Slider:SetValue(Info.Default)
	end

	Library:AttachRowHover(SliderFrame, SliderFrameStroke)

	if self.UpdateLayout then
		self:UpdateLayout()
	end

	Library:RegisterAccentElement(SliderUnderline)
	Library:RegisterAccentElement(ValueUnderline)

	return Slider
end

function Functions:AddKeybindPicker(Name, Info, Function)
	local KeybindPicker = {
		Value = Info.Default,
	}

	local Container = self.Container
	local KeybindShell, KeybindFrame, KeybindFrameStroke = Library:CreateRowShell(Container)

	local KeybindUnderline = Library:Create("Frame", {
		BackgroundTransparency = 0.15,
		BorderSizePixel = 0,
		BackgroundColor3 = Theme.Accent,
		Size = UDim2.new(0, 3, 0, 46),
		Position = UDim2.fromOffset(0, 15),
		ZIndex = 1,
		Parent = KeybindFrame,
	})
	Library:RegisterThemeBinding(KeybindUnderline, "BackgroundColor3", "Accent")

	local Option = Library:Create("TextLabel", {
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(0, 0.5),
		Size = UDim2.new(0, 220, 0, 24),
		Position = UDim2.new(0, 20, 0.5, 0),
		Text = Name or "Empty",
		TextColor3 = Theme.Text,
		TextSize = 18,
		TextXAlignment = Enum.TextXAlignment.Left,
		FontFace = Theme.Font,
		ZIndex = 1,
		Parent = KeybindFrame,
	})
	Library:RegisterThemeBinding(Option, "TextColor3", "Text")

	local OptionPadding = Library:Create("UIPadding", {
		PaddingBottom = UDim.new(0.25, 0),
		PaddingRight = UDim.new(0.01, 0),
		PaddingLeft = UDim.new(0.01, 0),
		PaddingTop = UDim.new(0.25, 0),
		Parent = Option,
	})

	local KeybindBox = Library:Create("TextButton", {
		Active = false,
		AnchorPoint = Vector2.new(1, 0.5),
		BackgroundColor3 = Theme.Surface2,
		BackgroundTransparency = 1,
		BorderColor3 = Theme.Outline,
		BorderSizePixel = 0,
		Position = UDim2.new(1, -20, 0.5, 0),
		Selectable = false,
		Size = UDim2.new(0, 124, 0, 38),
		FontFace = Theme.FontBold,
		Text = "[ Keybind ]",
		TextColor3 = Theme.Text,
		TextSize = 14,
		TextWrapped = true,
		TextXAlignment = Enum.TextXAlignment.Right,
		Parent = KeybindFrame,
	})
	Library:RegisterThemeBinding(KeybindBox, "TextColor3", "Text")

	local KeybindBoxPadding = Library:Create("UIPadding", {
		PaddingBottom = UDim.new(0.275, 0),
		PaddingRight = UDim.new(0.01, 0),
		PaddingLeft = UDim.new(0.01, 0),
		PaddingTop = UDim.new(0.275, 0),
		Parent = KeybindBox,
	})

	function KeybindPicker:Update()
		KeybindBox.Text = string.format("[ %s ]", KeybindPicker.Value)
	end

	function KeybindPicker:SetValue(Data)
		local Key, Mode = Data[1], Data[2]
		KeybindBox.Text = Key
		KeybindPicker.Value = Key
		KeybindPicker:Update()

		if Function then
			Function(KeybindPicker.Value, KeybindPicker)
		end
	end

	function KeybindPicker:GetValue()
		return KeybindPicker.Value
	end

	local Picking = false
	KeybindBox.InputBegan:Connect(function(Input)
		if Input.UserInputType == Enum.UserInputType.MouseButton1 then
			KeybindBox.Text = "[ ... ]"
			Picking = true

			task.wait(0.2)

			local Event
			Event = game:GetService("UserInputService").InputBegan:Connect(function(Input)
				local Key

				if Input.UserInputType == Enum.UserInputType.Keyboard and Input.KeyCode == Enum.KeyCode.Escape then
					Picking = false
					TweenService:Create(KeybindBox, TweenInfo.new(0.15), { TextTransparency = 1 }):Play()
					KeybindBox.Text = "[ " .. KeybindPicker.Value .. " ]"
					delay(0.1, function()
						TweenService:Create(KeybindBox, TweenInfo.new(0.15), { TextTransparency = 0 }):Play()
					end)
					Event:Disconnect()
					return
				end

				if Input.UserInputType == Enum.UserInputType.Keyboard then
					Key = Input.KeyCode.Name
				elseif Input.UserInputType == Enum.UserInputType.MouseButton1 then
					Key = "MB1"
				elseif Input.UserInputType == Enum.UserInputType.MouseButton2 then
					Key = "MB2"
				elseif Input.UserInputType == Enum.UserInputType.MouseButton3 then
					Key = "MB3"
				end

				Picking = false

				TweenService:Create(KeybindBox, TweenInfo.new(0.25), { TextTransparency = 1 }):Play()
				KeybindBox.Text = "[ " .. Key .. " ]"
				delay(0.25, function()
					TweenService:Create(KeybindBox, TweenInfo.new(0.25), { TextTransparency = 0 }):Play()
				end)
				KeybindPicker.Value = Key
				if Function then
					Function(KeybindPicker.Value, KeybindPicker)
				end
				Event:Disconnect()
			end)
		end
	end)

	UserInputService.InputEnded:Connect(function(Input)
		if not Picking then
			KeybindPicker:Update()
		end
	end)

	KeybindPicker:Update()

	Library:AttachRowHover(KeybindFrame, KeybindFrameStroke)

	if self.UpdateLayout then
		self:UpdateLayout()
	end

	Library:RegisterAccentElement(KeybindUnderline)

	return KeybindPicker
end

function Functions:AddColorPicker(Name, Info, Function)
	local ColorPicker = {
		Value = Info.Default,
	}

	local Container = self.Container
	local ColorPickerShell, ColorPickerFrame, ColorPickerFrameStroke = Library:CreateRowShell(Container)

	local ColorPickerFrameUnderline = Library:Create("Frame", {
		BackgroundTransparency = 0.15,
		BorderSizePixel = 0,
		BackgroundColor3 = Theme.Accent,
		Size = UDim2.new(0, 3, 0, 46),
		Position = UDim2.fromOffset(0, 15),
		ZIndex = 1,
		Parent = ColorPickerFrame,
	})
	Library:RegisterThemeBinding(ColorPickerFrameUnderline, "BackgroundColor3", "Accent")

	local Option = Library:Create("TextLabel", {
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(0, 0.5),
		Size = UDim2.new(0, 220, 0, 24),
		Position = UDim2.new(0, 20, 0.5, 0),
		Text = Name or "Empty",
		TextColor3 = Theme.Text,
		TextSize = 18,
		TextXAlignment = Enum.TextXAlignment.Left,
		FontFace = Theme.Font,
		ZIndex = 1,
		Parent = ColorPickerFrame,
	})
	Library:RegisterThemeBinding(Option, "TextColor3", "Text")

	local OptionPadding = Library:Create("UIPadding", {
		PaddingBottom = UDim.new(0.25, 0),
		PaddingRight = UDim.new(0.01, 0),
		PaddingLeft = UDim.new(0.01, 0),
		PaddingTop = UDim.new(0.25, 0),
		Parent = Option,
	})

	local ValueBox = Library:Create("TextLabel", {
		BackgroundColor3 = Theme.Surface2,
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(1, 0.5),
		Size = UDim2.new(0, 96, 0, 24),
		Position = UDim2.new(1, -64, 0.5, 0),
		Text = "",
		TextColor3 = Theme.AccentSoft,
		TextSize = 15,
		TextXAlignment = Enum.TextXAlignment.Right,
		FontFace = Theme.FontBold,
		ZIndex = 1,
		Parent = ColorPickerFrame,
	})

	Library:Create("UICorner", {
		CornerRadius = UDim.new(0, 8),
		Parent = ValueBox,
	})

	Library:Create("UIStroke", {
		Color = Theme.Outline,
		Transparency = 0.58,
		Thickness = 1,
		Parent = ValueBox,
	})

	local ValuePadding = Library:Create("UIPadding", {
		PaddingBottom = UDim.new(0.3, 0),
		PaddingRight = UDim.new(0.01, 0),
		PaddingLeft = UDim.new(0.01, 0),
		PaddingTop = UDim.new(0.3, 0),
		Parent = ValueBox,
	})

	local ColorPickerButton = Library:Create("TextButton", {
		AnchorPoint = Vector2.new(1, 0.5),
		BackgroundColor3 = Theme.Accent,
		BorderSizePixel = 0,
		Position = UDim2.new(1, -20, 0.5, 0),
		Size = UDim2.fromOffset(30, 30),
		Text = "",
		Parent = ColorPickerFrame,
	})

	local ColorPickerButtonCorner = Library:Create("UICorner", {
		CornerRadius = UDim.new(1, 0),
		Parent = ColorPickerButton,
	})

	local ColorPickerBox = Library:Create("Frame", {
		Active = true,
		Name = "ColorBox",
		BackgroundColor3 = Theme.Surface1,
		BorderSizePixel = 0,
		LayoutOrder = 1,
		ZIndex = 2,
		Size = UDim2.new(0, 260, 0, 260),
		Visible = false,
		Parent = ScreenGui,
	})
	Library:RegisterThemeBinding(ColorPickerBox, "BackgroundColor3", "Surface1")

	local ColorPickerCorner = Library:Create("UICorner", {
		CornerRadius = UDim.new(0.025, 0),
		Parent = ColorPickerBox,
	})

	local ColorPickerStroke = Library:Create("UIStroke", {
		Color = Theme.Outline,
		Transparency = 0.48,
		Thickness = 1,
		Parent = ColorPickerBox,
	})
	Library:RegisterThemeBinding(ColorPickerStroke, "Color", "Outline")

	local Saturation = Library:Create("Frame", {
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BorderSizePixel = 0,
		Position = UDim2.new(0.5, 0, 0.5, 0),
		Size = UDim2.new(0.95, 0, 0.95, 0),
		ZIndex = 2,
		Parent = ColorPickerBox,
	})

	local SaturationMap = Library:Create("ImageLabel", {
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BorderSizePixel = 0,
		Size = UDim2.new(1, 0, 1, 0),
		Image = "rbxassetid://4155801252",
		Parent = Saturation,
	})

	local Hue = Library:Create("Frame", {
		BackgroundColor3 = Theme.Surface2,
		BorderSizePixel = 0,
		Position = UDim2.new(-0.15, 0, 0, 0),
		Size = UDim2.new(0, 33, 0, 260),
		ZIndex = 2,
		Parent = ColorPickerBox,
	})
	Library:RegisterThemeBinding(Hue, "BackgroundColor3", "Surface2")

	local HueCorner = Library:Create("UICorner", {
		CornerRadius = UDim.new(0.2, 0),
		Parent = Hue,
	})

	local HueMap = Library:Create("Frame", {
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BorderSizePixel = 0,
		Position = UDim2.new(0.5, 0, 0.5, 0),
		Size = UDim2.new(0.75, 0, 0.97, 0),
		Parent = Hue,
	})

	local HueMapCorner = Library:Create("UICorner", {
		CornerRadius = UDim.new(0.2, 0),
		Parent = HueMap,
	})

	local ColorPickerCorner = Library:Create("UIGradient", {
		Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 4)),
			ColorSequenceKeypoint.new(0.10, Color3.fromRGB(255, 153, 0)),
			ColorSequenceKeypoint.new(0.20, Color3.fromRGB(209, 255, 0)),
			ColorSequenceKeypoint.new(0.30, Color3.fromRGB(55, 255, 0)),
			ColorSequenceKeypoint.new(0.40, Color3.fromRGB(0, 255, 102)),
			ColorSequenceKeypoint.new(0.50, Color3.fromRGB(0, 255, 255)),
			ColorSequenceKeypoint.new(0.60, Color3.fromRGB(0, 102, 255)),
			ColorSequenceKeypoint.new(0.70, Color3.fromRGB(51, 0, 255)),
			ColorSequenceKeypoint.new(0.80, Color3.fromRGB(204, 0, 255)),
			ColorSequenceKeypoint.new(0.90, Color3.fromRGB(255, 0, 153)),
			ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 0, 4)),
		}),
		Rotation = 90,
		Parent = HueMap,
	})

	function ColorPicker:SetHSVFromRGB(Color)
		local H, S, V = Color:ToHSV()

		ColorPicker.Hue = H
		ColorPicker.Saturation = S
		ColorPicker.Vibrancy = V
	end

	ColorPicker:SetHSVFromRGB(ColorPicker.Value)

	function ColorPicker:Display()
		ColorPicker.Value = Color3.fromHSV(ColorPicker.Hue, ColorPicker.Saturation, ColorPicker.Vibrancy)
		SaturationMap.BackgroundColor3 = Color3.fromHSV(ColorPicker.Hue, 1, 1)

		ValueBox.Text = string.upper(ColorPicker.Value:ToHex())
		ValueBox.TextColor3 = ColorPicker.Value
		ColorPickerButton.BackgroundColor3 = ColorPicker.Value

		if Function then
			Function(ColorPicker.Value, ColorPicker)
		end
	end

	function ColorPicker:GetValue()
		return ColorPicker.Value
	end

	function ColorPicker:Show()
		for Frame, Val in next, Library.VisibleFrames do
			if Frame.Name == "ColorBox" then
				Frame.Visible = false
				Library.VisibleFrames[Frame] = nil
			end
		end

		local ViewportSize = ScreenGui.AbsoluteSize
		local BoxSize = ColorPickerBox.AbsoluteSize
		local Margin = 8
		local Left = math.clamp(Mouse.X + 60, Margin, math.max(Margin, ViewportSize.X - BoxSize.X - Margin))
		local Top = math.clamp(Mouse.Y - 30, Margin, math.max(Margin, ViewportSize.Y - BoxSize.Y - Margin))

		ColorPickerBox.Position = UDim2.fromOffset(Left, Top)
		ColorPickerBox.Visible = true
		Library.VisibleFrames[ColorPickerBox] = true
	end

	function ColorPicker:Hide()
		ColorPickerBox.Visible = false
		Library.VisibleFrames[ColorPickerBox] = nil
	end

	SaturationMap.InputBegan:Connect(function(Input)
		if Input.UserInputType == Enum.UserInputType.MouseButton1 then
			while UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) do
				local MinX = SaturationMap.AbsolutePosition.X
				local MaxX = MinX + SaturationMap.AbsoluteSize.X
				local MouseX = math.clamp(Mouse.X, MinX, MaxX)

				local MinY = SaturationMap.AbsolutePosition.Y
				local MaxY = MinY + SaturationMap.AbsoluteSize.Y
				local MouseY = math.clamp(Mouse.Y, MinY, MaxY)

				ColorPicker.Saturation = (MouseX - MinX) / (MaxX - MinX)
				ColorPicker.Vibrancy = 1 - ((MouseY - MinY) / (MaxY - MinY))
				ColorPicker:Display()

				RunService.Heartbeat:Wait()
			end
		end
	end)

	HueMap.InputBegan:Connect(function(Input)
		if Input.UserInputType == Enum.UserInputType.MouseButton1 then
			while UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) do
				local MinY = HueMap.AbsolutePosition.Y
				local MaxY = MinY + HueMap.AbsoluteSize.Y
				local MouseY = math.clamp(Mouse.Y, MinY, MaxY)

				ColorPicker.Hue = ((MouseY - MinY) / (MaxY - MinY))
				ColorPicker:Display()

				RenderStepped:Wait()
			end
		end
	end)

	ColorPickerButton.Activated:Connect(function()
		if ColorPickerBox.Visible then
			ColorPicker:Hide()
		else
			ColorPicker:Show()
		end
	end)

	UserInputService.InputBegan:Connect(function(Input)
		if Input.UserInputType == Enum.UserInputType.MouseButton1 then
			local AbsPos, AbsSize = ColorPickerBox.AbsolutePosition, ColorPickerBox.AbsoluteSize
			local ButtonPos, ButtonSize = ColorPickerButton.AbsolutePosition, ColorPickerButton.AbsoluteSize

			if
				Mouse.X < (AbsPos.X - 40)
				or Mouse.X > AbsPos.X + AbsSize.X
				or Mouse.Y < AbsPos.Y
				or Mouse.Y > AbsPos.Y + AbsSize.Y
			then
				if
					Mouse.X < ButtonPos.X
					or Mouse.X > ButtonPos.X + ButtonSize.X
					or Mouse.Y < ButtonPos.Y
					or Mouse.Y > ButtonPos.Y + ButtonSize.Y
				then
					ColorPicker:Hide()
				end
			end
		end
	end)

	ColorPicker:Display()

	Library:AttachRowHover(ColorPickerFrame, ColorPickerFrameStroke)

	if self.UpdateLayout then
		self:UpdateLayout()
	end

	Library:RegisterAccentElement(ColorPickerFrameUnderline)

	return ColorPicker
end

function Functions:AddSection(Name, Info)
	Info = Info or {}

	local Container = self.Container
	if self.SectionColumns and #self.SectionColumns > 0 then
		local LeftColumn = self.SectionColumns[1]
		local RightColumn = self.SectionColumns[2]
		local RequestedColumns = self.MaxColumns or self._ResolvedColumnCount or 2
		local UseTwoColumns = RequestedColumns > 1 and RightColumn ~= nil

		if UseTwoColumns then
			local LeftHeight = 0
			local RightHeight = 0
			local LeftLayout = LeftColumn:FindFirstChildOfClass("UIListLayout")
			local RightLayout = RightColumn:FindFirstChildOfClass("UIListLayout")

			if LeftLayout then
				LeftHeight = LeftLayout.AbsoluteContentSize.Y
			end
			if RightLayout then
				RightHeight = RightLayout.AbsoluteContentSize.Y
			end

			Container = (LeftHeight <= RightHeight) and LeftColumn or RightColumn
		else
			Container = LeftColumn
		end
	end

	local Mode = string.lower(Info.Mode or "list")
	local IsGrid = (Mode == "grid")
	local HeaderHeight = Info.HeaderHeight or 38
	local SectionPadding = Info.Padding or 12
	local CellWidth = Info.CellWidth or 220
	local CellHeight = Info.CellHeight or 77
	local CellPadding = Info.CellPadding or 10
	local MinSectionHeight = Info.SectionHeight or (HeaderHeight + (SectionPadding * 2) + CellHeight)

	local Section = {}
	local SectionLayout

	local SectionBackgroundColor = Info.BackgroundColor3 or Theme.Surface1
	local SectionStrokeColor = Info.StrokeColor or Theme.Outline

	local SectionFrame = Library:Create("Frame", {
		BackgroundColor3 = SectionBackgroundColor,
		BorderSizePixel = 0,
		Size = UDim2.fromOffset(CellWidth, MinSectionHeight),
		ClipsDescendants = false,
		LayoutOrder = Library:GetLayoutOrder(Container),
		Parent = Container,
	})
	if Info.BackgroundColor3 == nil then
		Library:RegisterThemeBinding(SectionFrame, "BackgroundColor3", "Surface1")
	end

	Library:Create("UICorner", {
		CornerRadius = UDim.new(0, 6),
		Parent = SectionFrame,
	})

	local SectionStroke = Library:Create("UIStroke", {
		Color = SectionStrokeColor,
		Thickness = 1,
		Transparency = 0.58,
		Parent = SectionFrame,
	})
	if Info.StrokeColor == nil then
		Library:RegisterThemeBinding(SectionStroke, "Color", "Outline")
	end

	local SectionTitle = Library:Create("TextLabel", {
		BackgroundTransparency = 1,
		Position = UDim2.fromOffset(SectionPadding, 0),
		Size = UDim2.new(1, -(SectionPadding * 2), 0, HeaderHeight),
		FontFace = Theme.FontSemibold,
		Text = Name or "Section",
		TextColor3 = Theme.Text,
		TextSize = 18,
		TextXAlignment = Enum.TextXAlignment.Left,
		Parent = SectionFrame,
	})
	Library:RegisterThemeBinding(SectionTitle, "TextColor3", "Text")

	local Divider = Library:Create("Frame", {
		BackgroundColor3 = Theme.Outline,
		BorderSizePixel = 0,
		Position = UDim2.fromOffset(SectionPadding, HeaderHeight),
		Size = UDim2.new(1, -(SectionPadding * 2), 0, 1),
		Parent = SectionFrame,
	})
	Library:RegisterThemeBinding(Divider, "BackgroundColor3", "Outline")

	local SectionContainer = Library:Create("Frame", {
		BackgroundTransparency = 1,
		Position = UDim2.fromOffset(SectionPadding, HeaderHeight + SectionPadding),
		Size = UDim2.new(1, -(SectionPadding * 2), 0, CellHeight),
		AutomaticSize = Enum.AutomaticSize.Y,
		ClipsDescendants = false,
		Parent = SectionFrame,
	})

	local SectionContentPadding = Library:Create("UIPadding", {
		PaddingTop = UDim.new(0, 4),
		PaddingBottom = UDim.new(0, 4),
		PaddingLeft = UDim.new(0, 4),
		PaddingRight = UDim.new(0, 4),
		Parent = SectionContainer,
	})

	if IsGrid then
		SectionLayout = Library:Create("UIGridLayout", {
			CellPadding = UDim2.fromOffset(CellPadding, CellPadding),
			CellSize = UDim2.fromOffset(CellWidth, CellHeight),
			FillDirection = Enum.FillDirection.Horizontal,
			FillDirectionMaxCells = Info.MaxCells or 0,
			HorizontalAlignment = Info.HorizontalAlignment or Enum.HorizontalAlignment.Left,
			SortOrder = Enum.SortOrder.LayoutOrder,
			StartCorner = Enum.StartCorner.TopLeft,
			VerticalAlignment = Enum.VerticalAlignment.Top,
			Parent = SectionContainer,
		})
	else
		SectionLayout = Library:Create("UIListLayout", {
			FillDirection = Enum.FillDirection.Vertical,
			SortOrder = Enum.SortOrder.LayoutOrder,
			HorizontalAlignment = Enum.HorizontalAlignment.Left,
			VerticalAlignment = Enum.VerticalAlignment.Top,
			Padding = UDim.new(0, Info.ItemSpacing or 8),
			Parent = SectionContainer,
		})
	end

	local function UpdateSectionSize()
		local ContentHeight = CellHeight
		local ContentInset = 8
		local ResolvedWidth = CellWidth

		if SectionLayout and SectionLayout.AbsoluteContentSize.Y > 0 then
			ContentHeight = SectionLayout.AbsoluteContentSize.Y
		end

		if Container and Container.AbsoluteSize.X > 0 then
			ResolvedWidth = Container.AbsoluteSize.X
		end

		local PreferredHeight =
			math.max(MinSectionHeight, HeaderHeight + (SectionPadding * 2) + ContentHeight + ContentInset + 1)

		SectionContainer.Size = UDim2.new(1, -(SectionPadding * 2), 0, ContentHeight + ContentInset)
		SectionFrame.Size = UDim2.fromOffset(ResolvedWidth, PreferredHeight)
		SectionFrame:SetAttribute("PreferredHeight", PreferredHeight)

		if self.UpdateLayout then
			self:UpdateLayout()
		end
	end

	SectionContainer.ChildAdded:Connect(UpdateSectionSize)
	SectionContainer.ChildRemoved:Connect(UpdateSectionSize)
	SectionLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(UpdateSectionSize)
	Container:GetPropertyChangedSignal("AbsoluteSize"):Connect(UpdateSectionSize)
	UpdateSectionSize()

	Section.Container = SectionContainer
	Section.Frame = SectionFrame
	Section.Mode = Mode
	Section.ParentUpdateLayout = self.UpdateLayout
	Section.UpdateLayout = function(CurrentSection)
		UpdateSectionSize()
		if CurrentSection.ParentUpdateLayout then
			CurrentSection.ParentUpdateLayout()
		end
	end
	setmetatable(Section, Functions)

	return Section
end

function Functions:AddGridSection(Name, Info)
	Info = Info or {}
	Info.Mode = "grid"
	return self:AddSection(Name, Info)
end

Functions.__index = Functions
Functions.__namecall = function(Table, Key, ...)
	return Functions[Key](...)
end

---------------------
-- [[   Window  ]] --
---------------------

function Library:CreateWindow(...)
	local Arguments = { ... }
	local Config = { AnchorPoint = Vector2.zero }

	if type(...) == "table" then
		Config = ...
	end

	if typeof(Config.Position) ~= "UDim2" then
		Config.Position = UDim2.fromOffset(350, 150)
	end
	if typeof(Config.MinSize) ~= "Vector2" then
		Config.MinSize = Vector2.new(680, 435)
	end
	if typeof(Config.Size) ~= "Vector2" then
		Config.Size = Vector2.new(1280, 760)
	end
	if typeof(Config.Font) ~= "EnumItem" then
		Config.FontFace = Enum.Font.GothamMedium
	end
	if type(Config.TabBarWidth) ~= "number" then
		Config.TabBarWidth = 109
	end
	if type(Config.HeaderHeight) ~= "number" then
		Config.HeaderHeight = 60
	end
	if type(Config.StatusBarHeight) ~= "number" then
		Config.StatusBarHeight = 34
	end
	if type(Config.EdgeInset) ~= "number" then
		Config.EdgeInset = 8
	end
	if type(Config.ContentPadding) ~= "number" then
		Config.ContentPadding = 16
	end
	if type(Config.SectionSpacing) ~= "number" then
		Config.SectionSpacing = 14
	end
	if type(Config.SectionHeight) ~= "number" then
		Config.SectionHeight = 280
	end

	if Config.Center then
		Config.AnchorPoint = Vector2.new(0.5, 0.5)
		Config.Position = UDim2.fromScale(0.5, 0.5)
	end

	local ThemeOverrides = {}
	local SavedThemePreset = LoadSavedThemePreset()
	local SelectedThemePreset = Config.ThemePreset or SavedThemePreset

	if ThemePresets[SelectedThemePreset] then
		for Key, Value in next, ThemePresets[SelectedThemePreset] do
			ThemeOverrides[Key] = Value
		end
	end

	if type(Config.Theme) == "table" then
		for Key, Value in next, Config.Theme do
			ThemeOverrides[Key] = Value
		end
	end

	if typeof(Config.AccentColor) == "Color3" then
		ThemeOverrides.Accent = Config.AccentColor
	end
	if typeof(Config.CheckmarkColor) == "Color3" then
		ThemeOverrides.Checkmark = Config.CheckmarkColor
	end
	if typeof(Config.TextColor) == "Color3" then
		ThemeOverrides.Text = Config.TextColor
	end
	if typeof(Config.TextMutedColor) == "Color3" then
		ThemeOverrides.TextMuted = Config.TextMutedColor
	end
	if typeof(Config.Surface0Color) == "Color3" then
		ThemeOverrides.Surface0 = Config.Surface0Color
	end
	if typeof(Config.Surface1Color) == "Color3" then
		ThemeOverrides.Surface1 = Config.Surface1Color
	end
	if typeof(Config.Surface2Color) == "Color3" then
		ThemeOverrides.Surface2 = Config.Surface2Color
	end
	if typeof(Config.Surface3Color) == "Color3" then
		ThemeOverrides.Surface3 = Config.Surface3Color
	end
	if typeof(Config.TabBarColor) == "Color3" then
		ThemeOverrides.TabBar = Config.TabBarColor
	end
	if typeof(Config.OutlineColor) == "Color3" then
		ThemeOverrides.Outline = Config.OutlineColor
	end
	if typeof(Config.BorderColor) == "Color3" then
		ThemeOverrides.BorderColor = Config.BorderColor
	end
	if typeof(Config.Font) == "EnumItem" then
		ThemeOverrides.Font = Config.Font
	end
	if typeof(Config.BoldFont) == "EnumItem" then
		ThemeOverrides.FontBold = Config.BoldFont
	end
	if typeof(Config.SemiboldFont) == "EnumItem" then
		ThemeOverrides.FontSemibold = Config.SemiboldFont
	end

	Library:ApplyTheme(ThemeOverrides)

	local Window = {
		Tabs = {},
		CurrentTab = nil,
		ColorUpdateFunctions = {},
		_WindowFrame = nil,
		_Header = nil,
		_HeaderDivider = nil,
		_ContainerBox = nil,
		_TabTitle = nil,
		_Separator = nil,
		_Toggle = nil,
		_ToggleIcon = nil,
		_TabsList = nil,
		_StatusBar = nil,
		_StatusResetLabel = nil,
		_StatusUptimeLabel = nil,
		_StatusSessionLabel = nil,
		_StatusDivider = nil,
		_StatusAccent = nil,
		_ThemeButton = nil,
		_ThemePopup = nil,
	}

	local ToggleSize = math.max(28, Config.HeaderHeight - 20)

	local WindowFrame = Library:Create("Frame", {
		AnchorPoint = Config.AnchorPoint,
		BackgroundColor3 = Theme.Surface0,
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Position = Config.Position,
		Size = UDim2.fromOffset(Config.Size.X, Config.Size.Y),
		Visible = true,
		ClipsDescendants = false,
		ZIndex = 1,
		Parent = ScreenGui,
	})

	Window._WindowFrame = WindowFrame

	local WindowScale = Library:Create("UIScale", {
		Scale = 1,
		Parent = WindowFrame,
	})

	local WindowCanvas = Library:Create("Frame", {
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Size = UDim2.fromScale(1, 1),
		Parent = WindowFrame,
	})

	Library:Create("UICorner", {
		CornerRadius = UDim.new(0, 8),
		Parent = WindowFrame,
	})

	local WindowStroke = Library:Create("UIStroke", {
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
		LineJoinMode = Enum.LineJoinMode.Miter,
		Color = ThemeOverrides.BorderColor or Theme.Outline,
		Transparency = 0.34,
		Thickness = 1,
		Parent = WindowFrame,
	})
	Library:RegisterThemeBinding(WindowStroke, "Color", "Outline")

	-- Tabs --

	local TabsList = Library:Create("ScrollingFrame", {
		BackgroundColor3 = Theme.TabBar,
		BorderSizePixel = 0,
		Position = UDim2.new(0, 0, 0, 0),
		Size = UDim2.new(0, Config.TabBarWidth, 1, 0),
		Visible = true,
		ClipsDescendants = true,
		ZIndex = 1,
		ScrollBarThickness = 0,
		ScrollBarImageTransparency = 1,
		CanvasSize = UDim2.new(0, 0, 0, 0),
		Parent = WindowCanvas,
	})

	Window._TabsList = TabsList

	local TabsListStroke = Library:Create("UIStroke", {
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
		Color = Theme.Outline,
		Transparency = 0.72,
		Thickness = 1,
		Parent = TabsList,
	})
	Library:RegisterThemeBinding(TabsListStroke, "Color", "Outline")

	local TabsRightDivider = Library:Create("Frame", {
		AnchorPoint = Vector2.new(1, 0),
		BackgroundColor3 = Theme.Outline,
		BackgroundTransparency = 0.58,
		BorderSizePixel = 0,
		Position = UDim2.new(1, 0, 0, 0),
		Size = UDim2.new(0, 1, 1, 0),
		ZIndex = 2,
		Parent = TabsList,
	})
	Library:RegisterThemeBinding(TabsRightDivider, "BackgroundColor3", "Outline")

	local TabsTopPadding = 8
	local TabsSidePadding = 6
	local TabsSpacing = 10

	-- Header --

	local Header = Library:Create("Frame", {
		BorderSizePixel = 0,
		Position = UDim2.new(0, Config.TabBarWidth, 0, 0),
		Size = UDim2.new(1, -Config.TabBarWidth, 0, Config.HeaderHeight),
		Visible = true,
		BackgroundTransparency = 0,
		BackgroundColor3 = Theme.Surface1,
		ClipsDescendants = false,
		ZIndex = 1,
		Parent = WindowCanvas,
	})

	Window._Header = Header

	local HeaderDivider = Library:Create("Frame", {
		BackgroundColor3 = Theme.Outline,
		BorderSizePixel = 0,
		Position = UDim2.new(0, 0, 1, -1),
		Size = UDim2.new(1, 0, 0, 1),
		ZIndex = 2,
		Parent = Header,
	})

	Window._HeaderDivider = HeaderDivider

	local ToggleInset = 6 + Config.EdgeInset
	local HeaderButtonSize = math.max(30, ToggleSize - 2)
	local ThemeButtonGap = 16
	local SeparatorPadding = 8
	local SeparatorGap = ToggleInset + HeaderButtonSize + SeparatorPadding

	local Separator = Library:Create("Frame", {
		BackgroundColor3 = Theme.Outline,
		AnchorPoint = Vector2.new(1, 0.5),
		Position = UDim2.new(1, -SeparatorGap, 0.5, 0),
		Size = UDim2.new(0, 3, 0, 30),
		Visible = true,
		BackgroundTransparency = 0,
		BorderSizePixel = 0,
		ClipsDescendants = false,
		ZIndex = 1,
		Parent = Header,
	})

	Window._Separator = Separator

	local Toggle = Library:Create("ImageButton", {
		BackgroundColor3 = Theme.Accent,
		AnchorPoint = Vector2.new(1, 0.5),
		Position = UDim2.new(1, -ToggleInset, 0.5, 0),
		Size = UDim2.fromOffset(HeaderButtonSize, HeaderButtonSize),
		Visible = true,
		BackgroundTransparency = 1,
		AutoButtonColor = false,
		ImageTransparency = 1,
		BorderSizePixel = 0,
		ClipsDescendants = false,
		ZIndex = 1,
		Parent = Header,
	})

	Window._Toggle = Toggle

	local ThemeButton = Library:Create("ImageButton", {
		BackgroundColor3 = Theme.Accent,
		AnchorPoint = Vector2.new(1, 0.5),
		Position = UDim2.new(1, -(ToggleInset + HeaderButtonSize + ThemeButtonGap), 0.5, 0),
		Size = UDim2.fromOffset(HeaderButtonSize, HeaderButtonSize),
		Visible = true,
		BackgroundTransparency = 1,
		AutoButtonColor = false,
		ImageTransparency = 1,
		BorderSizePixel = 0,
		ClipsDescendants = false,
		ZIndex = 1,
		Parent = Header,
	})
	Window._ThemeButton = ThemeButton
	Library:RegisterThemeBinding(ThemeButton, "BackgroundColor3", "Accent")

	local ThemeButtonIcon = Library:Create("ImageLabel", {
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.new(0.5, 0, 0.5, 0),
		Size = UDim2.fromOffset(18, 18),
		Visible = true,
		BackgroundTransparency = 1,
		Image = "rbxassetid://7734053495",
		ImageColor3 = Theme.TextMuted,
		ScaleType = Enum.ScaleType.Fit,
		ClipsDescendants = false,
		ZIndex = 2,
		BorderSizePixel = 0,
		Parent = ThemeButton,
	})
	Library:RegisterThemeBinding(ThemeButtonIcon, "ImageColor3", "TextMuted")

	Library:Create("UICorner", {
		CornerRadius = UDim.new(0.15, 0),
		Parent = ThemeButton,
	})

	local ThemePopup = Library:Create("Frame", {
		Name = "ThemePopup",
		BackgroundColor3 = Theme.Surface1,
		BorderSizePixel = 0,
		Size = UDim2.fromOffset(210, 232),
		Visible = false,
		ZIndex = 20,
		Parent = ScreenGui,
	})
	Window._ThemePopup = ThemePopup
	Library:RegisterThemeBinding(ThemePopup, "BackgroundColor3", "Surface1")

	Library:Create("UICorner", {
		CornerRadius = UDim.new(0, 10),
		Parent = ThemePopup,
	})

	local ThemePopupStroke = Library:Create("UIStroke", {
		Color = Theme.Outline,
		Transparency = 0.4,
		Thickness = 1,
		Parent = ThemePopup,
	})
	Library:RegisterThemeBinding(ThemePopupStroke, "Color", "Outline")

	local ThemePopupTitle = Library:Create("TextLabel", {
		BackgroundTransparency = 1,
		Position = UDim2.fromOffset(14, 8),
		Size = UDim2.new(1, -28, 0, 24),
		FontFace = Theme.FontSemibold,
		Text = "Themes",
		TextColor3 = Theme.Text,
		TextSize = 18,
		TextXAlignment = Enum.TextXAlignment.Left,
		ZIndex = 21,
		Parent = ThemePopup,
	})
	Library:RegisterThemeBinding(ThemePopupTitle, "TextColor3", "Text")

	local ThemePopupDivider = Library:Create("Frame", {
		BackgroundColor3 = Theme.Outline,
		BackgroundTransparency = 0.5,
		BorderSizePixel = 0,
		Position = UDim2.fromOffset(14, 34),
		Size = UDim2.new(1, -28, 0, 1),
		ZIndex = 21,
		Parent = ThemePopup,
	})
	Library:RegisterThemeBinding(ThemePopupDivider, "BackgroundColor3", "Outline")

	local ThemeList = Library:Create("ScrollingFrame", {
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Position = UDim2.fromOffset(10, 42),
		Size = UDim2.new(1, -20, 1, -52),
		CanvasSize = UDim2.new(0, 0, 0, 0),
		ScrollBarThickness = 0,
		AutomaticCanvasSize = Enum.AutomaticSize.Y,
		ZIndex = 21,
		Parent = ThemePopup,
	})

	local ThemeListLayout = Library:Create("UIListLayout", {
		FillDirection = Enum.FillDirection.Vertical,
		SortOrder = Enum.SortOrder.LayoutOrder,
		Padding = UDim.new(0, 6),
		Parent = ThemeList,
	})

	local ToggleIcon = Library:Create("ImageLabel", {
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.new(0.5, 0, 0.5, 0),
		Size = UDim2.fromOffset(18, 18),
		Visible = true,
		BackgroundTransparency = 1,
		Image = "rbxassetid://4773247381",
		ImageColor3 = Theme.TextMuted,
		ScaleType = Enum.ScaleType.Fit,
		ClipsDescendants = false,
		ZIndex = 1,
		BorderSizePixel = 0,
		Parent = Toggle,
	})

	Window._ToggleIcon = ToggleIcon

	local ToggleCorner = Library:Create("UICorner", {
		CornerRadius = UDim.new(0.15, 0),
		Parent = Toggle,
	})

	local TabTitle = Library:Create("TextLabel", {
		AnchorPoint = Vector2.new(0, 0.5),
		Position = UDim2.new(0, 18 + Config.EdgeInset, 0.5, 0),
		Size = UDim2.new(1, -(96 + (Config.EdgeInset * 2)), 1, 0),
		Visible = true,
		FontFace = Theme.Font,
		Text = "",
		TextColor3 = Theme.Text,
		TextSize = 26,
		BackgroundTransparency = 1,
		ClipsDescendants = false,
		ZIndex = 1,
		TextXAlignment = Enum.TextXAlignment.Left,
		BorderSizePixel = 0,
		Parent = Header,
	})

	Window._TabTitle = TabTitle

	local TitlePadding = Library:Create("UIPadding", {
		PaddingBottom = UDim.new(0, 6),
		PaddingTop = UDim.new(0, 8),
		PaddingLeft = UDim.new(0, 0),
		PaddingRight = UDim.new(0, 12),
		Parent = TabTitle,
	})

	-- ContainerBox --

	local ContainerBox = Library:Create("Frame", {
		BorderSizePixel = 0,
		Position = UDim2.new(0, Config.TabBarWidth, 0, Config.HeaderHeight),
		Size = UDim2.new(1, -Config.TabBarWidth, 1, -(Config.HeaderHeight + Config.StatusBarHeight)),
		Visible = true,
		BackgroundColor3 = Theme.Surface0,
		BackgroundTransparency = 0,
		ClipsDescendants = true,
		ZIndex = 1,
		Parent = WindowCanvas,
	})

	Window._ContainerBox = ContainerBox

	local StatusBar = Library:Create("Frame", {
		BackgroundColor3 = Theme.Surface1,
		BorderSizePixel = 0,
		Position = UDim2.new(0, Config.TabBarWidth, 1, -Config.StatusBarHeight),
		Size = UDim2.new(1, -Config.TabBarWidth, 0, Config.StatusBarHeight),
		ZIndex = 1,
		Parent = WindowCanvas,
	})
	Window._StatusBar = StatusBar

	local StatusBarDivider = Library:Create("Frame", {
		BackgroundColor3 = Theme.Outline,
		BorderSizePixel = 0,
		Position = UDim2.new(0, 0, 0, 0),
		Size = UDim2.new(1, 0, 0, 1),
		ZIndex = 2,
		Parent = StatusBar,
	})
	Window._StatusDivider = StatusBarDivider

	local StatusAccent = Library:Create("Frame", {
		AnchorPoint = Vector2.new(0, 0.5),
		BackgroundColor3 = Theme.Accent,
		BorderSizePixel = 0,
		Position = UDim2.new(0, 12, 0.5, 0),
		Size = UDim2.new(0, 4, 1, -16),
		ZIndex = 2,
		Parent = StatusBar,
	})
	Window._StatusAccent = StatusAccent

	Library:Create("UICorner", {
		CornerRadius = UDim.new(1, 0),
		Parent = StatusAccent,
	})

	local StatusResetLabel = Library:Create("TextLabel", {
		BackgroundTransparency = 1,
		Position = UDim2.new(0, 24, 0, 0),
		Size = UDim2.new(0.42, -24, 1, 0),
		FontFace = Theme.Font,
		Text = "Daily Reset: --",
		TextColor3 = Theme.Text,
		TextSize = 18,
		TextXAlignment = Enum.TextXAlignment.Left,
		ZIndex = 2,
		Parent = StatusBar,
	})
	Window._StatusResetLabel = StatusResetLabel
	Library:RegisterThemeBinding(StatusResetLabel, "TextColor3", "Text")

	local StatusSessionLabel = Library:Create("TextLabel", {
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.new(0.5, 0, 0.5, 0),
		Size = UDim2.new(0.28, 0, 1, 0),
		FontFace = Theme.Font,
		Text = "Lives: 0 | Shinies: 0",
		TextColor3 = Theme.TextMuted,
		TextSize = 16,
		TextXAlignment = Enum.TextXAlignment.Center,
		ZIndex = 2,
		Parent = StatusBar,
	})
	Window._StatusSessionLabel = StatusSessionLabel
	Library:RegisterThemeBinding(StatusSessionLabel, "TextColor3", "TextMuted")

	local StatusUptimeLabel = Library:Create("TextLabel", {
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(1, 0.5),
		Position = UDim2.new(1, -16, 0.5, 0),
		Size = UDim2.new(0.22, 0, 1, 0),
		FontFace = Theme.FontBold,
		Text = "0:00:00",
		TextColor3 = Theme.Text,
		TextSize = 18,
		TextXAlignment = Enum.TextXAlignment.Right,
		ZIndex = 2,
		Parent = StatusBar,
	})
	Window._StatusUptimeLabel = StatusUptimeLabel
	Library:RegisterThemeBinding(StatusUptimeLabel, "TextColor3", "Text")

	local ContainerBoxLayout = Library:Create("UIPageLayout", {
		EasingDirection = Enum.EasingDirection.Out,
		EasingStyle = Enum.EasingStyle.Exponential,
		TweenTime = 0.5,
		FillDirection = Enum.FillDirection.Vertical,
		SortOrder = Enum.SortOrder.LayoutOrder,
		HorizontalAlignment = Enum.HorizontalAlignment.Left,
		VerticalAlignment = Enum.VerticalAlignment.Top,
		ScrollWheelInputEnabled = false,
		TouchInputEnabled = false,
		GamepadInputEnabled = false,
		Parent = ContainerBox,
	})

	local function GetTabButtonLayout(Index, Height)
		local Width = math.max(0, TabsList.AbsoluteSize.X - (TabsSidePadding * 2))
		local Top = TabsTopPadding + ((Index - 1) * (Height + TabsSpacing))
		local CenterX = TabsSidePadding + (Width / 2)
		local CenterY = Top + (Height / 2)

		return UDim2.fromOffset(CenterX, CenterY), UDim2.new(1, -(TabsSidePadding * 2), 0, Height)
	end

	local function UpdateTabsCanvas(TabCount)
		local Width = math.max(0, TabsList.AbsoluteSize.X - (TabsSidePadding * 2))
		local Height = TabsTopPadding + (TabCount * 68) + (math.max(0, TabCount - 1) * TabsSpacing) + TabsTopPadding
		TabsList.CanvasSize = UDim2.new(0, Width, 0, Height)
	end

	local function RunColorUpdates()
		for _, UpdateFunc in ipairs(Window.ColorUpdateFunctions) do
			UpdateFunc()
		end
	end

	local ThemeOptionButtons = {}

	local function RefreshThemeButtons()
		for PresetName, Button in next, ThemeOptionButtons do
			if Button and Button.Parent then
				local IsActive = PresetName == SelectedThemePreset
				Button.BackgroundTransparency = IsActive and 0 or 1
			end
		end
	end

	local function ApplyThemePreset(PresetName)
		local Preset = ThemePresets[PresetName]
		if not Preset then
			return
		end

		SelectedThemePreset = PresetName
		Library:ApplyTheme(CopyThemeDefinition(Preset))
		RunColorUpdates()
		RefreshThemeButtons()
		SaveThemePreset(PresetName)
	end

	local function PositionThemePopup()
		ThemePopup.Position = UDim2.fromOffset(
			ThemeButton.AbsolutePosition.X - ThemePopup.AbsoluteSize.X + ThemeButton.AbsoluteSize.X,
			ThemeButton.AbsolutePosition.Y + ThemeButton.AbsoluteSize.Y + 8
		)
	end

	local function OpenThemePopup()
		PositionThemePopup()
		ThemePopup.Visible = true
		Library.VisibleFrames[ThemePopup] = true
	end

	local function CloseThemePopup()
		ThemePopup.Visible = false
		Library.VisibleFrames[ThemePopup] = nil
	end

	for PresetName, _ in next, ThemePresets do
		local ThemeOptionButton = Library:Create("TextButton", {
			BackgroundColor3 = Theme.Surface2,
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Size = UDim2.new(1, 0, 0, 34),
			Text = PresetName,
			TextColor3 = Theme.Text,
			TextSize = 16,
			FontFace = Theme.Font,
			ZIndex = 22,
			Parent = ThemeList,
		})
		Library:RegisterThemeBinding(ThemeOptionButton, "BackgroundColor3", "Surface2")
		Library:RegisterThemeBinding(ThemeOptionButton, "TextColor3", "Text")

		Library:Create("UICorner", {
			CornerRadius = UDim.new(0, 8),
			Parent = ThemeOptionButton,
		})

		local ThemeOptionStroke = Library:Create("UIStroke", {
			Color = Theme.Outline,
			Transparency = 0.58,
			Thickness = 1,
			Parent = ThemeOptionButton,
		})
		Library:RegisterThemeBinding(ThemeOptionStroke, "Color", "Outline")

		ThemeOptionButton.MouseEnter:Connect(function()
			if PresetName ~= SelectedThemePreset then
				TweenService:Create(ThemeOptionButton, TweenInfo.new(0.15), { BackgroundTransparency = 0.25 }):Play()
			end
		end)

		ThemeOptionButton.MouseLeave:Connect(function()
			if PresetName ~= SelectedThemePreset then
				TweenService:Create(ThemeOptionButton, TweenInfo.new(0.15), { BackgroundTransparency = 1 }):Play()
			end
		end)

		ThemeOptionButton.Activated:Connect(function()
			ApplyThemePreset(PresetName)
			CloseThemePopup()
		end)

		ThemeOptionButtons[PresetName] = ThemeOptionButton
	end

	local function RegisterTabColorUpdate(Tab)
		table.insert(Window.ColorUpdateFunctions, function()
			if Tab.Button then
				Tab.Button.BackgroundColor3 = Theme.Surface2
			end
			if Tab.RefreshTheme then
				Tab.RefreshTheme()
			end
		end)
	end

	-- Functions --

	Window.SetStatusLeft = function(_, Text)
		if Window._StatusResetLabel then
			Window._StatusResetLabel.Text = tostring(Text or "")
		end
	end

	Window.SetStatusCenter = function(_, Text)
		if Window._StatusSessionLabel then
			Window._StatusSessionLabel.Text = tostring(Text or "")
		end
	end

	Window.SetStatusRight = function(_, Text)
		if Window._StatusUptimeLabel then
			Window._StatusUptimeLabel.Text = tostring(Text or "")
		end
	end

	Window.SetStatus = function(_, LeftText, CenterText, RightText)
		Window:SetStatusLeft(LeftText)
		Window:SetStatusCenter(CenterText)
		Window:SetStatusRight(RightText)
	end

	function Window:AddTab(NewTabName, NewTabIcon, OrderNumber)
		if not NewTabName or not NewTabIcon then
			return
		end
		local Tab = {
			OrderNumber = 0,
			Position = 0,
			BaseTabHeight = 68,
			HoverTabHeight = 74,
			DefaultPosition = nil,
			DefaultSize = nil,
			MaxColumns = nil,
		}
		local IsSelected = false
		local IsHovered = false
		local BaseTabHeight = 68
		local HoverTabHeight = 74
		local TabIndex = #Window.Tabs + 1
		local InitialPosition, InitialSize = GetTabButtonLayout(TabIndex, BaseTabHeight)
		local ResolvedOrderNumber = OrderNumber or TabIndex

		-- Tab Button --
		local TabButton = Library:Create("Frame", {
			AnchorPoint = Vector2.new(0.5, 0.5),
			BackgroundColor3 = Theme.Surface2,
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Position = InitialPosition,
			Size = InitialSize,
			LayoutOrder = ResolvedOrderNumber,
			Parent = TabsList,
		})

		local TabButtonCorner = Library:Create("UICorner", {
			CornerRadius = UDim.new(0.075, 0),
			Parent = TabButton,
		})

		local TabAccent = Library:Create("Frame", {
			BackgroundColor3 = Theme.Accent,
			BorderSizePixel = 0,
			Size = UDim2.new(0, 3, 0, 0),
			AnchorPoint = Vector2.new(0, 0.5),
			Position = UDim2.new(0, 0, 0.5, 0),
			Parent = TabButton,
		})
		Library:RegisterThemeBinding(TabAccent, "BackgroundColor3", "Accent")

		Library:Create("UICorner", {
			CornerRadius = UDim.new(1, 0),
			Parent = TabAccent,
		})

		local TabButtonIcon = Library:Create("ImageLabel", {
			AnchorPoint = Vector2.new(0.5, 0.5),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Position = UDim2.new(0.5, 0, 0.5, 0),
			Size = UDim2.new(0, 34, 0, 34),
			Image = NewTabIcon,
			ImageColor3 = Theme.TextMuted,
			Parent = TabButton,
		})

		local function RefreshTabIconColor(Instant)
			local TargetColor = (IsSelected or IsHovered) and Theme.Text or Theme.TextMuted
			if Instant then
				TabButtonIcon.ImageColor3 = TargetColor
			else
				TweenService:Create(TabButtonIcon, TweenInfo.new(0.2), { ImageColor3 = TargetColor }):Play()
			end
		end

		-- Container --

		local Container = Library:Create("ScrollingFrame", {
			BackgroundTransparency = 1,
			LayoutOrder = ResolvedOrderNumber,
			BorderSizePixel = 0,
			Position = UDim2.new(0, 0, 0, 0),
			Size = UDim2.new(1, 0, 1, 0),
			ClipsDescendants = true,
			AutomaticCanvasSize = Enum.AutomaticSize.Y,
			CanvasSize = UDim2.new(0, 0, 0, 0),
			ScrollBarThickness = 8,
			ScrollBarImageColor3 = Color3.fromRGB(68, 68, 68),
			Parent = ContainerBox,
		})

		local LeftColumn = Library:Create("Frame", {
			Name = "LeftColumn",
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Position = UDim2.new(0, Config.ContentPadding, 0, Config.ContentPadding),
			Size = UDim2.new(0, 240, 0, 0),
			AutomaticSize = Enum.AutomaticSize.Y,
			Parent = Container,
		})

		local LeftColumnLayout = Library:Create("UIListLayout", {
			FillDirection = Enum.FillDirection.Vertical,
			SortOrder = Enum.SortOrder.LayoutOrder,
			HorizontalAlignment = Enum.HorizontalAlignment.Left,
			VerticalAlignment = Enum.VerticalAlignment.Top,
			Padding = UDim.new(0, Config.SectionSpacing),
			Parent = LeftColumn,
		})

		local RightColumn = Library:Create("Frame", {
			Name = "RightColumn",
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Position = UDim2.new(0, Config.ContentPadding, 0, Config.ContentPadding),
			Size = UDim2.new(0, 240, 0, 0),
			AutomaticSize = Enum.AutomaticSize.Y,
			Parent = Container,
		})

		local RightColumnLayout = Library:Create("UIListLayout", {
			FillDirection = Enum.FillDirection.Vertical,
			SortOrder = Enum.SortOrder.LayoutOrder,
			HorizontalAlignment = Enum.HorizontalAlignment.Left,
			VerticalAlignment = Enum.VerticalAlignment.Top,
			Padding = UDim.new(0, Config.SectionSpacing),
			Parent = RightColumn,
		})

		-- Functions --

		function Tab:Show(Instant)
			for _, ExistingTab in next, Window.Tabs do
				if ExistingTab ~= Tab then
					ExistingTab:Hide()
				end
			end

			IsSelected = true
			IsHovered = false
			Window.CurrentTab = Tab
			TabTitle.Text = NewTabName

			ContainerBoxLayout:JumpTo(Container)
			if Instant then
				TabButton.Position = Tab.DefaultPosition or InitialPosition
				TabButton.Size = Tab.DefaultSize or InitialSize
				TabButton.BackgroundTransparency = 0
				TabAccent.Size = UDim2.new(0, 3, 0, 56)
				RefreshTabIconColor(true)
			else
				TweenService:Create(
					TabButton,
					TweenInfo.new(0.2),
					{ Position = Tab.DefaultPosition or InitialPosition, Size = Tab.DefaultSize or InitialSize }
				):Play()
				TweenService:Create(TabButton, TweenInfo.new(0.2), { BackgroundTransparency = 0 }):Play()
				TweenService:Create(TabAccent, TweenInfo.new(0.2), { Size = UDim2.new(0, 3, 0, 56) }):Play()
				RefreshTabIconColor(false)
			end
		end

		function Tab:Hide()
			IsSelected = false
			IsHovered = false
			TweenService:Create(
				TabButton,
				TweenInfo.new(0.2),
				{ Position = Tab.DefaultPosition or InitialPosition, Size = Tab.DefaultSize or InitialSize }
			):Play()
			TweenService:Create(TabButton, TweenInfo.new(0.2), { BackgroundTransparency = 1 }):Play()
			TweenService:Create(TabAccent, TweenInfo.new(0.2), { Size = UDim2.new(0, 3, 0, 0) }):Play()
			RefreshTabIconColor(false)
		end

		TabButton.MouseEnter:Connect(function()
			if IsSelected then
				return
			end

			IsHovered = true
			TweenService:Create(TabButton, TweenInfo.new(0.16, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
				Position = Tab.DefaultPosition or InitialPosition,
				Size = UDim2.new(1, -(math.max(0, TabsSidePadding - 2) * 2), 0, HoverTabHeight),
				BackgroundTransparency = 0.35,
			}):Play()
			TweenService:Create(TabButtonIcon, TweenInfo.new(0.16, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
				ImageColor3 = Theme.Text,
			}):Play()
		end)

		TabButton.MouseLeave:Connect(function()
			if IsSelected then
				return
			end

			IsHovered = false
			TweenService:Create(TabButton, TweenInfo.new(0.16, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
				Position = Tab.DefaultPosition or InitialPosition,
				Size = Tab.DefaultSize or InitialSize,
				BackgroundTransparency = 1,
			}):Play()
			RefreshTabIconColor(false)
		end)

		TabButton.InputBegan:Connect(function(Input)
			if Input.UserInputType == Enum.UserInputType.MouseButton1 and not Library:MouseIsOverVisibleFrames() then
				Tab:Show()
			end
		end)

		local function UpdateGrid()
			local AvailableWidth = math.max(0, Container.AbsoluteSize.X - (Config.ContentPadding * 2))
			local MaxColumns = Tab.MaxColumns or 2
			local Columns = math.min(MaxColumns, (AvailableWidth >= 760) and 2 or 1)
			local CellWidth = AvailableWidth

			if Columns > 1 then
				CellWidth = math.floor((AvailableWidth - (Config.SectionSpacing * (Columns - 1))) / Columns)
			end

			Tab._ResolvedColumnCount = Columns

			LeftColumn.Size = UDim2.fromOffset(CellWidth, 0)
			RightColumn.Size = UDim2.fromOffset(CellWidth, 0)

			if Columns > 1 then
				LeftColumn.Position = UDim2.fromOffset(Config.ContentPadding, Config.ContentPadding)
				RightColumn.Visible = true
				RightColumn.Position =
					UDim2.fromOffset(Config.ContentPadding + CellWidth + Config.SectionSpacing, Config.ContentPadding)

				Container.CanvasSize = UDim2.new(
					0,
					0,
					0,
					math.max(LeftColumnLayout.AbsoluteContentSize.Y, RightColumnLayout.AbsoluteContentSize.Y)
						+ (Config.ContentPadding * 2)
				)
			else
				LeftColumn.Position = UDim2.fromOffset(Config.ContentPadding, Config.ContentPadding)
				RightColumn.Visible = true
				RightColumn.Position = UDim2.fromOffset(
					Config.ContentPadding,
					Config.ContentPadding + LeftColumnLayout.AbsoluteContentSize.Y + Config.SectionSpacing
				)

				local TotalHeight = LeftColumnLayout.AbsoluteContentSize.Y
				if RightColumnLayout.AbsoluteContentSize.Y > 0 then
					TotalHeight += Config.SectionSpacing + RightColumnLayout.AbsoluteContentSize.Y
				end

				Container.CanvasSize = UDim2.new(0, 0, 0, TotalHeight + (Config.ContentPadding * 2))
			end
		end

		Container.ChildAdded:Connect(UpdateGrid)
		Container.ChildRemoved:Connect(UpdateGrid)
		Container:GetPropertyChangedSignal("AbsoluteSize"):Connect(UpdateGrid)
		LeftColumnLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(UpdateGrid)
		RightColumnLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(UpdateGrid)
		UpdateGrid()

		Tab.UpdateLayout = UpdateGrid

		TabsList.CanvasSize = UDim2.new(
			0,
			math.max(0, TabsList.AbsoluteSize.X - (TabsSidePadding * 2)),
			0,
			TabsTopPadding + (TabIndex * BaseTabHeight) + ((TabIndex - 1) * TabsSpacing) + TabsTopPadding
		)

		Tab.Position = TabIndex
		Tab.OrderNumber = ResolvedOrderNumber
		Tab.Button = TabButton
		Tab.BaseTabHeight = BaseTabHeight
		Tab.HoverTabHeight = HoverTabHeight
		Tab.DefaultPosition = InitialPosition
		Tab.DefaultSize = InitialSize
		Tab.Container = Container
		Tab.SectionColumns = { LeftColumn, RightColumn }
		Tab._ResolvedColumnCount = Tab.MaxColumns or 2
		Tab.RefreshTheme = function()
			RefreshTabIconColor(true)
		end
		Window.Tabs[#Window.Tabs + 1] = Tab
		RegisterTabColorUpdate(Tab)
		UpdateTabsCanvas(#Window.Tabs)

		if not Window.CurrentTab then
			Tab:Show(true)
		end

		setmetatable(Tab, Functions)
		return Tab
	end

	-- Register theme update functions for all window elements
	local function UpdateColors()
		if Window._WindowFrame then
			Window._WindowFrame.BackgroundColor3 = Theme.Surface0
		end
		if Window._Header then
			Window._Header.BackgroundColor3 = Theme.Surface1
		end
		if Window._HeaderDivider then
			Window._HeaderDivider.BackgroundColor3 = Theme.Outline
		end
		if Window._ContainerBox then
			Window._ContainerBox.BackgroundColor3 = Theme.Surface0
		end
		if Window._TabTitle then
			Window._TabTitle.TextColor3 = Theme.Text
		end
		if Window._Separator then
			Window._Separator.BackgroundColor3 = Theme.Outline
		end
		if Window._Toggle then
			Window._Toggle.BackgroundColor3 = Theme.Accent
		end
		if Window._ThemeButton then
			Window._ThemeButton.BackgroundColor3 = Theme.Accent
		end
		if Window._ToggleIcon then
			Window._ToggleIcon.ImageColor3 = Theme.TextMuted
		end
		if Window._TabsList then
			Window._TabsList.BackgroundColor3 = Theme.TabBar
		end
		if Window._StatusBar then
			Window._StatusBar.BackgroundColor3 = Theme.Surface1
		end
		if Window._StatusDivider then
			Window._StatusDivider.BackgroundColor3 = Theme.Outline
		end
		if Window._StatusAccent then
			Window._StatusAccent.BackgroundColor3 = Theme.Accent
		end
		if Window._StatusResetLabel then
			Window._StatusResetLabel.TextColor3 = Theme.Text
		end
		if Window._StatusUptimeLabel then
			Window._StatusUptimeLabel.TextColor3 = Theme.Text
		end
		if Window._StatusSessionLabel then
			Window._StatusSessionLabel.TextColor3 = Theme.TextMuted
		end

		-- Update all accent-colored elements (underlines, etc.)
		for _, Element in ipairs(Library.AccentElements) do
			if Element and Element.Parent then
				Element.BackgroundColor3 = Theme.Accent
			end
		end

		-- Update resize handles
		if Library.ResizeHandles[Window._WindowFrame] then
			for _, Handle in ipairs(Library.ResizeHandles[Window._WindowFrame]) do
				if Handle then
					Handle.BackgroundColor3 = Theme.Accent
				end
			end
		end
	end

	table.insert(Window.ColorUpdateFunctions, UpdateColors)

	-- Call update immediately to apply theme
	RunColorUpdates()
	RefreshThemeButtons()
	UpdateTabsCanvas(#Window.Tabs)
	Window:SetStatus("Status: --", "Session: --", "--:--:--")

	local ToggleTweenInfo = TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	local IsWindowAnimating = false
	local IsWindowOpen = true
	local ClosedWindowScale = 0.01

	local function CloseVisibleFrames()
		for Frame in next, Library.VisibleFrames do
			if Frame and Frame.Parent then
				Frame.Visible = false
			end
			Library.VisibleFrames[Frame] = nil
		end
	end

	function Library.Toggle()
		if IsWindowAnimating then
			return
		end

		IsWindowAnimating = true

		if IsWindowOpen then
			CloseVisibleFrames()
			TweenService:Create(WindowScale, ToggleTweenInfo, { Scale = ClosedWindowScale }):Play()

			task.delay(ToggleTweenInfo.Time, function()
				WindowFrame.Visible = false
				IsWindowOpen = false
				IsWindowAnimating = false
			end)
		else
			WindowFrame.Visible = true
			WindowScale.Scale = ClosedWindowScale
			TweenService:Create(WindowScale, ToggleTweenInfo, { Scale = 1 }):Play()

			task.delay(ToggleTweenInfo.Time, function()
				IsWindowOpen = true
				IsWindowAnimating = false
			end)
		end
	end

	Library:MakeResizable(WindowFrame, {
		MinSize = Config.MinSize,
		HandleColor = Config.ResizeHandleColor,
		HoverColor = Config.ResizeHandleHoverColor,
		HandleTransparency = Config.ResizeHandleTransparency,
		HoverTransparency = Config.ResizeHandleHoverTransparency,
		EdgeThickness = Config.ResizeEdgeThickness,
		CornerSize = Config.ResizeCornerSize,
	})

	Library:MakeDraggable(WindowFrame, Header, 80)

	Library:GiveSignal(UserInputService.InputBegan:Connect(function(Input, Processed)
		if Input.KeyCode == Enum.KeyCode.RightShift then
			task.spawn(Library.Toggle)
		end
	end))

	Library:GiveSignal(UserInputService.InputBegan:Connect(function(Input)
		if ThemePopup.Visible and Input.UserInputType == Enum.UserInputType.MouseButton1 then
			local PopupPos, PopupSize = ThemePopup.AbsolutePosition, ThemePopup.AbsoluteSize
			local ButtonPos, ButtonSize = ThemeButton.AbsolutePosition, ThemeButton.AbsoluteSize
			local InPopup = Mouse.X >= PopupPos.X
				and Mouse.X <= PopupPos.X + PopupSize.X
				and Mouse.Y >= PopupPos.Y
				and Mouse.Y <= PopupPos.Y + PopupSize.Y
			local InButton = Mouse.X >= ButtonPos.X
				and Mouse.X <= ButtonPos.X + ButtonSize.X
				and Mouse.Y >= ButtonPos.Y
				and Mouse.Y <= ButtonPos.Y + ButtonSize.Y

			if not InPopup and not InButton then
				CloseThemePopup()
			end
		end
	end))

	ThemeButton.MouseEnter:Connect(function()
		TweenService:Create(ThemeButton, TweenInfo.new(0.2), { BackgroundTransparency = 0 }):Play()
		TweenService:Create(ThemeButtonIcon, TweenInfo.new(0.2), { ImageColor3 = Theme.Surface0 }):Play()
	end)

	ThemeButton.MouseLeave:Connect(function()
		TweenService:Create(ThemeButton, TweenInfo.new(0.2), { BackgroundTransparency = 1 }):Play()
		TweenService:Create(ThemeButtonIcon, TweenInfo.new(0.2), { ImageColor3 = Theme.TextMuted }):Play()
	end)

	ThemeButton.Activated:Connect(function()
		if ThemePopup.Visible then
			CloseThemePopup()
		else
			OpenThemePopup()
		end
	end)

	Toggle.MouseEnter:Connect(function()
		TweenService:Create(Toggle, TweenInfo.new(0.2), { BackgroundTransparency = 0 }):Play()
		TweenService:Create(ToggleIcon, TweenInfo.new(0.2), { ImageColor3 = Theme.Surface0 }):Play()
	end)

	Toggle.MouseLeave:Connect(function()
		TweenService:Create(Toggle, TweenInfo.new(0.2), { BackgroundTransparency = 1 }):Play()
		TweenService:Create(ToggleIcon, TweenInfo.new(0.2), { ImageColor3 = Theme.TextMuted }):Play()
	end)

	Toggle.Activated:Connect(function()
		task.spawn(Library.Toggle)
	end)

	return Window
end

return Library
