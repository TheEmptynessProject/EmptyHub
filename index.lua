if not game:IsLoaded() then
    game.Loaded:Wait()
end
local custom =
    loadstring(
    game:HttpGet(
        "https://raw.githubusercontent.com/TheEmptynessProject/EmptynessProject/main/emptynessHub/customFunctions.lua"
    )
)()
local notificationLib =
    loadstring(
    game:HttpGet(
        "https://raw.githubusercontent.com/TheEmptynessProject/EmptynessProject/main/emptynessHub/notificationLib.lua"
    )
)()
local library =
    loadstring(
    game:HttpGet("https://raw.githubusercontent.com/TheEmptynessProject/EmptynessProject/main/emptynessHub/lib.lua")
)()
getgenv().mainLib =
    library:New(
    {
        Name = "Emptyness Hub",
        SizeX = 500,
        SizeY = 550
    }
)
getgenv().notifLib =
    notificationLib.new(
    {
        lifetime = 5,
        textColor = Color3.fromRGB(255, 255, 255),
        textSize = 20,
        textStrokeTransparency = 0.7,
        textStrokeColor = Color3.fromRGB(0, 0, 0),
        textFont = Enum.Font.Ubuntu
    }
)

notifLib:BuildUI()
local uniTab = mainLib:NewTab("Universal")
local randomThingsTab = mainLib:NewTab("Random")
local universalColumn1 =
    uniTab:NewSection(
    {
        Name = "",
        column = 1
    }
)
local universalColumn2 =
    uniTab:NewSection(
    {
        Name = "",
        column = 2
    }
)
local randomColumn1 =
    randomThingsTab:NewSection(
    {
        Name = "",
        column = 1
    }
)
local randomColumn2 =
    randomThingsTab:NewSection(
    {
        Name = "",
        column = 2
    }
)
universalColumn1:CreateKeybind(
    {
        Name = "Hide GUI",
        Default = library.toggleBind,
        Callback = function(key)
            task.wait()
            library.toggleBind = key
        end
    }
)
universalColumn1:CreateKeybind(
    {
        Name = "Close GUI",
        Default = library.closeBind,
        Callback = function(key)
            task.wait()
            library.closeBind = key
        end
    }
)
universalColumn1:CreateButton(
    {
        Name = "Get Place Info",
        Callback = function()
            setclipboard(tostring(game.PlaceId))
        end
    }
)
universalColumn1:CreateButton(
    {
        Name = "Get Self Position",
        Callback = function()
            setclipboard(tostring(game.Players.LocalPlayer.Character.HumanoidRootPart.Position))
        end
    }
)
universalColumn1:CreateLabel(
    {
        Name = "Teleport to Player"
    }
)
local dropdownPlayerArray = {}
for _, player in ipairs(game.Players:GetPlayers()) do
    table.insert(dropdownPlayerArray, player.DisplayName)
end
game.Players.PlayerAdded:Connect(
    function(player)
        table.insert(dropdownPlayerArray, player.DisplayName)
    end
)

game.Players.PlayerRemoving:Connect(
    function(player)
        for i, playerName in ipairs(dropdownPlayerArray) do
            if playerName == player.DisplayName then
                table.remove(dropdownPlayerArray, i)
                break
            end
        end
    end
)

