local custom = loadstring(game:HttpGet("https://raw.githubusercontent.com/TheEmptynessProject/EmptynessProject/main/emptynessHub/customFunctions.lua"))()

local notifications = {}

local function BuildUI()
    if notifications.screenGui then
        return
    end

    notifications.screenGui = custom.createObject("ScreenGui", {
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        Parent = game:GetService("CoreGui")
    })

    local frame = custom.createObject("Frame", {
        Parent = notifications.screenGui,
        BackgroundColor3 = Color3.new(1, 1, 1),
        BackgroundTransparency = 1,
        Position = UDim2.new(0.8, 0, 0.001, 0),
        Size = UDim2.new(0, 236, 0, 215)
    })

    custom.enableDrag(frame, 0.1)

    notifications.ui = {
        frame = frame,
        layout = custom.createObject("UIListLayout", {
            Parent = frame,
            Padding = UDim.new(0, 16),
            SortOrder = Enum.SortOrder.LayoutOrder
        })
    }
end

function notifications:Notify(opt)
    if not notifications.ui or not notifications.ui.frame then
        BuildUI()
    end

    local options = custom.formatTable(opt)

    local lifetime = options.time or options.lifetime or 5
    local font = typeof(options.font) == "string" and Enum.Font[options.font] or options.font
    local size = options.size or options.textsize or 15
    local color = options.color or Color3.new(255, 255, 255)
    local stroke = options.stroke or Color3.new(255, 255, 255)

    notifications.ui.layout.Padding = UDim.new(0, 1 + size)

    local notification = custom.createObject("TextLabel", {
        Parent = notifications.ui.frame,
        BackgroundTransparency = 1,
        Size = UDim2.new(0, 222, 0, 14),
        Text = options.text or "",
        Font = font or Enum.Font.Ubuntu,
        TextColor3 = color,
        TextSize = size,
        TextStrokeColor3 = stroke,
        TextStrokeTransparency = 0,
        Active = true
    })

    task.delay(lifetime, function()
        fadeObject(notification, function()
            notification:Destroy()
        end)
    end)
end

return notifications
