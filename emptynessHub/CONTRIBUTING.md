# Contributions can be made to this hub
### It should be common sense, but the functions you add should be yours, unless you credit the creator of it. You shall not add simple loads for other scripts like: Creating a button saying "OP GUI", but it's just a loadstring for IY.
## If you want to add a game the template should be as the following:\n
--GameName - [Game Link]: {Replace this with credits, like so: "Emptyness, TemplateName, OtherName"}\n
--1Feature\n
--2Feature\n
local default = getgenv().mainLib:NewTab("Game Tab 1")\n
local PlaceId =\n
    default:NewSection(\n
    {\n
        Name = "",\n
        column = 1\n
    }\n
)\n
## Or, if you want to contribute to a already existing game, just do the following:
1. Add the function creator to the top credits on the script
2. Optionally, you can also add the credits on the side of the function, example:
Demo:CreateKeybind( --Credits: LikeSo, SomeoneName
    {
        Name = "Test This",
        Default = Enum.KeyCode.X,
        Callback = function()
           --Demo
        end
    }
)
