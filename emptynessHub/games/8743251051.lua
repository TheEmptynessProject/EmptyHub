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
        Name = "Teleport to the end",
        Callback = function()
            for i,v in pairs(game.workspace.ActiveMap:GetChildren()) do
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.MapModel.Barriers.DraggerBarriers.Part.CFrame
end
        end
    }
)
PlaceId:CreateButton(
    {
        Name = "Teleport to the end V2",
        Callback = function()
for i,v in pairs(game.Players:GetChildren()) do
if v.Team == "Throwers" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame
end
end
        end
    }
)
