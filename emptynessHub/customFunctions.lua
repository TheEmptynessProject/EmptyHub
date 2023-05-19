local custom = {}; do
function custom.string(leng, seed)
    local array = {}

    for i = 1, leng do
        local leNumberPlus = (math.floor(i * 512))
        math.randomseed(seed + leNumberPlus)
        array[i] = string.char(math.random(33, 126))
    end

    return table.concat(array)
end

function custom.starts_with(str, start)
    return str:sub(1, string.len(start)) == start
end

local tempIndexx = 2

function custom.create(class, properties)
    local obj = Instance.new(class)

    local forcedProperties = {
        BorderSizePixel = 1,
        AutoButtonColor = false
    }

    for prop, v in next, properties do
        obj[prop] = v
    end

    for prop, v in next, forcedProperties do
        pcall(
            function()
                obj[prop] = v
                obj.Name = randomString(32, tempIndexx)
                tempIndexx = tempIndexx + 1
            end
        )
    end

    return obj
end

function custom.tween(obj, info, properties, callback)
    local anim = game:GetService("TweenService"):Create(obj, TweenInfo.new(unpack(info)), properties)
    anim:Play()

    if callback then
        anim.Completed:Connect(callback)
    end
end

function custom.ripple(obj)
    local ripple = Instance.new("Frame")
    Instance.new("UICorner", ripple).CornerRadius = UDim.new(0, 0)
    ripple.Size = UDim2.new(0, 0, 0, 0)
    ripple.BorderSizePixel = 0
    ripple.ZIndex = obj.ZIndex + 1
    ripple.Parent = obj
    ripple.Position = UDim2.new(0.5, 0, 0.5, 0)
    ripple.BackgroundTransparency = 0.4

    local maxSize = math.max(obj.AbsoluteSize.X, obj.AbsoluteSize.Y) * 1.5

    custom.tween(
        ripple,
        {0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out},
        {
            Size = UDim2.new(0, maxSize, 0, maxSize),
            Position = UDim2.new(0.5, -maxSize / 2, 0.5, -maxSize / 2)
        }
    )

    custom.tween(
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
function custom.drag(obj,speed)
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

                custom.tween(obj, {speed}, {Position = targetPosition})
            end
        end
    )
end

function custom.get_center(sizeX, sizeY)
    return UDim2.new(0.5, -(sizeX / 2), 0.5, -(sizeY / 2))
end

function custom.hex_to_rgb(hex)
    return Color3.fromRGB(
        tonumber("0x" .. hex:sub(2, 3)),
        tonumber("0x" .. hex:sub(4, 5)),
        tonumber("0x" .. hex:sub(6, 7))
    )
end

function custom.rgb_to_hex(color)
    return string.format(
        "#%02X%02X%02X",
        math.clamp(color.R * 255, 0, 255),
        math.clamp(color.G * 255, 0, 255),
        math.clamp(color.coreGui * 255, 0, 255)
    )
end

function custom.format_table(tbl)
    if tbl then
        local oldtbl = tbl
        local newtbl = {}
        local formattedtbl = {}

        for option, v in next, oldtbl do
            newtbl[option:lower()] = v
        end

        setmetatable(
            formattedtbl,
            {
                __newindex = function(t, k, v)
                    rawset(newtbl, k:lower(), v)
                end,
                __index = function(t, k, v)
                    return newtbl[k:lower()]
                end
            }
        )

        return formattedtbl
    else
        return {}
    end
end
end
return custom