universalColumn1:CreateDropdown(
    {
        Content = dropdownPlayerArray,
        MultiChoice = false,
        Callback = function(selectedPlayer)
            local targetPlayer = nil
            for _, player in ipairs(game.Players:GetPlayers()) do
                if player.DisplayName == selectedPlayer then
                    targetPlayer = player
                    break
                end
            end

            if targetPlayer then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame =
                    targetPlayer.Character.HumanoidRootPart.CFrame
            else
                notifLib:Notify("Error", {Color = Color3.new(255, 0, 0)})
            end
        end
    }
)
universalColumn1:CreateToggle(
    {
        Name = "Disable Invisible Parts",
        Callback = function(bool)
            for i, v in pairs(workspace:GetDescendants()) do
                if v:IsA("BasePart") and v.Transparency == 1 and v.CanCollide then
                    if bool then
                        v.CanCollide = false
                    else
                        v.CanCollide = true
                    end
                end
            end
        end
    }
)
universalColumn1:CreateLine(
    {
        Size = 2,
        Color = Color3.new(255, 0, 255)
    }
)
universalColumn2:CreateToggle_and_Keybind(
    {
        Name = "Hex Spitter Kill All",
        Default = Enum.KeyCode.G,
        Callback = function(bool, key)
            if not bool then
                return
            end
            for _, player in ipairs(game.Players:GetPlayers()) do
                if
                    player.Character and player.Character:FindFirstChild("Humanoid") and
                        player.Character.Humanoid.Health > 0 and
                        not player.Character:FindFirstChildOfClass("ForceField")
                 then
                    notifLib:Notify(
                        "Player " .. player.Name .. " now has " .. player.Character.Humanoid.Health,
                        {Color = Color3.new(255, 255, 255)}
                    )
                    local c = {
                        [1] = "RayHit",
                        [2] = {
                            ["Position"] = Vector3.new(0, 0, 0),
                            ["Hit"] = player.Character.HumanoidRootPart
                        }
                    }
                    game:GetService("Players").LocalPlayer.Character.HexSpitter.Remotes.ServerControl:InvokeServer(
                        unpack(c)
                    )
                    task.wait()
                end
            end
        end
    }
)
universalColumn2:CreateSlider(
    {
        Name = "WalkSpeed",
        Min = 10,
        Max = 200,
        Default = math.floor(game.Players.LocalPlayer.Character.Humanoid.WalkSpeed) or 10,
        Decimals = 1,
        Callback = function(value)
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = value
        end
    }
)
universalColumn2:CreateSlider(
    {
        Name = "JumpPower",
        Min = 10,
        Max = 200,
        Default = math.floor(game.Players.LocalPlayer.Character.Humanoid.JumpPower) or 10,
        Decimals = 1,
        Callback = function(value)
            game.Players.LocalPlayer.Character.Humanoid.JumpPower = value
        end
    }
)
universalColumn2:CreateSlider(
    {
        Name = "Camera Zoom Distance",
        Min = 0,
        Max = 200000,
        Default = math.floor(game.Players.LocalPlayer.CameraMaxZoomDistance) or 0,
        Decimals = 0.0001,
        Callback = function(value)
            game.Players.LocalPlayer.CameraMaxZoomDistance = value
        end
    }
)
universalColumn2:CreateSlider(
    {
        Name = "Gravity",
        Min = 0,
        Max = 200,
        Default = math.floor(game.workspace.Gravity) or 196,
        Decimals = 0.1,
        Callback = function(value)
            game.workspace.Gravity = value
        end
    }
)
local temporaryThing = false
universalColumn2:CreateToggle_and_Keybind(
    {
        Default = Enum.KeyCode.Space,
        Name = "Infinite Jump",
        Click = false,
        Callback = function(bool, keyed)
            if bool and not temporaryThing then
                temporaryThing = true
            elseif bool and temporaryThing then
                game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
            elseif not bool then
                temporaryThing = false
            end
        end
    }
)
local connection_noclip_one
universalColumn2:CreateToggle_and_Keybind(
    {
        Default = Enum.KeyCode.E,
        Name = "Noclip",
        Click = true,
        Callback = function(bool, toggled, keyed)
            local on = bool and toggled
            if on then
                connection_noclip_one =
                    game:GetService("RunService").Stepped:connect(
                    function()
                        if not on then
                            return
                        end
                        for i, v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
                            if v:IsA("BasePart") then
                                if v.CanCollide then
                                    v.CanCollide = false
                                end
                            end
                        end
                    end
                )
            else
                for i, v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
                    if v:IsA("BasePart") then
                        if not v.CanCollide then
                            v.CanCollide = true
                        end
                    end
                end

                connection_noclip_one:Disconnect()
            end
        end
    }
)
local connectionFly
universalColumn2:CreateToggle_and_Keybind(
    {
        Default = Enum.KeyCode.G,
        Name = "Fly",
        Click = true,
        Callback = function(bool, toggled, keyed)
            local player = game.Players.LocalPlayer
            local character = player.Character or player.CharacterAdded:Wait()
            local humanoid = character:WaitForChild("Humanoid")
            local rootPart = character:WaitForChild("HumanoidRootPart")

            local flying = toggled and bool
            local flySpeed = 0
            local flyMaxSpeed = 500
            print(flying)
            local mouse = player:GetMouse()
            local bodyVelocity

            local function updateFlySpeed()
                if flySpeed < flyMaxSpeed then
                    flySpeed = flySpeed + 1
                end
            end

            local function getMovementDirection()
                local camera = game.Workspace.CurrentCamera
                local lookVector = camera.CFrame.LookVector
                local rightVector = camera.CFrame.RightVector
                local flyDirection = Vector3.new(0, 0, 0)

                if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.W) then
                    flyDirection = flyDirection + lookVector
                end
                if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.S) then
                    flyDirection = flyDirection - lookVector
                end
                if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.A) then
                    flyDirection = flyDirection - rightVector
                end
                if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.D) then
                    flyDirection = flyDirection + rightVector
                end

                return flyDirection
            end
            if flying then
                connectionFly =
                    game:GetService("RunService").RenderStepped:Connect(
                    function()
                        if not flying then
                            return
                        end
                        if not bodyVelocity then
                            bodyVelocity = Instance.new("BodyVelocity", rootPart)
                            bodyVelocity.MaxForce = Vector3.new(2e10, 2e10, 2e10)
                            updateFlySpeed()
                        else
                            game:GetService("TweenService"):Create(
                                bodyVelocity,
                                TweenInfo.new(0.5),
                                {Velocity = getMovementDirection() * flySpeed}
                            ):Play()
                            updateFlySpeed()
                        end
                    end
                )
            else
                flySpeed = 0
                if bodyVelocity then
                    game:GetService("TweenService"):Create(
                        bodyVelocity,
                        TweenInfo.new(0.5),
                        {Velocity = Vector3.new(0, 0, 0)}
                    ):Play()
                    bodyVelocity:Destroy()
                    bodyVelocity = nil
                end
                if connectionFly then
                    connectionFly:Disconnect()
                end
            end
        end
    }
)
custom.insertFlag(1, "Safety", bool, false)
custom.insertFlag(1, "SafetyRange", value, 12)
custom.insertFlag(1, "Feet", bool, false)
custom.insertFlag(1, "Protection", bool, false)
custom.insertFlag(1, "reachonly", bool, false)
custom.insertFlag(1, "vpplus", bool, false)
custom.insertFlag(1, "toolcheck", bool, false)
universalColumn2:CreateLine(
    {
        Size = 2,
        Color = Color3.new(255, 0, 255)
    }
)
universalColumn2:CreateToggle(
    {
        Name = "Safety", --(Rotates your character paralell to the ground with sword pointing at the sky when someone is getting near)
        Callback = function(bool)
            custom.insertFlag(1, "Safety", bool)
        end
    }
)
universalColumn2:CreateSlider(
    {
        Name = "Safety Range",
        Min = 10,
        Max = 30,
        Default = 12,
        Callback = function(value)
            custom.insertFlag(1, "SafetyRange", value)
        end
    }
)
universalColumn2:CreateToggle(
    {
        Name = "Target Feet", --(Attacks feet instead of the back of the player)
        Callback = function(bool)
            custom.insertFlag(1, "Feet", bool)
        end
    }
)
universalColumn2:CreateToggle(
    {
        Name = "Protection", --(lays you with your back on the floor, may be harder to hit)
        Callback = function(bool)
            custom.insertFlag(1, "Protection", bool)
        end
    }
)
universalColumn2:CreateToggle(
    {
        Name = "Only Reach", --(No teleporting, only reach)
        Callback = function(bool)
            custom.insertFlag(1, "reachonly", bool)
        end
    }
)
universalColumn2:CreateToggle(
    {
        Name = "Void Protection++", --(if target or user goes lower than y coordinates, then local player is kicked)
        Callback = function(bool)
            custom.insertFlag(1, "vpplus", bool)
        end
    }
)

