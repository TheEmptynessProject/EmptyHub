local default = getgenv().mainLib:NewTab("Game Tab 1")
local PlaceId =
    default:NewSection(
    {
        Name = "",
        column = 1
    }
)
PlaceId:CreateKeybind(
    {
        Name = "Kill All",
        Default = Enum.KeyCode.X,
        Callback = function()
            local Players = game:GetService("Players")
            local LocalPlayer = Players.LocalPlayer
            local LocalCharacter = LocalPlayer.Character
            local HeadPosition = LocalCharacter.Head.Position
            local FireExit = LocalCharacter:FindFirstChildOfClass("Tool").Handle.FireExit

            for _, player in pairs(game.Players:GetPlayers()) do
                if player ~= LocalPlayer then
                    local character = player.Character
                    local head = character.Head
                    local headPosition = head.Position

                    local args = {
                        [1] = "shoot",
                        [2] = {
                            [1] = {
                                ["Normal"] = Vector3.new(0, 0, 0),
                                ["Position"] = headPosition,
                                ["Instance"] = head,
                                ["Material"] = Enum.Material.Pastic,
                                ["Distance"] = player:DistanceFromCharacter(HeadPosition),
                                ["From"] = FireExit
                            }
                        }
                    }

                    game:GetService("ReplicatedStorage").Events.RemoteEvent:FireServer(unpack(args))
                end
            end
        end
    }
)
