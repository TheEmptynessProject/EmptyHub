local default = getgenv().mainLib:NewTab("Game Tab 1")
    local PlaceId =
        default:NewSection(
        {
            Name = "",
            column = 1
        }
    )
PlaceId:CreateButton(
    {
        Name = "Get Flag",
        Callback = function()
            if not getgenv().lastGetFlagExecutionTime then
                getgenv().lastGetFlagExecutionTime = 0
            end

            local currentTime = tick()
            local timeDifference = currentTime - getgenv().lastGetFlagExecutionTime
            local remainingSeconds = math.floor(30 - timeDifference)

            if timeDifference >= 30 then
                getgenv().lastGetFlagExecutionTime = currentTime

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
                print("Please wait for " .. remainingSeconds .. " seconds before executing the script again.")
                task.wait(1)
            end
        end
    }
)