universalColumn2:CreateToggle(
    {
        Name = "Tool equipped check", --(Check if tool is equipped to teleport or attack)
        Callback = function(bool)
            custom.insertFlag(1, "toolcheck", bool)
        end
    }
)
universalColumn2:CreateButton( --c to increase range, v to decrease, g to lay on floor
    {
        Name = "Activate",
        Callback = function()
            local range = 15
            local player = game:GetService("Players").LocalPlayer
            local mouse = player:GetMouse()
            local safetyRange = custom.getFlag(1, "SafetyRange")
            local part1 = Instance.new("Part")
            part1.Position = Vector3.new(0, -safetyRange, 0)
            part1.Size = Vector3.new(5000, 0.1, 5000)
            part1.Anchored = true
            part1.Parent = game.Workspace
            part1.Transparency = 0.9
            local function adorn(part, radius)
                local sphereAdornment = Instance.new("SphereHandleAdornment")
                sphereAdornment.Name = "Reach"
                sphereAdornment.Adornee = part
                sphereAdornment.Radius = radius
                sphereAdornment.Transparency = 0.9
                sphereAdornment.Color3 = Color3.new(0, 1, 0)
                sphereAdornment.AlwaysOnTop = true
                sphereAdornment.ZIndex = -1
                sphereAdornment.Parent = part
            end
            local function updateAdornment()
                local head = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
                if head then
                    local reachAdornment = head:FindFirstChild("Reach")
                    if reachAdornment and reachAdornment:IsA("SphereHandleAdornment") then
                        reachAdornment.Radius = range
                    else
                        adorn(head, range)
                    end
                end
            end
            local debounce = false

            local function handleKeyDown(key)
                if debounce then
                    return
                end
                debounce = true

                if key == "c" then
                    range = range + 5
                    notifLib:Notify("Increased Range", {Color = Color3.new(255, 255, 255)})
                    updateAdornment()
                elseif key == "v" then
                    range = range - 5
                    notifLib:Notify("Decreased Range", {Color = Color3.new(255, 255, 255)})
                    updateAdornment()
                elseif key == "g" then
                    player.Character.HumanoidRootPart.CFrame =
                        CFrame.new(player.Character.HumanoidRootPart.Position) * CFrame.Angles(math.rad(90), 0, 0)
                end

                task.delay(
                    0.1,
                    function()
                        debounce = false
                    end
                )
            end
            local lastTarget
            local function teleportToBehindPlayer(targetPlayer)
                local targetRootPart = targetPlayer.Character:FindFirstChild("HumanoidRootPart")

                local targetHumanoid = targetPlayer.Character:FindFirstChild("Humanoid")
                local playerHumanoid = player.Character:FindFirstChild("Humanoid")
                local tool = player.Character:FindFirstChildOfClass("Tool")

                if custom.getFlag(1, "toolcheck") and (not tool or not tool:FindFirstChild("Handle")) then
                    return
                end
                if not custom.getFlag(1, "reachonly") then
                    if custom.isAlive(targetPlayer) and custom.isAlive(player) then
                        if custom.getFlag(1, "Safety") then
                            if custom.getFlag(1, "Feet") then
                                local targetFeetPosition =
                                    CFrame.new(targetRootPart.Position - Vector3.new(0, targetRootPart.Size.Y / 2, 0))
                                if targetFeetPosition.Y < -safetyRange and custom.getFlag(1, "vpplus") then
                                    game.Players.LocalPlayer:Kick("Void Protection")
                                end
                                local offset =
                                    Vector3.new(0, -targetRootPart.Size.Y - player.Character.HumanoidRootPart.Size.Y, 0)
                                offset = offset * (safetyRange / 10)
                                player.Character.HumanoidRootPart.CFrame =
                                    (targetFeetPosition + offset) * CFrame.Angles(math.rad(90), 0, 0)
                            else
                                local targetLookVector = targetRootPart.CFrame.LookVector
                                if targetRootPart.CFrame.Y < -safetyRange and custom.getFlag(1, "vpplus") then
                                    game.Players.LocalPlayer:Kick("Void Protection")
                                end
                                local offset = targetLookVector * -safetyRange
                                player.Character.HumanoidRootPart.CFrame = (targetRootPart.CFrame + offset)
                            end

                            if (safetyRange <= 6) then
                                safetyRange = 12
                            end
                            if (lastTarget and lastTarget ~= targetPlayer) then
                                safetyRange = 12
                            end
                            lastTarget = targetPlayer
                            safetyRange = safetyRange - 2
                        else
                            if custom.getFlag(1, "Feet") then
                                local targetFeetPosition =
                                    CFrame.new(targetRootPart.Position - Vector3.new(0, targetRootPart.Size.Y / 2, 0))
                                if targetFeetPosition.Y < -safetyRange and custom.getFlag(1, "vpplus") then
                                    game.Players.LocalPlayer:Kick("Void Protection")
                                end
                                local offset =
                                    Vector3.new(0, -targetRootPart.Size.Y - player.Character.HumanoidRootPart.Size.Y, 0)
                                player.Character.HumanoidRootPart.CFrame =
                                    (targetFeetPosition + offset) * CFrame.Angles(math.rad(90), 0, 0)
                            else
                                local targetLookVector = targetRootPart.CFrame.LookVector
                                if targetRootPart.CFrame.Y < -safetyRange and custom.getFlag(1, "vpplus") then
                                    game.Players.LocalPlayer:Kick("Void Protection")
                                end
                                local offset = targetLookVector * -3
                                player.Character.HumanoidRootPart.CFrame = (targetRootPart.CFrame + offset)
                            end
                            lastTarget = targetPlayer
                        end
                    end
                end

                if tool then
                    tool:Activate()
                    for _, part in ipairs(targetPlayer.Character:GetDescendants()) do
                        if part:IsA("BasePart") then
                            firetouchinterest(tool.Handle, part, 0)
                            firetouchinterest(tool.Handle, part, 1)
                        end
                    end
                end
            end

            local function checkPlayerReach()
                local playerCharacter = player.Character
                if not playerCharacter then
                    return
                end

                local playerHumanoidRootPart = playerCharacter:FindFirstChild("HumanoidRootPart")
                if not playerHumanoidRootPart then
                    return
                end

                local playerPosition = playerHumanoidRootPart.Position

                for _, v in ipairs(game.Players:GetPlayers()) do
                    if v ~= player then
                        local vCharacter = v.Character
                        if vCharacter and vCharacter:FindFirstChild("HumanoidRootPart") then
                            if custom.isPlayerTargetable(v, false, false) then
                                if v:DistanceFromCharacter(playerPosition) <= range then
                                    teleportToBehindPlayer(v)
                                elseif
                                    v:DistanceFromCharacter(playerPosition) <= range + 10 and
                                        custom.getFlag(1, "Protection")
                                 then
                                    player.Character.HumanoidRootPart.CFrame =
                                        CFrame.new(player.Character.HumanoidRootPart.Position + Vector3.new(0, -5, 0)) *
                                        CFrame.Angles(math.rad(90), 0, 0)
                                    task.wait(0.1)
                                end
                            end
                        end
                    end
                end
            end

            mouse.KeyDown:Connect(handleKeyDown)
            player.CharacterAdded:Connect(updateAdornment)
            player.CharacterRemoving:Connect(updateAdornment)
            game:GetService("RunService").RenderStepped:Connect(checkPlayerReach)
            updateAdornment()
        end
    }
)
local bodyVelocity = Instance.new("BodyVelocity")
bodyVelocity.Velocity = Vector3.new(math.huge, math.huge, math.huge)
bodyVelocity.MaxForce = Vector3.new(0, 0, 0)
local allToggled = 0

