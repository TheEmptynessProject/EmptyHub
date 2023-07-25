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
    local car = game.workspace.CarCollection:FindFirstChild(game.Players.LocalPlayer.Name)
    if not car then
        return nil
    end

    local model = car:FindFirstChild("Car")
    if not model then
        return nil
    end

    local isNotBroken =
        model:FindFirstChild("Wheels"):FindFirstChildOfClass("Part") and
        model:FindFirstChild("Body"):FindFirstChild("Engine"):FindFirstChildOfClass("MeshPart")

    return isNotBroken and model or nil
end
local Bmulti = 1
PlaceId:CreateSlider(
    {
        Name = "Boost Multiplier",
        Min = 0,
        Max = 100,
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
                temp.PrimaryPart.Velocity = Vector3.new(workspace.CurrentCamera.CFrame.LookVector.X* Bmulti,1,workspace.CurrentCamera.CFrame.LookVector.Z* Bmulti) 
            end
        end
    }
)
PlaceId:CreateSlider(
    {
        Name = "Acceleration",
        Min = 0,
        Max = 10000,
        Decimals = 0.001,
        Callback = function(a)
            local temp = getCurrentCar()
            if temp and temp.PrimaryPart then
                local data = require(temp.Body.Configuration)
                data.Acceleration = a
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
                                    car.PrimaryPart.Velocity = Vector3.new(0, -1000, 0)
                                    task.wait(0.1)
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
PlaceId:CreateButton(
    {
        Name = "Win Air Time Event",
        Callback = function()
            local oldGrav = game.workspace.Gravity
            local temp = getCurrentCar()
            if temp and temp.PrimaryPart then
            game.workspace.Gravity = 0
            temp.PrimaryPart.Velocity = CFrame.new(0, 1, 0)
                task.wait(60)
                game.workspace.Gravity = oldGrav
            end
        end
    }
)
