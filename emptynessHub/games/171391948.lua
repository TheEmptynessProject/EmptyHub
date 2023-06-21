local default = getgenv().mainLib:NewTab("Game Tab 1")
local PlaceId =
    default:NewSection(
    {
        Name = "",
        column = 1
    }
)
local function getVehicle()
    for i, v in pairs(game.Workspace.Vehicles:GetChildren()) do
        if v:IsA("Model") then
            if v:FindFirstChild("owner") then
                if v.owner.Value == game.Players.LocalPlayer.Name then
                    return v
                end
            end
        end
    end
    return nil
end
PlaceId:CreateButton(
    {
        Name = "Get Interactables",
        Callback = function()
            for i, v in pairs(game.workspace.Interactibles.AchievementObjects.PickupObjects:GetChildren()) do
                if v:FindFirstChild("Item") then
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Item.CFrame
                    for i = 1, 10 do
                        keypress(0x46)
                        task.wait(0.1)
                    end
                end
            end
        end
    }
)
PlaceId:CreateButton(
    {
        Name = "Get Interactables",
        Callback = function()
            for i, v in pairs(game.workspace.Interactibles.AchievementObjects.PickupObjects:GetChildren()) do
                if v:FindFirstChild("Item") then
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Item.CFrame
                    for i = 1, 10 do
                        keypress(0x46)
                        task.wait(0.1)
                    end
                end
            end
        end
    }
)
PlaceId:CreateToggle(
    {
        Name = "Auto Farm",
        Callback = function(bool)
            for i, v in pairs(game.Workspace.Farms:GetChildren()) do
                if v.Name == "Hay" then
                    v:Destroy()
                end
            end

            local name = getVehicle()
            if not name then
                return
            end

            local start = Vector3.new(136, 218, -4868)
            local finish = Vector3.new(4910, 218, -4868)

            local player = game.Players.LocalPlayer
            local root = player.Character.HumanoidRootPart
            while bool do
                task.wait()
                for i = 1, 5 do
                    root.CFrame = CFrame.new(start, finish)
                    task.wait()
                end

                task.wait(0.2)

                game:GetService("ReplicatedStorage").VehicleEvents.VehicleRegen:InvokeServer(name.Name)

                local v = nil
                local temp = nil

                while not v or not temp do
                    task.wait()
                    v = getVehicle()
                    if v then
                        temp = v.Chassis:FindFirstChild("VehicleSeat")
                    end
                end

                local startTime = tick()

                repeat
                    root.CFrame = CFrame.new(temp.Position, finish)
                    task.wait(0.1)
                    keypress(0x46)
                    task.wait(0.3)
                until temp:FindFirstChild("SeatWeld")

                task.wait(0.2)

                while player:DistanceFromCharacter(finish) >= 30 do
                    keypress(0x57)
                    task.wait()
                    if tick() - startTime >= 30 then
                        break
                    end
                end
                keypress(0x46)
                print("Finish")
                task.wait(1.2)
                keypress(0x57)
                task.wait(0.8)
            end
        end
    }
)
