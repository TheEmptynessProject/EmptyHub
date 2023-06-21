local default = getgenv().mainLib:NewTab("Game Tab 1")
    local PlaceId =
        default:NewSection(
        {
            Name = "",
            column = 1
        }
    )
    PlaceId:CreateToggle(
        {
            Name = "Fake AFK",
            Callback = function(bool)
                local mt = debug.getmetatable(game);
                local nc = mt.__namecall;

                setreadonly(mt, false);

                mt.__namecall = newcclosure(function(self, ...)
                   local args = {...};
                   local method = getnamecallmethod();

                   if (method == "FireServer" and self.Name == "AFK") then
                        if bool then
                       args[1] = true;
                            end
                   end;

                   return nc(self, unpack(args));
                end);

                setreadonly(mt, true);
            end
        }
    )
