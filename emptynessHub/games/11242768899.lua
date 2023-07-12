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
        Name = "Grab Near",
        Default = Enum.KeyCode.X,
        Callback = function()
            for i,v in pairs(game.Players:GetPlayers()) do
if v ~= game.Players.LocalPlayer then
if v:DistanceFromCharacter(game.Players.LocalPlayer.Character.HumanoidRootPart.Position) <= 10 then
local args = {
    [1] = "detain",
    [2] = v.Character.Head
}

game:GetService("ReplicatedStorage").DetainEvent:FireServer(unpack(args))
end
end
end
        end
    }
)
