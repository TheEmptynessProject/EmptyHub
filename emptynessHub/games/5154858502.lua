local default = getgenv().mainLib:NewTab("Game Tab 1")
local PlaceId =
    default:NewSection(
    {
        Name = "",
        column = 1
    }
)
local function getToolEquipped()
    for i, v in pairs(game.workspace:GetChildren()) do
        if v.Name == game.Players.LocalPlayer.Name then
            local tool = v:FindFirstChildOfClass("Tool")
            if not tool then
                return nil
            end
            if tool.Name == "Gun" then
                return true --pistol
            else
                return false --knife
            end
        end
    end
    return nil
end
PlaceId:CreateToggle(
    {
        Name = "Kill Aura",
        Callback = function(bool)
      while bool do
        task.wait()
for i, v in pairs(game.Players:GetPlayers()) do
    local distance = game.Players.LocalPlayer:DistanceFromCharacter(v.Character.HumanoidRootPart.Position)

    if
        distance < 100 and v.Character and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health > 0 and
            not v.Character:FindFirstChild("ForceField")
     then
        if v.Team ~= game.Players.LocalPlayer.Team then
            local pistol = getToolEquipped()

            repeat
                pistol = getToolEquipped()
                task.wait(0.2)
            until pistol ~= nil
            if gun then
                local args = {
                    [1] = v.Character.HumanoidRootPart,
                    [2] = Vector3.new(0, 0, 0),
                    [3] = Vector3.new(0, 0, 0)
                }

                game:GetService("Players").LocalPlayer.Character.Gun.Damage:FireServer(unpack(args))
            else
                local args = {
                    [1] = v.Character.HumanoidRootPart,
                    [2] = "Throw"
                }

                game:GetService("Players").LocalPlayer.Character.Knife.Damage:FireServer(unpack(args))
            end
        end
    end
end
      end
    end})
