-- https://www.hammerspoon.org/docs/index.html
local home = os.getenv("HOME")  -- ユーザーのホームディレクトリを取得
package.path = package.path .. ";" .. home .. "/.dotfiles/macos/.hammerspoon/?.lua"
-- require("debug")
-- require("ghostty")
-- require("setup")
-- require("apps")
