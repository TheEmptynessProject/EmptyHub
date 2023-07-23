# Contribution Guidelines

Thank you for your interest in contributing to this repository! To maintain consistency and ensure clarity, please follow the guidelines outlined below:

## General Guidelines

- Only add functions that you have created or explicitly credit the original creator.
- Avoid adding simple loads for other scripts or any form of malicious code.
- Make sure to credit the creator of any functions you are adding from external sources.

## Adding a New Game

If you want to add a new game, follow this template:

```lua
-- GameName - [Game Link]: {Replace this with credits, like so: "Emptyness, TemplateName, OtherName"}
-- 1Feature
-- 2Feature
local default = getgenv().mainLib:NewTab("Game Tab 1")
local PlaceId = -- Replace this with the actual PlaceId

default:NewSection(
{
    Name = "", -- Replace this with the name of the section
    column = 1 -- Replace this with the desired column number
}
)
```

## Contributing to an Existing Game

If you want to contribute to an already existing game, follow these steps:

1. Add the function creator to the top credits of the script.
2. Optionally, you can also add the credits on the side of the function, example:

```lua
Demo:CreateKeybind(
{
    Name = "Test This",
    Default = Enum.KeyCode.X,
    Callback = function()
    -- Demo
    end
} -- Credits: LikeSo, SomeoneName
)
```

Please adhere to these guidelines while making contributions to this repository. Your cooperation is highly appreciated.

Thank you for helping us improve this project!
