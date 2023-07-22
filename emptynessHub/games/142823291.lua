local default = getgenv().mainLib:NewTab("Game Tab 1")
local PlaceId =
    default:NewSection(
    {
        Name = "",
        column = 1
    }
)
local PlaceId2 =
    default:NewSection(
    {
        Name = "",
        column = 2
    }
)
local PathfindingService = game:GetService("PathfindingService")
local player = game.Players.LocalPlayer
local function getClosestCoin()
    local closestCoin, closestDistance
    for _, v in pairs(game.Workspace:GetChildren()) do
        if v:FindFirstChild("CoinContainer") then
            for _, coin in pairs(v.CoinContainer:GetChildren()) do
                if string.find(coin.Name, "Server") then
                    if not coin then
                        return nil
                    end
                    local distance =
                        (coin.Position - player.Character:FindFirstChild("HumanoidRootPart").Position).magnitude
                    if not closestDistance or distance < closestDistance then
                        closestCoin = coin
                        closestDistance = distance
                    end
                end
            end
        end
    end
    return closestCoin, closestDistance
end
local function getPlayerWithTool(murd)
    for _, play in ipairs(game.Players:GetPlayers()) do
        local character = play.Character
        local toolInBackpack = play.Backpack:FindFirstChildOfClass("Tool")
        if
            character and
                (murd and
                    (character:FindFirstChildOfClass("Tool") and character:FindFirstChildOfClass("Tool").Name == "Knife" or
                        toolInBackpack and toolInBackpack.Name == "Knife")) or
                (not murd and
                    (character:FindFirstChildOfClass("Tool") and character:FindFirstChildOfClass("Tool").Name == "Gun" or
                        toolInBackpack and toolInBackpack.Name == "Gun"))
         then
            --if gaslight then
            --if character == game.Players.LocalPlayer.Character then
            --	return getRandomPlayer(playersWithTool, game.Players.LocalPlayer)
            --end
            --end
            return play
        end
    end
    return nil
