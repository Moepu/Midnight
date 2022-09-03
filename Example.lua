local Library = loadstring(game:HttpGet('https://raw.githubusercontent.com/Nexilist/Midnight/main/Library.lua'))()

local Window = Library:CreateWindow({Center = true}) -- No resize yet and very gigantous.

for i = 1, 2 do
    local Tab = Window:AddTab("Test", "rbxassetid://6523858394", "Description")

    local Button = Tab:AddButton("Test Button", function()
        warn("Button clicked")
    end)

    local Toggle = Tab:AddToggle("Test Toggle", false, function()
        warn("Toggle Button changed")
    end) --> Toggle.Value [true or false]

    local ToggleAndInput = Tab:AddToggleAndInput("Test Toggle and TextBox", {
        BoolDefault = true,
        InputDefault = "Test",
        Numeric = false,
        MinLength = 1,
        MaxLength = 8,
        Finished = false,
    }, function()
        warn("Test Toggle and TextBox changed")
    end) --> Toggle.BoolValue [true or false] | Toggle.InputValue [string]

    local Dropdown = Tab:AddDropdown("Test Dropdown", {
        Values = {"Selection 1", "Selection 2", "Selection 3", "Selection 4", "Selection 5"},
        Default = 1,
        Multi = false,
        AllowNull = false,
        MaxItems = 8
    }, function()
        warn("Dropdown changed")
    end) --> Dropdown.Value [table]

    local MultiDropdown = Tab:AddDropdown("Test Multi Dropdown", {
        Values = {"Selection 1", "Selection 2", "Selection 3", "Selection 4", "Selection 5"},
        Multi = true,
        Default = {1, 3},
        MaxShow = 3,
        AllowNull = false,
        MaxItems = 8
    }, function()
        warn("Multi Dropdown changed")
    end) --> MultiDropdown.Value [table]

    local Input = Tab:AddInput("Test Input", {
        Default = "Test",
        Numeric = false,
        MinLength = 1,
        MaxLength = 8,
        Finished = false,
    }, function()
        warn("Input changed")
    end) --> Input.Value [string]

    local Slider = Tab:AddSlider("Test Slider", {
        Default = 10,
        Min = 0,
        Max = 50,
        Rounding = 0,
        Suffix = "m",
    }, function()
        warn("Slider changed")
    end) --> Slider.Value [int]

    local Keypicker = Tab:AddKeybindPicker("Test Keypicker", {
        Default = "MB1"
    }, function()
        warn("Keypicker changed")
    end) --> Keypicker.Value [string] (Name of the KeyCode)

    local ColorPicker = Tab:AddColorPicker("Test Color Picker", {
        Default = Color3.fromRGB(255, 255, 255)
    }, function()
        warn("Color Picker changed")
    end) --> ColorPicker.Value [Color3]
end
