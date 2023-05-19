local custom = loadstring(game:HttpGet("https://raw.githubusercontent.com/TheEmptynessProject/EmptynessProject/main/emptynessHub/customFunctions.lua"))()
local notificationLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/TheEmptynessProject/EmptynessProject/main/emptynessHub/notificationLib.lua"))()
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/TheEmptynessProject/EmptynessProject/main/emptynessHub/lib.lua"))()
if not game:IsLoaded() then
    game.Loaded:Wait()
end
if not (getgenv()[custom.string(32, 0)]) then
    getgenv().mainLib =
        library:Load(
        {
            Name = "Test",
            SizeX = 500,
            SizeY = 550
        }
    )
    getgenv().notifLib = =
        notificationLib.new(
        {
            NotificationLifetime = 5,
            TextColor = Color3.fromRGB(255, 255, 255),
            TextSize = 20,
            TextStrokeTransparency = 0.7,
            TextStrokeColor = Color3.fromRGB(0, 0, 0),
            TextFont = "Ubuntu",
            NotificationPosition = "TopRight"
        }
    )

    notifLib:BuildNotificationUI()

    --[[local default = main:Tab("Testing")
    local test =
        default:Section(
        {
            Name = "Test",
            column = 1
        }
    )
    test:Keybind(
        {
            Name = "Hide GUI",
            Default = library.toggleBind,
            Callback = function(key)
                task.wait()
                library.toggleBind = key
            end
        }
    )
    test:Keybind(
        {
            Name = "Close GUI",
            Default = library.closeBind,
            Callback = function(key)
                task.wait()
                library.closeBind = key
            end
        }
    )
    test:Button(
        {
            Name = "GetPlaceInfo",
            Callback = function()
                print(game.PlaceId)
                print(game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name)
                setclipboard(tostring(game.PlaceId))
                notifLib:Notify(game.PlaceId)
                notifLib:Notify(game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name)
            end
        }
    )--]]
	local gameScriptUrl = string.format("https://github.com/TheEmptynessProject/EmptynessProject/raw/main/emptynessHub/games/%d.lua", game.PlaceId)

	local success, gameScript = pcall(game.HttpGet, game, gameScriptUrl)

	if success then
		loadstring(gameScript)()
	end

end
