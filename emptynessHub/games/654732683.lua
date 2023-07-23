local default = getgenv().mainLib:NewTab("Game Tab 1")
local PlaceId =
    default:NewSection(
    {
        Name = "",
        column = 1
    }
)
local function spawnBest()
    local player = game.Players.LocalPlayer
    local guiScript = getsenv(player.PlayerGui.GUIs)
    guiScript.OpenDealership()
    guiScript.SpawnButton(true, Enum.UserInputState.Begin)
end

local function getCurrentCar()
    local player = game.Players.LocalPlayer
    local car =
        player.Character and player.Character:FindFirstChild("CarCollection") and
        player.Character.CarCollection:FindFirstChild(player.Name)
    if car then
        local model = car:FindFirstChild("Car")
        if
            model and model:FindFirstChild("Wheels"):FindFirstChildOfClass("Part") and
                model:FindFirstChild("Body"):FindFirstChild("Engine"):FindFirstChildOfClass("MeshPart")
         then
            return model
        end
    end
    return nil
end
local Bmulti
PlaceId:CreateSlider(
    {
        Name = "Boost Multiplier",
        Min = 0,
        Max = 500000,
        Callback = function(a)
            Bmulti = a
        end
    }
)
PlaceId:CreateKeybind(
    {
        Name = "Boost",
        Default = Enum.KeyCode.X,
        Callback = function()
            local temp = getCurrentCar()
            if temp and temp.PrimaryPart then
                car.PrimaryPart.Velocity = workspace.CurrentCamera.CFrame.LookVector * multi
            end
        end
    }
)
local coroutineFarm
PlaceId:CreateToggle(
    {
        Name = "Auto Farm",
        Callback = function(bool)
            if coroutineFarm then
                coroutine.close(coroutineFarm)
                coroutineFarm = nil
            end
            if bool then
                coroutineFarm =
                    coroutine.create(
                    function()
                        while task.wait(1) do
                            spawnBest()
                            local car
                            repeat
                                car = getCurrentCar()
                                if car and car.PrimaryPart then
                                    car.PrimaryPart.Velocity = Vector3.new(0, 500, 0)
                                    task.wait(0.1)
                                    car.PrimaryPart.Velocity = Vector3.new(0, -500, 0)
                                    task.wait(0.4)
                                end
                            until not car
                        end
                    end
                )
                coroutine.resume(coroutineFarm)
            else
                if coroutineFarm then
                    coroutine.close(coroutineFarm)
                    coroutineFarm = nil
                end
            end
        end
    }
)
