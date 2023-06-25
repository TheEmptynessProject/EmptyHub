local custom =
    loadstring(
    game:HttpGet(
        "https://raw.githubusercontent.com/TheEmptynessProject/EmptynessProject/main/emptynessHub/customFunctions.lua"
    )
)()
local default = getgenv().mainLib:NewTab("Game Tab 1")
local PlaceId =
    default:NewSection(
    {
        Name = "",
        column = 1
    }
)
PlaceId:CreateToggle(
    {
        Name = "AutoPlay",
        Callback = function(bool)
            local ball = nil
            local function temp()
                task.wait()
                game:GetService("UserInputService").MouseBehavior = Enum.MouseBehavior.LockCenter
                if game.workspace.Marker:FindFirstChild("Ball") then
                    ball = game.workspace.Marker:FindFirstChild("Ball").Hitbox
                end
                if ball then
                    local me = game.Players.LocalPlayer
                    if
                        me:DistanceFromCharacter(ball.Position) <= 10 and
                            tostring(game.ReplicatedStorage.Status.Target.Value) == tostring(me.Name)
                     then
                        mouse1press()
                        workspace.CurrentCamera.CFrame =
                            CFrame.new(me.Character.HumanoidRootPart.Position, ball.Position or Vector3.new(0, 0, 0))
                    end
                end
            end
            custom.loop(temp, not bool)
        end
    }
)
