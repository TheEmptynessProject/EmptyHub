local default = getgenv().mainLib:NewTab("Game Tab 1")
local PlaceId =
    default:NewSection(
    {
        Name = "",
        column = 1
    }
)
PlaceId:CreateToggle(
    {
        Name = "Get All Blocks",
        Callback = function(toggled)
            while true do
                if not toggled then return end
                for i, v in ipairs(game.workspace.Spawn_Part:GetDescendants()) do
                    if v:FindFirstChild("TouchInterest") then
                        firetouchinterest(v, game.Players.LocalPlayer.Character.HumanoidRootPart, 0)
                        firetouchinterest(v, game.Players.LocalPlayer.Character.HumanoidRootPart, 1)
                    end
                    if not toggled then return end
                end
                
                task.wait()
            end
        end
    }
)
