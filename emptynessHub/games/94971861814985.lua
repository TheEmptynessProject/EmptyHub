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
        Name = "Disable Damage",
        Callback = function()
            for i,v in pairs(game.workspace.tower:GetDescendants()) do
              if v:IsA("Part") and v.Material == Enum.Material.Neon then
              v:Destroy()
              end
              end
        end
    }
)
