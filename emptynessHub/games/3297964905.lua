local default = getgenv().mainLib:NewTab("Game Tab 1")
local PlaceId =
    default:NewSection(
    {
        Name = "",
        column = 1
    }
)
local Camera = workspace.CurrentCamera
local Mouse = game:GetService("Players").LocalPlayer:GetMouse()

local function isPartVisible(part)
    local ScreenPos, OnScreen = Camera:WorldToScreenPoint(part.Position)
    ScreenPos = Vector2.new(ScreenPos.X, ScreenPos.Y)
    return OnScreen, ScreenPos
end

local function isPlayerVisible(player)
    local limb, distance
    local char = player.Character
    if not char:FindFirstChildOfClass("ForceField") then
        if game.workspace.Hitboxes:FindFirstChild(tostring(player.userId)) then
            local hitbox = game.workspace.Hitboxes[player.userId]
            if char and hitbox and char.Humanoid.Health > 0 then
                local isHeadVisible, headScreenPos = isPartVisible(hitbox.HitboxHead)
                local isBodyVisible, bodyScreenPos = isPartVisible(hitbox.HitboxBody)
                local isLegVisible, legScreenPos = isPartVisible(hitbox.HitboxLeg)
                if isHeadVisible then
                    limb = hitbox.HitboxHead
                    distance = (headScreenPos - Vector2.new(Mouse.X, Mouse.Y)).Magnitude
                elseif isBodyVisible then
                    limb = hitbox.HitboxBody
                    distance = (bodyScreenPos - Vector2.new(Mouse.X, Mouse.Y)).Magnitude
                elseif isBodyVisible then
                    limb = hitbox.HitboxLeg
                    distance = (legScreenPos - Vector2.new(Mouse.X, Mouse.Y)).Magnitude
                else
                    return nil, nil
                end
            end
        end
    end
    return limb, distance
end

local function getClosestVisibleTarget()
    local closestLimb, closestDistance, play = nil, math.huge, nil
    for _, player in pairs(game:GetService("Players"):GetPlayers()) do
        if
            player ~= game:GetService("Players").LocalPlayer and player.Character and
                player.Character:FindFirstChild("HumanoidRootPart")
         then
            if player.Team then
                if player.Team ~= game:GetService("Players").LocalPlayer.Team then
                    local limb, dist = isPlayerVisible(player)
                    if limb and dist and dist < closestDistance then
                        closestLimb = limb
                        closestDistance = dist
                        play = player
                    end
                end
            else
                local limb, dist = isPlayerVisible(player)
                if limb and dist and dist < closestDistance then
                    closestLimb = limb
                    closestDistance = dist
                    play = player
                end
            end
        end
    end

    return closestLimb, play
end
PlaceId:CreateButton(
    {
        Name = "Silent Aim",
    Info = "Use AWP or possibly any sniper",
        Callback = function()
            local targetLimb, player
            game:GetService("RunService").Stepped:Connect(
                function()
                    targetLimb, player = getClosestVisibleTarget()
                end
            )

            local originalNamecall
            originalNamecall =
                hookmetamethod(
                game,
                "__namecall",
                function(self, ...)
                    local args = {...}
                    local method = getnamecallmethod()

                    if method == "InvokeServer" and self.Name == "HitHandler" then
                        if args[1]["HitPos"] then
                            if targetLimb then
                                args[1]["HitPos"] = targetLimb.Position
                                args[1]["HitObj"] = targetLimb
                            end
                        end
                    end
                    if method == "FireServer" and self.Name == "WeaponHandler" then
                        if args[3] then
                            if args[3]["RayDir"] then
                                if targetLimb then
                                    args[3]["RayDir"] =
                                        (targetLimb.Position - game.Players.LocalPlayer.Character.Head.Position).unit
                                end
                            end
                        end
                    end

                    return originalNamecall(self, unpack(args))
                end
            )
        end
    }
)
