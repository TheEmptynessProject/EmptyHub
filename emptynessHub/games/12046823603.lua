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
                for i, v in ipairs(game.workspace.Spawn_Part:GetDescendants()) do
                    if v:FindFirstChild("TouchInterest") then
                        firetouchinterest(v, game.Players.LocalPlayer.Character.HumanoidRootPart, 0)
                        firetouchinterest(v, game.Players.LocalPlayer.Character.HumanoidRootPart, 1)
                    end
                end
                if not toggled then
                    break
                end
                task.wait()
            end
        end
    }
)
