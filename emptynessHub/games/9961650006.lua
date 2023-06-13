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
        Name = "Finish TP",
        Default = Enum.KeyCode.R,
        Callback = function()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.workspace.Finish.Finish.CFrame
            task.wait(0.2)
            game.Players.LocalPlayer.Character.Humanoid:ChangeState("Jumping")
        end
    }
)
PlaceId:CreateButton(
    {
        Name = "Grab Coins",
        Callback = function()
            for i, v in ipairs(game.Workspace.Coins.Points:GetChildren()) do
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
                                task.wait(0.1)
                            end           
        end
    }
)
