    local default = getgenv().mainLib:Tab("Main")
    local test =
        default:Section(
        {
            Name = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name,
            column = 1
        }
    )
    test:Button(
        {
            Name = "Spawn Lucky Block",
            Callback = function()
                game:GetService("ReplicatedStorage").SpawnLuckyBlock:FireServer()
            end
        }
    )
