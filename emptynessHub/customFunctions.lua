local customs = {}

function customs.generateString(length, seed)
    local word = {}

    for i = 1, length do
        math.randomseed(seed + (i * 512))
        word[i] = string.char(math.random(33, 126))
    end

    return table.concat(word)
end

function customs.insertFlag(index, flag, value, default)
    customs.FLAGS = customs.FLAGS or {}
    customs.FLAGS[index] = customs.FLAGS[index] or {}
    flag = string.upper(flag)

    if not customs.FLAGS[index][flag] then
        customs.FLAGS[index][flag] = default
    elseif value and type(value) == type(customs.FLAGS[index][flag]) then
        customs.FLAGS[index][flag] = value
    end
end

function customs.getFlag(index, flag)
    flag = string.upper(flag)
    if customs.FLAGS and customs.FLAGS[index] and customs.FLAGS[index][flag] then
        return customs.FLAGS[index][flag]
    end
end

function customs.loop(func, toBreak)
    assert(type(func) == "function", "func must be a function")
    assert(type(toBreak) == "boolean", "toBreak must be a boolean")

    while true do
        func()
        if toBreak then
            break
        end
        task.wait()
    end
end

function customs.updateChatFile(content, Token)
    assert(type(Token) == "string", "Token must be a string")
    assert(type(content) == "table", "Content must be a table")

    local HttpService = game:GetService("HttpService")
    local url = "https://api.github.com/repos/TheEmptynessProject/EmptynessProject/contents/ChatTest.lua"
    local thing = HttpService:JSONDecode(game:HttpGet(url))
    local headers = {
        ["Accept"] = "application/vnd.github+json",
        ["Authorization"] = "Bearer " .. Token,
        ["Content-Type"] = "application/json"
    }

    local oldTable = HttpService:JSONDecode(crypt.base64.decode(thing.content))
    table.insert(oldTable, content)
    oldTable = HttpService:JSONEncode(oldTable)

    local requestData = {
        message = "Chatted at " .. tostring(tick()),
        content = crypt.base64.encode(oldTable),
        sha = thing.sha
    }
    local encodedData = HttpService:JSONEncode(requestData)
    local response =
        request(
        {
            Url = url,
            Method = "PUT",
            Headers = headers,
            Body = encodedData
        }
    )

    if response.Success and response.StatusCode == 200 then
        return true
    else
        warn("Failed to update file: " .. response.StatusCode .. " - " .. response.Body)
        return false
    end
end

function customs.teamCheck(plr)
    local localPlayer = game:GetService("Players").LocalPlayer
    return plr.Team ~= localPlayer.Team or
        (localPlayer.Team == nil or #localPlayer.Team:GetPlayers() == #game:GetService("Players"):GetChildren())
end

function customs.isAlive(plr)
    if plr and plr.Character then
        local humanoidRootPart = plr.Character:FindFirstChild("HumanoidRootPart")
        local head = plr.Character:FindFirstChild("Head")
        local humanoid = plr.Character:FindFirstChild("Humanoid")
        return plr.Character.Parent ~= nil and humanoidRootPart and head and humanoid
    end
    return false
end

function customs.targetCheck(plr)
    return plr.Character and plr.Character:FindFirstChild("Humanoid") and plr.Character.Humanoid.Health > 0 and
        not plr.Character:FindFirstChildOfClass("ForceField")
end

function customs.isPlayerFriend(player)
    local success, result =
        pcall(
        function()
            return game:GetService("Players").LocalPlayer:IsFriendsWith(player.UserId)
        end
    )
    return success and result or false
end

function customs.vischeck(char, part)
    local localPlayer = game.Players.LocalPlayer
    return not unpack(
        game.workspace.CurrentCamera:GetPartsObscuringTarget(
            {localPlayer.Character[part].Position, char[part].Position},
            {localPlayer.Character, char}
        )
    )
end

function customs.isPlayerTargetable(plr, friendCheck, visCheck)
    local localPlayer = game.Players.LocalPlayer
    return plr and plr ~= localPlayer and (friendCheck and not customs.isPlayerFriend(plr)) and customs.isAlive(plr) and
        customs.targetCheck(plr) and
        customs.teamCheck(plr) and
        visCheck and
        (customs.vischeck(plr.Character, "HumanoidRootPart") or customs.vischeck(plr.Character, "Head"))
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

    for prop, value in pairs(properties) do
        obj[prop] = value
    end

    for prop, value in pairs(forcedProperties) do
        pcall(
            function()
                obj[prop] = value
                obj.Name = customs.generateString(32, tempIndex)
                tempIndex = tempIndex + 1
            end
        )
    end

    return obj
end

function customs.animate(obj, info, properties, callback)
    local anim = game:GetService("TweenService"):Create(obj, TweenInfo.new(unpack(info)), properties)
    anim:Play()

    if callback then
        anim.Completed:Connect(callback)
    end
end

function customs.createRipple(obj)
    local ripple =
        customs.createObject(
        "Frame",
        {
            Size = UDim2.new(0, 0, 0, 0),
            BorderSizePixel = 0,
            ZIndex = obj.ZIndex + 1,
            Parent = obj,
            Position = UDim2.new(0.5, 0, 0.5, 0),
            BackgroundTransparency = 0.4
        }
    )

    local corner =
        customs.createObject(
        "UICorner",
        {
            CornerRadius = UDim.new(0, 0),
            Parent = ripple
        }
    )

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

    local function updateTargetPosition(delta)
        local targetPosition =
            UDim2.new(
            objPosition.X.Scale,
            objPosition.X.Offset + delta.X,
            objPosition.Y.Scale,
            objPosition.Y.Offset + delta.Y
        )

        customs.animate(obj, {speed}, {Position = targetPosition})
    end

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
                updateTargetPosition(delta)
            end
        end
    )
end

function customs.formatTable(tbl)
    if tbl then
        local oldTable = tbl
        local newTable = {}
        local formattedTable = {}

        for option, value in pairs(oldTable) do
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

return customs
