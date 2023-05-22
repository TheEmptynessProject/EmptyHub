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
            Name = "Test",
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

    local uniTab = mainLib:NewTab("Universal Tab 1")
    local universalColumn1 =
        uniTab:NewSection(
        {
            Name = "Universal",
            column = 1
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
                print(game.PlaceId)
                print(game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name)
                setclipboard(tostring(game.PlaceId))
                notifLib:Notify(game.PlaceId)
                notifLib:Notify(game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name)
            end
        }
    )
    universalColumn1:CreateBox(
        {
            Name = "Test",
            Callback = function(test)
                notifLib:Notify(test)
            end
        }
    )
    universalColumn1:CreateLine(2, Color3.new(255, 0, 255))
    universalColumn1:CreateButton(
        {
            Name = "Tool Reach",
            Callback = function()
                local range = 15
                local player = game:GetService("Players").LocalPlayer
                local mouse = player:GetMouse()

                local function adorn(part, radius)
                    local sphereAdornment = Instance.new("SphereHandleAdornment")
                    sphereAdornment.Name = "Reach"
                    sphereAdornment.Adornee = part
                    sphereAdornment.Radius = radius
                    sphereAdornment.Transparency = 0.8
                    sphereAdornment.Color3 = Color3.new(1, 1, 1)
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

                local function handleKeyDown(key)
                    if key == "c" then
                        range = range + 2
                        notifLib:Notify("Range Increased")
                        updateAdornment()
                    elseif key == "v" then
                        range = range - 2
                        notifLib:Notify("Range Decreased")
                        updateAdornment()
                    end
                end

                local function checkPlayerReach()
                    local p = game.Players:GetPlayers()
                    for i = 2, #p do
                        local v = p[i].Character
                        if
                            v and v:FindFirstChild("Humanoid") and not v:FindFirstChildOfClass("ForceField") and
                                v.Humanoid.Health > 0 and
                                v:FindFirstChild("HumanoidRootPart") and
                                player:DistanceFromCharacter(v.HumanoidRootPart.Position) <= range
                         then
                            local tool = player.Character and player.Character:FindFirstChildOfClass("Tool")
                            if tool and tool:FindFirstChild("Handle") then
                                tool:Activate()
                                for _, part in ipairs(v:GetDescendants()) do
                                    if part:IsA("BasePart") then
                                        firetouchinterest(tool.Handle, part, 0)
                                        firetouchinterest(tool.Handle, part, 1)
                                    end
                                end
                            end
                        end
                    end
                end
                mouse.KeyDown:Connect(handleKeyDown)
                game.Players.PlayerAdded:Connect(updateAdornment)
                game.Players.PlayerRemoving:Connect(updateAdornment)
                game:GetService("RunService").RenderStepped:Connect(checkPlayerReach)
                updateAdornment()
            end
        }
    )
    universalColumn1:CreateButton(
        {
            Name = "Tp Tool Reach",
            Callback = function()
                local range = 15
                local player = game:GetService("Players").LocalPlayer
                local mouse = player:GetMouse()

                local function adorn(part, radius)
                    local sphereAdornment = Instance.new("SphereHandleAdornment")
                    sphereAdornment.Name = "Reach"
                    sphereAdornment.Adornee = part
                    sphereAdornment.Radius = radius
                    sphereAdornment.Transparency = 0.8
                    sphereAdornment.Color3 = Color3.new(1, 1, 1)
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

                local function handleKeyDown(key)
                    if key == "c" then
                        range = range + 2
                        notifLib:Notify("Range Increased")
                        updateAdornment()
                    elseif key == "v" then
                        range = range - 2
                        notifLib:Notify("Range Decreased")
                        updateAdornment()
                    end
                end

                local function teleportToBehindPlayer(targetPlayer)
                    local targetCharacter = targetPlayer.Character
                    local targetRootPart = targetCharacter and targetCharacter:FindFirstChild("HumanoidRootPart")
                    local playerRootPart = player.Character and player.Character:FindFirstChild("HumanoidRootPart")

                    if targetRootPart and playerRootPart then
                        local targetCFrame = targetRootPart.CFrame
                        local targetLookVector = targetCFrame.LookVector
                        local offset = targetLookVector * -2

                        player.Character.HumanoidRootPart.CFrame = targetCFrame + offset
                    end
                end

                local function checkPlayerReach()
                    local p = game.Players:GetPlayers()
                    for i = 2, #p do
                        local v = p[i]
                        local vCharacter = v.Character
                        if
                            vCharacter and vCharacter:FindFirstChild("Humanoid") and
                                not vCharacter:FindFirstChildOfClass("ForceField") and
                                vCharacter.Humanoid.Health > 0 and
                                vCharacter:FindFirstChild("HumanoidRootPart") and
                                player:DistanceFromCharacter(vCharacter.HumanoidRootPart.Position) <= range
                         then
                            local tool = player.Character and player.Character:FindFirstChildOfClass("Tool")
                            if tool and tool:FindFirstChild("Handle") then
                                tool:Activate()
                                for _, part in ipairs(vCharacter:GetDescendants()) do
                                    if part:IsA("BasePart") then
                                        firetouchinterest(tool.Handle, part, 0)
                                        firetouchinterest(tool.Handle, part, 1)
                                    end
                                end
                            end
                            teleportToBehindPlayer(v)
                        end
                    end
                end

                mouse.KeyDown:Connect(handleKeyDown)
                game.Players.PlayerAdded:Connect(updateAdornment)
                game.Players.PlayerRemoving:Connect(updateAdornment)
                game:GetService("RunService").RenderStepped:Connect(checkPlayerReach)
                updateAdornment()
            end
        }
    )
    local gameScriptUrl =
        string.format(
        "https://github.com/TheEmptynessProject/EmptynessProject/raw/main/emptynessHub/games/%d.lua",
        game.PlaceId
    )

    local success, gameScript = pcall(game.HttpGet, game, gameScriptUrl)

    if success then
        return loadstring(gameScript)()
    end
end
