local default = getgenv().mainLib:NewTab("Game Tab 1")
local PlaceId =
    default:NewSection(
    {
        Name = "",
        column = 1
    }
)
local function getVehicle()
    for i, v in pairs(game.workspace.Vehicles:GetChildren()) do
        if string.find(v.Name, game.Players.LocalPlayer.Name) then
            return v
        end
    end
    return nil
end
local multi = 0
PlaceId:CreateSlider(
    {
        Name = "Boost Multiplier",
        Min = 0,
        Max = 50000000,
        Default = 0,
        Decimals = 0.0001,
        Callback = function(value)
            multi = value
        end
    }
)
PlaceId:CreateKeybind(
    {
        Name = "Boost",
        Default = Enum.KeyCode.E,
        Callback = function()
            local temp = getVehicle()
            if not temp or not temp:FindFirstChild("Weight") then
                notifLib:Notify("Error: Car not found!", {Color = Color3.new(255, 0, 0)})
                return
            end
            temp.Weight.boostForce.force = workspace.CurrentCamera.CFrame.LookVector * Vector3.new(multi, 0, multi)
        end
    }
)
PlaceId:CreateToggle(
    {
        Name = "AutoFarm",
        Callback = function(bool)
            game:GetService("ReplicatedStorage").Event.updateSetting:FireServer("pvpEnabled", false)

            local veh = getVehicle()
            if not veh then
                notifLib:Notify("Error: Car not found!", {Color = Color3.new(255, 0, 0)})
                return
            end
            
            local start = Vector3.new(4801, 17, 1930)
            local finish = Vector3.new(-313, 17, 2460)

            local me = game.Players.LocalPlayer

            local this = me.Character.HumanoidRootPart

            local cam = workspace.CurrentCamera
            local function temp()
                this.CFrame = CFrame.new(start, finish)
                task.wait(0.5)
                game:GetService("ReplicatedStorage").Event.vehicleEvent:InvokeServer(veh.vehicleType.Value)
                task.wait(0.5)
                veh = getVehicle()
                cam.CFrame = CFrame.new(me.Character.HumanoidRootPart.Position, finish)

                local startTime = tick()

                while me:DistanceFromCharacter(finish) >= 100 do
                    keypress(0x57)
                    task.wait()
                    if tick() - startTime >= 30 then
                        break
                    end
                end
                keypress(0x46)
                task.wait(1.2)
                keypress(0x57)
                task.wait(0.8)
            end
            custom.loop(temp, not bool)
        end
    }
)
PlaceId:CreateSlider(
    {
        Name = "Torque Front Right",
        Min = 0,
        Max = 50000000,
        Default = getVehicle().Core.FRcylConstraint.MotorMaxTorque or 0,
        Decimals = 0.0001,
        Callback = function(value)
            local temp = getVehicle()
            if not temp then
                return
            end
            temp.Core.FRcylConstraint.MotorMaxTorque = value
        end
    }
)
PlaceId:CreateSlider(
    {
        Name = "Torque Front Left",
        Min = 0,
        Max = 50000000,
        Default = getVehicle().Core.FlcylConstraint.MotorMaxTorque or 0,
        Decimals = 0.0001,
        Callback = function(value)
            local temp = getVehicle()
            if not temp then
                return
            end
            temp.Core.FlcylConstraint.MotorMaxTorque = value
        end
    }
)
PlaceId:CreateSlider(
    {
        Name = "Torque Back Right",
        Min = 0,
        Max = 50000000,
        Default = getVehicle().Core.RRcylConstraint.MotorMaxTorque or 0,
        Decimals = 0.0001,
        Callback = function(value)
            local temp = getVehicle()
            if not temp then
                return
            end
            temp.Core.RRcylConstraint.MotorMaxTorque = value
        end
    }
)
PlaceId:CreateSlider(
    {
        Name = "Torque Back Left",
        Min = 0,
        Max = 50000000,
        Default = getVehicle().Core.RLcylConstraint.MotorMaxTorque or 0,
        Decimals = 0.0001,
        Callback = function(value)
            local temp = getVehicle()
            if not temp then
                return
            end
            temp.Core.RLcylConstraint.MotorMaxTorque = value
        end
    }
)
