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
test:Button(
        {
            Name = "Spawn Super Block",
            Callback = function()
                game:GetService("ReplicatedStorage").SpawnSuperBlock:FireServer()
            end
        }
    )
test:Button(
        {
            Name = "Spawn Diamond Block",
            Callback = function()
                game:GetService("ReplicatedStorage").SpawnDiamondBlock:FireServer()
            end
        }
    )
test:Button(
        {
            Name = "Spawn Rainbow Block",
            Callback = function()
                game:GetService("ReplicatedStorage").SpawnRainbowBlock:FireServer()
            end
        }
    )
test:Button(
        {
            Name = "Spawn Galaxy Block",
        Tooltip = "test",
        tooltip = "test2",
            Callback = function()
                game:GetService("ReplicatedStorage").SpawnGalaxyBlock:FireServer()
            end
        }
    )
