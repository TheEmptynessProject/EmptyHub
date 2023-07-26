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
local autoKillCoroutine
PlaceId:CreateToggle(
    {
        Name = "Auto Kill",
        Callback = function(bool)
            if bool then
                autoKillCoroutine =
                    coroutine.create(
                    function()
                        while true do
                            pcall(
                                function()
                                    for i, v in pairs(game.Players:GetPlayers()) do
                                        if v ~= game.Players.LocalPlayer then
                                            if v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                                                if
                                                    v:DistanceFromCharacter(
                                                        game.Players.LocalPlayer.Character.HumanoidRootPart.Position
                                                    ) < 10
                                                 then
                                                    local args = {
                                                        [1] = v.Character.HumanoidRootPart,
                                                        [2] = "Grab",
                                                        [3] = v.Character.HumanoidRootPart.Position,
                                                        [4] = v.Character.HumanoidRootPart.CFrame
                                                    }

                                                    game:GetService("ReplicatedStorage").Events.Grab:FireServer(
                                                        unpack(args)
                                                    )
                                                    local lastpos =
                                                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                                                    task.wait(0.1)
                                                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                        CFrame.new(Vector3.new(2e5, 10e5, 2e5))
                                                    task.wait(0.1)
                                                    local args = {
                                                        [1] = v.Character.HumanoidRootPart,
                                                        [2] = "Grab",
                                                        [3] = v.Character.HumanoidRootPart.Position,
                                                        [4] = v.Character.HumanoidRootPart.CFrame
                                                    }

                                                    game:GetService("ReplicatedStorage").Events.Grab:FireServer(
                                                        unpack(args)
                                                    )
                                                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = lastpos
                                                    task.wait(0.1)
                                                end
                                                if v.Character:FindFirstChild("HumanoidRootPart") then
                                                    local distance =
                                                        (v.Character.HumanoidRootPart.Position -
                                                        Vector3.new(2e5, 10e5, 2e5)).Magnitude
                                                    if distance <= 1000 then
                                                        warn(
                                                            "Killed player: ",
                                                            v.Name,
                                                            "Current Position: ",
                                                            v.Character.HumanoidRootPart.Position
                                                        )
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            )
                        end
                    end
                )
                coroutine.resume(autoKillCoroutine)
            else
                if autoKillCoroutine then
                    coroutine.close(autoKillCoroutine)
                    autoKillCoroutine = nil
                end
            end
        end
    }
)
