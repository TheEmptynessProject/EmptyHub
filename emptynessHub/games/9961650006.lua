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
            task.wait(0.5)
            game.Players.LocalPlayer.Character.Humanoid:ChangeState("Jumping")
        end
    }
)
PlaceId:CreateToggle(
    {
        Name = "Autofarm",
        Callback = function(bool)
            while bool do
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.workspace.Finish.Finish.CFrame
            task.wait(0.5)
            game.Players.LocalPlayer.Character.Humanoid:ChangeState("Jumping")
                end
        end
    }
)
PlaceId:CreateButton(
    {
        Name = "Grab Coins",
        Callback = function()
            local max = 10
            for i, v in ipairs(game.Workspace.Coins.Points:GetChildren()) do
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
                                i=i+1
                                task.wait(0.1)
                if i >= 10 then return end
                            end           
        end
    }
)
