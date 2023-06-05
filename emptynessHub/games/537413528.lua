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
PlaceId:CreateButton(
    {
        Name = "Crash Build (Equip Build Tool)",
        Callback = function()
            local RunService = game:GetService("RunService")
            local Players = game:GetService("Players")
            local LocalPlayer = Players.LocalPlayer
            local Character = LocalPlayer.Character
            local CoreGui = game:GetService("CoreGui")
            local RobloxGui = CoreGui.RobloxGui
            local Workspace = game:GetService("Workspace")

            local overlay = Instance.new("Frame", RobloxGui)
            overlay.BackgroundColor3 = Color3.new(0, 0, 0)
            overlay.Size = UDim2.fromScale(1, 1)

            local function set3DRenderingEnabled(enabled)
                RunService:Set3dRenderingEnabled(enabled)
            end

            local teamString = tostring(LocalPlayer.TeamColor) .. "Zone"

            local args = {
                {
                    [1] = "SticksOfTNT",
                    [2] = 180,
                    [3] = Workspace[teamString],
                    [4] = CFrame.new(10, 5.6, -120) * CFrame.Angles(-math.pi, 0, -math.pi),
                    [5] = false,
                    [6] = 1,
                    [7] = CFrame.new(-43.565689086914, -12.399991989136, -465.50686645508) *
                        CFrame.Angles(-math.pi, 0, -math.pi),
                    [8] = false
                },
                {
                    [1] = "Seat",
                    [2] = 1065,
                    [3] = Workspace[teamString],
                    [4] = CFrame.new(10, 5.6, -120) * CFrame.Angles(-math.pi, 0, -math.pi),
                    [5] = false,
                    [6] = 1,
                    [7] = CFrame.new(-43.565689086914, -12.399991989136, -465.50686645508) *
                        CFrame.Angles(-math.pi, 0, -math.pi),
                    [8] = false
                }
            }

            local function invokeServerBatch(toolArgs)
                Character.BuildingTool.RF:InvokeServer(unpack(toolArgs))
            end

            local function temp(enabled)
                overlay.Visible = enabled
                set3DRenderingEnabled(not enabled)
            end

            temp(true)

            game.workspace.PVPRemote:FireServer(true)

            for i = 1, 50 do
                invokeServerBatch(args[2])
                invokeServerBatch(args[1])
                task.wait()
            end

            for _, v in ipairs(Workspace:GetChildren()) do
                if v.Name == "SticksOfTNT" and v:FindFirstChild("PPart") then
                    v.PPart.ActivateRemote:FireServer()
                end
                task.wait(1)
            end

            temp(false)
        end
    }
)
PlaceId:CreateToggle(
    {
        Name = "AutoFarm",
        Callback = function(bool)
            local startpos = CFrame.new(-50, 75, 500)
            local connection
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
                rootPart.CFrame = workspace.BoatStages.NormalStages.TheEnd.GoldenChest.Trigger.CFrame
                task.wait(0.5)
                bodyVelocity.Parent = nil
                task.wait(0.5)
            end

            autofarm()
            connection = game.Players.LocalPlayer.CharacterAdded:Connect(autofarm)
        end
    }
)
universalColumn1:CreateLine(2, Color3.new(255, 0, 255))
local dropdownItemArray = {}
local protecEnabled = false
for _, item in pairs(game.ReplicatedStorage.BuildingParts:GetChildren()) do
if (item:IsA("Model")) then
table.insert(dropdownItemArray, item.Name)
end
end
universalColumn1:CreateLabel("Item to use")
PlaceId:CreateDropdown(
        {
            Content = dropdownPlayerArray,
            MultiChoice = false,
            Callback = function(selection)
                    
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
            if protecEnabled then
            local overlay = Instance.new("Frame", RobloxGui)
            overlay.BackgroundColor3 = Color3.new(0, 0, 0)
            overlay.Size = UDim2.fromScale(1, 1)

            local function set3DRenderingEnabled(enabled)
                RunService:Set3dRenderingEnabled(enabled)
            end
end
            local teamString = tostring(LocalPlayer.TeamColor) .. "Zone"

            local TNTargs = {
                    [1] = "SticksOfTNT",
                    [2] = 180,
                    [3] = Workspace[teamString],
                    [4] = CFrame.new(10, 7.6, -124) * CFrame.Angles(-math.pi, 0, -math.pi),
                    [5] = true,
                    [6] = 1,
                    [7] = CFrame.new(-43.565689086914, -13.399991989136, -464.50686645508) *
                        CFrame.Angles(-math.pi, 0, -math.pi),
                    [8] = false
                }

            local function invokeServerBatch(toolArgs)
                Character.BuildingTool.RF:InvokeServer(unpack(toolArgs))
            end
if protecEnabled then
            local function temp(enabled)
                overlay.Visible = enabled
                set3DRenderingEnabled(not enabled)
            end

            temp(true)
                end

			game.workspace.PVPRemote:FireServer(true)
local seatArgs = {
                    [1] = "Seat",
                    [2] = 1065,
                    [3] = Workspace[teamString],
                    [4] = CFrame.new(10, 6.6, -120) * CFrame.Angles(-math.pi, 0, -math.pi),
                    [5] = false,
                    [6] = 1,
                    [7] = CFrame.new(-43.565689086914, -12.399991989136, -465.50686645508) *
                        CFrame.Angles(-math.pi, 0, -math.pi),
                    [8] = false
                }
            for i = 1, 20 do
            local temp = seatArgs[4]
            	seatArgs[4] = seatArgs[4]+Vector3.new(0,i/50,0)
                invokeServerBatch(seatArgs)
                task.wait()
                seatArgs[4] = temp
            end
            for i = 1, 1 do
            local temp = TNTargs[4]
            	TNTargs[4] = TNTargs[4]+Vector3.new(0,1,0)
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
            temp(false)
                end
            game.workspace.PVPRemote:FireServer(false)
        end
    }
)
