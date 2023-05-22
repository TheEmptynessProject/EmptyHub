local custom =
    loadstring(
    game:HttpGet(
        "https://raw.githubusercontent.com/TheEmptynessProject/EmptynessProject/main/emptynessHub/customFunctions.lua"
    )
)()

local inputService = game:GetService("UserInputService")
local tweenService = game:GetService("TweenService")
local runService = game:GetService("RunService")
local coreGui = game:GetService("CoreGui")

local library = {toggleBind = Enum.KeyCode.Q, closeBind = Enum.KeyCode.P, dragSpeed = 0.3}

local themes = {
    Default = {
        TextColor = Color3.fromRGB(255, 255, 255),
        MainFrame = Color3.fromRGB(0, 0, 0),
        TabBackground = Color3.fromRGB(25, 25, 25),
        Tab = Color3.fromRGB(0, 0, 0),
        EnabledText = Color3.fromRGB(255, 255, 255),
        DisabledText = Color3.fromRGB(180, 180, 180),
        TabToggleEnabled = Color3.fromRGB(0, 0, 0),
        TabToggleDisabled = Color3.fromRGB(10, 10, 10),
        TabToggleDisabledMouseOver = Color3.fromRGB(25, 25, 25),
        Section = Color3.fromRGB(25, 25, 25),
        Button = Color3.fromRGB(0, 0, 0),
        ButtonMouseOver = Color3.fromRGB(25, 25, 25),
        ToggleEnabled = Color3.fromRGB(99, 129, 169),
        ToggleEnabledMouseOver = Color3.fromRGB(99, 159, 178),
        ToggleDisabled = Color3.fromRGB(0, 0, 0),
        ToggleDisabledMouseOver = Color3.fromRGB(25, 25, 25),
        Box = Color3.fromRGB(0, 0, 0),
        BoxFocused = Color3.fromRGB(25, 25, 25),
        Slider = Color3.fromRGB(0, 0, 0),
        SliderMouseOver = Color3.fromRGB(25, 25, 25),
        SliderFill = Color3.fromRGB(49, 99, 138),
        SliderFillSliding = Color3.fromRGB(99, 159, 178),
        Dropdown = Color3.fromRGB(0, 0, 0),
        DropdownMouseOver = Color3.fromRGB(25, 25, 25),
        DropdownContent = Color3.fromRGB(25, 25, 25)
    }
}

function _destroy()
    if (coreGui:FindFirstChild(custom.generateString(32, 1))) then
        coreGui[custom.generateString(32, 1)]:Destroy()
    end
    getgenv()[custom.generateString(32, 0)] = false
end

if getgenv()[custom.generateString(32, 0)] then
    _destroy()
else
    getgenv()[custom.generateString(32, 0)] = false
end

local themeObjects = {}
for i, v in next, themes.Default do
    themeObjects[i] = {}
end

-----------------------------------------------------------------------------------------------------------------------------------------------------------------
emptyCustoms = custom.createObject("ScreenGui", {})
emptyCustoms.Parent = game:GetService("CoreGui")
emptyCustoms.Name = custom.generateString(32, 1)
library = custom.formatTable(library)