randomColumn1:CreateToggle(
    {
        Name = "Block X POS",
        Callback = function(bool)
            if bool then
                allToggled = allToggled + 1
                bodyVelocity.MaxForce = bodyVelocity.MaxForce + Vector3.new(math.huge, 0, 0)
                bodyVelocity.Velocity = bodyVelocity.Velocity - Vector3.new(math.huge, 0, 0)
            else
                allToggled = allToggled - 1
                bodyVelocity.MaxForce = bodyVelocity.MaxForce - Vector3.new(math.huge, 0, 0)
                bodyVelocity.Velocity = bodyVelocity.Velocity + Vector3.new(math.huge, 0, 0)
            end

            if allToggled == 0 then
                bodyVelocity.Parent = nil
                return
            else
                bodyVelocity.Parent = game.Players.LocalPlayer.Character.HumanoidRootPart
            end
        end
    }
)

randomColumn1:CreateToggle(
    {
        Name = "Block Y POS",
        Callback = function(bool)
            if bool then
                allToggled = allToggled + 1
                bodyVelocity.MaxForce = bodyVelocity.MaxForce + Vector3.new(0, math.huge, 0)
                bodyVelocity.Velocity = bodyVelocity.Velocity - Vector3.new(0, math.huge, 0)
            else
                allToggled = allToggled - 1
                bodyVelocity.MaxForce = bodyVelocity.MaxForce - Vector3.new(0, math.huge, 0)
                bodyVelocity.Velocity = bodyVelocity.Velocity + Vector3.new(0, math.huge, 0)
            end

            if allToggled == 0 then
                bodyVelocity.Parent = nil
                return
            else
                bodyVelocity.Parent = game.Players.LocalPlayer.Character.HumanoidRootPart
            end
        end
    }
)

