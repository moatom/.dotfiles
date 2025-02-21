local spaces = require("hs.spaces")
local appLayout = {
    -- {"Google Chrome", nil, 1},
    -- {"Gmail", nil, 2}
    -- {"Safari", nil, 1},  -- Safariをスペース1に配置
    -- {"Slack", nil, 2},   -- Slackをスペース2に配置
    -- {"Terminal", nil, 3} -- Terminalをスペース3に配置
}
for i, app in ipairs(appLayout) do
    hs.application.launchOrFocus(app[1])
    local win = hs.application.find(app[1]):mainWindow()
    if win then
        spaces.moveWindowToSpace(win:id(), app[3])
    end
end
