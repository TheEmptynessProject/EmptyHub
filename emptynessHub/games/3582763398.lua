local default = getgenv().mainLib:NewTab("Game Tab 1")
    local PlaceId =
        default:NewSection(
        {
            Name = "",
            column = 1
        }
    )
PlaceId:CreateButton(
    {
        Name = "Disable Damage",
        Callback = function()
            for i,v in pairs(game.workspace.tower:GetDescendants()) do
              if v:IsA("Part") and v.Material == Enum.Material.Neon then
              v:Destroy()
              end
              end
        end
    }
)
PlaceId:CreateButton(
    {
        Name = "Teleport to exit",
        Callback = function()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.workspace.tower.sections.finish.exit.carpet.CFrame
        end
    }
)
local thing
PlaceId:CreateToggle(
    {
        Name = "Infinite Jump Bypass",
        Callback = function(toggled)
        if not thing then
        thing = Instance.new("Part")
        thing.Anchored = true
        thing.Parent = game.Workspace
        thing.Size = Vector3.new(5, 0.1, 5)
		thing.Transparency = 1
        end
	while true do
        thing.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame - Vector3.new(0,3.3,0)
        if not toggled then
          thing:Destroy()
          thing = nil
          break
          end
        task.wait()
        end
        end
    }
)
