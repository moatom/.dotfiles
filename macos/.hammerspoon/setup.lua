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



-- -- アプリ起動とウィンドウ配置
-- hs.application.launchOrFocus("Slack")
-- hs.application.launchOrFocus("Google Chrome")

-- -- 遅延してから配置（ウィンドウが出揃うまで待つ）
-- hs.timer.doAfter(2, function()
--   local slack = hs.window.get("Slack")
--   if slack then
--     slack:moveToScreen(hs.screen.primaryScreen()):moveToUnit(hs.layout.left50)
--   end

--   local chrome = hs.window.get("Google Chrome")
--   if chrome then
--     chrome:moveToScreen(hs.screen.primaryScreen()):moveToUnit(hs.layout.right50)
--   end
-- end)

---

