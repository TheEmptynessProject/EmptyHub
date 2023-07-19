local default = getgenv().mainLib:NewTab("Game Tab 1")
local PlaceId =
    default:NewSection(
    {
        Name = "",
        column = 1
    }
)
local function getClosestPlayerToHead()
    local localPlayer = game.Players.LocalPlayer
    local localHeadPosition = localPlayer.Character and localPlayer.Character:FindFirstChild("Head") and localPlayer.Character.Head.Position

    if not localHeadPosition then
        return nil
    end

    local closestPlayer, closestDistance
    for _, player in pairs(game.Players:GetPlayers()) do
        if player ~= localPlayer and player.Character then
            local headPosition = player.Character:FindFirstChild("Head") and player.Character.Head.Position
            if headPosition then
                local distance = (headPosition - localHeadPosition).magnitude
                if not closestDistance or distance < closestDistance then
                    closestPlayer = player
                    closestDistance = distance
                end
            end
        end
    end

    return closestPlayer
end
PlaceId:CreateKeybind(
    {
        Name = "Shoot Near",
        Default = Enum.KeyCode.X,
        Callback = function()
        local closestPlayer = getClosestPlayerToHead()
        local player = game.Players.LocalPlayer
        local camera = game.Workspace.CurrentCamera
        
        if closestPlayer then
            local targetPosition = closestPlayer.Character and closestPlayer.Character:FindFirstChild("HumanoidRootPart") and closestPlayer.Character.HumanoidRootPart.Position
            if targetPosition then
                local direction = (targetPosition - player.Character.Head.Position).unit
                local args = {
                    [1] = Ray.new(player.Character.Head.Position, direction)
                }
                game:GetService("Players").LocalPlayer.Character.Shotgun.RemoteBridge:FireServer(unpack(args))
            end
        end
        end
    }
)
