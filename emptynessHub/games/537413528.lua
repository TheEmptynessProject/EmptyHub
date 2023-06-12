local default = getgenv().mainLib:NewTab("Game Tab 1")
local PlaceId =
    default:NewSection(
    {
        Name = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name,
        column = 1
    }
)
PlaceId:CreateButton(
    {
        Name = "Disable Water Damage",
        Callback = function()
            for i, v in pairs(game.workspace:GetDescendants()) do
                if v.Name == "Water" then
                    local wah_uh = v:Clone()
                    local wah_uh_parent = v.Parent
                    wah_uh.Parent = nil
                    v:Destroy()
                    wah_uh.Parent = wah_uh_parent
                end
            end
        end
    }
)
PlaceId:CreateButton(
    {
        Name = "Fire All Thrusters",
        Callback = function()
            for i, v in pairs(game.Workspace:GetDescendants()) do
                if string.find(v.Parent.Name, "Thruster") and v:IsA("ClickDetector") then
                    fireclickdetector(v, 0)
                end
            end
        end
    }
)
PlaceId:CreateButton(
    {
        Name = "Fire All Jets",
        Callback = function()
            for i, v in pairs(game.Workspace:GetDescendants()) do
                if string.find(v.Parent.Name, "Turbine") and v:IsA("ClickDetector") then
                    fireclickdetector(v, 0)
                end
            end
        end
    }
)
PlaceId:CreateButton(
    {
        Name = "Touch Glue Blocks",
        Callback = function()
            for i, v in pairs(game.Workspace:GetDescendants()) do
                if v.Parent.Name == "Glue" and v:IsA("ClickDetector") then
                    fireclickdetector(v, 0)
                end
            end
        end
    }
)
PlaceId:CreateButton(
    {
        Name = "Touch Balloon Blocks",
        Callback = function()
            for i, v in pairs(game.Workspace:GetDescendants()) do
                if string.find(v.Parent.Name, "Balloon") and v:IsA("ClickDetector") then
                    fireclickdetector(v, 0)
                end
            end
        end
    }
)
PlaceId:CreateButton(
    {
        Name = "Touch Cannons",
        Callback = function()
            for i, v in pairs(game.Workspace:GetDescendants()) do
                if string.find(v.Parent.Name, "Cannon") and v:IsA("ClickDetector") then
                    fireclickdetector(v, 0)
                end
            end
        end
    }
)
local connection
PlaceId:CreateToggle(
    {
        Name = "AutoFarm",
        Callback = function(bool)
            local startpos = CFrame.new(-50, 75, 500)
            local bodyVelocity = Instance.new("BodyVelocity")
            bodyVelocity.Velocity = Vector3.new(0, -1, 600)
            bodyVelocity.MaxForce = Vector3.new(0, math.huge, math.huge)

            local function autofarm()
                if not bool then
                    bodyVelocity:Destroy()
                    connection:Disconnect()
                    return
                end
                local rootPart = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart")
                rootPart.CFrame = startpos
                bodyVelocity.Parent = rootPart
                task.wait(14)
                bodyVelocity.Parent = nil
                task.wait(0.5)
                rootPart.CFrame = workspace.BoatStages.NormalStages.TheEnd.GoldenChest.Trigger.CFrame
                task.wait(0.5)
            end

            autofarm()
            connection = game.Players.LocalPlayer.CharacterAdded:Connect(autofarm)
        end
    }
)
PlaceId:CreateLine(2, Color3.new(255, 0, 255))
local dropdownItemArray = {}
local numberArray = {}
local item = "Seat"
local numberino = 1262
local protecEnabled = false
for _, item in pairs(game.Players.LocalPlayer.Data:GetChildren()) do
if (item:IsA("IntValue") and not string.find(item.Name,"Tool") and item.Value>0) then
table.insert(dropdownItemArray, item.Name)
table.insert(numberArray, item.Value)
end
end
function indexOf(array, value)
    for i, v in ipairs(array) do
        if v == value then
            return i
        end
    end
    return nil
end

PlaceId:CreateLabel("Item to use")
PlaceId:CreateDropdown(
       {
            Content = dropdownItemArray,
            MultiChoice = false,
            Callback = function(selection)
                    item = selection
                    numberino = numberArray[indexOf(dropdownItemArray,selection)]
            end
        }
    )
