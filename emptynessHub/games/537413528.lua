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
            Name = "Disable Water Damage",
            Callback = function()
                local wah_uh = game.workspace.Water:Clone()
                wah_uh.Parent = nil
                game.workspace.Water:Destroy()
                wah_uh.Parent = workspace
            end
        }
    )
