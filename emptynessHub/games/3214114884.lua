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
            local lastGetFlagExecutionTime = 0

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
                notifLib:Notify(("Please wait for " .. remainingSeconds .. " seconds before executing the script again."), {Color = Color3.new(255, 255, 255)})
                task.wait(1)
            end
        end
    }
)
