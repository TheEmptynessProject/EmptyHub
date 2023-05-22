local custom = loadstring(game:HttpGet("https://raw.githubusercontent.com/TheEmptynessProject/EmptynessProject/main/emptynessHub/customFunctions.lua"))()
local notificationLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/TheEmptynessProject/EmptynessProject/main/emptynessHub/notificationLib.lua"))()
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/TheEmptynessProject/EmptynessProject/main/emptynessHub/lib.lua"))()
if not game:IsLoaded() then
    game.Loaded:Wait()
end
if not (getgenv()[custom.generateString(32, 0)]) then
    getgenv().mainLib =
        library:New(
        {
            Name = "Test",
            SizeX = 500,
            SizeY = 550
        }
    )
    getgenv().notifLib =
        notificationLib.new(
        {
            lifetime = 5,
            textColor = Color3.fromRGB(255, 255, 255),
            textSize = 20,
            textStrokeTransparency = 0.7,
            textStrokeColor = Color3.fromRGB(0, 0, 0),
            textFont = Enum.Font.Ubuntu
        }
    )

    notifLib:BuildUI()

    local uniTab = mainLib:NewTab("Universal Tab 1")
    local universalColumn1 =
        uniTab:NewSection(
        {
            Name = "Universal",
            column = 1
        }
    )
    universalColumn1:CreateKeybind(
        {
            Name = "Hide GUI",
            Default = library.toggleBind,
            Callback = function(key)
                task.wait()
                library.toggleBind = key
            end
        }
    )
    universalColumn1:CreateKeybind(
        {
            Name = "Close GUI",
            Default = library.closeBind,
            Callback = function(key)
                task.wait()
                library.closeBind = key
            end
        }
    )
    universalColumn1:CreateButton(
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
    )
	local gameScriptUrl = string.format("https://github.com/TheEmptynessProject/EmptynessProject/raw/main/emptynessHub/games/%d.lua", game.PlaceId)

	local success, gameScript = pcall(game.HttpGet, game, gameScriptUrl)

	if success then
		loadstring(gameScript)()
	end

end
