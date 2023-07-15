local default = getgenv().mainLib:NewTab("Game Tab 1")
local PlaceId =
    default:NewSection(
    {
        Name = "",
        column = 1
    }
)
local function getVehicle()
local temp = game.workspace.Vehicles:FindFirstChild(tostring(game.Players.LocalPlayer.Name))
    if temp then
		return temp
	end
    return nil
end
local multi = 0
PlaceId:CreateSlider(
    {
        Name = "Boost Multiplier",
        Min = 0,
        Max = 8500000,
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
            temp.Weight._boost.force = workspace.CurrentCamera.CFrame.LookVector * multi
        end
    }
)
