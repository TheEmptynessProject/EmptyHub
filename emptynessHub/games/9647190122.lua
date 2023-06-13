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
            Name = "Auto Farm",
            Callback = function(toggled)
local function completeAll()
for i = 1, #workspace.Checkpoints:GetChildren() do
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Checkpoints[i].CFrame
i=i+1
task.wait(0.1)
end
end
while toggled do
completeAll()
task.wait(0.1)
game:GetService("ReplicatedStorage").Remotes.Rebirth:FireServer()
task.wait(0.1)
end
            end
        }
    )
