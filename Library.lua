local Library = {
	VisibleFrames = {},
	Signals = {},
}

---------------------
-- [[ Locals ]] --
---------------------

local UserInputService = game:GetService('UserInputService')
local TweenService = game:GetService('TweenService')
local CoreGui = game:GetService('CoreGui')
local RunService = game:GetService('RunService')
local RenderStepped = RunService.RenderStepped
local LocalPlayer = game:GetService('Players').LocalPlayer
local Mouse = LocalPlayer:GetMouse()

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = gethui()
ScreenGui.Name = "FuckNiggers"

---------------------
-- [[ Functions ]] --
---------------------

function Library:MouseIsOverVisibleFrames()
	for Frame, _ in next, Library.VisibleFrames do
		local AbsPos, AbsSize = Frame.AbsolutePosition, Frame.AbsoluteSize

		if Mouse.X >= AbsPos.X and Mouse.X <= AbsPos.X + AbsSize.X
			and Mouse.Y >= AbsPos.Y and Mouse.Y <= AbsPos.Y + AbsSize.Y then
			return true
		end
	end
end

function Library:MakeDraggable(Instance, DragInstance, Cutoff)
	Instance.Active = true

	DragInstance.InputBegan:Connect(function(Input)
		if Input.UserInputType == Enum.UserInputType.MouseButton1 then
			local ObjPos = Vector2.new(
				Mouse.X - Instance.AbsolutePosition.X,
				Mouse.Y - Instance.AbsolutePosition.Y
			)

			if ObjPos.Y > (Cutoff or 40) then
				return
			end

			while UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) do
				local Position = UDim2.new(
					0,
					Mouse.X - ObjPos.X + (Instance.Size.X.Offset * Instance.AnchorPoint.X),
					0,
					Mouse.Y - ObjPos.Y + (Instance.Size.Y.Offset * Instance.AnchorPoint.Y)
				)
				Instance:TweenPosition(Position, Enum.EasingDirection.Out, Enum.EasingStyle.Linear, 0.05, true)
				RenderStepped:Wait()
			end
		end
	end)
end

function Library:MapValue(Value, MinA, MaxA, MinB, MaxB)
	return (1 - ((Value - MinA) / (MaxA - MinA))) * MinB + ((Value - MinA) / (MaxA - MinA)) * MaxB
end

function Library:GiveSignal(Signal)
	table.insert(Library.Signals, Signal)
end

function Library:Create(Class, Properties)
	local _Instance = Class

	if type(Class) == 'string' then
		_Instance = Instance.new(Class)
	end

	for Property, Value in next, Properties do
		_Instance[Property] = Value
	end

	return _Instance
end

---------------------
-- [[  Classes  ]] --
---------------------

local Functions = {}

function Functions:AddButton(Text, Function)
	local Button = {}

	local Container = self.Container

	local ButtonFrame = Library:Create('Frame', {
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 0, 77),
		ZIndex = 1,
		LayoutOrder = #Container:GetChildren() + 1,
		Parent = Container,
	})

	local ButtonUnderline = Library:Create('Frame', {
		BackgroundTransparency = 0,
		BorderSizePixel = 0,
		BackgroundColor3 = Color3.fromRGB(43, 43, 43),
		Size = UDim2.new(0.975, 0, 0, 3),
		Position = UDim2.new(0, 0, 1, 0),
		ZIndex = 1,
		Parent = ButtonFrame,
	})

	local ClickButton = Library:Create('ImageButton', {
		BackgroundTransparency = 0,
		AnchorPoint = Vector2.new(1, 0.5),
		BackgroundColor3 = Color3.fromRGB(112, 183, 250),
		Size = UDim2.new(0, 30, 0, 30),
		Position = UDim2.new(0.97, 0, 0.5, 0),
		Image = "rbxassetid://5659139479",
		ZIndex = 1,
		Parent = ButtonFrame,
	})

	local ButtonStroke = Library:Create('UIStroke', {
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
		Color = Color3.fromRGB(240, 240, 240),
		Thickness = 0,
		Parent = ClickButton,
	})

	local ButtonCorner = Library:Create('UICorner', {
		CornerRadius = UDim.new(0.175, 0),
		Parent = ClickButton,
	})

	local ButtonPadding = Library:Create('UIPadding', {
		PaddingBottom = UDim.new(0.25, 0),
		PaddingRight = UDim.new(0.01, 0),
		PaddingLeft = UDim.new(0.01, 0),
		PaddingTop = UDim.new(0.25, 0),
		Parent = ClickButton,
	})

	local Option = Library:Create('TextLabel', {
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(0, 0.5),
		Size = UDim2.new(0, 250, 0, 50),
		Position = UDim2.new(0.125, 0, 0.5, 0),
		Text = Text or "Empty",
		TextColor3 = Color3.fromRGB(208, 208, 208),
		TextScaled = true,
		TextXAlignment = Enum.TextXAlignment.Left,
		Font = Enum.Font.SourceSansSemibold,
		ZIndex = 1,
		Parent = ButtonFrame,
	})

	local OptionPadding = Library:Create('UIPadding', {
		PaddingBottom = UDim.new(0.25, 0),
		PaddingRight = UDim.new(0.01, 0),
		PaddingLeft = UDim.new(0.01, 0),
		PaddingTop = UDim.new(0.25, 0),
		Parent = Option,
	})

	ClickButton.MouseEnter:Connect(function()
		TweenService:Create(ButtonStroke, TweenInfo.new(0.15), {Thickness = 2.5}):Play()
	end)

	ClickButton.MouseLeave:Connect(function()
		TweenService:Create(ButtonStroke, TweenInfo.new(0.15), {Thickness = 0}):Play()
	end)

	ClickButton.Activated:Connect(function() Function() end)

	return Button
end

