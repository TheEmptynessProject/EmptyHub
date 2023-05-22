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
            Name = "Get Lucky Block",
            Callback = function()
                game:GetService("ReplicatedStorage").SpawnLuckyBlock:FireServer()
            end
        }
    )
PlaceId:CreateButton(
        {
            Name = "Get Super Block",
            Callback = function()
                game:GetService("ReplicatedStorage").SpawnSuperBlock:FireServer()
            end
        }
    )
PlaceId:CreateButton(
        {
            Name = "Get Diamond Block",
            Callback = function()
                game:GetService("ReplicatedStorage").SpawnDiamondBlock:FireServer()
            end
        }
    )
PlaceId:CreateButton(
        {
            Name = "Get Rainbow Block",
            Callback = function()
                game:GetService("ReplicatedStorage").SpawnRainbowBlock:FireServer()
            end
        }
    )
PlaceId:CreateButton(
        {
            Name = "Get Galaxy Block",
            Callback = function()
                game:GetService("ReplicatedStorage").SpawnGalaxyBlock:FireServer()
            end
        }
    )