PlaceId:CreateToggle(
    {
        Name = "Protection",
        Callback = function(bool)
            protecEnabled = bool
        end
    }
)
PlaceId:CreateButton(
    {
        Name = "Fire",
        Callback = function()
            local RunService = game:GetService("RunService")
            local Players = game:GetService("Players")
            local LocalPlayer = Players.LocalPlayer
            local Character = LocalPlayer.Character
            local CoreGui = game:GetService("CoreGui")
            local RobloxGui = CoreGui.RobloxGui
            local Workspace = game:GetService("Workspace")
            local overlay
            if protecEnabled then
                overlay = Instance.new("Frame", RobloxGui)
                overlay.BackgroundColor3 = Color3.new(0, 0, 0)
                overlay.Size = UDim2.fromScale(1, 1)
            end
            local teamString = tostring(LocalPlayer.TeamColor) .. "Zone"

            local TNTargs = {
                [1] = "SticksOfTNT",
                [2] = 180,
                [3] = Workspace[teamString],
                [4] = CFrame.new(10, 7.6, -124) * CFrame.Angles(-math.pi, 0, -math.pi),
                [5] = true,
                [6] = 1,
                [7] = nil,
                [8] = false
            }

            local function invokeServerBatch(toolArgs)
                Character.BuildingTool.RF:InvokeServer(unpack(toolArgs))
            end
            if protecEnabled then
                    overlay.Visible = true
                    RunService:Set3dRenderingEnabled(false)
            end
            game.workspace.PVPRemote:FireServer(true)
            local seatArgs = {
                [1] = item,
                [2] = numberino,
                [3] = Workspace[teamString],
                [4] = CFrame.new(10, 6.6, -120) * CFrame.Angles(-math.pi, 0, -math.pi),
                [5] = false,
                [6] = 1,
                [7] = nil,
                [8] = false
            }
            for i = 1, 20 do
                local temp = seatArgs[4]
                seatArgs[4] = seatArgs[4] + Vector3.new(0, i / 50, 0)
                invokeServerBatch(seatArgs)
                task.wait()
                seatArgs[4] = temp
            end
            for i = 1, 1 do
                local temp = TNTargs[4]
                TNTargs[4] = TNTargs[4] + Vector3.new(0, 1, 0)
                invokeServerBatch(TNTargs)
                task.wait()
                TNTargs[4] = temp
            end

            for _, v in ipairs(Workspace:GetChildren()) do
                if string.find(v.Name, "TNT") and v:FindFirstChild("PPart") then
                    v.PPart.ActivateRemote:FireServer()
                end
            end
            task.wait(0.5)
            if protecEnabled then
                overlay.Visible = false
                    RunService:Set3dRenderingEnabled(true)
            end
            game.workspace.PVPRemote:FireServer(false)
        end
    }
)

local dropdownChestArray = {"Common", "Uncommon", "Rare", "Epic", "Legendary"}
local dropdownCostArray = {5, 15, 45, 135, 405}
local selectedChest = "Common"
local selectedCost = 5
PlaceId:CreateDropdown(
    {
        Content = dropdownChestArray,
        MultiChoice = false,
        Default = "Common",
        Callback = function(selection)
            selectedChest = selection
            selectedCost = dropdownCostArray[indexOf(dropdownChestArray, selectedChest)]
        end
    }
)
local function maxBuyableQuantity(chestCost)
    return math.floor(game.Players.LocalPlayer.Data.Gold.Value / chestCost)
end
PlaceId:CreateButton(
    {
        Name = "Buy Max Chest",
        Callback = function()
            local args = {
                [1] = selectedChest .. " Chest",
                [2] = maxBuyableQuantity(selectedCost)
            }

            workspace.ItemBoughtFromShop:InvokeServer(unpack(args))
        end
    }
)
local dropdownTeamName = {}
for i,v in pairs(game.workspace:GetChildren()) do
if string.find(v.Name, "Team") and v:FindFirstChild("Baseplate") then
table.insert(dropdownTeamName, v.Name)
end
end
PlaceId:CreateLabel("Team Teleports")
PlaceId:CreateDropdown(
    {
        Content = dropdownTeamName,
        MultiChoice = false,
        Callback = function(selection)
            if game.workspace:FindFirstChild(selection) and game.workspace[selection]:FindFirstChild("Baseplate") then
                game.Players.LocalPlayer.Character.HumamoidRootPart.CFrame = game.workspace[selection].Baseplate.CFrame
            end
        end
    }
)
