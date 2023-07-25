# Contribution Guidelines

Thank you for your interest in contributing to this repository! To maintain consistency and ensure clarity, please follow the guidelines outlined below:

## General Guidelines

- Only add functions that you have created or explicitly credit the original creator.
- Avoid adding simple loads for other scripts or any form of malicious code.
- Make sure to credit the creator of any functions you are adding from external sources.
- Only simple types of obfuscation are allowed: Renaming functions and variables, changing strings to bytes, removing whitespace, shuffling.
- Any type of obfuscation that wouldn't let the user confirm it's not malicious code is not allowed.
- Any type of obfuscation that lowers the script loading time is not allowed (Dead code, for example).

## Adding a New Game

If you want to add a new game, follow this template:

```lua
-- GameName - [Game Link]: {Replace this with credits, like so: Emptyness, TemplateName, OtherName}
-- 1Feature
-- 2Feature
--[[rest of code]]--
```

## Contributing to an Existing Game

If you want to contribute to an already existing game, follow these steps:

1. Add the function creator to the top credits of the script.
2. Add the feature(s) that the function adds to the top of the script.
3. Optionally, you can also add the credits on the side of the function, example:

```lua
Demo:CreateKeybind(  -- Credits: LikeSo, SomeoneName
{
    Name = "Test This",
    Default = Enum.KeyCode.X,
    Callback = function()
    -- Demo
    end
}
)
```

Please adhere to these guidelines while making contributions to this repository. Your cooperation is highly appreciated.

Thank you for helping us improve this project!
