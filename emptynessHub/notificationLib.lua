local custom = loadstring(game:HttpGet("https://raw.githubusercontent.com/TheEmptynessProject/EmptynessProject/main/emptynessHub/customFunctions.lua"))()

local pos = {
    ["Middle"] = UDim2.new(0.445, 0, 0.7, 0),
    ["MiddleRight"] = UDim2.new(0.85, 0, 0.7, 0),
    ["MiddleLeft"] = UDim2.new(0.01, 0, 0.7, 0),
    ["Top"] = UDim2.new(0.445, 0, 0.007, 0),
    ["TopLeft"] = UDim2.new(0.06, 0, 0.001, 0),
    ["TopRight"] = UDim2.new(0.8, 0, 0.001, 0)
}; 

-- functions

function fadeObject(object, onTweenCompleted)
    local tweenInformation = custom.tween(object, {0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut}, {
        TextTransparency = 1,
        TextStrokeTransparency = 1
    }, onTweenCompleted);
end

local notifications = {}; do 
    function notifications.new(settings)
        assert(settings, "missing argument #1 in function notifications.new(settings)");
        assert(typeof(settings) == "table", string.format("expected table for argument #1 in function notifications.new(settings), got %s", typeof(settings)));
        
        local notificationSettings = {ui = {notificationsFrame = nil, notificationsFrame_UIListLayout = nil}};
        
        for setting, value in next, settings do 
            notificationSettings[setting] = value 
        end
        
        setmetatable(notificationSettings, {__index = notifications});
        return notificationSettings
    end

    function notifications:SetNotificationLifetime(lifetime)
        assert(lifetime, "Missing argument #1 in function SetNotificationLifetime(lifetime)")
        assert(typeof(lifetime) == "number", string.format("Expected number for argument #1 in function SetNotificationLifetime, got %s", typeof(lifetime)))
        self.NotificationLifetime = lifetime
    end

    function notifications:SetTextColor(color)
        assert(color, "Missing argument #1 in function SetTextColor(color)")
        assert(typeof(color) == "Color3", string.format("Expected Color3 for argument #1 in function SetTextColor, got %s", typeof(color)))
        self.TextColor = color
    end

    function notifications:SetTextSize(size)
        assert(size, "Missing argument #1 in function SetTextSize(size)")
        assert(typeof(size) == "number", string.format("Expected number for argument #1 in function SetTextSize, got %s", typeof(size)))
        self.TextSize = size
    end

    function notifications:SetTextStrokeTransparency(transparency)
        assert(transparency, "Missing argument #1 in function SetTextStrokeTransparency(transparency)")
        assert(typeof(transparency) == "number", string.format("Expected number for argument #1 in function SetTextStrokeTransparency, got %s", typeof(transparency)))
        self.TextStrokeTransparency = transparency
    end

    function notifications:SetTextStrokeColor(color)
        assert(color, "Missing argument #1 in function SetTextStrokeColor(color)")
        assert(typeof(color) == "Color3", string.format("Expected Color3 for argument #1 in function SetTextStrokeColor, got %s", typeof(color)))
        self.TextStrokeColor = color
    end

    function notifications:SetTextFont(font)
        assert(font, "Missing argument #1 in function SetTextFont(font)")
        assert(typeof(font) == "string" or typeof(font) == "EnumItem", string.format("Expected string or EnumItem for argument #1 in function SetTextFont, got %s", typeof(font)))
        self.TextFont = Enum.Font[font]
    end
    
    function notifications:BuildNotificationUI()
        if notifications_screenGui then
            notifications_screenGui:Destroy()
        end

        notifications_screenGui = custom.create("ScreenGui", {ZIndexBehavior = Enum.ZIndexBehavior.Sibling, Parent = emptyCustoms})
        self.ui.notificationsFrame = custom.create("Frame", {
            Name = "notificationsFrame",
            Parent = notifications_screenGui,
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            BackgroundTransparency = 1.000,
            Position = pos[self.NotificationPosition],
            Size = UDim2.new(0, 236, 0, 215)
        })

        custom.drag(self.ui.notificationsFrame)

        self.ui.notificationsFrame_UIListLayout = custom.create("UIListLayout", {
            Name = "notificationsFrame_UIListLayout",
            Parent = self.ui.notificationsFrame,
            Padding = UDim.new(0, 1 + self.TextSize),
            SortOrder = Enum.SortOrder.LayoutOrder
        })
    end

    function notifications:Notify(text)
        local notif = custom.create("TextLabel", {
            Name = "notification",
            Parent = self.ui.notificationsFrame,
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            BackgroundTransparency = 1.000,
            Size = UDim2.new(0, 222, 0, 14),
            Text = text,
            Font = self.TextFont,
            TextColor3 = self.TextColor,
            TextSize = self.TextSize,
            TextStrokeColor3 = self.TextStrokeColor,
            TextStrokeTransparency = self.TextStrokeTransparency
        })
        notif.Active = true

        task.delay(self.NotificationLifetime, function()
            fadeObject(notif, function()
                notif:Destroy()
            end)
        end)
    end
end

return notifications 
