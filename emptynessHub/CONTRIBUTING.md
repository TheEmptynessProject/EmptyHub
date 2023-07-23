# Contributions can be made to this hub
### It should be common sense, but the functions you add should be yours, unless you credit the creator of it. You shall not add simple loads for other scripts like: Creating a button saying "OP GUI", but it's just a loadstring for IY.
## If you want to add a game the template should be as the following:
--GameName - [Game Link]: {Replace this with credits, like so: "Emptyness, TemplateName, OtherName"}<br>
--1Feature<br>
--2Feature<br>
local default = getgenv().mainLib:NewTab("Game Tab 1")<br>
local PlaceId =<br>
    default:NewSection(<br>
    {<br>
        Name = "",<br>
        column = 1<br>
    }<br>
)<br>
## Or, if you want to contribute to a already existing game, just do the following:
1. Add the function creator to the top credits of the script<br>
2. Optionally, you can also add the credits on the side of the function, example:<br>
Demo:CreateKeybind( --Credits: LikeSo, SomeoneName<br>
    {<br>
        Name = "Test This",<br>
        Default = Enum.KeyCode.X,<br>
        Callback = function()<br>
           --Demo<br>
        end<br>
    }<br>
)<br>
