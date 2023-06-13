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
        end
    }
)
