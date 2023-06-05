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
