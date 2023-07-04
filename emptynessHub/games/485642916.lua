local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local LocalCharacter = LocalPlayer.Character
local LocalHumanoid = LocalCharacter.Humanoid

local MainModule = workspace.MainModule
local BlowDamage = MainModule.BlowDamage

local function disableDamage(bool)
    local mt = debug.getmetatable(game)
    local nc = mt.__namecall

    setreadonly(mt, false)

    mt.__namecall = newcclosure(function(self, ...)
        local args = {...}
        local method = getnamecallmethod()

        if method == "FireServer" and self.Name == "BlowDamage" and bool then
            if args[1] == LocalHumanoid then
                args[2] = 0
            end
        end

        return nc(self, unpack(args))
    end)

    setreadonly(mt, true)
end

local function killPlayers(teamValue)
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            if player.Character.Team.Value == teamValue then
                local humanoid = player.Character.Humanoid
                local args = { humanoid, 100 }
                BlowDamage:FireServer(unpack(args))
            end
        end
    end
end

local default = getgenv().mainLib:NewTab("Game Tab 1")
local PlaceId = default:NewSection({ Name = "", column = 1 })

PlaceId:CreateToggle({
    Name = "Disable Damage",
    Callback = disableDamage
})

PlaceId:CreateButton({
    Name = "Kill Teammates",
    Callback = function()
        killPlayers(LocalPlayer.Character.Team.Value)
    end
})

PlaceId:CreateButton({
    Name = "Kill Enemies",
    Callback = function()
        killPlayers("nil")
    end
})
