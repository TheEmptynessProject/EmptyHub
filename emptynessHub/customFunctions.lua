local customs = {}
do
    function customs.generateString(length, seed)
        local word = {}

        for i = 1, length do
            local real = (math.floor(i * 512))
            math.randomseed(seed + real)
            word[i] = string.char(math.random(33, 126))
        end

        return table.concat(word)
    end
    
    function customs.getCenterPosition(sizeX, sizeY)
        return UDim2.new(0.5, -(sizeX / 2), 0.5, -(sizeY / 2))
    end

    local tempIndex = 2
    function customs.createObject(class, properties)
        local obj = Instance.new(class)

        local forcedProperties = {
            BorderSizePixel = 1,
            AutoButtonColor = false
        }

        for prop, value in next, properties do
            obj[prop] = value
        end

        for prop, value in next, forcedProperties do
            pcall(
                function()
                    obj[prop] = value
                    obj.Name = createTooltip.generateString(32, tempIndex)
                    tempIndex = tempIndex + 1
                end
            )
        end

        return obj
    end

    function customs.createTooltip(parent, text)
        if text then
            local frame = customs.createObject("Frame", {
                Size = UDim2.new(0, 200, 0, 50),
                Position = UDim2.new(0, 0, 0, 0),
                BackgroundColor3 = Color3.new(1, 1, 1),
                BorderSizePixel = 0,
                Parent = parent
            })

            local label = customs.createObject("TextLabel", {
                Size = UDim2.new(1, 0, 1, 0),
                Position = UDim2.new(0, 0, 0, 0),
                BackgroundTransparency = 1,
                TextColor3 = Color3.new(0, 0, 0),
                Text = text,
                Parent = frame
            })

            parent.MouseEnter:Connect(
                function()
                    frame.Visible = true
                end
            )

            parent.MouseLeave:Connect(
                function()
                    frame.Visible = false
                end
            )

            frame.Visible = false

            local function updateTooltipPosition(mouse)
                frame.Position = UDim2.new(0, mouse.X + 10, 0, mouse.Y + 10)
            end

            game:GetService("UserInputService").InputChanged:Connect(
                function(input)
                    if input.UserInputType == Enum.UserInputType.MouseMovement and frame.Visible then
                        updateTooltipPosition(input.Position)
                    end
                end
            )
        end
    end
    
    function customs.animate(obj, info, properties, callback)
        local anim = game:GetService("TweenService"):Create(obj, TweenInfo.new(unpack(info)), properties)
        anim:Play()

        if callback then
            anim.Completed:Connect(callback)
        end
    end

    function customs.createRipple(obj)
        local ripple = customs.createObject("Frame", {
            Size = UDim2.new(0, 0, 0, 0),
            BorderSizePixel = 0,
            ZIndex = obj.ZIndex + 1,
            Parent = obj,
            Position = UDim2.new(0.5, 0, 0.5, 0),
            BackgroundTransparency = 0.4
        })

        local corner = customs.createObject("UICorner", {
            CornerRadius = UDim.new(0, 0),
            Parent = ripple
        })

        local maxSize = math.max(obj.AbsoluteSize.X, obj.AbsoluteSize.Y) * 1.5

        customs.animate(
            ripple,
            {0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out},
            {
                Size = UDim2.new(0, maxSize, 0, maxSize),
                Position = UDim2.new(0.5, -maxSize / 2, 0.5, -maxSize / 2)
            }
        )

        customs.animate(
            ripple,
            {0.75, Enum.EasingStyle.Quad, Enum.EasingDirection.Out},
            {
                BackgroundTransparency = 1
            },
            function()
                ripple:Destroy()
            end
        )
    end


    function customs.enableDrag(obj, speed)
        local start, objPosition, dragging

        obj.InputBegan:Connect(
            function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = true
                    start = input.Position
                    objPosition = obj.Position
                end
            end
        )

        obj.InputEnded:Connect(
            function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = false
                end
            end
        )

        game:GetService("UserInputService").InputChanged:Connect(
            function(input)
                if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then
                    local delta = input.Position - start
                    local targetPosition =
                        UDim2.new(
                        objPosition.X.Scale,
                        objPosition.X.Offset + delta.X,
                        objPosition.Y.Scale,
                        objPosition.Y.Offset + delta.Y
                    )

                    customs.animate(obj, {speed}, {Position = targetPosition})
                end
            end
        )
    end

    function customs.formatTable(tbl)
        if tbl then
            local oldTable = tbl
            local newTable = {}
            local formattedTable = {}

            for option, value in next, oldTable do
                newTable[option:lower()] = value
            end

            setmetatable(
                formattedTable,
                {
                    __newindex = function(t, k, v)
                        rawset(newTable, k:lower(), v)
                    end,
                    __index = function(t, k, v)
                        return newTable[k:lower()]
                    end
                }
            )

            return formattedTable
        else
            return {}
        end
    end
end

return customs
