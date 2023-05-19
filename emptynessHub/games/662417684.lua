    local default = getgenv().main:Tab("Main")
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
