local default = getgenv().mainLib:NewTab("Game Tab 1")
local PlaceId =
    default:NewSection(
    {
        Name = "",
        column = 1
    }
)
local lastGetFlagExecutionTime = 0
PlaceId:CreateButton(
    {
        Name = "Get Flag",
        Callback = function()
            local currentTime = tick()
            local timeDifference = currentTime - lastGetFlagExecutionTime
            local remainingSeconds = math.floor(30 - timeDifference)

            if timeDifference >= 30 then
                lastGetFlagExecutionTime = currentTime

                for i, v in pairs(game.Workspace:GetDescendants()) do
                    if string.find(v.Name, "Flags") then
                        for a, b in pairs(v:GetChildren()) do
                            if b.Name ~= tostring(game.Players.LocalPlayer.Team) then
                                for c, d in pairs(b:GetChildren()) do
                                    if d:IsA("MeshPart") then
                                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = d.CFrame
                                        task.wait(0.1)
                                        game.Players.LocalPlayer.Character.Humanoid:ChangeState("Jumping")
                                        task.wait(30)
                                    end
                                end
                            end
                        end
                    end
                end
            else
                notifLib:Notify(
                    ("Please wait for " .. remainingSeconds .. " seconds before executing the script again."),
                    {Color = Color3.new(255, 255, 255)}
                )
                task.wait(1)
            end
        end
    }
)
PlaceId:CreateKeybind(
    {
        Name = "Damage All",
        Default = Enum.KeyCode.J,
        Callback = function()
            for i, v in pairs(game.Players:GetPlayers()) do
                if v ~= game.Players.LocalPlayer then
                    local args = {
                        [1] = game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Tool"),
                        [2] = {
                            ["p"] = v.Character.HumanoidRootPart.Position,
                            ["pid"] = 1,
                            ["part"] = v.Character.HumanoidRootPart,
                            ["d"] = 1,
                            ["maxDist"] = 1,
                            ["h"] = v.Character.HumanoidRootPart,
                            ["m"] = Enum.Material.Plastic,
                            ["sid"] = 0,
                            ["t"] = 0,
                            ["n"] = Vector3.new(0, 0, 0)
                        }
                    }

                    game:GetService("ReplicatedStorage").WeaponsSystem.Network.WeaponHit:FireServer(unpack(args))
                end
            end
        end
    }
)
