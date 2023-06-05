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
if not game:IsLoaded() then
    game.Loaded:Wait()
end
if not (getgenv()[custom.generateString(32, 0)]) then
    getgenv().mainLib =
        library:New(
        {
            Name = "Emptyness Hub",
            SizeX = 500,
            SizeY = 550,
            Console = false,
            Chat = false
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
    universalColumn1:CreateLabel("Teleport")
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

    universalColumn1:CreateLine(2, Color3.new(255, 0, 255))
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
            Default = game.Players.LocalPlayer.Character.Humanoid.WalkSpeed or 10,
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
            Default = game.Players.LocalPlayer.Character.Humanoid.JumpPower or 10,
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
            Default = game.Players.LocalPlayer.CameraMaxZoomDistance,
            Decimals = 0.0001,
            Callback = function(value)
                game.Players.LocalPlayer.CameraMaxZoomDistance = value
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
                if not connection_noclip_one and on then
                    connection_noclip_one =
                        game:GetService("RunService").Stepped:connect(
                        function()
                            if not on then
                                return
                            end
                            for i, v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
                                if v:IsA("BasePart") then
                                    v.CanCollide = false
                                end
                            end
                        end
                    )
                elseif connection_noclip_one and not on then
                    for i, v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
                        if v:IsA("BasePart") then
                            v.CanCollide = true
                        end
                    end
                    connection_noclip_one:Disconnect()
                    connection_noclip_one = nil
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
                local function init()
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

                    connectionFly =
                        game:GetService("RunService").RenderStepped:Connect(
                        function()
                            local flyDirection = getMovementDirection()
                            if flying and not bodyVelocity then
                                bodyVelocity = Instance.new("BodyVelocity", rootPart)
                                bodyVelocity.MaxForce = Vector3.new(2e10, 2e10, 2e10)
                                updateFlySpeed()
                            elseif flying and bodyVelocity then
                                updateFlySpeed()
                                game:GetService("TweenService"):Create(
                                    bodyVelocity,
                                    TweenInfo.new(0.5),
                                    {Velocity = flyDirection * flySpeed}
                                ):Play()
                            elseif not flying then
                                flySpeed = 0
                                game:GetService("TweenService"):Create(
                                    bodyVelocity,
                                    TweenInfo.new(0.5),
                                    {Velocity = Vector3.new(0, 0, 0)}
                                ):Play()
                                if bodyVelocity then
                                    bodyVelocity:Destroy()
                                end
                                if connectionFly then
                                    connectionFly:Disconnect()
                                end
                            end
                        end
                    )
                end

                init()
            end
        }
    )
    local gameScriptUrl =
        string.format(
        "https://github.com/TheEmptynessProject/EmptynessProject/raw/main/emptynessHub/games/%d.lua",
        game.PlaceId
    )

    local success, gameScript = pcall(game.HttpGet, game, gameScriptUrl)

    if success and gameScript and gamescript ~= "" then
        loadstring(gameScript)()
    end
end
