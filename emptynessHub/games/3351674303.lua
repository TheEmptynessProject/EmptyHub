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
	else
notifLib:Notify("Error: Car not found!", {Color = Color3.new(255, 0, 0)})
	end
    return nil
end
local multi = 0
PlaceId:CreateSlider(
    {
        Name = "Boost Multiplier",
        Min = 0,
        Max = 500000,
        Default = 0,
        Decimals = 0.001,
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
if not temp then return end
            temp.Weight._boost.force = workspace.CurrentCamera.CFrame.LookVector * multi
        end
    }
)
local function apply(front, both)
	local temp = getVehicle()
	if not temp then return end
    for i, v in pairs(temp.Constraints:GetChildren()) do
        if both then
            if string.find(v.Name, "Spring") then
                v.Damping = Damping
                v.FreeLength = Length
                v.LimitsEnabled = limitsEnabled
                v.Visible = Visible
                v.Radius = Radius
                v.MaxForce = MaxForce
                v.Coils = Coils
                v.Stiffness = Stiffness
                v.Enabled = Enabled
                v.Thickness = Thickness
            end
        else
            if front then
                if string.find(v.Name, "FrontSpring") then
                    v.Damping = Damping
                    v.FreeLength = Length
                    v.LimitsEnabled = limitsEnabled
                    v.Visible = Visible
                    v.Radius = Radius
                    v.MaxForce = MaxForce
                    v.Coils = Coils
                    v.Stiffness = Stiffness
                    v.Enabled = Enabled
                    v.Thickness = Thickness
                end
            else
                if string.find(v.Name, "RearSpring") then
                    v.Damping = Damping
                    v.FreeLength = Length
                    v.LimitsEnabled = limitsEnabled
                    v.Visible = Visible
                    v.Radius = Radius
                    v.MaxForce = MaxForce
                    v.Coils = Coils
                    v.Stiffness = Stiffness
                    v.Enabled = Enabled
                    v.Thickness = Thickness
                end
            end
        end
    end
end
local Damping, Length, limitsEnabled, Visible, Radius, MaxForce, Coils, Stiffness, Enabled, Thickness = 0
local affectFront, bothAffected = nil
local autoApply = false
universalColumn1:CreateDropdown(
    {
        Content = {"Front", "Rear"},
        MultiChoice = true,
        Callback = function(selection)
            if #selection == 2 then
                bothAffected = true
            else
                bothAffected = false
                if selection == "Front" then
                    affectFront = true
                elseif selection == "Rear" then
                    affectFront = false
                end
            end
        end
    }
)
PlaceId:CreateSlider(
    {
        Name = "Damping",
        Min = 0,
        Max = 10000,
        Default = 400,
        Decimals = 0.01,
        Callback = function(value)
            Damping = value
            if autoApply then
                apply(affectFront, bothAffected)
            end
        end
    }
)
PlaceId:CreateSlider(
    {
        Name = "Length",
        Min = 0,
        Max = 10,
        Default = 2,
        Decimals = 0.0001,
        Callback = function(value)
            Length = value
            if autoApply then
                apply(affectFront, bothAffected)
            end
        end
    }
)
PlaceId:CreateSlider(
    {
        Name = "Radius",
        Info = "Visual Only",
        Min = 0,
        Max = 10,
        Default = 1,
        Decimals = 1,
        Callback = function(value)
            Radius = value
            if autoApply then
                apply(affectFront, bothAffected)
            end
        end
    }
)
PlaceId:CreateSlider(
    {
        Name = "Max Force",
        Min = 0,
        Max = 10000000,
        Default = 1000000,
        Decimals = 0.0001,
        Callback = function(value)
            MaxForce = value
            if autoApply then
                apply(affectFront, bothAffected)
            end
        end
    }
)
PlaceId:CreateSlider(
    {
        Name = "Coils",
        Min = 0,
        Max = 8,
        Default = 2,
        Decimals = 0.1,
        Callback = function(value)
            Coils = value
            if autoApply then
                apply(affectFront, bothAffected)
            end
        end
    }
)
PlaceId:CreateSlider(
    {
        Name = "Stiffness",
        Min = 0,
        Max = 50000,
        Default = 22000,
        Decimals = 0.01,
        Callback = function(value)
            Stiffness = value
            if autoApply then
                apply(affectFront, bothAffected)
            end
        end
    }
)
PlaceId:CreateSlider(
    {
        Name = "Thickness",
        Min = 0,
        Max = 1000,
        Default = 0.1,
        Decimals = 0.1,
        Callback = function(value)
            Thickness = value
            if autoApply then
                apply(affectFront, bothAffected)
            end
        end
    }
)
PlaceId:CreateToggle(
    {
        Name = "Limits Enabled",
        Callback = function(bool)
            limitsEnabled = bool
            if autoApply then
                apply(affectFront, bothAffected)
            end
        end
    }
)
PlaceId:CreateToggle(
    {
        Name = "Visible",
        Callback = function(bool)
            Visible = bool
            if autoApply then
                apply(affectFront, bothAffected)
            end
        end
    }
)
PlaceId:CreateToggle(
    {
        Name = "Enabled",
        Callback = function(bool)
            Enabled = bool
            if autoApply then
                apply(affectFront, bothAffected)
            end
        end
    }
)
PlaceId:CreateToggle(
    {
        Name = "Auto Apply",
        Callback = function(bool)
            autoApply = bool
        end
    }
)
PlaceId:CreateButton(
    {
        Name = "Apply",
        Callback = function()
            apply(affectFront, bothAffected)
        end
    }
)