function Functions:AddToggle(Name, Default, Function)
	local Toggle = {
		Value = Default or false,
	}

	local Container = self.Container

	local ToggleFrame = Library:Create('Frame', {
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 0, 77),
		ZIndex = 1,
		LayoutOrder = #Container:GetChildren() + 1,
		Parent = Container,
	})

	local ToggleUnderline = Library:Create('Frame', {
		BackgroundTransparency = 0,
		BorderSizePixel = 0,
		BackgroundColor3 = Color3.fromRGB(43, 43, 43),
		Size = UDim2.new(0.975, 0, 0, 3),
		Position = UDim2.new(0, 0, 1, 0),
		ZIndex = 1,
		Parent = ToggleFrame,
	})

	local Option = Library:Create('TextLabel', {
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(0, 0.5),
		Size = UDim2.new(0, 250, 0, 50),
		Position = UDim2.new(0.125, 0, 0.5, 0),
		Text = Name or "Empty",
		TextColor3 = Color3.fromRGB(208, 208, 208),
		TextScaled = true,
		TextXAlignment = Enum.TextXAlignment.Left,
		Font = Enum.Font.SourceSansSemibold,
		ZIndex = 1,
		Parent = ToggleFrame,
	})

	local OptionPadding = Library:Create('UIPadding', {
		PaddingBottom = UDim.new(0.25, 0),
		PaddingRight = UDim.new(0.01, 0),
		PaddingLeft = UDim.new(0.01, 0),
		PaddingTop = UDim.new(0.25, 0),
		Parent = Option,
	})

	local ToggleButton = Library:Create('TextButton', {
		AnchorPoint = Vector2.new(0, 0.5),
		BackgroundTransparency = 1,
		BackgroundColor3 = Color3.fromRGB(96, 175, 250),
		Size = UDim2.fromOffset(30, 30),
		Position = UDim2.fromScale(0.045, 0.5),
		Text = "",
		Parent = ToggleFrame,
	})

	local ToggleTick = Library:Create('ImageLabel', {
		AnchorPoint = Vector2.new(0, 0),
		BackgroundTransparency = 1,
		ImageTransparency = 1,
		Image = "rbxassetid://8589545938",
		Size = UDim2.fromScale(1, 1),
		Parent = ToggleButton,
	})

	local ToggleCorner = Library:Create('UICorner', {
		CornerRadius = UDim.new(0.23, 0),
		Parent = ToggleButton,
	})

	local ToggleStroke = Library:Create('UIStroke', {
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
		Color = Color3.fromRGB(107, 107, 107),
		Thickness = 2.5,
		Parent = ToggleButton,
	})

	function Toggle:Display()
		if Toggle.Value then
			TweenService:Create(ToggleTick, TweenInfo.new(0.15), {ImageTransparency = 0}):Play()
			TweenService:Create(ToggleButton, TweenInfo.new(0.15), {BackgroundTransparency = 0}):Play()
			TweenService:Create(ToggleStroke, TweenInfo.new(0.15), {Transparency = 1}):Play()
		else
			TweenService:Create(ToggleTick, TweenInfo.new(0.15), {ImageTransparency = 1}):Play()
			TweenService:Create(ToggleButton, TweenInfo.new(0.15), {BackgroundTransparency = 1}):Play()
			TweenService:Create(ToggleStroke, TweenInfo.new(0.15), {Transparency = 0}):Play()
		end
	end

	function Toggle:SetValue(Bool)
		Bool = (not not Bool)

		Toggle.Value = Bool
		Toggle:Display()

		if Function then
			Function()
		end
	end

	ToggleButton.Activated:Connect(function()
		Toggle:SetValue(not Toggle.Value)
	end)

	Toggle:SetValue()
	Toggle:Display()

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

	local ToggleFrame = Library:Create('Frame', {
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 0, 77),
		ZIndex = 1,
		LayoutOrder = #Container:GetChildren() + 1,
		Parent = Container,
	})

	local ToggleUnderline = Library:Create('Frame', {
		BackgroundTransparency = 0,
		BorderSizePixel = 0,
		BackgroundColor3 = Color3.fromRGB(43, 43, 43),
		Size = UDim2.new(0.975, 0, 0, 3),
		Position = UDim2.new(0, 0, 1, 0),
		ZIndex = 1,
		Parent = ToggleFrame,
	})

	local Option = Library:Create('TextLabel', {
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(0, 0.5),
		Size = UDim2.new(0, 250, 0, 50),
		Position = UDim2.new(0.125, 0, 0.5, 0),
		Text = Name or "Empty",
		TextColor3 = Color3.fromRGB(208, 208, 208),
		TextScaled = true,
		TextXAlignment = Enum.TextXAlignment.Left,
		Font = Enum.Font.SourceSansSemibold,
		ZIndex = 1,
		Parent = ToggleFrame,
	})

	local OptionPadding = Library:Create('UIPadding', {
		PaddingBottom = UDim.new(0.25, 0),
		PaddingRight = UDim.new(0.01, 0),
		PaddingLeft = UDim.new(0.01, 0),
		PaddingTop = UDim.new(0.25, 0),
		Parent = Option,
	})

	local ToggleButton = Library:Create('TextButton', {
		AnchorPoint = Vector2.new(0, 0.5),
		BackgroundTransparency = 1,
		BackgroundColor3 = Color3.fromRGB(96, 175, 250),
		Size = UDim2.fromOffset(30, 30),
		Position = UDim2.fromScale(0.045, 0.5),
		Text = "",
		Parent = ToggleFrame,
	})

	local ToggleTick = Library:Create('ImageLabel', {
		AnchorPoint = Vector2.new(0, 0),
		BackgroundTransparency = 1,
		ImageTransparency = 1,
		Image = "rbxassetid://8589545938",
		Size = UDim2.fromScale(1, 1),
		Parent = ToggleButton,
	})

	local ToggleCorner = Library:Create('UICorner', {
		CornerRadius = UDim.new(0.23, 0),
		Parent = ToggleButton,
	})

	local ToggleStroke = Library:Create('UIStroke', {
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
		Color = Color3.fromRGB(107, 107, 107),
		Thickness = 2.5,
		Parent = ToggleButton,
	})

	local InputBox = Library:Create('TextBox', {
		AnchorPoint = Vector2.new(0, 0.5),
		BackgroundTransparency = 1,
		Size = UDim2.fromOffset(130, 40),
		PlaceholderColor3 = Color3.fromRGB(178, 178, 178),
		Position = UDim2.fromScale(0.77, 0.51),
		Text = "",
		ClearTextOnFocus = false,
		TextColor3 = Color3.fromRGB(235, 235, 235),
		TextScaled = true,
		Font = Enum.Font.GothamBold,
		PlaceholderText = "Value",
		Parent = ToggleFrame,
	})

	local InputUnderline = Library:Create('Frame', {
		BackgroundColor3 = Color3.fromRGB(96, 175, 250),
		Size = UDim2.new(0, 0, 0.1, 0),
		ZIndex = 1,
		BorderSizePixel = 0,
		AnchorPoint = Vector2.new(0.5, 0),
		Position = UDim2.fromScale(0.5, 1.5),
		Parent = InputBox,
	})

	local InputPadding = Library:Create('UIPadding', {
		PaddingBottom = UDim.new(0.25, 0),
		PaddingRight = UDim.new(0.01, 0),
		PaddingLeft = UDim.new(0.01, 0),
		PaddingTop = UDim.new(0.25, 0),
		Parent = InputBox,
	})

	function Toggle:Display()
		if Toggle.BoolValue then
			TweenService:Create(ToggleTick, TweenInfo.new(0.15), {ImageTransparency = 0}):Play()
			TweenService:Create(ToggleButton, TweenInfo.new(0.15), {BackgroundTransparency = 0}):Play()
			TweenService:Create(ToggleStroke, TweenInfo.new(0.15), {Transparency = 1}):Play()
		else
			TweenService:Create(ToggleTick, TweenInfo.new(0.15), {ImageTransparency = 1}):Play()
			TweenService:Create(ToggleButton, TweenInfo.new(0.15), {BackgroundTransparency = 1}):Play()
			TweenService:Create(ToggleStroke, TweenInfo.new(0.15), {Transparency = 0}):Play()
		end
	end

	function Toggle:InputDisplay()
		if InputBox.Text:len() > 0 then
			TweenService:Create(InputUnderline, TweenInfo.new(.2), {Size = UDim2.fromScale(1, 0.1)}):Play()
		else
			TweenService:Create(InputUnderline, TweenInfo.new(.2), {Size = UDim2.fromScale(0, 0.1)}):Play()
		end
	end

	function Toggle:SetBoolValue(Bool)
		Bool = (not not Bool)

		Toggle.BoolValue = Bool
		Toggle:Display()

		if Function then
			Function()
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
	end

	InputBox.Focused:Connect(function(Enter)
		TweenService:Create(InputUnderline, TweenInfo.new(.2), {Size = UDim2.fromScale(1, 0.1)}):Play()
		if Toggle.Finished then
			if not Enter then return end
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

	return Toggle
end

function Functions:AddDropdown(Name, Info, Function)
	local Dropdown = {
		Values = Info.Values,
		Value = Info.Multi and {},
		Multi = Info.Multi,
		MaxShow = Info.MaxShow or 3,
		AllowNull = Info.AllowNull or false,
		MaxItems = Info.MaxItems or 5,
	}

	local Container = self.Container

	local DropdownFrame = Library:Create('Frame', {
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 0, 77),
		ZIndex = 1,
		LayoutOrder = #Container:GetChildren() + 1,
		Parent = Container,
	})

	local DropdownUnderline = Library:Create('Frame', {
		BackgroundTransparency = 0,
		BorderSizePixel = 0,
		BackgroundColor3 = Color3.fromRGB(43, 43, 43),
		Size = UDim2.new(0.975, 0, 0, 3),
		Position = UDim2.new(0, 0, 1, 0),
		ZIndex = 1,
		Parent = DropdownFrame,
	})

	local Option = Library:Create('TextLabel', {
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(0, 0.5),
		Size = UDim2.new(0, 250, 0, 50),
		Position = UDim2.new(0.125, 0, 0.5, 0),
		Text = Name or "Empty",
		TextColor3 = Color3.fromRGB(208, 208, 208),
		TextScaled = true,
		TextXAlignment = Enum.TextXAlignment.Left,
		Font = Enum.Font.SourceSansSemibold,
		ZIndex = 1,
		Parent = DropdownFrame,
	})

	local OptionPadding = Library:Create('UIPadding', {
		PaddingBottom = UDim.new(0.25, 0),
		PaddingRight = UDim.new(0.01, 0),
		PaddingLeft = UDim.new(0.01, 0),
		PaddingTop = UDim.new(0.25, 0),
		Parent = Option,
	})

	local DropdownButton = Library:Create('ImageButton', {
		AnchorPoint = Vector2.new(1, 0.5),
		BackgroundTransparency = 1,
		ImageTransparency = 0,
		BorderSizePixel = 0,
		Position = UDim2.fromScale(0.975, 0.5),
		ZIndex = 2,
		Image = "rbxassetid://293296862",
		Size = UDim2.fromOffset(50, 50),
		Parent = DropdownFrame,
	})

	local DropdownHolder = Library:Create('Frame', {
		BackgroundColor3 = Color3.fromRGB(45, 46, 49),
		Size = UDim2.new(0, 245, 0, 168),
		ZIndex = 1,
		Visible = false,
		Position = UDim2.fromScale(-3.9, 1.1),
		Parent = ScreenGui,
	})

	local DropdownCorner = Library:Create('UICorner', {
		CornerRadius = UDim.new(0.05, 0),
		Parent = DropdownHolder,
	})

	local DropdownList = Library:Create('ScrollingFrame', {
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

	local DropdownLayout = Library:Create('UIListLayout', {
		FillDirection = Enum.FillDirection.Vertical,
		SortOrder = Enum.SortOrder.LayoutOrder,
		HorizontalAlignment = Enum.HorizontalAlignment.Left,
		VerticalAlignment = Enum.VerticalAlignment.Top,
		Padding = UDim.new(0, 5),
		Parent = DropdownList,
	})

	local DropdownPadding = Library:Create('UIPadding', {
		PaddingBottom = UDim.new(0, 7),
		PaddingTop = UDim.new(0, 7),
		PaddingLeft = UDim.new(0.027, 0),
		PaddingRight = UDim.new(0.025, 0),
		Parent = DropdownList,
	})

	local DropdownValue = Library:Create('TextLabel', {
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(0, 0.5),
		Size = UDim2.new(0, 222, 0, 50),
		Position = UDim2.new(0.525, 0, 0.51, 0),
		Text = "...",
		TextColor3 = Color3.fromRGB(208, 208, 208),
		RichText = true,
		TextTruncate = Enum.TextTruncate.AtEnd,
		TextSize = 18,
		TextWrapped = true,
		TextXAlignment = Enum.TextXAlignment.Right,
		Font = Enum.Font.GothamBold,
		ZIndex = 1,
		Parent = DropdownFrame,
	})

	local DropdownValuePadding = Library:Create('UIPadding', {
		PaddingBottom = UDim.new(0.3, 0),
		PaddingTop = UDim.new(0.3, 0),
		PaddingLeft = UDim.new(0.01, 0),
		PaddingRight = UDim.new(0.01, 0),
		Parent = DropdownValue,
	})

	function Dropdown:Display()
		local Values = Dropdown.Values
		local Str = ''
		local Count = 0

		if Dropdown.Multi then
			for Idx, Value in next, Values do
				if Dropdown.Value[Value] then
					if Count < Dropdown.MaxShow then
						Count += 1
						Str = Str .. Value .. ', '
					else
						Count += 1
						Str = Str .. "..."
						break
					end
				end
			end

			if Count <= Dropdown.MaxShow then
				Str = Str:sub(1, #Str - 2)
			end
		else
			Str = Dropdown.Value or ''
		end
		DropdownValue.Text = (Str == '' and '...' or Str)
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

	function Dropdown:SetValues()
		local Values = Dropdown.Values
		local Buttons = {}

		for _, Element in next, DropdownList:GetChildren() do
			if not Element:IsA('UIListLayout') and not Element:IsA('UIPadding') then
				Element:Destroy()
			end
		end

		local Count = 0

		for Idx, Value in next, Values do
			local Table = {}

			Count = Count + 1

			local SelectionButton = Library:Create('Frame', {
				BackgroundColor3 = Color3.fromRGB(65, 67, 72),
				BackgroundTransparency = 1,
				Size = UDim2.new(1, 0, 0, 35),
				ZIndex = 1,
				Active = true,
				Parent = DropdownList,
			})

			local SelectionCorner = Library:Create('UICorner', {
				CornerRadius = UDim.new(0.15, 0),
				Parent = SelectionButton,
			})

			local Bar = Library:Create('Frame', {
				BackgroundColor3 = Color3.fromRGB(96, 174, 250),
				AnchorPoint = Vector2.new(0, 0.5),
				BorderSizePixel = 0,
				Position = UDim2.fromScale(0.025, 0.5),
				Size = UDim2.new(0, 2, 0, 0),
				ZIndex = 1,
				Parent = SelectionButton,
			})

			local SelectionText = Library:Create('TextLabel', {
				BackgroundTransparency = 1,
				AnchorPoint = Vector2.new(0, 0.5),
				Size = UDim2.new(-0.688, 368, 1, 0),
				Position = UDim2.new(0.083, 0, 0.5, 0),
				Text = Value,
				TextColor3 = Color3.fromRGB(208, 208, 208),
				TextScaled = true,
				RichText = true,
				TextXAlignment = Enum.TextXAlignment.Left,
				Font = Enum.Font.SourceSansSemibold,
				ZIndex = 1,
				Parent = SelectionButton,
			})

			local SelectionPadding = Library:Create('UIPadding', {
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
					TweenService:Create(SelectionButton, TweenInfo.new(0.2), {BackgroundTransparency = 0}):Play()
					TweenService:Create(Bar, TweenInfo.new(0.2), {Size = UDim2.new(0, 2, 0, 25)}):Play()
				else
					TweenService:Create(SelectionButton, TweenInfo.new(0.2), {BackgroundTransparency = 1}):Play()
					TweenService:Create(Bar, TweenInfo.new(0.2), {Size = UDim2.new(0, 2, 0, 0)}):Play()
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

					if Dropdown:GetActiveValues() == 1 and (not Try) and (not Dropdown.AllowNull) then
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
							end;

							for _, OtherButton in next, Buttons do
								OtherButton:UpdateButton()
							end
						end

						Table:UpdateButton()
						Dropdown:Display()

						if Function then
							Function()
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
		DropdownHolder.Position = UDim2.fromOffset(DropdownButton.AbsolutePosition.X - DropdownHolder.Size.X.Offset - 10, DropdownButton.AbsolutePosition.Y + 10)
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
			if (not Val) then
				Dropdown.Value = nil
			elseif table.find(Dropdown.Values, Val) then
				Dropdown.Value = Val
			end
		end

		Dropdown:SetValues()
		Dropdown:Display()

		if Function then
			Function()
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

		if Mouse.X < AbsPos.X or Mouse.X > AbsPos.X + AbsSize.X
			or Mouse.Y < (AbsPos.Y) or Mouse.Y > AbsPos.Y + AbsSize.Y then
			if Mouse.X < ButtonPos.X or Mouse.X > ButtonPos.X + ButtonSize.X
				or Mouse.Y < (ButtonPos.Y) or Mouse.Y > ButtonPos.Y + ButtonSize.Y then
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

	local InputFrame = Library:Create('Frame', {
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 0, 77),
		ZIndex = 1,
		LayoutOrder = #Container:GetChildren() + 1,
		Parent = Container,
	})

	local InputUnderline = Library:Create('Frame', {
		BackgroundTransparency = 0,
		BorderSizePixel = 0,
		BackgroundColor3 = Color3.fromRGB(43, 43, 43),
		Size = UDim2.new(0.975, 0, 0, 3),
		Position = UDim2.new(0, 0, 1, 0),
		ZIndex = 1,
		Parent = InputFrame,
	})

	local Option = Library:Create('TextLabel', {
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(0, 0.5),
		Size = UDim2.new(0, 250, 0, 50),
		Position = UDim2.new(0.125, 0, 0.5, 0),
		Text = Name or "Empty",
		TextColor3 = Color3.fromRGB(208, 208, 208),
		TextScaled = true,
		TextXAlignment = Enum.TextXAlignment.Left,
		Font = Enum.Font.SourceSansSemibold,
		ZIndex = 1,
		Parent = InputFrame,
	})

	local OptionPadding = Library:Create('UIPadding', {
		PaddingBottom = UDim.new(0.25, 0),
		PaddingRight = UDim.new(0.01, 0),
		PaddingLeft = UDim.new(0.01, 0),
		PaddingTop = UDim.new(0.25, 0),
		Parent = Option,
	})

	local InputBox = Library:Create('TextBox', {
		AnchorPoint = Vector2.new(0, 0.5),
		BackgroundTransparency = 1,
		Size = UDim2.fromOffset(130, 40),
		PlaceholderColor3 = Color3.fromRGB(178, 178, 178),
		Position = UDim2.fromScale(0.77, 0.51),
		Text = "",
		ClearTextOnFocus = false,
		TextColor3 = Color3.fromRGB(235, 235, 235),
		TextScaled = true,
		Font = Enum.Font.GothamBold,
		PlaceholderText = "Value",
		Parent = InputFrame,
	})

	local InputUnderline = Library:Create('Frame', {
		BackgroundColor3 = Color3.fromRGB(96, 175, 250),
		Size = UDim2.new(0, 0, 0.1, 0),
		ZIndex = 1,
		BorderSizePixel = 0,
		AnchorPoint = Vector2.new(0.5, 0),
		Position = UDim2.fromScale(0.5, 1.5),
		Parent = InputBox,
	})

	local InputPadding = Library:Create('UIPadding', {
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
			Function()
		end
	end

	function Input:Display()
		if InputBox.Text:len() > 0 then
			TweenService:Create(InputUnderline, TweenInfo.new(.2), {Size = UDim2.fromScale(1, 0.1)}):Play()
		else
			TweenService:Create(InputUnderline, TweenInfo.new(.2), {Size = UDim2.fromScale(0, 0.1)}):Play()
		end
	end

	InputBox.Focused:Connect(function(Enter)
		TweenService:Create(InputUnderline, TweenInfo.new(.2), {Size = UDim2.fromScale(1, 0.1)}):Play()
		if Input.Finished then
			if not Enter then return end
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

	local SliderFrame = Library:Create('Frame', {
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 0, 77),
		ZIndex = 1,
		LayoutOrder = #Container:GetChildren() + 1,
		Parent = Container,
	})

	local SliderUnderline = Library:Create('Frame', {
		BackgroundTransparency = 0,
		BorderSizePixel = 0,
		BackgroundColor3 = Color3.fromRGB(43, 43, 43),
		Size = UDim2.new(0.975, 0, 0, 3),
		Position = UDim2.new(0, 0, 1, 0),
		ZIndex = 1,
		Parent = SliderFrame,
	})

	local Option = Library:Create('TextLabel', {
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(0, 0.5),
		Size = UDim2.new(0, 250, 0, 50),
		Position = UDim2.new(0.125, 0, 0.5, 0),
		Text = Name or "Empty",
		TextColor3 = Color3.fromRGB(208, 208, 208),
		TextScaled = true,
		TextXAlignment = Enum.TextXAlignment.Left,
		Font = Enum.Font.SourceSansSemibold,
		ZIndex = 1,
		Parent = SliderFrame,
	})

	local OptionPadding = Library:Create('UIPadding', {
		PaddingBottom = UDim.new(0.25, 0),
		PaddingRight = UDim.new(0.01, 0),
		PaddingLeft = UDim.new(0.01, 0),
		PaddingTop = UDim.new(0.25, 0),
		Parent = Option,
	})

	local Drag = Library:Create('ImageLabel', {
		AnchorPoint = Vector2.new(1, 0.5),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 1.000,
		BorderSizePixel = 0,
		Position = UDim2.new(0.965, 0, 0.5, 0),
		Size = UDim2.new(0, 195, 0, 7),
		Image = "rbxassetid://5825681337",
		ImageColor3 = Color3.fromRGB(54, 52, 52),
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = Rect.new(130, 134, 388, 390),
		Parent = SliderFrame,
	})

	local Bar = Library:Create('ImageLabel', {
		BackgroundColor3 = Color3.fromRGB(1, 1, 1),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Size = UDim2.new(0.5, 0, 1, 0),
		Image = "rbxassetid://5825681337",
		ImageColor3 = Color3.fromRGB(96, 174, 250),
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = Rect.new(130, 134, 388, 390),
		Parent = Drag,
	})

	local Dot = Library:Create('ImageLabel', {
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

	local Circle = Library:Create('ImageLabel', {
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 1,
		Position = UDim2.new(0.5, 0, 0.5, 0),
		Selectable = true,
		ImageColor3 = Color3.fromRGB(96, 174, 250),
		Size = UDim2.new(0.35, 0, 0.35, 0),
		Image = "rbxassetid://4504304159",
		Parent = Dot,
	})

	local ValueBox = Library:Create('TextBox', {
		AnchorPoint = Vector2.new(0, 0.5),
		BackgroundTransparency = 1,
		Size = UDim2.fromOffset(89, 50),
		PlaceholderColor3 = Color3.fromRGB(178, 178, 178),
		Position = UDim2.fromScale(0.505, 0.51),
		Text = "",
		TextColor3 = Color3.fromRGB(235, 235, 235),
		TextScaled = true,
		Font = Enum.Font.GothamBold,
		PlaceholderText = "Value",
		Parent = SliderFrame,
	})

	local ValueUnderline = Library:Create('Frame', {
		BackgroundColor3 = Color3.fromRGB(96, 175, 250),
		Size = UDim2.new(0, 0, 0.1, 0),
		ZIndex = 1,
		BorderSizePixel = 0,
		AnchorPoint = Vector2.new(0.5, 0),
		Position = UDim2.fromScale(0.5, 1.5),
		Parent = ValueBox,
	})

	local ValuePadding = Library:Create('UIPadding', {
		PaddingBottom = UDim.new(0.3, 0),
		PaddingRight = UDim.new(0.01, 0),
		PaddingLeft = UDim.new(0.01, 0),
		PaddingTop = UDim.new(0.3, 0),
		Parent = ValueBox,
	})

	function Slider:Display()
		local Suffix = Slider.Suffix
		ValueBox.Text = string.format('%s', Slider.Value .. " " .. Suffix)

		local X = math.ceil(Library:MapValue(Slider.Value, Slider.Min, Slider.Max, 0, 195))
		TweenService:Create(Bar, TweenInfo.new(.2), {Size = UDim2.new(0, X, 1, 0)}):Play()
	end

	local function Round(Value)
		if Slider.Rounding == 0 then
			return math.floor(Value)
		end

		local Str = Value .. ''
		local Dot = Str:find('%.')

		return Dot and tonumber(Str:sub(1, Dot + Slider.Rounding)) or Value
	end

	function Slider:GetValueFromXOffset(X)
		return Round(Library:MapValue(X, 0, 195, Slider.Min, Slider.Max))
	end

	function Slider:SetValue(Str)
		local Num = tonumber(Str)

		if (not Num) then
			Slider:SetValue(Slider.Value)
			return
		end

		Num = math.clamp(Num, Slider.Min, Slider.Max)

		Slider.Value = Num
		Slider:Display()
	end

	Dot.InputBegan:Connect(function(Input)
		if Input.UserInputType == Enum.UserInputType.MouseButton1 and not Library:MouseIsOverVisibleFrames() then
			local mPos = Mouse.X
			local gPos = Bar.Size.X.Offset
			local Diff = mPos - (Bar.AbsolutePosition.X + gPos)

			while UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) do
				local nMPos = Mouse.X
				local nX = math.clamp(gPos + (nMPos - mPos) + Diff, 0, 195)

				local nValue = Slider:GetValueFromXOffset(nX)
				local OldValue = Slider.Value
				Slider.Value = nValue

				Slider:Display()

				RenderStepped:Wait()
			end
		end
	end)

	ValueBox.Focused:Connect(function(Enter)
		TweenService:Create(ValueUnderline, TweenInfo.new(.2), {Size = UDim2.fromScale(1, 0.1)}):Play()
	end)

	ValueBox.FocusLost:Connect(function()
		Slider:SetValue(ValueBox.Text)
		TweenService:Create(ValueUnderline, TweenInfo.new(.2), {Size = UDim2.fromScale(0, 0.1)}):Play()
	end)

	Slider:Display()

	if Info.Default then
		Slider:SetValue(Info.Default)
	end

	return Slider
end

function Functions:AddKeybindPicker(Name, Info, Function)
	local KeybindPicker = {
		Value = Info.Default
	}

	local Container = self.Container

	local KeybindFrame = Library:Create('Frame', {
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 0, 77),
		ZIndex = 1,
		LayoutOrder = #Container:GetChildren() + 1,
		Parent = Container,
	})

	local KeybindUnderline = Library:Create('Frame', {
		BackgroundTransparency = 0,
		BorderSizePixel = 0,
		BackgroundColor3 = Color3.fromRGB(43, 43, 43),
		Size = UDim2.new(0.975, 0, 0, 3),
		Position = UDim2.new(0, 0, 1, 0),
		ZIndex = 1,
		Parent = KeybindFrame,
	})

	local Option = Library:Create('TextLabel', {
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(0, 0.5),
		Size = UDim2.new(0, 250, 0, 50),
		Position = UDim2.new(0.125, 0, 0.5, 0),
		Text = Name or "Empty",
		TextColor3 = Color3.fromRGB(208, 208, 208),
		TextScaled = true,
		TextXAlignment = Enum.TextXAlignment.Left,
		Font = Enum.Font.SourceSansSemibold,
		ZIndex = 1,
		Parent = KeybindFrame,
	})

	local OptionPadding = Library:Create('UIPadding', {
		PaddingBottom = UDim.new(0.25, 0),
		PaddingRight = UDim.new(0.01, 0),
		PaddingLeft = UDim.new(0.01, 0),
		PaddingTop = UDim.new(0.25, 0),
		Parent = Option,
	})

	local KeybindBox = Library:Create('TextButton', {
		Active = false,
		AnchorPoint = Vector2.new(0, 0.5),
		BackgroundColor3 = Color3.fromRGB(68, 68, 68),
		BackgroundTransparency = 1.000,
		BorderColor3 = Color3.fromRGB(27, 42, 53),
		BorderSizePixel = 0,
		Position = UDim2.new(0.755, 0, 0.5, 0),
		Selectable = false,
		Size = UDim2.new(0, 130, 0, 40),
		Font = Enum.Font.GothamBold,
		Text = "[ Keybind ]",
		TextColor3 = Color3.fromRGB(235, 235, 235),
		TextScaled = true,
		TextSize = 14.000,
		TextWrapped = true,
		TextXAlignment = Enum.TextXAlignment.Right,
		Parent = KeybindFrame,
	})

	local KeybindBoxPadding = Library:Create('UIPadding', {
		PaddingBottom = UDim.new(0.275, 0),
		PaddingRight = UDim.new(0.01, 0),
		PaddingLeft = UDim.new(0.01, 0),
		PaddingTop = UDim.new(0.275, 0),
		Parent = KeybindBox,
	})

	function KeybindPicker:Update()
		KeybindBox.Text = string.format('[ %s ]', KeybindPicker.Value)
	end

	function KeybindPicker:SetValue(Data)
		local Key, Mode = Data[1], Data[2]
		KeybindBox.Text = Key
		KeybindPicker.Value = Key
		KeybindPicker:Update()
	end

	local Picking = false
	KeybindBox.InputBegan:Connect(function(Input)
		if Input.UserInputType == Enum.UserInputType.MouseButton1 then
			KeybindBox.Text = '[ ... ]'
			Picking = true

			task.wait(.2)

			local Event
			Event = game:GetService("UserInputService").InputBegan:Connect(function(Input)
				local Key

				if Input.UserInputType == Enum.UserInputType.Keyboard and Input.KeyCode == Enum.KeyCode.Escape then
					Picking = false
					TweenService:Create(KeybindBox, TweenInfo.new(0.15), {TextTransparency = 1}):Play()
					KeybindBox.Text = "[ " .. KeybindPicker.Value .. " ]"
					delay(.1,function()
						TweenService:Create(KeybindBox, TweenInfo.new(0.15), {TextTransparency = 0}):Play()
					end)
					Event:Disconnect()
					return
				end

				if Input.UserInputType == Enum.UserInputType.Keyboard then
					Key = Input.KeyCode.Name
				elseif Input.UserInputType == Enum.UserInputType.MouseButton1 then
					Key = 'MB1'
				elseif Input.UserInputType == Enum.UserInputType.MouseButton2 then
					Key = 'MB2'
				elseif Input.UserInputType == Enum.UserInputType.MouseButton3 then
					Key = 'MB3'
				end

				Picking = false

				TweenService:Create(KeybindBox, TweenInfo.new(0.25), {TextTransparency = 1}):Play()
				KeybindBox.Text = "[ " .. Key .. " ]"
				delay(.25,function()
					TweenService:Create(KeybindBox, TweenInfo.new(0.25), {TextTransparency = 0}):Play()
				end)
				KeybindPicker.Value = Key
				Event:Disconnect()
			end)
		end
	end)

	UserInputService.InputEnded:Connect(function(Input)
		if (not Picking) then
			KeybindPicker:Update()
		end
	end)

	KeybindPicker:Update()

	return KeybindPicker
end

function Functions:AddColorPicker(Name, Info, Function)
	local ColorPicker = {
		Value = Info.Default,
	}

	local Container = self.Container

	local ColorPickerFrame = Library:Create('Frame', {
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 0, 77),
		ZIndex = 1,
		LayoutOrder = #Container:GetChildren() + 1,
		Parent = Container,
	})

	local ColorPickerFrameUnderline = Library:Create('Frame', {
		BackgroundTransparency = 0,
		BorderSizePixel = 0,
		BackgroundColor3 = Color3.fromRGB(43, 43, 43),
		Size = UDim2.new(0.975, 0, 0, 3),
		Position = UDim2.new(0, 0, 1, 0),
		ZIndex = 1,
		Parent = ColorPickerFrame,
	})

	local Option = Library:Create('TextLabel', {
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(0, 0.5),
		Size = UDim2.new(0, 250, 0, 50),
		Position = UDim2.new(0.125, 0, 0.5, 0),
		Text = Name or "Empty",
		TextColor3 = Color3.fromRGB(208, 208, 208),
		TextScaled = true,
		TextXAlignment = Enum.TextXAlignment.Left,
		Font = Enum.Font.SourceSansSemibold,
		ZIndex = 1,
		Parent = ColorPickerFrame,
	})

	local OptionPadding = Library:Create('UIPadding', {
		PaddingBottom = UDim.new(0.25, 0),
		PaddingRight = UDim.new(0.01, 0),
		PaddingLeft = UDim.new(0.01, 0),
		PaddingTop = UDim.new(0.25, 0),
		Parent = Option,
	})

	local ValueBox = Library:Create('TextLabel', {
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(0, 0.5),
		Size = UDim2.new(0, 125, 0, 50),
		Position = UDim2.new(0.7, 0, 0.5, 0),
		Text = "",
		TextColor3 = Color3.fromRGB(126, 230, 250),
		TextScaled = true,
		TextXAlignment = Enum.TextXAlignment.Right,
		Font = Enum.Font.GothamBold,
		ZIndex = 1,
		Parent = ColorPickerFrame,
	})

	local ValuePadding = Library:Create('UIPadding', {
		PaddingBottom = UDim.new(0.3, 0),
		PaddingRight = UDim.new(0.01, 0),
		PaddingLeft = UDim.new(0.01, 0),
		PaddingTop = UDim.new(0.3, 0),
		Parent = ValueBox,
	})

	local ColorPickerButton = Library:Create('TextButton', {
		AnchorPoint = Vector2.new(1, 0.5),
		BackgroundColor3 = Color3.fromRGB(126, 230, 250),
		BorderSizePixel = 0,
		Position = UDim2.new(0.955, 0, 0.5, 0),
		Size = UDim2.fromOffset(30, 30),
		Text = "",
		Parent = ColorPickerFrame,
	})

	local ColorPickerButtonCorner = Library:Create('UICorner', {
		CornerRadius = UDim.new(1, 0),
		Parent = ColorPickerButton,
	})

	local ColorPickerBox = Library:Create('Frame', {
		Active = true,
		Name = "ColorBox",
		BackgroundColor3 = Color3.fromRGB(57, 58, 62),
		BorderSizePixel = 0,
		LayoutOrder = 1,
		ZIndex = 2,
		Size = UDim2.new(0, 260, 0, 260),
		Visible = false,
		Parent = ScreenGui,
	})

	local ColorPickerCorner = Library:Create('UICorner', {
		CornerRadius = UDim.new(0.025, 0),
		Parent = ColorPickerBox,
	})

	local Saturation = Library:Create('Frame', {
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BorderSizePixel = 0,
		Position = UDim2.new(0.5, 0, 0.5, 0),
		Size = UDim2.new(0.95, 0, 0.95, 0),
		ZIndex = 2,
		Parent = ColorPickerBox,
	})

	local SaturationMap = Library:Create('ImageLabel', {
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BorderSizePixel = 0,
		Size = UDim2.new(1, 0, 1, 0),
		Image = "rbxassetid://4155801252",
		Parent = Saturation,
	})

	local Hue = Library:Create('Frame', {
		BackgroundColor3 = Color3.fromRGB(57, 58, 62),
		BorderSizePixel = 0,
		Position = UDim2.new(-0.15, 0, 0, 0),
		Size = UDim2.new(0, 33, 0, 260),
		ZIndex = 2,
		Parent = ColorPickerBox,
	})

	local HueCorner = Library:Create('UICorner', {
		CornerRadius = UDim.new(0.2, 0),
		Parent = Hue,
	})

	local HueMap = Library:Create('Frame', {
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BorderSizePixel = 0,
		Position = UDim2.new(0.5, 0, 0.5, 0),
		Size = UDim2.new(0.75, 0, 0.97, 0),
		Parent = Hue,
	})

	local HueMapCorner = Library:Create('UICorner', {
		CornerRadius = UDim.new(0.2, 0),
		Parent = HueMap,
	})

	local ColorPickerCorner = Library:Create('UIGradient', {
		Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 4)), ColorSequenceKeypoint.new(0.10, Color3.fromRGB(255, 153, 0)), ColorSequenceKeypoint.new(0.20, Color3.fromRGB(209, 255, 0)), ColorSequenceKeypoint.new(0.30, Color3.fromRGB(55, 255, 0)), ColorSequenceKeypoint.new(0.40, Color3.fromRGB(0, 255, 102)), ColorSequenceKeypoint.new(0.50, Color3.fromRGB(0, 255, 255)), ColorSequenceKeypoint.new(0.60, Color3.fromRGB(0, 102, 255)), ColorSequenceKeypoint.new(0.70, Color3.fromRGB(51, 0, 255)), ColorSequenceKeypoint.new(0.80, Color3.fromRGB(204, 0, 255)), ColorSequenceKeypoint.new(0.90, Color3.fromRGB(255, 0, 153)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 0, 4))},
		Rotation = 90,
		Parent = HueMap,
	})

	function ColorPicker:SetHSVFromRGB(Color)
		local H, S, V = Color3.toHSV(Color)

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
			Function()
		end
	end

	function ColorPicker:Show()
		for Frame, Val in next, Library.VisibleFrames do
			if Frame.Name == 'ColorBox' then
				Frame.Visible = false
				Library.VisibleFrames[Frame] = nil
			end
		end

		ColorPickerBox.Position = UDim2.fromOffset(Mouse.X + 60, Mouse.Y - 30)
		ColorPickerBox.Visible = true
		Library.VisibleFrames[ColorPickerBox] = true
	end;

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

			if Mouse.X < (AbsPos.X - 40) or Mouse.X > AbsPos.X + AbsSize.X
				or Mouse.Y < (AbsPos.Y) or Mouse.Y > AbsPos.Y + AbsSize.Y then
				if Mouse.X < ButtonPos.X or Mouse.X > ButtonPos.X + ButtonSize.X
					or Mouse.Y < (ButtonPos.Y) or Mouse.Y > ButtonPos.Y + ButtonSize.Y then
					ColorPicker:Hide()
				end
			end
		end
	end)

	ColorPicker:Display()

	return ColorPicker
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

	if type(...) == 'table' then
		Config = ...
	end

	if typeof(Config.Position) ~= 'UDim2' then Config.Position = UDim2.fromOffset(350, 150) end

	if Config.Center then
		Config.AnchorPoint = Vector2.new(0.5, 0.5)
		Config.Position = UDim2.fromScale(0.5, 0.5)
	end

	local Window = {
		Tabs = {}
	}

	local WindowFrame = Library:Create('Frame', {
		AnchorPoint = Config.AnchorPoint,
		BackgroundColor3 = Color3.fromRGB(27, 28, 30),
		BorderSizePixel = 0,
		Position = Config.Position,
		Size = UDim2.new(0, 750, 0, 445),
		Visible = true,
		ClipsDescendants = true,
		ZIndex = 1,
		Parent = ScreenGui,
	})

	-- Tabs --

	local TabsList = Library:Create('ScrollingFrame', {
		BackgroundColor3 = Color3.fromRGB(45, 46, 49),
		BorderSizePixel = 0,
		Position = UDim2.new(0, 0, 0, 0),
		Size = UDim2.new(0.147, 0, 1, 0),
		Visible = true,
		ClipsDescendants = true,
		ZIndex = 1,
		ScrollBarThickness = 0,
		CanvasSize = UDim2.new(0, 0, 0, 0),
		AutomaticCanvasSize = Enum.AutomaticSize.Y,
		Parent = WindowFrame,
	})

	local TabsLayout = Library:Create('UIListLayout', {
		FillDirection = Enum.FillDirection.Vertical,
		SortOrder = Enum.SortOrder.LayoutOrder,
		Padding = UDim.new(0, 20),
		HorizontalAlignment = Enum.HorizontalAlignment.Left,
		VerticalAlignment = Enum.VerticalAlignment.Top,
		Parent = TabsList,
	})

	local TabsPadding = Library:Create('UIPadding', {
		PaddingBottom = UDim.new(0, 20),
		PaddingTop = UDim.new(0, 20),
		PaddingLeft = UDim.new(0.2, 0),
		PaddingRight = UDim.new(0.2, 0),
		Parent = TabsList,
	})

	-- Header --

	local Header = Library:Create('Frame', {
		BorderSizePixel = 0,
		Position = UDim2.new(0, 109, 0, 0),
		Size = UDim2.new(0.855, 0, 0.135, 0),
		Visible = true,
		BackgroundTransparency = 0.95,
		BackgroundColor3 = Color3.fromRGB(163, 162, 165),
		ClipsDescendants = true,
		ZIndex = 1,
		Parent = WindowFrame,
	})

	local Separator = Library:Create('Frame', {
		BackgroundColor3 = Color3.fromRGB(41, 42, 45),
		AnchorPoint = Vector2.new(1, 0.5),
		Position = UDim2.new(0.875, 0, 0.5, 0),
		Size = UDim2.new(0.005, 0, 0.5, 0),
		Visible = true,
		BackgroundTransparency = 0,
		BorderSizePixel = 0,
		ClipsDescendants = false,
		ZIndex = 1,
		Parent = Header,
	})

	local Toggle = Library:Create('ImageButton', {
		BackgroundColor3 = Color3.fromRGB(96, 175, 255),
		AnchorPoint = Vector2.new(1, 0.5),
		Position = UDim2.new(0.97, 0, 0.5, 0),
		Size = UDim2.new(0.062, 0, 0.667, 0),
		Visible = true,
		BackgroundTransparency = 1,
		AutoButtonColor = false,
		ImageTransparency = 1,
		BorderSizePixel = 0,
		ClipsDescendants = false,
		ZIndex = 1,
		Parent = Header,
	})

	local ToggleIcon = Library:Create('ImageLabel', {
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.new(0.5, 0, 0.5, 0),
		Size = UDim2.new(1, 0, 1, 0),
		Visible = true,
		BackgroundTransparency = 1,
		Image = "rbxassetid://7436812392",
		ImageColor3 = Color3.fromRGB(157, 157, 157),
		ClipsDescendants = false,
		ZIndex = 1,
		BorderSizePixel = 0,
		Parent = Toggle,
	})

	local ToggleCorner = Library:Create('UICorner', {
		CornerRadius = UDim.new(0.15, 0),
		Parent = Toggle,
	})

	local TabTitle = Library:Create('TextLabel', {
		AnchorPoint = Vector2.new(0, 0.5),
		Position = UDim2.new(0.05, 0, 0.5, 0),
		Size = UDim2.new(0.76, 0, 0.75, 0),
		Visible = true,
		Font = Enum.Font.SourceSansBold,
		RichText = true,
		Text = '',
		TextColor3 = Color3.fromRGB(255, 255, 255),
		TextScaled = true,
		BackgroundTransparency = 1,
		ClipsDescendants = false,
		ZIndex = 1,
		TextXAlignment = Enum.TextXAlignment.Left,
		BorderSizePixel = 0,
		Parent = Header,
	})

	local TitlePadding = Library:Create('UIPadding', {
		PaddingBottom = UDim.new(0.1, 0),
		PaddingTop = UDim.new(0.15, 0),
		PaddingLeft = UDim.new(0.01, 0),
		PaddingRight = UDim.new(0.15, 0),
		Parent = TabTitle,
	})

	-- ContainerBox --

	local ContainerBox = Library:Create('Frame', {
		BorderSizePixel = 0,
		Position = UDim2.new(0.145, 0, 0.135, 0),
		Size = UDim2.new(0.855, 0, 0.865, 0),
		Visible = true,
		BackgroundTransparency = 1,
		ClipsDescendants = true,
		ZIndex = 1,
		Parent = WindowFrame,
	})

	local ContainerBoxLayout = Library:Create('UIPageLayout', {
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

	-- Functions --

	function Window:AddTab(NewTabName, NewTabIcon)
		if not NewTabName or not NewTabIcon then return end
		local Tab = {}

		-- Tab Button --
		local TabButton = Library:Create('Frame', {
			BackgroundColor3 = Color3.fromRGB(96, 175, 250),
			BackgroundTransparency = 1,
			LayoutOrder = #Window.Tabs + 1,
			BorderSizePixel = 0,
			Size = UDim2.new(0.995, 0, 0, 65),
			Parent = TabsList,
		})

		local TabButtonCorner = Library:Create('UICorner', {
			CornerRadius = UDim.new(0.075, 0),
			Parent = TabButton,
		})

		local TabButtonIcon = Library:Create('ImageLabel', {
			AnchorPoint = Vector2.new(0.5, 0.5),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Position = UDim2.new(0.5, 0, 0.5, 0),
			Size = UDim2.new(0, 40, 0, 40),
			Image = NewTabIcon,
			ImageColor3 = Color3.fromRGB(255, 255, 255),
			Parent = TabButton,
		})

		-- Container --

		local Container = Library:Create('ScrollingFrame', {
			BackgroundTransparency = 1,
			LayoutOrder = #Window.Tabs + 1,
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

		local ContainerLayout = Library:Create('UIListLayout', {
			FillDirection = Enum.FillDirection.Vertical,
			SortOrder = Enum.SortOrder.LayoutOrder,
			HorizontalAlignment = Enum.HorizontalAlignment.Left,
			VerticalAlignment = Enum.VerticalAlignment.Top,
			Parent = Container,
		})

		-- Functions --

		function Tab:Show()
			for _, Tab in next, Window.Tabs do
				Tab:Hide()
			end

			TabTitle.Text = NewTabName

			ContainerBoxLayout:JumpTo(Container)
			TweenService:Create(TabButton, TweenInfo.new(0.2), {BackgroundTransparency = 0}):Play()
			TweenService:Create(TabButtonIcon, TweenInfo.new(0.2), {ImageColor3 = Color3.fromRGB(255, 255, 255)}):Play()
		end

		function Tab:Hide()
			TweenService:Create(TabButton, TweenInfo.new(0.2), {BackgroundTransparency = 1}):Play()
			TweenService:Create(TabButtonIcon, TweenInfo.new(0.2), {ImageColor3 = Color3.fromRGB(255, 255, 255)}):Play()
		end

		TabButton.InputBegan:Connect(function(Input)
			if Input.UserInputType == Enum.UserInputType.MouseButton1 and not Library:MouseIsOverVisibleFrames() then
				Tab:Show()
			end
		end)

		Container.ChildAdded:Connect(function()
			Container.CanvasSize = UDim2.new(0, 0, 0, ContainerLayout.AbsoluteContentSize.Y + 35)
		end)

		if #TabsList:GetChildren() == 3 then
			Tab:Show()
		end

		Tab.Position = #Window.Tabs + 1
		Tab.Container = Container
		Window.Tabs[#Window.Tabs + 1] = Tab
		setmetatable(Tab, Functions)
		return Tab
	end

	function Library.Toggle()
		WindowFrame.Visible = not WindowFrame.Visible
	end

	TabsList.ChildAdded:Connect(function()
		TabsList.CanvasSize = UDim2.new(0, 0, 0, TabsLayout.AbsoluteContentSize.Y + 35)
	end)

	Library:MakeDraggable(WindowFrame, Header, 80)

	Library:GiveSignal(UserInputService.InputBegan:Connect(function(Input, Processed)
		if Input.KeyCode == Enum.KeyCode.RightControl or (Input.KeyCode == Enum.KeyCode.RightShift and (not Processed)) then
			task.spawn(Library.Toggle)
		end
	end))

	Toggle.MouseEnter:Connect(function()
		TweenService:Create(Toggle, TweenInfo.new(0.2), {BackgroundTransparency = 0}):Play()
		TweenService:Create(ToggleIcon, TweenInfo.new(0.2), {ImageColor3 = Color3.fromRGB(25, 25, 25)}):Play()
	end)

	Toggle.MouseLeave:Connect(function()
		TweenService:Create(Toggle, TweenInfo.new(0.2), {BackgroundTransparency = 1}):Play()
		TweenService:Create(ToggleIcon, TweenInfo.new(0.2), {ImageColor3 = Color3.fromRGB(157, 157, 157)}):Play()
	end)

	Toggle.Activated:Connect(function()
		task.spawn(Library.Toggle)
	end)

	return Window
end

return Library
