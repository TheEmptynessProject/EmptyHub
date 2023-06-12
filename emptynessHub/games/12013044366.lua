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
            Name = "Get Victories",
            Callback = function()
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.workspace.Mars.Parkour.VictoryPad.Hitbox.CFrame+Vector3.new(0,0,15)
wait(0.2)
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.workspace.Mars.Parkour.VictoryPad.Hitbox.CFrame
            end
        }
    )
PlaceId:CreateButton(
        {
            Name = "Destroy Negative EFfects",
            Callback = function()
for i,v in pairs(game.workspace:GetDescendants()) do
if (v.Name == "Doors" and v.ClassName == "Folder") or (v.Name == "Negative" and v.ClassName == "Model" and v.Parent.ClassName == "Folder") then
	for a,b in pairs(v:GetDescendants()) do
		if (b:IsA("TouchTransmitter")) then
			b:Destroy()
		end
	end
end
end
            end
        }
    )
PlaceId:CreateButton(
        {
            Name = "Get Troops",
            Callback = function()
local target
local count = 0

for _, instance in ipairs(game.workspace.Moon:GetChildren()) do
    if instance.Name == "Conveyer" then
        count = count + 1
        if count == 3 then
            target = instance
            break
        end
    end
end
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = target.VictoryPad.Hitbox.CFrame-Vector3.new(0,0,15)
wait(0.2)
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = target.VictoryPad.Hitbox.CFrame
            end
        }
    )
