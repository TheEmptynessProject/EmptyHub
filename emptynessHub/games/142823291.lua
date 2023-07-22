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
                        wait(0.2)
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
                        wait(0.2)
                    end
                end
            end
        end
    }
)