randomColumn1:CreateToggle(
    {
        Name = "Block Z POS",
        Callback = function(bool)
            if bool then
                allToggled = allToggled + 1
                bodyVelocity.MaxForce = bodyVelocity.MaxForce + Vector3.new(0, 0, math.huge)
                bodyVelocity.Velocity = bodyVelocity.Velocity - Vector3.new(0, 0, math.huge)
            else
                allToggled = allToggled - 1
                bodyVelocity.MaxForce = bodyVelocity.MaxForce - Vector3.new(0, 0, math.huge)
                bodyVelocity.Velocity = bodyVelocity.Velocity + Vector3.new(0, 0, math.huge)
            end

            if allToggled == 0 then
                bodyVelocity.Parent = nil
                return
            else
                bodyVelocity.Parent = game.Players.LocalPlayer.Character.HumanoidRootPart
            end
        end
    }
)

randomColumn2:CreateLine(
    {
        Size = 2,
        Color = Color3.new(0, 0, 0)
    }
)
randomColumn2:CreateLabel(
    {
        Name = "DRUGS"
    }
)
randomColumn2:CreateLine(
    {
        Size = 2,
        Color = Color3.new(0, 0, 0)
    }
)
local function overdose()
    notifLib:Notify("You overdosed!", {Color = Color3.new(255, 0, 0)})
    task.wait()
    game.Players.LocalPlayer:BreakJoints()