inputService.InputBegan:Connect(
    function(input)
        if input.KeyCode == library.toggleBind then
            emptyCustoms.Enabled = not emptyCustoms.Enabled
        elseif input.KeyCode == library.closeBind then
            emptyCustoms:Destroy()
        end
    end
)
function library:New(opts)
    getgenv()[custom.generateString(32, 0)] = true
    local options = custom.formatTable(opts)
    local name = options.name
    local sizeX = options.sizeX or 440
    local sizeY = options.sizeY or 480
    local theme = options.theme or themes.Default
    local fonted = options.font or Enum.Font.Ubuntu

    local holder =
        custom.createObject(
        "Frame",
        {
            Size = UDim2.new(0, sizeX, 0, 26),
            BackgroundTransparency = 1,
            Position = custom.getCenterPosition(sizeX, sizeY),
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            Parent = emptyCustoms
        }
    )

    local title =
        custom.createObject(
        "TextLabel",
        {
            Size = UDim2.new(0, 1, 1, 0),
            BackgroundTransparency = 1,
            Position = UDim2.new(0, 8, 0, 0),
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            FontSize = Enum.FontSize.Size14,
            TextSize = 20,
            TextColor3 = theme.TextColor,
            Text = name,
            Font = fonted,
            TextXAlignment = Enum.TextXAlignment.Left,
            ZIndex = 2,
            Parent = holder
        }
    )

    spawn(
        function()
            while true do
                for i = 0, 1, 1 / 5000 do
                    title.TextColor3 = Color3.fromHSV(i, 1, 1)
                    wait()
                end
            end
        end
    )

    custom.enableDrag(holder, library.dragSpeed)

    local main =
        custom.createObject(
        "Frame",
        {
            Size = UDim2.new(1, 0, 0, sizeY),
            BackgroundColor3 = theme.MainFrame,
            Parent = holder
        }
    )

    custom.createObject(
        "UICorner",
        {
            CornerRadius = UDim.new(0, 4),
            Parent = main
        }
    )

    local tabs =
        custom.createObject(
        "Frame",
        {
            ZIndex = 2,
            Size = UDim2.new(1, -16, 1, -34),
            Position = UDim2.new(0, 8, 0, 26),
            BackgroundColor3 = theme.TabBackground,
            Parent = main
        }
    )

    custom.createObject(
        "UICorner",
        {
            CornerRadius = UDim.new(0, 4),
            Parent = tabs
        }
    )

    local tabToggles =
        custom.createObject(
        "Frame",
        {
            Size = UDim2.new(1, -12, 0, 18),
            BackgroundTransparency = 1,
            Position = UDim2.new(0, 6, 0, 6),
            Parent = tabs
        }
    )

    local tabFrames =
        custom.createObject(
        "Frame",
        {
            ZIndex = 4,
            Size = UDim2.new(1, -12, 1, -29),
            Position = UDim2.new(0, 6, 0, 24),
            BackgroundColor3 = theme.Tab,
            Parent = tabs
        }
    )

    custom.createObject(
        "UICorner",
        {
            Parent = tabFrames
        }
    )

    local tabFrameHolder =
        custom.createObject(
        "Frame",
        {
            Size = UDim2.new(1, -12, 1, -12),
            BackgroundTransparency = 1,
            Position = UDim2.new(0, 6, 0, 6),
            BackgroundColor3 = Color3.fromRGB(20, 20, 20),
            Parent = tabFrames
        }
    )

    custom.createObject(
        "UIListLayout",
        {
            FillDirection = Enum.FillDirection.Horizontal,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, 4),
            Parent = tabToggles
        }
    )

    local window_info = {count = 0}
    window_info = custom.formatTable(window_info)

    function window_info:NewTab(name)
        window_info.count = window_info.count + 1
        local toggled = window_info.count == 1

        local tabToggle =
            custom.createObject(
            "TextButton",
            {
                ZIndex = 4,
                BackgroundColor3 = toggled and theme.TabToggleEnabled or theme.TabToggleDisabled,
                Size = UDim2.new(0, 52, 1, 0),
                FontSize = Enum.FontSize.Size12,
                TextSize = 12,
                TextColor3 = toggled and theme.EnabledText or theme.DisabledText,
                Text = name,
                Font = fonted,
                Parent = tabToggles
            }
        )

        if tabToggle.TextBounds.X + 16 > 52 then
            tabToggle.Size = UDim2.new(0, tabToggle.TextBounds.X + 16, 1, 0)
        end

        local noround =
            custom.createObject(
            "Frame",
            {
                ZIndex = 3,
                Size = UDim2.new(1, 0, 1, 5),
                Position = UDim2.new(0, 0, 1, -10),
                BackgroundColor3 = toggled and theme.TabToggleEnabled or theme.TabToggleDisabled,
                Parent = tabToggle
            }
        )

        tabToggle:GetPropertyChangedSignal("BackgroundColor3"):Connect(
            function()
                noround.BackgroundColor3 = tabToggle.BackgroundColor3
            end
        )

        custom.createObject(
            "UICorner",
            {
                CornerRadius = UDim.new(0, 2),
                Parent = tabToggle
            }
        )

        local tab =
            custom.createObject(
            "Frame",
            {
                Size = UDim2.new(1, 0, 1, 0),
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                Visible = toggled,
                Parent = tabFrameHolder
            }
        )

        custom.createObject(
            "UIListLayout",
            {
                FillDirection = Enum.FillDirection.Horizontal,
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0, 6),
                Parent = tab
            }
        )

        local column1 =
            custom.createObject(
            "ScrollingFrame",
            {
                Size = UDim2.new(0.5, -3, 1, 0),
                BackgroundTransparency = 1,
                Active = true,
                ScrollBarThickness = 0,
                CanvasSize = UDim2.new(0, 0, 0, 0),
                Parent = tab
            }
        )

        local column1list =
            custom.createObject(
            "UIListLayout",
            {
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0, 6),
                Parent = column1
            }
        )

        column1list:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(
            function()
                column1.CanvasSize = UDim2.new(0, 0, 0, column1list.AbsoluteContentSize.Y)
            end
        )

        local column2 =
            custom.createObject(
            "ScrollingFrame",
            {
                Size = UDim2.new(0.5, -3, 1, 0),
                BackgroundTransparency = 1,
                Active = true,
                ScrollBarThickness = 0,
                CanvasSize = UDim2.new(0, 0, 0, 0),
                Parent = tab
            }
        )

        local column2list =
            custom.createObject(
            "UIListLayout",
            {
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0, 6),
                Parent = column2
            }
        )

        column2list:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(
            function()
                column2.CanvasSize = UDim2.new(0, 0, 0, column2list.AbsoluteContentSize.Y)
            end
        )

        local function toggleTab()
            for i, v in next, tabFrameHolder:GetChildren() do
                if v ~= tab then
                    v.Visible = false
                end
            end

            tab.Visible = true

            for i, v in next, tabToggles:GetChildren() do
                if v:IsA("TextButton") then
                    if v ~= tabToggle then
                        custom.animate(
                            v,
                            {0.2},
                            {TextColor3 = theme.DisabledText, BackgroundColor3 = theme.TabToggleDisabled}
                        )
                    end
                end
            end

            custom.animate(
                tabToggle,
                {0.2},
                {TextColor3 = theme.EnabledText, BackgroundColor3 = theme.TabToggleEnabled}
            )
        end

        tabToggle.MouseButton1Click:Connect(toggleTab)

        tabToggle.MouseEnter:Connect(
            function()
                if not tab.Visible then
                    custom.animate(tabToggle, {0.2}, {BackgroundColor3 = theme.TabToggleDisabledMouseOver})
                end
            end
        )

        tabToggle.MouseLeave:Connect(
            function()
                if not tab.Visible then
                    custom.animate(tabToggle, {0.2}, {BackgroundColor3 = theme.TabToggleDisabled})
                end
            end
        )

        local tab_info = {}
        tab_info = custom.formatTable(tab_info)

        function tab_info:Open()
            toggleTab()
        end

        function tab_info:NewSection(opts)
            local options = custom.formatTable(opts)
            local name = options.name
            local column = options.column or 1
            column = column == 1 and column1 or column == 2 and column2

            local section =
                custom.createObject(
                "Frame",
                {
                    ZIndex = 5,
                    Size = UDim2.new(1, 0, 0, 24),
                    BackgroundColor3 = theme.Section,
                    Parent = column
                }
            )

            custom.createObject(
                "UICorner",
                {
                    CornerRadius = UDim.new(0, 4),
                    Parent = section
                }
            )

            custom.createObject(
                "TextLabel",
                {
                    ZIndex = 6,
                    Size = UDim2.new(0, 1, 0, 16),
                    BackgroundTransparency = 1,
                    Position = UDim2.new(0, 8, 0, 4),
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    FontSize = Enum.FontSize.Size12,
                    TextSize = 12,
                    TextColor3 = theme.TextColor,
                    Text = name,
                    Font = fonted,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Parent = section
                }
            )

            local sectionContent =
                custom.createObject(
                "Frame",
                {
                    Size = UDim2.new(1, -10, 1, -24),
                    Position = UDim2.new(0, 5, 0, 22),
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    Parent = section
                }
            )

            local sectionContentList =
                custom.createObject(
                "UIListLayout",
                {
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    Padding = UDim.new(0, 6),
                    Parent = sectionContent
                }
            )

            sectionContentList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(
                function()
                    section.Size = UDim2.new(1, 0, 0, sectionContentList.AbsoluteContentSize.Y + 27)
                end
            )

            local section_info = {}
            section_info = custom.formatTable(section_info)

            function section_info:Hide()
                section.Visible = false
            end

            function section_info:Show()
                section.Visible = true
            end

            function section_info:CreateLabel(text)
                local label =
                    custom.createObject(
                    "TextLabel",
                    {
                        ZIndex = 6,
                        Size = UDim2.new(1, 0, 0, 10),
                        BackgroundTransparency = 1,
                        Position = UDim2.new(1, 5, 0, 0),
                        FontSize = Enum.FontSize.Size12,
                        TextSize = 12,
                        Text = text,
                        TextColor3 = theme.TextColor,
                        Font = fonted,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        Parent = sectionContent
                    }
                )

                local label_info = {}
                label_info = custom.formatTable(label_info)

                function label_info:Hide()
                    label.Visible = false
                end

                function label_info:Show()
                    label.Visible = true
                end

                return label_info
            end
            function section_info:CreateLine(px, color)
                local separator =
                    custom.createObject(
                    "Frame",
                    {
                        ZIndex = 6,
                        Size = UDim2.new(1, 0, 0, px),
                        BackgroundColor3 = color,
                        Parent = sectionContent
                    }
                )

                local separator_info = {}
                separator_info = custom.formatTable(separator_info)

                function separator_info:Hide()
                    separator.Visible = false
                end

                function separator_info:Show()
                    separator.Visible = true
                end

                return separator_info
            end
            function section_info:CreateButton(opts)
                local options = custom.formatTable(opts)
                local name = options.name
                local callback = options.callback

                local button =
                    custom.createObject(
                    "TextButton",
                    {
                        ZIndex = 6,
                        Size = UDim2.new(1, 0, 0, 16),
                        BackgroundColor3 = theme.Button,
                        FontSize = Enum.FontSize.Size12,
                        TextSize = 12,
                        Text = name,
                        TextColor3 = theme.TextColor,
                        Font = fonted,
                        ClipsDescendants = true,
                        Parent = sectionContent
                    }
                )

                custom.createObject(
                    "UICorner",
                    {
                        CornerRadius = UDim.new(0, 2),
                        Parent = button
                    }
                )

                button.MouseButton1Click:Connect(
                    function()
                        callback()
                        custom.createRipple(button)
                    end
                )
                button.MouseEnter:Connect(
                    function()
                        custom.animate(button, {0.2}, {BackgroundColor3 = theme.ButtonMouseOver})
                    end
                )

                button.MouseLeave:Connect(
                    function()
                        custom.animate(button, {0.2}, {BackgroundColor3 = theme.Button})
                    end
                )

                local button_info = {}
                button_info = custom.formatTable(button_info)

                function button_info:Hide()
                    button.Visible = false
                end

                function button_info:Show()
                    button.Visible = true
                end

                function button_info:Click()
                    callback()
                end

                return button_info
            end

            function section_info:CreateToggle(opts)
                local options = custom.formatTable(opts)
                local name = options.name
                local callback = options.callback or function()
                    end

                local toggled = false
                local mouseOver = false

                local toggle =
                    custom.createObject(
                    "TextButton",
                    {
                        Size = UDim2.new(1, 0, 0, 10),
                        BackgroundTransparency = 1,
                        FontSize = Enum.FontSize.Size14,
                        TextSize = 14,
                        Text = "",
                        Font = Enum.Font.SourceSans,
                        Parent = sectionContent
                    }
                )

                local icon =
                    custom.createObject(
                    "Frame",
                    {
                        ZIndex = 6,
                        Size = UDim2.new(0, 10, 0, 10),
                        BackgroundColor3 = theme.ToggleDisabled,
                        Parent = toggle
                    }
                )

                custom.createObject(
                    "UICorner",
                    {
                        CornerRadius = UDim.new(0, 4),
                        Parent = icon
                    }
                )

                local title =
                    custom.createObject(
                    "TextLabel",
                    {
                        ZIndex = 6,
                        Size = UDim2.new(0, 1, 0, 10),
                        BackgroundTransparency = 1,
                        Position = UDim2.new(1, 5, 0, 0),
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        FontSize = Enum.FontSize.Size12,
                        TextSize = 12,
                        TextColor3 = theme.DisabledText,
                        Text = name,
                        Font = fonted,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        Parent = icon
                    }
                )

                local function toggleToggle()
                    toggled = not toggled

                    custom.animate(title, {0.2}, {TextColor3 = toggled and theme.EnabledText or theme.DisabledText})

                    if not mouseOver then
                        custom.animate(
                            icon,
                            {0.2},
                            {BackgroundColor3 = toggled and theme.ToggleEnabled or theme.ToggleDisabled}
                        )
                    else
                        custom.animate(
                            icon,
                            {0.2},
                            {
                                BackgroundColor3 = toggled and theme.ToggleEnabledMouseOver or
                                    theme.ToggleDisabledMouseOver
                            }
                        )
                    end

                    callback(toggled)
                end

                toggle.MouseButton1Click:connect(toggleToggle)

                toggle.MouseEnter:Connect(
                    function()
                        mouseOver = true
                        custom.animate(
                            icon,
                            {0.2},
                            {
                                BackgroundColor3 = toggled and theme.ToggleEnabledMouseOver or
                                    theme.ToggleDisabledMouseOver
                            }
                        )
                    end
                )

                toggle.MouseLeave:Connect(
                    function()
                        mouseOver = false
                        custom.animate(
                            icon,
                            {0.2},
                            {BackgroundColor3 = toggled and theme.ToggleEnabled or theme.ToggleDisabled}
                        )
                    end
                )

                local toggle_info = {}
                toggle_info = custom.formatTable(toggle_info)

                function toggle_info:Toggle(bool)
                    if toggled ~= bool then
                        toggleToggle()
                    end
                end

                function toggle_info:Hide()
                    toggle.Visible = false
                end

                function toggle_info:Show()
                    toggle.Visible = true
                end

                return toggle_info
            end

            function section_info:CreateBox(opts)
                local options = custom.formatTable(opts)
                local placeholder = options.name or options.placeholder
                local default = options.default or ""
                local callback = options.callback or nil

                local mouseOver = false
                local focused = false

                local box =
                    custom.createObject(
                    "TextBox",
                    {
                        ZIndex = 6,
                        Size = UDim2.new(1, 0, 0, 16),
                        BackgroundColor3 = theme.Box,
                        PlaceholderColor3 = Color3.fromRGB(180, 180, 180),
                        FontSize = Enum.FontSize.Size12,
                        TextSize = 12,
                        TextColor3 = theme.TextColor,
                        Text = "",
                        Font = fonted,
                        PlaceholderText = placeholder,
                        Parent = sectionContent
                    }
                )
                custom.createObject(
                    "UICorner",
                    {
                        CornerRadius = UDim.new(0, 2),
                        Parent = box
                    }
                )

                local function boxFinished()
                    focused = false

                    if not mouseOver then
                        custom.animate(box, {0.2}, {BackgroundColor3 = theme.Box})
                    end
                    callback(box.Text)
                end

                box.Focused:Connect(
                    function()
                        focused = true
                        custom.animate(box, {0.2}, {BackgroundColor3 = theme.BoxFocused})
                    end
                )

                box.MouseEnter:Connect(
                    function()
                        mouseOver = true
                        custom.animate(box, {0.2}, {BackgroundColor3 = theme.BoxFocused})
                    end
                )

                box.MouseLeave:Connect(
                    function()
                        mouseOver = false
                        if not focused then
                            custom.animate(box, {0.2}, {BackgroundColor3 = theme.Box})
                        end
                    end
                )

                box.FocusLost:Connect(boxFinished)

                local box_info = {}
                box_info = custom.formatTable(box_info)

                function box_info:Set(text)
                    box.Text = text
                    boxFinished()
                end

                function box_info:Hide()
                    box.Visible = false
                end

                function box_info:Show()
                    box.Visible = true
                end

                return box_info
            end

            function section_info:CreateSlider(opts)
                local options = custom.formatTable(opts)
                local name = options.name
                local min = options.min or 1
                local max = options.max or 100
                local decimals = options.decimals or 0.1
                local default = options.default and math.clamp(options.default, min, max) or min
                local valueType = options.valueType or "/" .. tostring(max)
                local callback = options.callback or function()
                    end

                local slider =
                    custom.createObject(
                    "Frame",
                    {
                        ZIndex = 6,
                        Size = UDim2.new(1, 0, 0, 16),
                        ClipsDescendants = true,
                        BackgroundColor3 = theme.Slider,
                        Parent = sectionContent
                    }
                )

                local fill =
                    custom.createObject(
                    "Frame",
                    {
                        ZIndex = 7,
                        Size = UDim2.new((default - min) / (max - min), 0, 1, 0),
                        BackgroundColor3 = theme.SliderFill,
                        Parent = slider
                    }
                )

                local title =
                    custom.createObject(
                    "TextLabel",
                    {
                        ZIndex = 8,
                        Size = UDim2.new(1, 0, 1, 0),
                        BackgroundTransparency = 1,
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        FontSize = Enum.FontSize.Size12,
                        TextSize = 12,
                        TextColor3 = theme.TextColor,
                        Text = name .. ": " .. default .. valueType,
                        Font = fonted,
                        Parent = slider
                    }
                )

                local function slide(input)
                    local sizeX =
                        math.clamp((input.Position.X - slider.AbsolutePosition.X) / slider.AbsoluteSize.X, 0, 1)
                    custom.animate(fill, {0.3}, {Size = UDim2.new(sizeX, 0, 1, 0)})

                    local value = math.floor((((max - min) * sizeX) + min) * (decimals * 10)) / (decimals * 10)
                    title.Text = name .. ": " .. value .. valueType

                    callback(value)
                end

                slider.InputBegan:Connect(
                    function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            custom.animate(fill, {0.2}, {BackgroundColor3 = theme.SliderFillSliding})
                            slide(input)
                        end
                    end
                )

                slider.InputEnded:Connect(
                    function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            custom.animate(fill, {0.2}, {BackgroundColor3 = theme.SliderFill})
                            if not input:IsMouseOver() then
                                custom.animate(slider, {0.2}, {BackgroundColor3 = theme.Slider})
                            end
                        end
                    end
                )

                slider.MouseEnter:Connect(
                    function()
                        custom.animate(slider, {0.2}, {BackgroundColor3 = theme.SliderMouseOver})
                    end
                )

                slider.MouseLeave:Connect(
                    function()
                        if not slider.InputBegan:FindFirstAncestorWhichIsA("TextButton") then
                            custom.animate(slider, {0.2}, {BackgroundColor3 = theme.Slider})
                        end
                    end
                )

                inputService.InputChanged:Connect(
                    function(input)
                        if
                            input.UserInputType == Enum.UserInputType.MouseMovement and
                                slider:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)
                         then
                            slide(input)
                        end
                    end
                )

                local slider_info = {}

                function slider_info:Set(value)
                    value = math.floor(value * (decimals * 10)) / (decimals * 10)
                    value = math.clamp(value, min, max)

                    fill.Size = UDim2.new((value - min) / (max - min), 0, 1, 0)
                    title.Text = name .. ": " .. value .. valueType
                end

                function slider_info:Hide()
                    slider.Visible = false
                end

                function slider_info:Show()
                    slider.Visible = true
                end

                return slider_info
            end

            function section_info:CreateDropdown(opts)
                local options = custom.formatTable(opts)
                local default = options.default or nil
                local contentTable = options.content or {}
                local multiChoice = options.multiChoice or false
                local callback = options.callback or function()
                    end

                local chosen = {}
                local curValue = default
                local open = false
                local optionInstances = {}

                local defaultInContent = false

                for i, v in next, contentTable do
                    if v == default then
                        defaultInContent = true
                    end
                end

                default = defaultInContent and default or nil

                local dropdown =
                    custom.createObject(
                    "TextButton",
                    {
                        ZIndex = 6,
                        Size = UDim2.new(1, 0, 0, 16),
                        BackgroundColor3 = theme.Dropdown,
                        FontSize = Enum.FontSize.Size12,
                        TextSize = 12,
                        TextColor3 = theme.TextColor,
                        Text = "",
                        Font = fonted,
                        Parent = sectionContent
                    }
                )

                custom.createObject(
                    "UICorner",
                    {
                        CornerRadius = UDim.new(0, 2),
                        Parent = dropdown
                    }
                )

                local value =
                    custom.createObject(
                    "TextLabel",
                    {
                        ZIndex = 7,
                        Size = UDim2.new(0, 0, 1, 0),
                        BackgroundTransparency = 1,
                        Position = UDim2.new(0, 5, 0, 0),
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        FontSize = Enum.FontSize.Size12,
                        TextSize = 12,
                        TextColor3 = default and theme.EnabledText or theme.DisabledText,
                        Text = default or "NONE",
                        Font = fonted,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        Parent = dropdown
                    }
                )

                local icon =
                    custom.createObject(
                    "ImageLabel",
                    {
                        ZIndex = 7,
                        Size = UDim2.new(0, 10, 0, 11),
                        Rotation = 180,
                        BackgroundTransparency = 1,
                        Position = UDim2.new(1, -16, 0, 3),
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        Parent = dropdown
                    }
                )

                local content =
                    custom.createObject(
                    "Frame",
                    {
                        ZIndex = 10,
                        Visible = false,
                        Size = UDim2.new(1, 0, 0, 0),
                        ClipsDescendants = true,
                        Position = UDim2.new(0, 0, 1, 6),
                        BackgroundColor3 = theme.DropdownContent,
                        Parent = dropdown
                    }
                )

                custom.createObject(
                    "UICorner",
                    {
                        CornerRadius = UDim.new(0, 2),
                        Parent = content
                    }
                )

                local contentHolder =
                    custom.createObject(
                    "Frame",
                    {
                        Size = UDim2.new(1, -6, 1, 0),
                        Position = UDim2.new(0, 6, 0, 0),
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        Parent = content
                    }
                )

                local contentList =
                    custom.createObject(
                    "UIListLayout",
                    {
                        SortOrder = Enum.SortOrder.LayoutOrder,
                        Parent = contentHolder
                    }
                )

                local function toggleDropdown()
                    open = not open
                    local sizeX = UDim2.new(1, 0, 0, open and contentList.AbsoluteContentSize.Y or 0)
                    local rotation = open and 0 or 180

                    if open then
                        content.Visible = open
                    end

                    custom.animate(
                        content,
                        {#contentTable * 0.1},
                        {Size = sizeX},
                        function()
                            content.Visible = open
                        end
                    )
                    custom.animate(icon, {0.2}, {Rotation = rotation})
                end

                dropdown.MouseButton1Click:connect(toggleDropdown)

                dropdown.MouseEnter:Connect(
                    function()
                        custom.animate(dropdown, {0.2}, {BackgroundColor3 = theme.DropdownMouseOver})
                    end
                )

                dropdown.MouseLeave:Connect(
                    function()
                        custom.animate(dropdown, {0.2}, {BackgroundColor3 = theme.Dropdown})
                    end
                )

                for i, v in next, contentTable do
                    local option =
                        custom.createObject(
                        "TextButton",
                        {
                            ZIndex = 11,
                            Size = UDim2.new(1, 0, 0, 16),
                            BackgroundTransparency = 1,
                            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                            FontSize = Enum.FontSize.Size12,
                            TextSize = 12,
                            TextColor3 = v == default and theme.EnabledText or theme.DisabledText,
                            Text = v,
                            Font = fonted,
                            TextXAlignment = Enum.TextXAlignment.Left,
                            Parent = contentHolder
                        }
                    )

                    optionInstances[v] = option

                    if v == default then
                        if not multiChoice then
                            callback(v)
                        else
                            table.insert(chosen, v)

                            callback(chosen)
                        end
                    end

                    option.MouseButton1Click:connect(
                        function()
                            if not multiChoice then
                                if curValue ~= v then
                                    curValue = v

                                    for i2, v2 in next, contentHolder:GetChildren() do
                                        if v2:IsA("TextButton") then
                                            custom.animate(v2, {0.2}, {TextColor3 = theme.DisabledText})
                                        end
                                    end

                                    custom.animate(option, {0.2}, {TextColor3 = theme.EnabledText})

                                    custom.animate(
                                        value,
                                        {0.2},
                                        {TextTransparency = 1},
                                        function()
                                            value.TextColor3 = theme.EnabledText
                                            value.Text = v
                                            custom.animate(value, {0.2}, {TextTransparency = 0})
                                        end
                                    )

                                    callback(v)
                                else
                                    curValue = nil
                                    custom.animate(option, {0.2}, {TextColor3 = theme.DisabledText})

                                    custom.animate(
                                        value,
                                        {0.2},
                                        {TextTransparency = 1},
                                        function()
                                            value.TextColor3 = theme.DisabledText
                                            value.Text = "NONE"
                                            custom.animate(value, {0.2}, {TextTransparency = 0})
                                        end
                                    )

                                    callback(nil)
                                end
                            else
                                if table.find(chosen, v) then
                                    for i, v2 in next, chosen do
                                        if v2 == v then
                                            table.remove(chosen, i)
                                        end
                                    end

                                    custom.animate(option, {0.2}, {TextColor3 = theme.DisabledText})

                                    custom.animate(
                                        value,
                                        {0.2},
                                        {TextTransparency = 1},
                                        function()
                                            value.TextColor3 =
                                                table.concat(chosen) ~= "" and theme.EnabledText or theme.DisabledText
                                            value.Text =
                                                table.concat(chosen) ~= "" and table.concat(chosen, ", ") or "NONE"
                                            custom.animate(value, {0.2}, {TextTransparency = 0})
                                        end
                                    )

                                    callback(chosen)
                                else
                                    table.insert(chosen, v)

                                    custom.animate(option, {0.2}, {TextColor3 = theme.EnabledText})

                                    custom.animate(
                                        value,
                                        {0.2},
                                        {TextTransparency = 1},
                                        function()
                                            value.TextColor3 =
                                                table.concat(chosen) ~= "" and theme.EnabledText or theme.DisabledText
                                            value.Text =
                                                table.concat(chosen) ~= "" and table.concat(chosen, ", ") or "NONE"
                                            custom.animate(value, {0.2}, {TextTransparency = 0})
                                        end
                                    )

                                    callback(chosen)
                                end
                            end
                        end
                    )
                end

                local dropdown_info = {}
                dropdown_info = custom.formatTable(dropdown_info)

                function dropdown_info:Set(opt)
                    if opt ~= nil then
                        if not multiChoice then
                            local optionExists = false

                            for i, v in next, contentTable do
                                if v == opt then
                                    optionExists = true
                                end
                            end

                            local option = optionInstances[opt]

                            if optionExists then
                                curValue = opt

                                for i2, v2 in next, contentHolder:GetChildren() do
                                    if v2:IsA("TextButton") then
                                        v2.TextColor3 = theme.DisabledText
                                    end
                                end

                                custom.animate(option, {0.2}, {TextColor3 = theme.EnabledText})

                                custom.animate(
                                    value,
                                    {0.2},
                                    {TextTransparency = 1},
                                    function()
                                        value.TextColor3 = theme.EnabledText
                                        value.Text = opt
                                        custom.animate(value, {0.2}, {TextTransparency = 0})
                                    end
                                )

                                callback(opt)
                            end
                        else
                            if typeof(opt) == "table" then
                                chosen = opt

                                for i, v in next, chosen do
                                    custom.animate(optionInstances[v], {0.2}, {TextColor3 = theme.EnabledText})
                                end
                            else
                                if not table.find(chosen, opt) then
                                    table.insert(chosen, opt)

                                    custom.animate(optionInstances[opt], {0.2}, {TextColor3 = theme.EnabledText})
                                end
                            end

                            custom.animate(
                                value,
                                {0.2},
                                {TextTransparency = 1},
                                function()
                                    value.TextColor3 = theme.EnabledText
                                    value.Text = table.concat(chosen, ", ")
                                    custom.animate(value, {0.2}, {TextTransparency = 0})
                                end
                            )

                            callback(chosen)
                        end
                    else
                        if not multiChoice then
                            curValue = nil
                            for i2, v2 in next, contentHolder:GetChildren() do
                                if v2:IsA("TextButton") then
                                    custom.animate(v2, {0.2}, {TextColor3 = theme.DisabledText})
                                end
                            end

                            custom.animate(
                                value,
                                {0.2},
                                {TextTransparency = 1},
                                function()
                                    value.TextColor3 = theme.DisabledText
                                    value.Text = "NONE"
                                    custom.animate(value, {0.2}, {TextTransparency = 0})
                                end
                            )

                            callback(nil)
                        else
                            chosen = {}

                            for i2, v2 in next, contentHolder:GetChildren() do
                                if v2:IsA("TextButton") then
                                    v2.TextColor3 = theme.DisabledText
                                end
                            end

                            custom.animate(
                                value,
                                {0.2},
                                {TextTransparency = 1},
                                function()
                                    value.TextColor3 = theme.DisabledText
                                    value.Text = "NONE"
                                    custom.animate(value, {0.2}, {TextTransparency = 0})
                                end
                            )

                            callback(chosen)
                        end
                    end
                end

                function dropdown_info:Refresh(tbl)
                    contentTable = tbl

                    for i, v in next, optionInstances do
                        v:Destroy()
                    end

                    custom.animate(
                        value,
                        {0.2},
                        {TextTransparency = 1},
                        function()
                            value.TextColor3 = theme.DisabledText
                            value.Text = "NONE"
                            custom.animate(value, {0.2}, {TextTransparency = 0})
                        end
                    )

                    for i, v in next, contentTable do
                        local option =
                            custom.createObject(
                            "TextButton",
                            {
                                ZIndex = 11,
                                Size = UDim2.new(1, 0, 0, 16),
                                BackgroundTransparency = 1,
                                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                                FontSize = Enum.FontSize.Size12,
                                TextSize = 12,
                                TextColor3 = v == default and theme.EnabledText or theme.DisabledText,
                                Text = v,
                                Font = fonted,
                                TextXAlignment = Enum.TextXAlignment.Left,
                                Parent = contentHolder
                            }
                        )

                        optionInstances[v] = option

                        if v == default then
                            if not multiChoice then
                                callback(v)
                            else
                                table.insert(chosen, v)

                                callback(chosen)
                            end
                        end

                        option.MouseButton1Click:connect(
                            function()
                                if not multiChoice then
                                    if curValue ~= v then
                                        curValue = v

                                        for i2, v2 in next, contentHolder:GetChildren() do
                                            if v2:IsA("TextButton") then
                                                custom.animate(v2, {0.2}, {TextColor3 = theme.DisabledText})
                                            end
                                        end

                                        custom.animate(option, {0.2}, {TextColor3 = theme.EnabledText})

                                        custom.animate(
                                            value,
                                            {0.2},
                                            {TextTransparency = 1},
                                            function()
                                                value.TextColor3 = theme.EnabledText
                                                value.Text = v
                                                custom.animate(value, {0.2}, {TextTransparency = 0})
                                            end
                                        )

                                        callback(v)
                                    else
                                        curValue = nil
                                        custom.animate(option, {0.2}, {TextColor3 = theme.DisabledText})

                                        custom.animate(
                                            value,
                                            {0.2},
                                            {TextTransparency = 1},
                                            function()
                                                value.TextColor3 = theme.DisabledText
                                                value.Text = "NONE"
                                                custom.animate(value, {0.2}, {TextTransparency = 0})
                                            end
                                        )

                                        callback(nil)
                                    end
                                else
                                    if table.find(chosen, v) then
                                        for i, v2 in next, chosen do
                                            if v2 == v then
                                                table.remove(chosen, i)
                                            end
                                        end

                                        custom.animate(option, {0.2}, {TextColor3 = theme.DisabledText})

                                        custom.animate(
                                            value,
                                            {0.2},
                                            {TextTransparency = 1},
                                            function()
                                                value.TextColor3 =
                                                    table.concat(chosen) ~= "" and theme.EnabledText or
                                                    theme.DisabledText
                                                value.Text =
                                                    table.concat(chosen) ~= "" and table.concat(chosen, ", ") or "NONE"
                                                custom.animate(value, {0.2}, {TextTransparency = 0})
                                            end
                                        )

                                        callback(chosen)
                                    else
                                        table.insert(chosen, v)

                                        custom.animate(option, {0.2}, {TextColor3 = theme.EnabledText})

                                        custom.animate(
                                            value,
                                            {0.2},
                                            {TextTransparency = 1},
                                            function()
                                                value.TextColor3 =
                                                    table.concat(chosen) ~= "" and theme.EnabledText or
                                                    theme.DisabledText
                                                value.Text =
                                                    table.concat(chosen) ~= "" and table.concat(chosen, ", ") or "NONE"
                                                custom.animate(value, {0.2}, {TextTransparency = 0})
                                            end
                                        )

                                        callback(chosen)
                                    end
                                end
                            end
                        )
                    end

                    function dropdown_info:Add(opt)
                        table.insert(contentTable, opt)
                        --dropdown_info:Refresh(contentTable)
                        local option =
                            custom.createObject(
                            "TextButton",
                            {
                                ZIndex = 11,
                                Size = UDim2.new(1, 0, 0, 16),
                                BackgroundTransparency = 1,
                                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                                FontSize = Enum.FontSize.Size12,
                                TextSize = 12,
                                TextColor3 = theme.DisabledText,
                                Text = opt,
                                Font = fonted,
                                TextXAlignment = Enum.TextXAlignment.Left,
                                Parent = contentHolder
                            }
                        )

                        optionInstances[opt] = option

                        option.MouseButton1Click:connect(
                            function()
                                if not multiChoice then
                                    if curValue ~= opt then
                                        curValue = opt

                                        for i, v in next, contentHolder:GetChildren() do
                                            if v:IsA("TextButton") then
                                                custom.animate(v, {0.2}, {TextColor3 = theme.DisabledText})
                                            end
                                        end

                                        custom.animate(option, {0.2}, {TextColor3 = theme.EnabledText})

                                        custom.animate(
                                            value,
                                            {0.2},
                                            {TextTransparency = 1},
                                            function()
                                                value.TextColor3 = theme.EnabledText
                                                value.Text = opt
                                                custom.animate(value, {0.2}, {TextTransparency = 0})
                                            end
                                        )

                                        callback(opt)
                                    else
                                        curValue = nil
                                        custom.animate(option, {0.2}, {TextColor3 = theme.DisabledText})

                                        custom.animate(
                                            value,
                                            {0.2},
                                            {TextTransparency = 1},
                                            function()
                                                value.TextColor3 = theme.DisabledText
                                                value.Text = "NONE"
                                                custom.animate(value, {0.2}, {TextTransparency = 0})
                                            end
                                        )

                                        callback(nil)
                                    end
                                else
                                    if table.find(chosen, opt) then
                                        for i, v in next, chosen do
                                            if v == opt then
                                                table.remove(chosen, i)
                                            end
                                        end

                                        custom.animate(option, {0.2}, {TextColor3 = theme.DisabledText})

                                        custom.animate(
                                            value,
                                            {0.2},
                                            {TextTransparency = 1},
                                            function()
                                                value.TextColor3 =
                                                    table.concat(chosen) ~= "" and theme.EnabledText or
                                                    theme.DisabledText
                                                value.Text =
                                                    table.concat(chosen) ~= "" and table.concat(chosen, ", ") or "NONE"
                                                custom.animate(value, {0.2}, {TextTransparency = 0})
                                            end
                                        )

                                        callback(chosen)
                                    else
                                        table.insert(chosen, opt)
                                        custom.animate(option, {0.2}, {TextColor3 = theme.EnabledText})

                                        custom.animate(
                                            value,
                                            {0.2},
                                            {TextTransparency = 1},
                                            function()
                                                value.TextColor3 =
                                                    table.concat(chosen) ~= "" and theme.EnabledText or
                                                    theme.DisabledText
                                                value.Text =
                                                    table.concat(chosen) ~= "" and table.concat(chosen, ", ") or "NONE"
                                                custom.animate(value, {0.2}, {TextTransparency = 0})
                                            end
                                        )

                                        callback(chosen)
                                    end
                                end
                            end
                        )

                        if content.Visible then
                            local sizeX = UDim2.new(1, 0, 0, contentList.AbsoluteContentSize.Y)
                            custom.animate(content, {#contentTable * 0.1}, {Size = sizeX})
                        end
                    end

                    function dropdown_info:Remove(opt)
                        if table.find(contentTable, opt) then
                            custom.animate(
                                optionInstances[opt],
                                {0.2},
                                {TextTransparency = 1},
                                function()
                                    table.remove(contentTable, table.find(contentTable, opt))
                                    optionInstances[opt]:Destroy()
                                    table.remove(optionInstances, table.find(optionInstances, opt))
                                end
                            )

                            table.remove(contentTable, table.find(contentTable, opt))
                            --dropdown_info:Refresh(contentTable)

                            if content.Visible then
                                local sizeX = UDim2.new(1, 0, 0, contentList.AbsoluteContentSize.Y - 16)
                                custom.animate(content, {#contentTable * 0.1}, {Size = sizeX})
                            end

                            if not multiChoice then
                                if curValue == opt then
                                    curValue = nil
                                    custom.animate(
                                        value,
                                        {0.2},
                                        {TextTransparency = 1},
                                        function()
                                            value.TextColor3 = theme.DisabledText
                                            value.Text = "NONE"
                                            custom.animate(value, {0.2}, {TextTransparency = 0})
                                        end
                                    )
                                    table.remove(contentTable, table.find(contentTable, curValue))
                                --dropdown_info:Refresh(contentTable)
                                end
                            else
                                if table.find(chosen, opt) then
                                    table.remove(chosen, table.find(chosen, opt))
                                    custom.animate(
                                        value,
                                        {0.2},
                                        {TextTransparency = 1},
                                        function()
                                            value.TextColor3 =
                                                table.concat(chosen) ~= "" and theme.EnabledText or theme.DisabledText
                                            value.Text =
                                                table.concat(chosen) ~= "" and table.concat(chosen, ", ") or "NONE"
                                            custom.animate(value, {0.2}, {TextTransparency = 0})
                                        end
                                    )
                                end
                            end
                        end
                    end

                    if content.Visible then
                        local sizeX = UDim2.new(1, 0, 0, contentList.AbsoluteContentSize.Y)
                        custom.animate(content, {#contentTable * 0.1}, {Size = sizeX})
                    end
                end

                function dropdown_info:Hide()
                    dropdown.Visible = false
                end

                function dropdown_info:Show()
                    dropdown.Visible = true
                end

                return dropdown_info
            end

            function section_info:CreateKeybind(opts)
                local options = custom.formatTable(opts)
                local name = options.name
                local default = options.default
                local callback = options.callback or function()
                    end

                local keyChosen = default

                local keys = {
                    [Enum.KeyCode.LeftShift] = "L-SHIFT",
                    [Enum.KeyCode.RightShift] = "R-SHIFT",
                    [Enum.KeyCode.LeftControl] = "L-CTRL",
                    [Enum.KeyCode.RightControl] = "R-CTRL",
                    [Enum.KeyCode.LeftAlt] = "L-ALT",
                    [Enum.KeyCode.RightAlt] = "R-ALT",
                    [Enum.KeyCode.CapsLock] = "CAPSLOCK",
                    [Enum.KeyCode.One] = "1",
                    [Enum.KeyCode.Two] = "2",
                    [Enum.KeyCode.Three] = "3",
                    [Enum.KeyCode.Four] = "4",
                    [Enum.KeyCode.Five] = "5",
                    [Enum.KeyCode.Six] = "6",
                    [Enum.KeyCode.Seven] = "7",
                    [Enum.KeyCode.Eight] = "8",
                    [Enum.KeyCode.Nine] = "9",
                    [Enum.KeyCode.Zero] = "0",
                    [Enum.KeyCode.KeypadOne] = "NUM-1",
                    [Enum.KeyCode.KeypadTwo] = "NUM-2",
                    [Enum.KeyCode.KeypadThree] = "NUM-3",
                    [Enum.KeyCode.KeypadFour] = "NUM-4",
                    [Enum.KeyCode.KeypadFive] = "NUM-5",
                    [Enum.KeyCode.KeypadSix] = "NUM-6",
                    [Enum.KeyCode.KeypadSeven] = "NUM-7",
                    [Enum.KeyCode.KeypadEight] = "NUM-8",
                    [Enum.KeyCode.KeypadNine] = "NUM-9",
                    [Enum.KeyCode.KeypadZero] = "NUM-0",
                    [Enum.KeyCode.Minus] = "-",
                    [Enum.KeyCode.Equals] = "=",
                    [Enum.KeyCode.Tilde] = "~",
                    [Enum.KeyCode.LeftBracket] = "[",
                    [Enum.KeyCode.RightBracket] = "]",
                    [Enum.KeyCode.RightParenthesis] = ")",
                    [Enum.KeyCode.LeftParenthesis] = "(",
                    [Enum.KeyCode.Semicolon] = ";",
                    [Enum.KeyCode.Quote] = "'",
                    [Enum.KeyCode.BackSlash] = "\\",
                    [Enum.KeyCode.Comma] = ";",
                    [Enum.KeyCode.Period] = ".",
                    [Enum.KeyCode.Slash] = "/",
                    [Enum.KeyCode.Asterisk] = "*",
                    [Enum.KeyCode.Plus] = "+",
                    [Enum.KeyCode.Period] = ".",
                    [Enum.KeyCode.Backquote] = "`",
                    [Enum.UserInputType.MouseButton1] = "MOUSE-1",
                    [Enum.UserInputType.MouseButton2] = "MOUSE-2",
                    [Enum.UserInputType.MouseButton3] = "MOUSE-3"
                }

                local keybind =
                    custom.createObject(
                    "TextButton",
                    {
                        ZIndex = 6,
                        Size = UDim2.new(1, 0, 0, 10),
                        BackgroundTransparency = 1,
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        FontSize = Enum.FontSize.Size12,
                        TextSize = 12,
                        TextColor3 = theme.TextColor,
                        Text = options.name or "Keybind",
                        Font = fonted,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        Parent = sectionContent
                    }
                )
                local value =
                    custom.createObject(
                    "TextLabel",
                    {
                        ZIndex = 6,
                        Size = UDim2.new(0, 1, 0, 10),
                        BackgroundTransparency = 1,
                        Position = UDim2.new(1, -1, 0, 0),
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        FontSize = Enum.FontSize.Size12,
                        TextSize = 12,
                        TextColor3 = default and theme.EnabledText or theme.DisabledText,
                        Text = default and (keys[default] or tostring(default):gsub("Enum.KeyCode.", "")) or "NONE",
                        Font = fonted,
                        TextXAlignment = Enum.TextXAlignment.Right,
                        Parent = keybind
                    }
                )

                keybind.MouseButton1Click:Connect(
                    function()
                        value.Text = "..."
                        custom.animate(value, {0.2}, {TextColor3 = theme.DisabledText})

                        local binding
                        binding =
                            inputService.InputBegan:Connect(
                            function(input)
                                local key = keys[input.KeyCode] or keys[input.UserInputType]
                                value.Text = (keys[key] or tostring(input.KeyCode):gsub("Enum.KeyCode.", ""))
                                custom.animate(value, {0.2}, {TextColor3 = theme.EnabledText})

                                if input.UserInputType == Enum.UserInputType.Keyboard then
                                    keyChosen = input.KeyCode

                                    callback(input.KeyCode)
                                    binding:Disconnect()
                                else
                                    keyChosen = input.UserInputType

                                    callback(input.UserInputType)
                                    binding:Disconnect()
                                end
                            end
                        )
                    end
                )

                inputService.InputBegan:Connect(
                    function(input)
                        if input.UserInputType == Enum.UserInputType.Keyboard then
                            if input.KeyCode == keyChosen then
                                callback(keyChosen)
                            end
                        else
                            if input.UserInputType == keyChosen then
                                callback(keyChosen)
                            end
                        end
                    end
                )

                local keybind_info = {}
                keybind_info = custom.formatTable(keybind_info)

                function keybind_info:Set(newKey)
                    local key = keys[newKey]
                    value.Text = (keys[key] or tostring(newKey):gsub("Enum.KeyCode.", ""))
                    custom.animate(value, {0.2}, {TextColor3 = theme.EnabledText})

                    keyChosen = newKey

                    callback(newKey)
                end

                function keybind_info:Hide()
                    keybind.Visible = false
                end

                function keybind_info:Show()
                    keybind.Visible = true
                end

                return keybind_info
            end

            function section_info:CreateToggle_or_Keybind(opts)
                local options = custom.formatTable(opts)
                local name = options.name
                local default = options.default
                local keybindCallback = options.keybindCallback or function()
                    end
                local toggleCallback = options.toggleCallback or function()
                    end

                local keyChosen = default
                local mouseOver = false
                local toggled = false

                local keys = {
                    [Enum.KeyCode.LeftShift] = "L-SHIFT",
                    [Enum.KeyCode.RightShift] = "R-SHIFT",
                    [Enum.KeyCode.LeftControl] = "L-CTRL",
                    [Enum.KeyCode.RightControl] = "R-CTRL",
                    [Enum.KeyCode.LeftAlt] = "L-ALT",
                    [Enum.KeyCode.RightAlt] = "R-ALT",
                    [Enum.KeyCode.CapsLock] = "CAPSLOCK",
                    [Enum.KeyCode.One] = "1",
                    [Enum.KeyCode.Two] = "2",
                    [Enum.KeyCode.Three] = "3",
                    [Enum.KeyCode.Four] = "4",
                    [Enum.KeyCode.Five] = "5",
                    [Enum.KeyCode.Six] = "6",
                    [Enum.KeyCode.Seven] = "7",
                    [Enum.KeyCode.Eight] = "8",
                    [Enum.KeyCode.Nine] = "9",
                    [Enum.KeyCode.Zero] = "0",
                    [Enum.KeyCode.KeypadOne] = "NUM-1",
                    [Enum.KeyCode.KeypadTwo] = "NUM-2",
                    [Enum.KeyCode.KeypadThree] = "NUM-3",
                    [Enum.KeyCode.KeypadFour] = "NUM-4",
                    [Enum.KeyCode.KeypadFive] = "NUM-5",
                    [Enum.KeyCode.KeypadSix] = "NUM-6",
                    [Enum.KeyCode.KeypadSeven] = "NUM-7",
                    [Enum.KeyCode.KeypadEight] = "NUM-8",
                    [Enum.KeyCode.KeypadNine] = "NUM-9",
                    [Enum.KeyCode.KeypadZero] = "NUM-0",
                    [Enum.KeyCode.Minus] = "-",
                    [Enum.KeyCode.Equals] = "=",
                    [Enum.KeyCode.Tilde] = "~",
                    [Enum.KeyCode.LeftBracket] = "[",
                    [Enum.KeyCode.RightBracket] = "]",
                    [Enum.KeyCode.RightParenthesis] = ")",
                    [Enum.KeyCode.LeftParenthesis] = "(",
                    [Enum.KeyCode.Semicolon] = ";",
                    [Enum.KeyCode.Quote] = "'",
                    [Enum.KeyCode.BackSlash] = "\\",
                    [Enum.KeyCode.Comma] = ";",
                    [Enum.KeyCode.Period] = ".",
                    [Enum.KeyCode.Slash] = "/",
                    [Enum.KeyCode.Asterisk] = "*",
                    [Enum.KeyCode.Plus] = "+",
                    [Enum.KeyCode.Period] = ".",
                    [Enum.KeyCode.Backquote] = "`",
                    [Enum.UserInputType.MouseButton1] = "MOUSE-1",
                    [Enum.UserInputType.MouseButton2] = "MOUSE-2",
                    [Enum.UserInputType.MouseButton3] = "MOUSE-3"
                }

                local toggleKeybind =
                    custom.createObject(
                    "TextButton",
                    {
                        Size = UDim2.new(1, 0, 0, 10),
                        BackgroundTransparency = 1,
                        Parent = sectionContent
                    }
                )

                local icon =
                    custom.createObject(
                    "Frame",
                    {
                        ZIndex = 6,
                        Size = UDim2.new(0, 10, 0, 10),
                        BackgroundColor3 = theme.ToggleDisabled,
                        Parent = toggleKeybind
                    }
                )

                custom.createObject(
                    "UICorner",
                    {
                        CornerRadius = UDim.new(0, 4),
                        Parent = icon
                    }
                )

                local title =
                    custom.createObject(
                    "TextLabel",
                    {
                        ZIndex = 6,
                        Size = UDim2.new(0, 1, 0, 10),
                        BackgroundTransparency = 1,
                        Position = UDim2.new(1, 5, 0, 0),
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        FontSize = Enum.FontSize.Size12,
                        TextSize = 12,
                        TextColor3 = theme.DisabledText,
                        Text = name,
                        Font = fonted,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        Parent = icon
                    }
                )
                local value =
                    custom.createObject(
                    "TextButton",
                    {
                        ZIndex = 6,
                        Size = UDim2.new(0, 1, 0, 10),
                        BackgroundTransparency = 1,
                        Position = UDim2.new(1, -1, 0, 0),
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        FontSize = Enum.FontSize.Size12,
                        TextSize = 12,
                        TextColor3 = default and theme.EnabledText or theme.DisabledText,
                        Text = default and (keys[default] or tostring(default):gsub("Enum.KeyCode.", "")) or "NONE",
                        Font = fonted,
                        TextXAlignment = Enum.TextXAlignment.Right,
                        Parent = toggleKeybind
                    }
                )

                value.Size = UDim2.new(0, value.TextBounds.X, 0, 10)
                value.Position = UDim2.new(1, -(value.TextBounds.X), 0, 0)

                local function toggleToggle()
                    toggled = not toggled

                    custom.animate(title, {0.2}, {TextColor3 = toggled and theme.EnabledText or theme.DisabledText})

                    if not mouseOver then
                        custom.animate(
                            icon,
                            {0.2},
                            {BackgroundColor3 = toggled and theme.ToggleEnabled or theme.ToggleDisabled}
                        )
                    else
                        custom.animate(
                            icon,
                            {0.2},
                            {
                                BackgroundColor3 = toggled and theme.ToggleEnabledMouseOver or
                                    theme.ToggleDisabledMouseOver
                            }
                        )
                    end

                    toggleCallback(toggled)
                end

                toggleKeybind.MouseButton1Click:connect(toggleToggle)

                toggleKeybind.MouseEnter:Connect(
                    function()
                        mouseOver = true
                        custom.animate(
                            icon,
                            {0.2},
                            {
                                BackgroundColor3 = toggled and theme.ToggleEnabledMouseOver or
                                    theme.ToggleDisabledMouseOver
                            }
                        )
                    end
                )

                toggleKeybind.MouseLeave:Connect(
                    function()
                        mouseOver = false
                        custom.animate(
                            icon,
                            {0.2},
                            {BackgroundColor3 = toggled and theme.ToggleEnabled or theme.ToggleDisabled}
                        )
                    end
                )

                value.MouseButton1Click:Connect(
                    function()
                        value.Text = "..."
                        custom.animate(value, {0.2}, {TextColor3 = theme.DisabledText})

                        local binding
                        binding =
                            inputService.InputBegan:Connect(
                            function(input)
                                local key = keys[input.KeyCode] or keys[input.UserInputType]
                                value.Text = key or (tostring(input.KeyCode):gsub("Enum.KeyCode.", ""))
                                value.Size = UDim2.new(0, value.TextBounds.X, 0, 10)
                                value.Position = UDim2.new(1, -(value.TextBounds.X), 0, 0)
                                custom.animate(value, {0.2}, {TextColor3 = theme.EnabledText})

                                if input.UserInputType == Enum.UserInputType.Keyboard then
                                    keyChosen = input.KeyCode

                                    keybindCallback(input.KeyCode)
                                    binding:Disconnect()
                                else
                                    keyChosen = input.UserInputType

                                    keybindCallback(input.UserInputType)
                                    binding:Disconnect()
                                end
                            end
                        )
                    end
                )

                inputService.InputBegan:Connect(
                    function(input)
                        if input.UserInputType == Enum.UserInputType.Keyboard then
                            if input.KeyCode == keyChosen then
                                toggleToggle()
                                keybindCallback(keyChosen)
                            end
                        else
                            if input.UserInputType == keyChosen then
                                toggleToggle()
                                keybindCallback(keyChosen)
                            end
                        end
                    end
                )

                local tork_info = {}
                tork_info = custom.formatTable(tork_info)

                function tork_info:Toggle(bool)
                    if toggled ~= bool then
                        toggleToggle()
                    end
                end

                function tork_info:Set(newKey)
                    local key = keys[newKey]
                    value.Text = (keys[key] or tostring(newKey):gsub("Enum.KeyCode.", ""))
                    custom.animate(value, {0.2}, {TextColor3 = theme.EnabledText})

                    keyChosen = newKey

                    keybindCallback(newKey)
                end

                function tork_info:Hide()
                    toggleKeybind.Visible = false
                end

                function tork_info:Show()
                    toggleKeybind.Visible = true
                end

                return tork_info
            end

            function section_info:CreateToggle_and_Keybind(opts)
                local options = custom.formatTable(opts)
                local name = options.name
                local default = options.default
                local Callback = options.Callback or function()
                    end

                local keyChosen = default
                local mouseOver = false
                local toggled = false

                local keys = {
                    [Enum.KeyCode.LeftShift] = "L-SHIFT",
                    [Enum.KeyCode.RightShift] = "R-SHIFT",
                    [Enum.KeyCode.LeftControl] = "L-CTRL",
                    [Enum.KeyCode.RightControl] = "R-CTRL",
                    [Enum.KeyCode.LeftAlt] = "L-ALT",
                    [Enum.KeyCode.RightAlt] = "R-ALT",
                    [Enum.KeyCode.CapsLock] = "CAPSLOCK",
                    [Enum.KeyCode.One] = "1",
                    [Enum.KeyCode.Two] = "2",
                    [Enum.KeyCode.Three] = "3",
                    [Enum.KeyCode.Four] = "4",
                    [Enum.KeyCode.Five] = "5",
                    [Enum.KeyCode.Six] = "6",
                    [Enum.KeyCode.Seven] = "7",
                    [Enum.KeyCode.Eight] = "8",
                    [Enum.KeyCode.Nine] = "9",
                    [Enum.KeyCode.Zero] = "0",
                    [Enum.KeyCode.KeypadOne] = "NUM-1",
                    [Enum.KeyCode.KeypadTwo] = "NUM-2",
                    [Enum.KeyCode.KeypadThree] = "NUM-3",
                    [Enum.KeyCode.KeypadFour] = "NUM-4",
                    [Enum.KeyCode.KeypadFive] = "NUM-5",
                    [Enum.KeyCode.KeypadSix] = "NUM-6",
                    [Enum.KeyCode.KeypadSeven] = "NUM-7",
                    [Enum.KeyCode.KeypadEight] = "NUM-8",
                    [Enum.KeyCode.KeypadNine] = "NUM-9",
                    [Enum.KeyCode.KeypadZero] = "NUM-0",
                    [Enum.KeyCode.Minus] = "-",
                    [Enum.KeyCode.Equals] = "=",
                    [Enum.KeyCode.Tilde] = "~",
                    [Enum.KeyCode.LeftBracket] = "[",
                    [Enum.KeyCode.RightBracket] = "]",
                    [Enum.KeyCode.RightParenthesis] = ")",
                    [Enum.KeyCode.LeftParenthesis] = "(",
                    [Enum.KeyCode.Semicolon] = ";",
                    [Enum.KeyCode.Quote] = "'",
                    [Enum.KeyCode.BackSlash] = "\\",
                    [Enum.KeyCode.Comma] = ";",
                    [Enum.KeyCode.Period] = ".",
                    [Enum.KeyCode.Slash] = "/",
                    [Enum.KeyCode.Asterisk] = "*",
                    [Enum.KeyCode.Plus] = "+",
                    [Enum.KeyCode.Period] = ".",
                    [Enum.KeyCode.Backquote] = "`",
                    [Enum.UserInputType.MouseButton1] = "MOUSE-1",
                    [Enum.UserInputType.MouseButton2] = "MOUSE-2",
                    [Enum.UserInputType.MouseButton3] = "MOUSE-3"
                }

                local toggleKeybind =
                    custom.createObject(
                    "TextButton",
                    {
                        Size = UDim2.new(1, 0, 0, 10),
                        BackgroundTransparency = 1,
                        Parent = sectionContent
                    }
                )

                local icon =
                    custom.createObject(
                    "Frame",
                    {
                        ZIndex = 6,
                        Size = UDim2.new(0, 10, 0, 10),
                        BackgroundColor3 = theme.ToggleDisabled,
                        Parent = toggleKeybind
                    }
                )

                custom.createObject(
                    "UICorner",
                    {
                        CornerRadius = UDim.new(0, 4),
                        Parent = icon
                    }
                )

                local title =
                    custom.createObject(
                    "TextLabel",
                    {
                        ZIndex = 6,
                        Size = UDim2.new(0, 1, 0, 10),
                        BackgroundTransparency = 1,
                        Position = UDim2.new(1, 5, 0, 0),
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        FontSize = Enum.FontSize.Size12,
                        TextSize = 12,
                        TextColor3 = theme.DisabledText,
                        Text = name,
                        Font = fonted,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        Parent = icon
                    }
                )
                local value =
                    custom.createObject(
                    "TextButton",
                    {
                        ZIndex = 6,
                        Size = UDim2.new(0, 1, 0, 10),
                        BackgroundTransparency = 1,
                        Position = UDim2.new(1, -1, 0, 0),
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        FontSize = Enum.FontSize.Size12,
                        TextSize = 12,
                        TextColor3 = default and theme.EnabledText or theme.DisabledText,
                        Text = default and (keys[default] or tostring(default):gsub("Enum.KeyCode.", "")) or "NONE",
                        Font = fonted,
                        TextXAlignment = Enum.TextXAlignment.Right,
                        Parent = toggleKeybind
                    }
                )

                value.Size = UDim2.new(0, value.TextBounds.X, 0, 10)
                value.Position = UDim2.new(1, -(value.TextBounds.X), 0, 0)

                local function toggleToggle()
                    toggled = not toggled

                    custom.animate(title, {0.2}, {TextColor3 = toggled and theme.EnabledText or theme.DisabledText})

                    if not mouseOver then
                        custom.animate(
                            icon,
                            {0.2},
                            {BackgroundColor3 = toggled and theme.ToggleEnabled or theme.ToggleDisabled}
                        )
                    else
                        custom.animate(
                            icon,
                            {0.2},
                            {
                                BackgroundColor3 = toggled and theme.ToggleEnabledMouseOver or
                                    theme.ToggleDisabledMouseOver
                            }
                        )
                    end

                    Callback(toggled, keyChosen)
                end

                toggleKeybind.MouseButton1Click:connect(toggleToggle)

                toggleKeybind.MouseEnter:Connect(
                    function()
                        mouseOver = true
                        custom.animate(
                            icon,
                            {0.2},
                            {
                                BackgroundColor3 = toggled and theme.ToggleEnabledMouseOver or
                                    theme.ToggleDisabledMouseOver
                            }
                        )
                    end
                )

                toggleKeybind.MouseLeave:Connect(
                    function()
                        mouseOver = false
                        custom.animate(
                            icon,
                            {0.2},
                            {BackgroundColor3 = toggled and theme.ToggleEnabled or theme.ToggleDisabled}
                        )
                    end
                )

                value.MouseButton1Click:Connect(
                    function()
                        value.Text = "..."
                        custom.animate(value, {0.2}, {TextColor3 = theme.DisabledText})

                        local binding
                        binding =
                            inputService.InputBegan:Connect(
                            function(input)
                                local key = keys[input.KeyCode] or keys[input.UserInputType]
                                value.Text = key or (tostring(input.KeyCode):gsub("Enum.KeyCode.", ""))
                                value.Size = UDim2.new(0, value.TextBounds.X, 0, 10)
                                value.Position = UDim2.new(1, -(value.TextBounds.X), 0, 0)
                                custom.animate(value, {0.2}, {TextColor3 = theme.EnabledText})

                                if input.UserInputType == Enum.UserInputType.Keyboard then
                                    keyChosen = input.KeyCode
                                    Callback(toggled, keyChosen)

                                    binding:Disconnect()
                                else
                                    keyChosen = input.UserInputType

                                    Callback(toggled, keyChosen)

                                    binding:Disconnect()
                                end
                            end
                        )
                    end
                )

                local tandk_info = {}
                tandk_info = custom.formatTable(tandk_info)

                function tandk_info:Toggle(bool)
                    if toggled ~= bool then
                        toggleToggle()
                    end
                end

                function tandk_info:Set(newKey)
                    local key = keys[newKey]
                    value.Text = (keys[key] or tostring(newKey):gsub("Enum.KeyCode.", ""))
                    custom.animate(value, {0.2}, {TextColor3 = theme.EnabledText})

                    keyChosen = newKey

                    Callback(toggled, keyChosen)
                end

                function tandk_info:Hide()
                    toggleKeybind.Visible = false
                end

                function tandk_info:Show()
                    toggleKeybind.Visible = true
                end

                return tandk_info
            end

            return section_info
        end

        return tab_info
    end

    return window_info
end
return library
