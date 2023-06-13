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
            Name = "KillAll",
            Callback = function()
                for i,v in pairs(game.Players:GetChildren()) do
                    game:GetService("ReplicatedStorage").Remotes.Stab:FireServer(v.Character.HumanoidRootPart)
                end
                --OR
                -- for i,v in pairs(game.Players:GetChildren()) do
                -- local args = {
                    -- [1] = Vector3.new(0,0,0),
                    -- [2] = Vector3.new(0,0,0),
                    -- [3] = v.Character.HumanoidRootPart,
                    -- [4] = Vector3.new(0,0,0)
                -- }

                -- game:GetService("ReplicatedStorage").Remotes.Shoot:FireServer(unpack(args))
                -- end
            end
        }
    )
