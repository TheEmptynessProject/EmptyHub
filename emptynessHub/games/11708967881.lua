local default = getgenv().mainLib:NewTab("Game Tab 1")
local PlaceId =
    default:NewSection(
    {
        Name = "",
        column = 1
    }
)

local function egg(n)
    local args = {
        [1] = n
    }

    game:GetService("ReplicatedStorage").Remote.Egg.Server.Purchase:InvokeServer(unpack(args))
end

local function collect()
    for i, v in pairs(game.workspace.Stars:GetChildren()) do
        game:GetService("ReplicatedStorage").Remote.Star.Server.Collect:FireServer(v.Name)
    end
end

local function teleThrow()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame =
        CFrame.new(game.workspace.World.ThrowArea.ThrowArea.Position + Vector3.new(0, 5, 0))
end

local EggPrice = {}

for i, v in pairs(game.Players.LocalPlayer.PlayerGui.InteractableUIs:GetChildren()) do
    if v.Holder.Main.PriceText.Text and not string.find(v.Holder.Main.PriceText.Text, "R") then
        EggPrice[v] = v.Holder.Main.PriceText.Text
    end
end

local function getNumericPrice(price)
    local suffixes = {
        ["K"] = 10 ^ 3,
        ["M"] = 10 ^ 6,
        ["B"] = 10 ^ 9,
        ["T"] = 10 ^ 12
    }

    local suffix = string.sub(price, -1)
    local numericPrice = tonumber(string.sub(price, 1, -2))

    if suffixes[suffix] and numericPrice then
        return numericPrice * suffixes[suffix]
    else
        return tonumber(price)
    end
end

local function getMostExpensiveEgg(money)
    local maxPrice = 0
    local maxEgg

    for egg, price in pairs(EggPrice) do
        local numericPrice = getNumericPrice(price)

        if numericPrice and numericPrice > maxPrice and tonumber(money:gsub(",", ""):match("%d+")) >= numericPrice then
            maxPrice = numericPrice
            maxEgg = tostring(egg)
        end
    end

    return maxEgg
end

PlaceId:CreateToggle(
    {
        Name = "Auto Farm",
        Callback = function(bool)
            while bool do
                task.wait()
                local money = game.Players.LocalPlayer.PlayerGui.Main.Right.Energy.Amount.Text
                for i = 1, 10 do
                    money = game.Players.LocalPlayer.PlayerGui.Main.Right.Energy.Amount.Text
                    collect()
                    game:GetService("ReplicatedStorage").Remote.Quest.Server.Claim:InvokeServer(i)
                    local most = getMostExpensiveEgg(money)
                    egg(most)
                    game:GetService("ReplicatedStorage").Remote.Pet.Server.CraftAll:FireServer()
                    game:GetService("ReplicatedStorage").Remote.Pet.Server.EquipBest:FireServer()
                    task.wait()
                    teleThrow()
                    task.wait(0.1)
                    game:GetService("ReplicatedStorage").Remote.Throw.Server.Request:FireServer()
                end
                game:GetService("ReplicatedStorage").Remote.Player.Server.AttemptRebirth:InvokeServer()
            end
        end
    }
)
