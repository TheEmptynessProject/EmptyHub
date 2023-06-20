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
                        if game.Players[v.Name].Team ~= nil and game.Players[v.Name].Team ~= game.Players.LocalPlayer.Team and v.Humanoid.Health > 0 then
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
                        if game.Players[v.Name].Team ~= nil and game.Players[v.Name].Team ~= game.Players.LocalPlayer.Team and v.Humanoid.Health > 0 then
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
                        if game.Players[v.Name].Team ~= nil and game.Players[v.Name].Team ~= game.Players.LocalPlayer.Team and v.Humanoid.Health > 0 then
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
                        if game.Players[v.Name].Team ~= nil and game.Players[v.Name].Team ~= game.Players.LocalPlayer.Team and v.Humanoid.Health > 0 then
                            
                            game:GetService("ReplicatedStorage").Remotes.Stab:FireServer(v.HumanoidRootPart)
                            return
                        end
                    end
                end
            end
        end
    }
)
local delay = 0
universalColumn2:CreateSlider(
        {
            Name = "WalkSpeed",
            Min = 0,
            Max = 5,
            Default = 0,
            Decimals = 1,
            Callback = function(value)
               delay = value
            end
        }
    )
PlaceId:CreateToggle(
    {
        Name = "Silent Aim",
        Default = Enum.KeyCode.R,
        Callback = function()
            local mouse = game.Players.LocalPlayer:GetMouse()
            local pistol = getToolEquipped()

            repeat
                pistol = getToolEquipped()
                task.wait(0.2)
            until pistol ~= nil

            if pistol then
                local nearestPlayer, nearestDistance = nil, math.huge

                for _, player in ipairs(game.Players:GetPlayers()) do
                    if player ~= game.Players.LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                        local playerRootPart = player.Character.HumanoidRootPart
                        local distance = (playerRootPart.Position - mouse.Hit.p).Magnitude

                        if distance < nearestDistance then
                            nearestPlayer = player
                            nearestDistance = distance
                        end
                    end
                end

                if nearestPlayer and nearestPlayer.Team and nearestPlayer.Team ~= game.Players.LocalPlayer.Team then

                    local args = {
                        [1] = Vector3.new(0, 0, 0),
                        [2] = Vector3.new(0, 0, 0),
                        [3] = nearestPlayer.Character.HumanoidRootPart,
                        [4] = Vector3.new(0, 0, 0)
                    }

                    task.wait(delay)
                    game:GetService("ReplicatedStorage").Remotes.Shoot:FireServer(unpack(args))
                end
            else
                local nearestPlayer, nearestDistance = nil, math.huge

                for _, player in ipairs(game.Players:GetPlayers()) do
                    if player ~= game.Players.LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                        local playerRootPart = player.Character.HumanoidRootPart
                        local distance = (playerRootPart.Position - mouse.Hit.p).Magnitude

                        if distance < nearestDistance then
                            nearestPlayer = player
                            nearestDistance = distance
                        end
                    end
                end

                if nearestPlayer and nearestPlayer.Team and nearestPlayer.Team ~= game.Players.LocalPlayer.Team then

                    task.wait(delay)
                    game:GetService("ReplicatedStorage").Remotes.Stab:FireServer(nearestPlayer.Character.HumanoidRootPart)
                end
            end
        end
    }
)
