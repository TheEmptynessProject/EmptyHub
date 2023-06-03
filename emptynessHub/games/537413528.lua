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
            for i,v in pairs(game.workspace:GetDescendants()) do
                if v.Name == "Water" then
                local wah_uh = v:Clone()
                    local wah_uh_parent = v.Parent
                    wah_uh.Parent = nil
                    v:Destroy()
                    wah_uh.Parent = wah_uh_parent
                    end
                end
            end
        }
    )
