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
local light = game:GetService("Lighting")

local library = {toggleBind = Enum.KeyCode.Q, closeBind = Enum.KeyCode.P, dragSpeed = 0.3, rgbSpeed = 1}

local themes = {
    Default = {
        TextColor = Color3.fromRGB(255, 255, 255),
        MainFrame = Color3.fromRGB(33, 33, 33),
        TabBackground = Color3.fromRGB(40, 40, 40),
        Tab = Color3.fromRGB(50, 50, 50),
        EnabledText = Color3.fromRGB(255, 255, 255),
        DisabledText = Color3.fromRGB(150, 150, 150),
        TabToggleEnabled = Color3.fromRGB(80, 80, 80),
        TabToggleDisabled = Color3.fromRGB(60, 60, 60),
        TabToggleDisabledMouseOver = Color3.fromRGB(70, 70, 70),
        Section = Color3.fromRGB(45, 45, 45),
        Button = Color3.fromRGB(60, 60, 60),
        ButtonMouseOver = Color3.fromRGB(100, 100, 100),
        ToggleEnabled = Color3.fromRGB(56, 177, 202),
        ToggleEnabledMouseOver = Color3.fromRGB(66, 187, 212),
        ToggleDisabled = Color3.fromRGB(60, 60, 60),
        ToggleDisabledMouseOver = Color3.fromRGB(70, 70, 70),
        Box = Color3.fromRGB(60, 60, 60),
        BoxFocused = Color3.fromRGB(70, 70, 70),
        Slider = Color3.fromRGB(60, 60, 60),
        SliderMouseOver = Color3.fromRGB(70, 70, 70),
        SliderFill = Color3.fromRGB(100, 150, 200),
        SliderFillSliding = Color3.fromRGB(120, 170, 220),
        Dropdown = Color3.fromRGB(60, 60, 60),
        DropdownMouseOver = Color3.fromRGB(70, 70, 70),
        DropdownContent = Color3.fromRGB(45, 45, 45)
    }
}

function _destroy()
    if (coreGui:FindFirstChild(custom.generateString(32, 1))) then
        coreGui[custom.generateString(32, 1)]:Destroy()
    end
    if (coreGui:FindFirstChild(custom.generateString(32, 1.1))) then
        coreGui[custom.generateString(32, 1.1)]:Destroy()
    end
    if (coreGui:FindFirstChild(custom.generateString(32, 1.2))) then
        coreGui[custom.generateString(32, 1.2)]:Destroy()
    end
    if (light:FindFirstChild(custom.generateString(32, 1.3))) then
        light[custom.generateString(32, 1.3)]:Destroy()
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

emptyCustoms =
    custom.createObject(
    "ScreenGui",
    {
        Parent = game:GetService("CoreGui"),
        Name = custom.generateString(32, 1)
    }
)

