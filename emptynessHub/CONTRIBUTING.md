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
