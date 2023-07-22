local default = getgenv().mainLib:NewTab("Game Tab 1")
local PlaceId =
    default:NewSection(
    {
        Name = "",
        column = 1
    }
)
local PathfindingService = game:GetService("PathfindingService")
local player = game.Players.LocalPlayer
local character = player.Character
local function getClosestCoin()
    local closestCoin, closestDistance
    for _, v in pairs(game.Workspace:GetChildren()) do
        if v:FindFirstChild("CoinContainer") then
            for _, coin in pairs(v.CoinContainer:GetChildren()) do
                if string.find(coin.Name, "Server") then
                    local distance = (coin.Position - character:FindFirstChild("HumanoidRootPart").Position).magnitude
                    if not closestDistance or distance < closestDistance then
                        closestCoin = coin
                        closestDistance = distance
                    end
                end
            end
        end
    end
    if closestCoin then
        return closestCoin
    end
end
PlaceId:CreateToggle(
    {
        Name = "Coin Farm - Path TP",
        Callback = function(bool)
            while bool do
                local coin = getClosestCoin()
                if coin then
                    local path = PathfindingService:CreatePath()
                    path:ComputeAsync(character.HumanoidRootPart.Position, coin.Position)
                    local waypoints = path:GetWaypoints()
                    for _, waypoint in ipairs(waypoints) do
                        character.HumanoidRootPart.CFrame = CFrame.new(waypoint.Position)
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
            while bool do
                local coin = getClosestCoin()
                if coin then
                    local path = PathfindingService:CreatePath()
                    path:ComputeAsync(character.HumanoidRootPart.Position, coin.Position)

                    local waypoints = path:GetWaypoints()
                    for _, waypoint in ipairs(waypoints) do
                        character.Humanoid:MoveTo(waypoint.Position)
                        character.Humanoid.MoveToFinished:Wait()
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
            while bool do
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
            while bool do
                local coin = getClosestCoin()
                if coin then
                    local tweenTime = closestDistance / 75

                    local tweenInfo = TweenInfo.new(tweenTime, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)

                    local tween =
                        TweenService:Create(
                        character.HumanoidRootPart,
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
            while bool do
                local coin = getClosestCoin()
                if coin then
                    local tweenInfo = TweenInfo.new(5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)

                    local tween =
                        TweenService:Create(
                        character.HumanoidRootPart,
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
PlaceId:CreateButton(
    {
        Name = "Teleport to Safe Place",
        Callback = function(bool)
            while bool do
                local coin = getClosestCoin()
                if coin then
                    local path = PathfindingService:CreatePath()
                    path:ComputeAsync(character.HumanoidRootPart.Position, coin.Position)

                    local waypoints = path:GetWaypoints()
                    for _, waypoint in ipairs(waypoints) do
                        character.Humanoid:MoveTo(waypoint.Position)
                        character.Humanoid.MoveToFinished:Wait()
                        wait(0.1)
                    end
                end
            end
        end
    }
)
PlaceId:CreateButton(
    {
        Name = "Teleport to Lobby",
        Callback = function()
            character.HumanoidRootPart.CFrame = game.Lobby.Map.Spawns:FindFirstChild("Spawn").CFrame
        end
    }
)
PlaceId:CreateToggle(
    {
        Name = "No Radios",
        Callback = function(bool)
            while bool do
                for i, v in pairs(game.workspace:GetDescendants()) do
                    if v.Parent ~= "Lobby" and v.Name == "Radio" then
                        v:Destroy()
                    end
                end
                task.wait()
            end
        end
    }
)
