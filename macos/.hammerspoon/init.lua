-- https://www.hammerspoon.org/docs/index.html
local home = os.getenv("HOME")  -- ユーザーのホームディレクトリを取得
package.path = package.path .. ";" .. home .. "/.dotfiles/macos/.hammerspoon/?.lua"
-- require("debug")
-- require("ghostty")
-- require("setup")
-- require("apps")


-- -- hs.hotkey.bind({"cmd", "alt", "ctrl"}, "D", function()
-- hs.hotkey.bind({}, "F1", function()
--   local screen = hs.screen.mainScreen()
--   local frame = screen:frame()

--   -- ウィンドウ幅を半分にする
--   local halfWidth = frame.w / 2

--   -- Discord を左側に
--   local discord = hs.application.get("Discord")
--   if discord then
--     local win = discord:mainWindow()
--     if win then
--       win:setFrame({
--         x = frame.x,
--         y = frame.y,
--         w = halfWidth,
--         h = frame.h
--       })
--     end
--   end

--   -- Slack を右側に
--   local slack = hs.application.get("Slack")
--   if slack then
--     local win = slack:mainWindow()
--     if win then
--       win:setFrame({
--         x = frame.x + halfWidth,
--         y = frame.y,
--         w = halfWidth,
--         h = frame.h
--       })
--     end
--   end
-- end)

hs.hotkey.bind({}, "F1", function()
  -- アプリ名（英語表記）
  local apps = {"Discord", "Slack"}

  -- 起動 or フォーカスする関数
  local function launchOrFocus(appName)
    local app = hs.application.get(appName)
    if not app then
      hs.application.launchOrFocus(appName)
      -- 起動待ち（最大3秒）
      hs.timer.waitUntil(
        function() return hs.application.get(appName) ~= nil end,
        function() hs.application.get(appName):activate() end,
        3
      )
    else
      app:activate()
    end
  end

  -- まず両方起動 or フォーカス
  for _, appName in ipairs(apps) do
    launchOrFocus(appName)
  end

  -- 少し待ってからウィンドウ配置（0.5秒）
  hs.timer.doAfter(0.5, function()
    local screens = hs.screen.allScreens()
    local screen = screens[#screens] -- 末尾ディスプレイ
    -- local screen = screens[2] -- sub display
    -- local screen = hs.screen.mainScreen()
    local frame = screen:frame()
    local halfWidth = frame.w / 2

    -- Discord 左
    local discord = hs.application.get(apps[1])
    if discord then
      local win = discord:mainWindow()
      if win then
        win:setFrame({x = frame.x, y = frame.y, w = halfWidth, h = frame.h})
      end
    end

    -- Slack 右
    local slack = hs.application.get(apps[2])
    if slack then
      local win = slack:mainWindow()
      if win then
        win:setFrame({x = frame.x + halfWidth, y = frame.y, w = halfWidth, h = frame.h})
      end
    end
  end)
end)