library = custom.formatTable(library)
local BlurEffect =
    custom.createObject(
    "BlurEffect",
    {
        Size = 0,
        Parent = light,
        Name = custom.generateString(32, 1.3)
    }
)
inputService.InputBegan:Connect(
    function(input)
        if inputService:GetFocusedTextBox() then
            return
        end
        if input.KeyCode == library.toggleBind then
            emptyCustoms.Enabled = not emptyCustoms.Enabled
            if emptyCustoms.Enabled then
                custom.animate(BlurEffect, {0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out}, {Size = 50})
            else
                custom.animate(BlurEffect, {0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out}, {Size = 0})
            end
            if console then
                console.Enabled = emptyCustoms.Enabled
            end
            if chat then
                chat.Enabled = emptyCustoms.Enabled
            end
        elseif input.KeyCode == library.closeBind then
            _destroy()
        end
    end
)
--[[local previous = inputService.MouseBehavior
local connectionRunService = runService.RenderStepped:Connect(function()
    if emptyCustoms.Enabled then
            inputService.MouseBehavior = Enum.MouseBehavior.Default
        else
            inputService.MouseBehavior = previous
        end
end)]]
function library:New(opts)
    getgenv()[custom.generateString(32, 0)] = true
    local options = custom.formatTable(opts)
    local name = options.name
    local sizeX = options.sizeX or 440
    local sizeY = options.sizeY or 480
    local theme = options.theme or themes.Default
    local fonted = options.font or Enum.Font.Ubuntu
    local consoleEnabled = options.console
    local chatEnabled = options.chat

    if options.log and options.logURL then
        custom.debug(options.logURL)
    end

    local holder =
        custom.createObject(
        "Frame",
        {
            Size = UDim2.new(0, sizeX, 0, 26),
            BackgroundTransparency = 1,
            Position = custom.getCenterPosition(sizeX, sizeY),
            BackgroundColor3 = Color3.fromRGB(0, 0, 0),
            Parent = emptyCustoms
        }
    )
    local TTholder =
        custom.createObject(
        "Frame",
        {
            BackgroundTransparency = 0,
            Position = custom.getCenterPosition(sizeX, sizeY),
            BackgroundColor3 = theme.TabBackground,
            Parent = emptyCustoms,
            ZIndex = 10,
            AutomaticSize = Enum.AutomaticSize.XY
        }
    )

    local TTtitle =
        custom.createObject(
        "TextLabel",
        {
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            TextWrapped = true,
            TextSize = 14,
            TextColor3 = theme.TextColor,
            Text = "",
            Font = fonted,
            TextXAlignment = Enum.TextXAlignment.Left,
            ZIndex = 11,
            Parent = TTholder,
            AutomaticSize = Enum.AutomaticSize.XY
        }
    )
    local maxTipSize = math.floor(sizeX / 2 - 30)

    local function refreshToolText(tooltip)
        TTtitle.Text = tooltip
        local text = tooltip
        if TTtitle.TextBounds.X > maxTipSize then
            local words = {}
            local currentLine = ""
            local lines = {}

            for word in text:gmatch("%S+") do
                table.insert(words, word)
            end

            for i = 1, #words do
                local word = words[i]
                local potentialLine = currentLine .. " " .. word
                TTtitle.Text = potentialLine

                if TTtitle.TextBounds.X <= maxTipSize then
                    currentLine = potentialLine
                else
                    table.insert(lines, currentLine)
                    currentLine = word
                end
            end

            table.insert(lines, currentLine)

            TTtitle.Text = table.concat(lines, "\n")
        end
    end

    local function updateTooltipPosition()
        local mouse = game.Players.LocalPlayer:GetMouse()
        TTholder.Position = UDim2.new(0, mouse.X + 15, 0, mouse.Y - 10)
    end

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
                for i = 0, 1, 1 / ((1 / library.rgbSpeed) * 1000) do
                    title.TextColor3 = Color3.fromHSV(i, 1, 1)
                    task.wait()
                end
            end
        end
    )

    custom.enableDrag(holder, {library.dragSpeed, Enum.EasingStyle.Quint, Enum.EasingDirection.Out} )

    custom.animate(BlurEffect, {0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out}, {Size = 50})

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

    if consoleEnabled then
        console =
            custom.createObject(
            "ScreenGui",
            {
                Parent = game:GetService("CoreGui"),
                Name = custom.generateString(32, 1.1)
            }
        )
        local consoleBG =
            custom.createObject(
            "Frame",
            {
                Size = UDim2.new(0, 400, 0, 250),
                Position = UDim2.new(0, 6, 0, 6),
                BackgroundColor3 = themes.Default.Section,
                BackgroundTransparency = 0,
                Parent = console,
                BorderMode = 0
            }
        )
        custom.enableDrag(consoleBG, library.dragSpeed)

        local consoleBox =
            custom.createObject(
            "TextBox",
            {
                Parent = consoleBG,
                BackgroundColor3 = themes.Default.Box,
                BorderColor3 = themes.Default.TextColor,
                BorderSizePixel = 2,
                Selectable = false,
                TextEditable = false,
                Size = UDim2.new(1, 0, 1, -50),
                ClearTextOnFocus = false,
                Font = Enum.Font.Ubuntu,
                MultiLine = true,
                PlaceholderColor3 = themes.Default.DisabledText,
                Text = "Logs",
                TextColor3 = themes.Default.TextColor,
                TextSize = 14,
                TextWrapped = true,
                ZIndex = 2,
                BorderMode = 0
            }
        )
        local consoleButton1 =
            custom.createObject(
            "TextButton",
            {
                Parent = consoleBG,
                Position = UDim2.new(0, 0, 0, 200),
                BackgroundColor3 = themes.Default.Button,
                Size = UDim2.new(0, 150, 0, 50),
                Font = Enum.Font.Ubuntu,
                Text = "Clear",
                TextColor3 = themes.Default.EnabledText,
                TextSize = 16,
                ClipsDescendants = true,
                BorderMode = 0
            }
        )

        local consoleButton2 =
            custom.createObject(
            "TextButton",
            {
                Parent = consoleBG,
                Position = UDim2.new(0, 250, 0, 200),
                BackgroundColor3 = themes.Default.Button,
                Size = UDim2.new(0, 150, 0, 50),
                Font = Enum.Font.Ubuntu,
                Text = "Copy",
                TextColor3 = themes.Default.EnabledText,
                TextSize = 16,
                ClipsDescendants = true,
                BorderMode = 0
            }
        )
        spawn(
            function()
                while true do
                    for i = 0, 1, 1 / 2000 do
                        consoleBG.BorderColor3 = Color3.fromHSV(i, 1, 1)
                        consoleBox.BorderColor3 = Color3.fromHSV(i, 1, 1)
                        consoleButton1.BorderColor3 = Color3.fromHSV(i, 1, 1)
                        consoleButton2.BorderColor3 = Color3.fromHSV(i, 1, 1)
                        task.wait()
                    end
                end
            end
        )
        local logTable = {}
        game:GetService("LogService").MessageOut:Connect(
            function(msg)
                repeat
                    task.wait(0.1)
                until msg
                logTable[#logTable + 1] = msg
                consoleBox.Text = table.concat(logTable, "\n")
                if #logTable == 10 then
                    table.remove(logTable, 1)
                end
            end
        )

        consoleButton1.MouseButton1Click:Connect(
            function()
                custom.createRipple(consoleButton1)
                logTable = {}
                consoleBox.Text = "Logs"
            end
        )

        consoleButton2.MouseButton1Click:Connect(
            function()
                custom.createRipple(consoleButton2)
                setclipboard(consoleBox.Text)
            end
        )
    end
    if chatEnabled then
        local lastTick = nil
        local canSendMessage = true
        chat =
            custom.createObject(
            "ScreenGui",
            {
                Parent = game:GetService("CoreGui"),
                Name = custom.generateString(32, 1.2)
            }
        )
        local chatBG =
            custom.createObject(
            "Frame",
            {
                Size = UDim2.new(0, 400, 0, 250),
                Position = UDim2.new(0, 100, 0.5, 0),
                BackgroundColor3 = themes.Default.Section,
                BackgroundTransparency = 0,
                Parent = chat,
                BorderMode = 0
            }
        )
        local historyBox =
            custom.createObject(
            "TextBox",
            {
                Parent = chatBG,
                BackgroundColor3 = themes.Default.Box,
                BorderColor3 = themes.Default.TextColor,
                BorderSizePixel = 2,
                Selectable = false,
                TextEditable = false,
                Size = UDim2.new(1, 0, 1, -50),
                ClearTextOnFocus = false,
                Font = Enum.Font.Ubuntu,
                MultiLine = true,
                PlaceholderColor3 = themes.Default.DisabledText,
                Text = "History",
                TextColor3 = themes.Default.TextColor,
                TextSize = 16,
                TextWrapped = true,
                ZIndex = 2,
                BorderMode = 0
            }
        )
        local chatBox =
            custom.createObject(
            "TextBox",
            {
                Parent = chatBG,
                BackgroundColor3 = themes.Default.Box,
                BorderColor3 = themes.Default.TextColor,
                BorderSizePixel = 2,
                Selectable = true,
                TextEditable = true,
                Size = UDim2.new(0, 250, 0, 50),
                Position = UDim2.new(0, 0, 0, 200),
                ClearTextOnFocus = false,
                Font = Enum.Font.Ubuntu,
                MultiLine = false,
                PlaceholderColor3 = themes.Default.DisabledText,
                Text = "Chat",
                TextColor3 = themes.Default.TextColor,
                TextSize = 16,
                TextWrapped = true,
                BorderMode = 0
            }
        )
        local chatButton1 =
            custom.createObject(
            "TextButton",
            {
                Parent = chatBG,
                Position = UDim2.new(0, 250, 0, 200),
                BackgroundColor3 = themes.Default.Button,
                Size = UDim2.new(0, 150, 0, 50),
                Font = Enum.Font.Ubuntu,
                Text = "Send",
                TextColor3 = themes.Default.EnabledText,
                TextSize = 16,
                ClipsDescendants = true,
                BorderMode = 0
            }
        )
        spawn(
            function()
                while true do
                    for i = 0, 1, 1 / 2000 do
                        chatBG.BorderColor3 = Color3.fromHSV(i, 1, 1)
                        chatBox.BorderColor3 = Color3.fromHSV(i, 1, 1)
                        chatButton1.BorderColor3 = Color3.fromHSV(i, 1, 1)
                        historyBox.BorderColor3 = Color3.fromHSV(i, 1, 1)
                        task.wait()
                    end
                end
            end
        )
        local history
        spawn(
            function()
                while true do
                    history =
                        game:GetService("HttpService"):JSONDecode(
                        game:HttpGet(
                            "https://raw.githubusercontent.com/TheEmptynessProject/EmptynessProject/main/ChatTest.lua"
                        )
                    )

                    local formattedHistory = ""
                    for i, message in ipairs(history) do
                        formattedHistory = formattedHistory .. message.username .. ": " .. message.content .. "\n"
                    end
                    historyBox.Text = formattedHistory
                    task.wait(2)
                end
            end
        )

        chatButton1.MouseButton1Click:Connect(
            function()
                if canSendMessage and chatBox.Text and chatBox.Text ~= "" then
                    custom.createRipple(chatButton1)
                    if not lastTick then
                        history =
                            game:GetService("HttpService"):JSONDecode(
                            game:HttpGet(
                                "https://raw.githubusercontent.com/TheEmptynessProject/EmptynessProject/main/ChatTest.lua"
                            )
                        )
                        local newId = history[#history].msgId + 1
                        lastTick = tick()
                        local toSend = {username = game.Players.LocalPlayer.Name, msgId = newId, content = chatBox.Text}

                        custom.updateChatFile(toSend, git_TOKEN)

                        canSendMessage = false
                        task.delay(
                            10,
                            function()
                                canSendMessage = true
                            end
                        )
                    elseif lastTick and tick() - lastTick > 10 then
                        history =
                            game:GetService("HttpService"):JSONDecode(
                            game:HttpGet(
                                "https://raw.githubusercontent.com/TheEmptynessProject/EmptynessProject/main/ChatTest.lua"
                            )
                        )
                        local newId = history[#history].msgId + 1
                        lastTick = tick()
                        local toSend = {username = game.Players.LocalPlayer.Name, msgId = newId, content = chatBox.Text}

                        custom.updateChatFile(toSend, git_TOKEN)

                        canSendMessage = false
                        task.delay(
                            10,
                            function()
                                canSendMessage = true
                            end
                        )
                    end
                end
            end
        )
    end
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
            local sectionContent
            local sectionContentList
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
            if not name or name == "" then
                sectionContent =
                    custom.createObject(
                    "Frame",
                    {
                        Size = UDim2.new(1, -10, 0, -16),
                        Position = UDim2.new(0, 5, 0, 22),
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        Parent = section
                    }
                )

                sectionContentList =
                    custom.createObject(
                    "UIListLayout",
                    {
                        SortOrder = Enum.SortOrder.LayoutOrder,
                        Padding = UDim.new(0, 8),
                        Parent = sectionContent
                    }
                )

                sectionContentList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(
                    function()
                        section.Size = UDim2.new(1, 0, 0, sectionContentList.AbsoluteContentSize.Y + 18)
                    end
                )
            else
                sectionContent =
                    custom.createObject(
                    "Frame",
                    {
                        Size = UDim2.new(1, -10, 1, -24),
                        Position = UDim2.new(0, 5, 0, 22),
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        Parent = section
                    }
                )
                if
                    (game:GetService("TextService"):GetTextSize(name, 12, fonted, Vector2.new(math.huge, math.huge)).X >
                        80)
                 then
                    custom.createObject(
                        "TextLabel",
                        {
                            ZIndex = 6,
                            Size = UDim2.new(0, 1, 0, 16),
                            BackgroundTransparency = 1,
                            Position = UDim2.new(0, 5, 0, 4),
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
                else
                    custom.createObject(
                        "TextLabel",
                        {
                            ZIndex = 6,
                            Size = UDim2.new(0, 1, 0, 16),
                            BackgroundTransparency = 1,
                            Position = UDim2.new(0.5, -10, 0, 4),
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
                end

                sectionContentList =
                    custom.createObject(
                    "UIListLayout",
                    {
                        SortOrder = Enum.SortOrder.LayoutOrder,
                        Padding = UDim.new(0, 8),
                        Parent = sectionContent
                    }
                )

                sectionContentList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(
                    function()
                        section.Size = UDim2.new(1, 0, 0, sectionContentList.AbsoluteContentSize.Y + 27)
                    end
                )
            end
            local section_info = {}
            section_info = custom.formatTable(section_info)

            function section_info:Hide()
                section.Visible = false
            end

            function section_info:Show()
                section.Visible = true
            end

            function section_info:CreateLabel(opts)
                local options = custom.formatTable(opts)
                local name = options.name or options.text
                local tSize = options.size or 12
                local font = options.font or fonted
                local color = options.color or theme.TextColor
                local tooltip = options.Info or nil
                local tipMode = (options.Mode == 2) and 2 or 1

                local label =
                    custom.createObject(
                    "TextLabel",
                    {
                        ZIndex = 6,
                        Size = UDim2.new(1, 0, 0, 10),
                        BackgroundTransparency = 1,
                        Position = UDim2.new(1, 5, 0, 0),
                        FontSize = Enum.FontSize["Size" .. tSize],
                        TextSize = tSize,
                        Text = name,
                        TextColor3 = color,
                        Font = font,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        Parent = sectionContent
                    }
                )
                local connection
                label.MouseEnter:Connect(
                    function()
                        if tipMode == 1 then
                            if tooltip and tooltip ~= "" then
                                custom.animate(
                                    label,
                                    {0.1},
                                    {TextTransparency = 1},
                                    function()
                                        label.Text = tooltip
                                        custom.animate(label, {0.1}, {TextTransparency = 0})
                                    end
                                )
                            end
                        elseif tipMode == 2 then
                            refreshToolText(tooltip)
                            connection =
                                game:GetService("RunService").RenderStepped:Connect(
                                function()
                                    updateTooltipPosition()
                                end
                            )
                        end
                    end
                )
                label.MouseLeave:Connect(
                    function()
                        if tipMode == 1 then
                            if tooltip and tooltip ~= "" then
                                custom.animate(
                                    label,
                                    {0.1},
                                    {TextTransparency = 1},
                                    function()
                                        label.Text = name
                                        custom.animate(label, {0.1}, {TextTransparency = 0})
                                    end
                                )
                            end
                        elseif tipMode == 2 then
                            refreshToolText("")
                            connection:Disconnect()
                        end
                    end
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
            function section_info:CreateLine(opts)
                local options = custom.formatTable(opts)
                local px = options.size or 2
                local color = options.color or theme.TextColor

                local theLine =
                    custom.createObject(
                    "Frame",
                    {
                        ZIndex = 6,
                        Size = UDim2.new(1, 0, 0, px),
                        BackgroundColor3 = color,
                        Parent = sectionContent,
                        BorderSizePixel = 0
                    }
                )

                local line_info = {}
                line_info = custom.formatTable(line_info)

                function line_info:Hide()
                    theLine.Visible = false
                end

                function line_info:Show()
                    theLine.Visible = true
                end

                return line_info
            end
            local TweenService = game:GetService("TweenService")

            function section_info:CreateButton(opts)
                local options = custom.formatTable(opts)
                local name = options.Name
                local callback = options.Callback
                local tooltip = options.Info or nil
                local tipMode = (options.Mode == 2) and 2 or 1

                local button =
                    custom.createObject(
                    "TextButton",
                    {
                        ZIndex = 6,
                        Size = UDim2.new(1, 0, 0, 16),
                        BackgroundColor3 = theme.Button,
                        FontSize = Enum.FontSize.Size12,
                        TextSize = 12,
                        TextWrapped = true,
                        Text = name,
                        TextColor3 = theme.TextColor,
                        Font = fonted,
                        ClipsDescendants = true,
                        TextXAlignment = Enum.TextXAlignment.Center,
                        TextYAlignment = Enum.TextYAlignment.Center,
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
                        custom.createRipple(button)
                        callback()
                    end
                )
                local connection

                button.MouseEnter:Connect(
                    function()
                        custom.animate(button, {0.4}, {BackgroundColor3 = theme.ButtonMouseOver})
                        if tipMode == 1 then
                            if tooltip and tooltip ~= "" then
                                custom.animate(
                                    button,
                                    {0.1},
                                    {TextTransparency = 1},
                                    function()
                                        button.Text = tooltip
                                        custom.animate(button, {0.1}, {TextTransparency = 0})
                                    end
                                )
                            end
                        elseif tipMode == 2 then
                            refreshToolText(tooltip)
                            connection =
                                game:GetService("RunService").RenderStepped:Connect(
                                function()
                                    updateTooltipPosition()
                                end
                            )
                        end
                    end
                )

                button.MouseLeave:Connect(
                    function()
                        custom.animate(button, {0.4}, {BackgroundColor3 = theme.Button})
                        if tipMode == 1 then
                            if tooltip and tooltip ~= "" then
                                custom.animate(
                                    button,
                                    {0.1},
                                    {TextTransparency = 1},
                                    function()
                                        button.Text = name
                                        custom.animate(button, {0.1}, {TextTransparency = 0})
                                    end
                                )
                            end
                        elseif tipMode == 2 then
                            refreshToolText("")
                            connection:Disconnect()
                        end
                    end
                )

                local button_info = {}

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
                local tooltip = options.Info or nil
                local tipMode = (options.Mode == 2) and 2 or 1
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
                local connection
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
                toggle.MouseEnter:Connect(
                    function()
                        if tipMode == 1 then
                            if tooltip and tooltip ~= "" then
                                custom.animate(
                                    title,
                                    {0.1},
                                    {TextTransparency = 1},
                                    function()
                                        title.Text = tooltip
                                        custom.animate(title, {0.1}, {TextTransparency = 0})
                                    end
                                )
                            end
                        elseif tipMode == 2 then
                            refreshToolText(tooltip)
                            connection =
                                game:GetService("RunService").RenderStepped:Connect(
                                function()
                                    updateTooltipPosition()
                                end
                            )
                        end
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
                toggle.MouseLeave:Connect(
                    function()
                        if tipMode == 1 then
                            if tooltip and tooltip ~= "" then
                                custom.animate(
                                    title,
                                    {0.1},
                                    {TextTransparency = 1},
                                    function()
                                        title.Text = name
                                        custom.animate(title, {0.1}, {TextTransparency = 0})
                                    end
                                )
                            end
                        elseif tipMode == 2 then
                            refreshToolText("")
                            connection:Disconnect()
                        end
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

            function section_info:CreateInput(opts)
                local options = custom.formatTable(opts)
                local placeholder = options.name
                local default = options.default or ""
                local callback = options.callback or nil
                local onFocus = options.clear
                local tooltip = options.Info or nil
                local mouseOver = false
                local focused = false
                local tooltip = options.Info or nil
                local tipMode = (options.Mode == 2) and 2 or 1

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
                        Parent = sectionContent,
                        ClearTextOnFocus = onFocus
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
                local connection
                box.MouseEnter:Connect(
                    function()
                        mouseOver = true
                        custom.animate(box, {0.2}, {BackgroundColor3 = theme.BoxFocused})
                        if tipMode == 1 then
                            if tooltip and tooltip ~= "" then
                                custom.animate(
                                    label,
                                    {0.1},
                                    {TextTransparency = 1},
                                    function()
                                        label.Text = tooltip
                                        custom.animate(label, {0.1}, {TextTransparency = 0})
                                    end
                                )
                            end
                        elseif tipMode == 2 then
                            refreshToolText(tooltip)
                            connection =
                                game:GetService("RunService").RenderStepped:Connect(
                                function()
                                    updateTooltipPosition()
                                end
                            )
                        end
                    end
                )

                box.MouseLeave:Connect(
                    function()
                        mouseOver = false
                        if not focused then
                            custom.animate(box, {0.2}, {BackgroundColor3 = theme.Box})
                        end
                        if tipMode == 1 then
                            if tooltip and tooltip ~= "" then
                                custom.animate(
                                    label,
                                    {0.1},
                                    {TextTransparency = 1},
                                    function()
                                        label.Text = name
                                        custom.animate(label, {0.1}, {TextTransparency = 0})
                                    end
                                )
                            end
                        elseif tipMode == 2 then
                            refreshToolText("")
                            connection:Disconnect()
                        end
                    end
                )

                box.FocusLost:Connect(boxFinished)

                local inputBox_info = {}
                inputBox_info = custom.formatTable(box_info)

                function inputBox_info:Set(text)
                    box.Text = text
                    boxFinished()
                end

                function inputBox_info:Hide()
                    box.Visible = false
                end

                function inputBox_info:Show()
                    box.Visible = true
                end

                return inputBox_info
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
                local tooltip = options.Info or nil
                local tipMode = (options.Mode == 2) and 2 or 1
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
                local holding, hovering = false, false
                slider.InputBegan:Connect(
                    function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            holding = true
                            custom.animate(fill, {0.2}, {BackgroundColor3 = theme.SliderFillSliding})
                            slide(input)
                        end
                    end
                )

                slider.InputEnded:Connect(
                    function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            custom.animate(fill, {0.2}, {BackgroundColor3 = theme.SliderFill})
                            holding = false
                            if not hovering then
                                custom.animate(slider, {0.2}, {BackgroundColor3 = theme.Slider})
                            end
                        end
                    end
                )
                local connection
                slider.MouseEnter:Connect(
                    function()
                        hovering = true
                        custom.animate(slider, {0.2}, {BackgroundColor3 = theme.SliderMouseOver})
                        if tipMode == 1 then
                            if tooltip and tooltip ~= "" then
                                custom.animate(
                                    title,
                                    {0.1},
                                    {TextTransparency = 1},
                                    function()
                                        title.Text = tooltip
                                        custom.animate(title, {0.1}, {TextTransparency = 0})
                                    end
                                )
                            end
                        elseif tipMode == 2 then
                            refreshToolText(tooltip)
                            connection =
                                game:GetService("RunService").RenderStepped:Connect(
                                function()
                                    updateTooltipPosition()
                                end
                            )
                        end
                    end
                )

                slider.MouseLeave:Connect(
                    function()
                        hovering = false
                        if not slider:FindFirstAncestorWhichIsA("TextButton") then
                            custom.animate(slider, {0.2}, {BackgroundColor3 = theme.Slider})
                        end
                        if tipMode == 1 then
                            if tooltip and tooltip ~= "" then
                                custom.animate(
                                    title,
                                    {0.1},
                                    {TextTransparency = 1},
                                    function()
                                        title.Text = name
                                        custom.animate(title, {0.1}, {TextTransparency = 0})
                                    end
                                )
                            end
                        elseif tipMode == 2 then
                            refreshToolText("")
                            connection:Disconnect()
                        end
                    end
                )

                inputService.InputChanged:Connect(
                    function(input)
                        if input.UserInputType == Enum.UserInputType.MouseMovement and holding then
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
                local tooltip = options.Info or nil
                local tipMode = (options.Mode == 2) and 2 or 1

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

                local content =
                    custom.createObject(
                    "Frame",
                    {
                        ZIndex = 10,
                        Visible = false,
                        Size = UDim2.new(1, 0, 0, 0),
                        ClipsDescendants = false,
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
                    "ScrollingFrame",
                    {
                        Size = UDim2.new(1, -6, 1, 0),
                        Position = UDim2.new(0, 6, 0, 0),
                        Active = true,
                        ScrollBarThickness = 0,
                        CanvasSize = UDim2.new(0, 0, 0, 0),
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

                contentList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(
                    function()
                        contentHolder.CanvasSize = UDim2.new(0, 0, 0, contentList.AbsoluteContentSize.Y)
                    end
                )

                local function toggleDropdown()
                    open = not open
                    if open then
                        local sizeX = UDim2.new(1, 0, 0, contentList.AbsoluteContentSize.Y)
                        content.Visible = true
                        custom.animate(
                            content,
                            {0.5},
                            {Size = sizeX},
                            function()
                                content.Visible = true
                                contentHolder.CanvasSize = UDim2.new(0, 0, 0, contentList.AbsoluteContentSize.Y)
                            end
                        )
                    else
                        local sizeX = UDim2.new(1, 0, 0, 0)
                        custom.animate(
                            content,
                            {0.5},
                            {Size = sizeX},
                            function()
                                content.Visible = false
                                contentHolder.CanvasSize = UDim2.new(0, 0, 0, contentList.AbsoluteContentSize.Y)
                            end
                        )
                    end
                end

                dropdown.MouseButton1Click:connect(toggleDropdown)
                local connection
                dropdown.MouseEnter:Connect(
                    function()
                        custom.animate(dropdown, {0.2}, {BackgroundColor3 = theme.DropdownMouseOver})
                        if tipMode == 1 then
                            if tooltip and tooltip ~= "" then
                                custom.animate(
                                    label,
                                    {0.1},
                                    {TextTransparency = 1},
                                    function()
                                        label.Text = tooltip
                                        custom.animate(label, {0.1}, {TextTransparency = 0})
                                    end
                                )
                            end
                        elseif tipMode == 2 then
                            refreshToolText(tooltip)
                            connection =
                                game:GetService("RunService").RenderStepped:Connect(
                                function()
                                    updateTooltipPosition()
                                end
                            )
                        end
                    end
                )

                dropdown.MouseLeave:Connect(
                    function()
                        custom.animate(dropdown, {0.2}, {BackgroundColor3 = theme.Dropdown})
                        if tipMode == 1 then
                            if tooltip and tooltip ~= "" then
                                custom.animate(
                                    label,
                                    {0.1},
                                    {TextTransparency = 1},
                                    function()
                                        label.Text = name
                                        custom.animate(label, {0.1}, {TextTransparency = 0})
                                    end
                                )
                            end
                        elseif tipMode == 2 then
                            refreshToolText("")
                            connection:Disconnect()
                        end
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

                --addfunctions: REMOVE, ADD

                if content.Visible then
                    local sizeX = UDim2.new(1, 0, 0, contentList.AbsoluteContentSize.Y)
                    custom.animate(content, {0.5}, {Size = sizeX})
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
                local tooltip = options.Info or nil
                local tipMode = (options.Mode == 2) and 2 or 1

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
                        Text = name or "Keybind",
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
                local binding
                keybind.MouseButton1Click:Connect(
                    function()
                        value.Text = "..."
                        custom.animate(value, {0.2}, {TextColor3 = theme.DisabledText})

                        binding =
                            inputService.InputBegan:Connect(
                            function(input)
                                local key = keys[input.KeyCode] or keys[input.UserInputType]
                                value.Text = (keys[key] or tostring(input.KeyCode):gsub("Enum.KeyCode.", ""))
                                custom.animate(value, {0.2}, {TextColor3 = theme.EnabledText})

                                if input.UserInputType == Enum.UserInputType.Keyboard then
                                    keyChosen = input.KeyCode

                                    binding:Disconnect()
                                    binding = nil
                                else
                                    keyChosen = input.UserInputType

                                    binding:Disconnect()
                                    binding = nil
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
                local connection
                keybind.MouseEnter:Connect(
                    function()
                        if tipMode == 1 then
                            if tooltip and tooltip ~= "" then
                                custom.animate(
                                    keybind,
                                    {0.1},
                                    {TextTransparency = 1},
                                    function()
                                        keybind.Text = tooltip
                                        custom.animate(keybind, {0.1}, {TextTransparency = 0})
                                    end
                                )
                            end
                        elseif tipMode == 2 then
                            refreshToolText(tooltip)
                            connection =
                                game:GetService("RunService").RenderStepped:Connect(
                                function()
                                    updateTooltipPosition()
                                end
                            )
                        end
                    end
                )
                keybind.MouseLeave:Connect(
                    function()
                        if tipMode == 1 then
                            if tooltip and tooltip ~= "" then
                                custom.animate(
                                    keybind,
                                    {0.1},
                                    {TextTransparency = 1},
                                    function()
                                        keybind.Text = name
                                        custom.animate(keybind, {0.1}, {TextTransparency = 0})
                                    end
                                )
                            end
                        elseif tipMode == 2 then
                            refreshToolText("")
                            connection:Disconnect()
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
                local tooltip = options.Info or nil
                local tipMode = (options.Mode == 2) and 2 or 1
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
                local connection
                toggleKeybind.MouseEnter:Connect(
                    function()
                        if tipMode == 1 then
                            if tooltip and tooltip ~= "" then
                                custom.animate(
                                    title,
                                    {0.1},
                                    {TextTransparency = 1},
                                    function()
                                        title.Text = tooltip
                                        custom.animate(title, {0.1}, {TextTransparency = 0})
                                    end
                                )
                            end
                        elseif tipMode == 2 then
                            refreshToolText(tooltip)
                            connection =
                                game:GetService("RunService").RenderStepped:Connect(
                                function()
                                    updateTooltipPosition()
                                end
                            )
                        end
                    end
                )
                toggleKeybind.MouseLeave:Connect(
                    function()
                        if tipMode == 1 then
                            if tooltip and tooltip ~= "" then
                                custom.animate(
                                    title,
                                    {0.1},
                                    {TextTransparency = 1},
                                    function()
                                        title.Text = name
                                        custom.animate(title, {0.1}, {TextTransparency = 0})
                                    end
                                )
                            end
                        elseif tipMode == 2 then
                            refreshToolText("")
                            connection:Disconnect()
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
                local changeAtClick = options.Click or false
                local keyChosen = default

                local mouseOver = false
                local toggled = false
                local tooltip = options.Info or nil
                local tipMode = (options.Mode == 2) and 2 or 1

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
                local temp = false
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
                    if changeAtClick then
                        Callback(toggled, temp, keyChosen)
                    else
                        Callback(toggled, keyChosen)
                    end
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
                                    if changeAtClick then
                                        temp = not temp
                                        Callback(toggled, temp, keyChosen)
                                    else
                                        Callback(toggled, keyChosen)
                                    end
                                    binding:Disconnect()
                                else
                                    keyChosen = input.UserInputType
                                    if changeAtClick then
                                        temp = not temp
                                        Callback(toggled, temp, keyChosen)
                                    else
                                        Callback(toggled, keyChosen)
                                    end
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
                                if changeAtClick then
                                    temp = not temp
                                    Callback(toggled, temp, keyChosen)
                                else
                                    Callback(toggled, keyChosen)
                                end
                            end
                        else
                            if input.UserInputType == keyChosen then
                                if changeAtClick then
                                    temp = not temp
                                    Callback(toggled, temp, keyChosen)
                                else
                                    Callback(toggled, keyChosen)
                                end
                            end
                        end
                    end
                )
                local connection
                toggleKeybind.MouseEnter:Connect(
                    function()
                        if tipMode == 1 then
                            if tooltip and tooltip ~= "" then
                                custom.animate(
                                    title,
                                    {0.1},
                                    {TextTransparency = 1},
                                    function()
                                        title.Text = tooltip
                                        custom.animate(title, {0.1}, {TextTransparency = 0})
                                    end
                                )
                            end
                        elseif tipMode == 2 then
                            refreshToolText(tooltip)
                            connection =
                                game:GetService("RunService").RenderStepped:Connect(
                                function()
                                    updateTooltipPosition()
                                end
                            )
                        end
                    end
                )
                toggleKeybind.MouseLeave:Connect(
                    function()
                        if tipMode == 1 then
                            if tooltip and tooltip ~= "" then
                                custom.animate(
                                    title,
                                    {0.1},
                                    {TextTransparency = 1},
                                    function()
                                        title.Text = name
                                        custom.animate(title, {0.1}, {TextTransparency = 0})
                                    end
                                )
                            end
                        elseif tipMode == 2 then
                            refreshToolText("")
                            connection:Disconnect()
                        end
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

                    if changeAtClick then
                        Callback(toggled, temp, keyChosen)
                    else
                        Callback(toggled, keyChosen)
                    end
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
