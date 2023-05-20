local custom = loadstring(game:HttpGet("https://raw.githubusercontent.com/TheEmptynessProject/EmptynessProject/main/emptynessHub/customFunctions.lua"))()

local function fadeObject(object, onTweenCompleted)
    local tweenInfo = custom.animate(object, {0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut}, {
        TextTransparency = 1,
        TextStrokeTransparency = 1
    }, onTweenCompleted)
end

local notifications = {}

function notifications.new(settings)
    local notificationSettings = {
        ui = {
            frame = nil,
            layout = nil
        },
        lifetime = 3,
        textColor = Color3.new(1, 1, 1),
        textSize = 14,
        textStrokeTransparency = 0,
        textStrokeColor = Color3.new(0, 0, 0),
        textFont = Enum.Font.Ubuntu
    }

    for setting, value in next, settings do
        notificationSettings[setting] = value
    end

    setmetatable(notificationSettings, {__index = notifications})
    return notificationSettings
end

function notifications:SetLifetime(lifetime)
    self.lifetime = lifetime
end

function notifications:SetTextColor(color)
    self.textColor = color
end

function notifications:SetTextSize(size)
    self.textSize = size
end

function notifications:SetTextStrokeTransparency(transparency)
    self.textStrokeTransparency = transparency
end

function notifications:SetTextStrokeColor(color)
    self.textStrokeColor = color
end

function notifications:SetTextFont(font)
    self.textFont = typeof(font) == "string" and Enum.Font[font] or font
end

function notifications:BuildUI()
    if notifications.screenGui then
        notifications.screenGui:Destroy()
    end

    notifications.screenGui = custom.createObject("ScreenGui", {ZIndexBehavior = Enum.ZIndexBehavior.Sibling, Parent = emptyCustoms})
    self.ui.frame = custom.createObject("Frame", {
        Parent = notifications.screenGui,
        BackgroundColor3 = Color3.new(1, 1, 1),
        BackgroundTransparency = 1,
        Position = UDim2.new(0.8, 0, 0.001, 0),
        Size = UDim2.new(0, 236, 0, 215)
    })

    custom.enableDrag(self.ui.frame, 0.1)

    self.ui.layout = custom.createObject("UIListLayout", {
        Parent = self.ui.frame,
        Padding = UDim.new(0, 1 + self.textSize),
        SortOrder = Enum.SortOrder.LayoutOrder
    })
end

function notifications:Notify(text)
    assert(type(text) == "string", "Invalid argument #1 in function Notify(text). Expected string.")
    local notification = custom.createObject("TextLabel", {
        Parent = self.ui.frame,
        BackgroundColor3 = Color3.new(1, 1, 1),
        BackgroundTransparency = 1,
        Size = UDim2.new(0, 222, 0, 14),
        Text = text,
        Font = self.textFont,
        TextColor3 = self.textColor,
        TextSize = self.textSize,
        TextStrokeColor3 = self.textStrokeColor,
        TextStrokeTransparency = self.textStrokeTransparency
    })
    notification.Active = true

    task.delay(self.lifetime, function()
        fadeObject(notification, function()
            notification:Destroy()
        end)
    end)
end

return notifications