end
local PostEffect = Instance.new("BloomEffect")
PostEffect.Intensity = 200
PostEffect.Size = 2 ^ 10
PostEffect.Threshold = 1
randomColumn2:CreateButton(
    {
        Name = "Take LSD",
        Callback = function()
            local TweenService = game:GetService("TweenService")
            local affected = {}
            local materials = {}
            local colors = {}
            local coroutines = {}
            local centerPosition = game.Workspace.CurrentCamera.CFrame.Position -- Set the center position as the camera's position
            PostEffect.Parent = workspace.CurrentCamera
            for i, v in pairs(game.Workspace:GetDescendants()) do
                if (v.Position - centerPosition).Magnitude <= 500 then -- Check if the part is within the desired radius
                    local success, error =
                        pcall(
                        function()
                            table.insert(affected, v)
                            table.insert(materials, v.Material)
                            table.insert(colors, v.Color)
                            v.Material = Enum.Material.Neon

                            local co =
                                coroutine.create(
                                function()
                                    while true do
                                        for i = 0, 1, 1 / 50 do
                                            v.Color = Color3.fromHSV(i, 1, 1)
                                            task.wait()
                                        end
                                    end
                                end
                            )

                            table.insert(coroutines, co)
                        end
                    )

                    if not success then
                        -- Handle the error here if needed
                        print("Error occurred:", error)
                    end

                    task.wait(0.002)
                end
            end

            for _, co in ipairs(coroutines) do
                coroutine.resume(co)
            end

            task.delay(
                5,
                function()
                    for _, co in ipairs(coroutines) do
                        coroutine.close(co)
                        PostEffect.Parent = nil
                        task.wait()
                    end
                    if math.random() <= 0.075 then
                        overdose()
                    end
                    for i, v in ipairs(affected) do
                        local TweenInfo = TweenInfo.new(25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)

                        local colorTween = TweenService:Create(v, TweenInfo, {Color = colors[i]})
                        colorTween:Play()
                        colorTween.Completed:Connect(
                            function()
                                task.wait(0.5)
                                v.Material = materials[i]
                            end
                        )
                    end
                end
            )
        end
    }
)
randomColumn2:CreateButton( --Motion Blur and speed?
    {
        Name = "Take Cocaine",
        Callback = function()
        end
    }
)
local gameScriptUrl =
    string.format(
    "https://github.com/TheEmptynessProject/EmptynessProject/raw/main/emptynessHub/games/%d.lua",
    game.PlaceId
)

pcall(
    function()
        loadstring(game:HttpGet(gameScriptUrl))()
    end
)