end
PlaceId:CreateToggle(
    {
        Name = "Coin Farm - Path TP",
        Callback = function(bool)
            while task.wait() do
                if not bool then
                    return
                end
                local coin = getClosestCoin()
                if coin then
                    local path = PathfindingService:CreatePath()
                    path:ComputeAsync(player.Character.HumanoidRootPart.Position, coin.Position)
                    local waypoints = path:GetWaypoints()
                    for _, waypoint in ipairs(waypoints) do
                        player.Character.HumanoidRootPart.CFrame = CFrame.new(waypoint.Position)
                        task.wait(0.1)
                    end
                end
            end
        end
    }
)
PlaceId:CreateToggle(
    {
        Name = "Coin Farm - Path Walk",
        Callback = function(bool)
            while task.wait() do
                if not bool then
                    return
                end
                local coin = getClosestCoin()
                if coin then
                    local path = PathfindingService:CreatePath()
                    path:ComputeAsync(player.Character.HumanoidRootPart.Position, coin.Position)

                    local waypoints = path:GetWaypoints()
                    for _, waypoint in ipairs(waypoints) do
                        player.Character.Humanoid:MoveTo(waypoint.Position)
                        player.Character.Humanoid.MoveToFinished:Wait()
                        task.wait(0.1)
                    end
                end
            end
        end
    }
)
PlaceId:CreateToggle(
    {
        Name = "Coin Farm - CFrame TP",
        Callback = function(bool)
            while task.wait() do
                if not bool then
                    return
                end
                local coin = getClosestCoin()
                if coin then
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = coin.CFrame
                    task.wait(2)
                end
            end
        end
    }
)
PlaceId:CreateToggle(
    {
        Name = "Coin Farm - Tween Distance",
        Callback = function(bool)
            while task.wait() do
                if not bool then
                    return
                end
                local coin, closestDistance = getClosestCoin()
                if coin then
                    local tweenTime = closestDistance / 75

                    local tweenInfo = TweenInfo.new(tweenTime, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)

                    local tween =
                        game:GetService("TweenService"):Create(
                        player.Character.HumanoidRootPart,
                        tweenInfo,
                        {
                            CFrame = targetCFrame
                        }
                    ):Play()
                    tween.Completed:Wait()
                end
            end
        end
    }
)
PlaceId:CreateToggle(
    {
        Name = "Coin Farm - Tween Time",
        Callback = function(bool)
            while task.wait() do
                if not bool then
                    return
                end
                local coin = getClosestCoin()
                if coin then
                    local tweenInfo = TweenInfo.new(5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)

                    local tween =
                        game:GetService("TweenService"):Create(
                        player.Character.HumanoidRootPart,
                        tweenInfo,
                        {
                            CFrame = targetCFrame
                        }
                    ):Play()
                    tween.Completed:Wait()
                end
            end
        end
    }
)
PlaceId:CreateKeybind(
    {
        Name = "Kill Murderer",
        Default = Enum.KeyCode.X,
        Callback = function(key)
            local target = getPlayerWithTool(true)
            if target and player.Character:FindFirstChild("Gun") then
                local targetLookVector = target.Character.HumanoidRootPart.CFrame.LookVector
                local offset = targetLookVector * -3
                player.Character.HumanoidRootPart.CFrame = (target.Character.HumanoidRootPart.CFrame + offset)
                local args = {
                    [1] = 1,
                    [2] = target.Character.HumanoidRootPart.Position,
                    [3] = "AH"
                }
                player.Character.Gun.KnifeServer.ShootGun:InvokeServer(unpack(args))
            end
        end
    }
)
PlaceId2:CreateButton(
    {
        Name = "Teleport to Safe Place",
        Callback = function()
        end
    }
)
PlaceId2:CreateButton(
    {
        Name = "Teleport to Lobby",
        Callback = function()
            player.Character.HumanoidRootPart.CFrame =
                CFrame.new(game.workspace.Lobby.Map.Spawns:FindFirstChild("Spawn").Position + Vector3.new(0, 3, 0))
        end
    }
)
PlaceId2:CreateButton(
    {
        Name = "Teleport to Murderer",
        Callback = function()
            local temp = getPlayerWithTool(true)
            if temp then
            player.Character.HumanoidRootPart.CFrame =
                temp.Character.HumanoidRootPart.CFrame
            end
        end
    }
)
PlaceId2:CreateButton(
    {
        Name = "Teleport to Sheriff",
        Callback = function()
            local temp = getPlayerWithTool(false)
            if temp then
            player.Character.HumanoidRootPart.CFrame =
                temp.Character.HumanoidRootPart.CFrame
            end
        end
    }
)
PlaceId:CreateButton(
    {
        Name = "Kill Aura",
        Callback = function()
            local tool = game:GetService("Players").LocalPlayer.Character:FindFirstChild("Knife")
            if not tool then return end
            for i,v in pairs(game.Players:GetPlayers()) do
            if v ~= game.Players.LocalPlayer then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame
            tool.Stab:FireServer("Slash")
            task.wait(0.2)
            end
            end
        end
    }
)
PlaceId2:CreateButton(
    {
        Name = "Grab Gun",
        Callback = function()
            local temp = getPlayerWithTool(false)
            if temp then
            player.Character.HumanoidRootPart.CFrame =
                temp.Character.HumanoidRootPart.CFrame
            end
        end
    }
)
PlaceId:CreateButton(
    {
        Name = "Get Murderer Chance",
        Callback = function()
            notifLib:Notify(
                "You have " ..
                    tostring(game:GetService("ReplicatedStorage").Remotes.Extras.GetChance:InvokeServer()) ..
                        "% chance to be the murderer",
                {Color = Color3.new(255, 255, 255)}
            )
        end
    }
)
PlaceId:CreateButton(
    {
        Name = "God Mode",
        Info = "Use for Trolling, as this kills you",
        Mode = 2,
        Callback = function()
            local pre = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
            game.Players.LocalPlayer.Character:BreakJoints()
            task.wait(1)
            repeat
                task.wait()
            until game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(pre)
        end
    }
)
PlaceId:CreateToggle(
    {
        Name = "No Radios",
        Callback = function(bool)
            while task.wait() do
                if not bool then
                    return
                end
                for i, v in pairs(game.Players:GetPlayers()) do
                    if v ~= player then
                        if v.Character and v:FindFirstChild("Radio") then
                            v:Destroy()
                        end
                    end
                end
            end
        end
    }
)
