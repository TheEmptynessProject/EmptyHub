local default = getgenv().mainLib:NewTab("Game Tab 1")
local PlaceId =
    default:NewSection(
    {
        Name = "",
        column = 1
    }
)
local function getToolEquipped()
    for i, v in pairs(game.workspace:GetChildren()) do
        if v.Name == game.Players.LocalPlayer.Name then
            local tool = v:FindFirstChildOfClass("Tool")
            if not tool then
                return nil
            end
            if tool:FindFirstChild("Fire") and tool.Fire:IsA("Sound") then
                return true --pistol
            else
                return false --knife
            end
        end
    end
    return nil
end
PlaceId:CreateKeybind(
    {
        Name = "Kill All",
        Default = Enum.KeyCode.J,
        Callback = function()
            local pistol = getToolEquipped()
            repeat
                pistol = getToolEquipped()
                task.wait(0.2)
            until pistol ~= nil
            if pistol then
                for i, v in pairs(game.workspace:GetChildren()) do
                    if
                        v.ClassName == "Model" and v.Name ~= "" and v:FindFirstChild("HumanoidRootPart") and
                            v.Name ~= game.Players.LocalPlayer.Name
                     then
                        if game.Players[v.Name].Team ~= nil or game.Players[v.Name].Team ~= game.Players.LocalPlayer.Team then
                            local args = {
                                [1] = Vector3.new(0, 0, 0),
                                [2] = Vector3.new(0, 0, 0),
                                [3] = v.HumanoidRootPart,
                                [4] = Vector3.new(0, 0, 0)
                            }

                            game:GetService("ReplicatedStorage").Remotes.Shoot:FireServer(unpack(args))
                        end
                    end
                end
            else
                for i, v in pairs(game.workspace:GetChildren()) do
                    if
                        v.ClassName == "Model" and v.Name ~= "" and v:FindFirstChild("HumanoidRootPart") and
                            v.Name ~= game.Players.LocalPlayer.Name
                     then
                        if game.Players[v.Name].Team ~= nil or game.Players[v.Name].Team ~= game.Players.LocalPlayer.Team then
                            game:GetService("ReplicatedStorage").Remotes.Stab:FireServer(v.HumanoidRootPart)
                        end
                    end
                end
            end
        end
    }
)

PlaceId:CreateKeybind(
    {
        Name = "Kill one",
        Default = Enum.KeyCode.R,
        Callback = function()
            local pistol = getToolEquipped()
            repeat
                pistol = getToolEquipped()
                task.wait(0.2)
            until pistol ~= nil
            if pistol then
                for i, v in pairs(game.workspace:GetChildren()) do
                    if
                        v.ClassName == "Model" and v.Name ~= "" and v:FindFirstChild("HumanoidRootPart") and
                            v.Name ~= game.Players.LocalPlayer.Name
                     then
                        if game.Players[v.Name].Team ~= nil or game.Players[v.Name].Team ~= game.Players.LocalPlayer.Team then
                            print(v.Name)
                            print(v.Humanoid.Health)
                            local args = {
                                [1] = Vector3.new(0, 0, 0),
                                [2] = Vector3.new(0, 0, 0),
                                [3] = v.HumanoidRootPart,
                                [4] = Vector3.new(0, 0, 0)
                            }

                            game:GetService("ReplicatedStorage").Remotes.Shoot:FireServer(unpack(args))
                            return
                        end
                    end
                end
            else
                for i, v in pairs(game.workspace:GetChildren()) do
                    if
                        v.ClassName == "Model" and v.Name ~= "" and v:FindFirstChild("HumanoidRootPart") and
                            v.Name ~= game.Players.LocalPlayer.Name
                     then
                        if game.Players[v.Name].Team ~= nil or game.Players[v.Name].Team ~= game.Players.LocalPlayer.Team then
                            print(v.Name)
                            print(v.Humanoid.Health)
                            game:GetService("ReplicatedStorage").Remotes.Stab:FireServer(v.HumanoidRootPart)
                            return
                        end
                    end
                end
            end
        end
    }
)
