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
 --
--[[local connectionFly
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
local function overdose()
    notifLib:Notify("You overdosed!", {Color = Color3.new(255, 0, 0)})
    task.wait()
    game.Players.LocalPlayer.Character:BreakJoints()
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
            local centerPosition = game.Workspace.CurrentCamera.CFrame.Position
            
			local TweenInfo1 = TweenInfo.new(5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
			local TweenInfo2 = TweenInfo.new(30, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
			local TweenInfo3 = TweenInfo.new(15, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)

			local Tween1 = TweenService:Create(PostEffect, TweenInfo2, {Size = 2^5, Intensity = 200}):Play()
            for i, v in pairs(game.Workspace:GetDescendants()) do
			local success, error = pcall(function()
                if (v.Position - centerPosition).Magnitude <= 500 then
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
				end)
				if sucess then
                        table.insert(affected, v)
                        table.insert(materials, v.Material)
                        table.insert(colors, v.Color)
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
                        task.wait()
                    end
                    if math.random() <= 0.075 then
                        overdose()
                    end
                    for i, v in ipairs(affected) do
                        local colorTween = TweenService:Create(v, TweenInfo, {Color = colors[i]})
                        colorTween:Play()
                        colorTween.Completed:Connect(
                            function()
                                v.Material = materials[i]
                            end
                        )
                    end
					local Tween2 = TweenService:Create(PostEffect, TweenInfo3, {Size = 0, Intensity = 0}):Play()
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
)]] local connection_BHOP
universalColumn2:CreateToggle_and_Keybind(
    {
        Default = Enum.KeyCode.F,
        Name = "BHOP",
        Click = true,
        Callback = function(temp, thing, keyed)
            local bool = temp and thing
            if bool then
                connection_BHOP =
                    game:GetService("RunService").Stepped:connect(
                    function()
                        if not bool then
                            return
                        end
                        if game.Players.LocalPlayer.Character.Humanoid.FloorMaterial ~= Enum.Material.Air then
                            game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
                        end
                    end
                )
            else
                connection_BHOP:Disconnect()
            end
        end
    }
)
universalColumn1:CreateButton(
    {
        Name = "TP Lowest Player Server",
        Callback = function()
            local HttpService = game:GetService("HttpService")
local request = syn and syn.request or http and http.request or http_request or request or httprequest

    local response = HttpService:JSONDecode(
        request({
            Url = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=25",
            Method = "GET"
        }).Body
    )
    local i = 0
    for _, v in pairs(response.data) do
    
        if v.playing <= i then
            game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, v.id, game.Players.LocalPlayer)
        else
        i = i+1
        end
        task.wait()
    end
        end
    }
)
universalColumn1:CreateButton(
    {
        Name = "TP Highest Player Server",
        Callback = function()
            local HttpService = game:GetService("HttpService")
local request = syn and syn.request or http and http.request or http_request or request or httprequest

    local response = HttpService:JSONDecode(
        request({
            Url = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Desc&limit=25&excludeFullGames=true",
            Method = "GET"
        }).Body
    )
    for _, v in pairs(response.data) do
	game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, v.id, game.Players.LocalPlayer)
        task.wait()
    end
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
