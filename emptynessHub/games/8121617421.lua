local default = getgenv().mainLib:NewTab("Game Tab 1")
    local PlaceId =
        default:NewSection(
        {
            Name = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name,
            column = 1
        }
    )
    PlaceId:CreateButton(
        {
            Name = "Farm",
            Callback = function()
for i,v in pairs(game.Workspace:GetChildren()) do
if string.find(v.Name, "Drops") then
for a,b in pairs(v:GetChildren()) do
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = b.CFrame
task.wait()
end
end
end
            end
        }
    )
