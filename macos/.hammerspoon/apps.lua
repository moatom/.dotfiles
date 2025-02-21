-- Option + ` でGhosttyのオーバーレイをトグル
local hyperKey = { "alt" }
local toggleKey = "`"
local ghosttyAppName = "Google Chrome" -- Ghosttyのアプリ名（必要に応じて変更）

-- Ghosttyのウィンドウをトグル
local function toggleGhosttyOverlay()
	local app = hs.application.get(ghosttyAppName)
	if app then
		local win = app:mainWindow()
		if win then
			if win:isVisible() then
				win:application():hide() -- ウィンドウが表示されている場合は非表示
			else
				win:application():activate(true) -- ウィンドウが非表示の場合は表示
				win:focus()
			end
		else
			-- メインウィンドウがない場合（最小化されている場合を含む）
			local allWindows = app:allWindows() -- すべてのウィンドウを取得
			if #allWindows > 0 then
				for _, w in ipairs(allWindows) do
					if w:isMinimized() then
						w:unminimize()
						w:focus() -- ウィンドウをフォーカス
						hs.alert.show("Ghostty restored from minimized")
						return
					end
				end
			else
				-- ウィンドウが完全に閉じられている場合、アクティブ化
				app:activate()
				hs.alert.show("Ghostty activated but no visible windows")
			end
			-- app:activate()
			-- local win2 = app:mainWindow()
			-- win2:application():activate(true) -- ウィンドウが非表示の場合は表示
			--hs.alert.show("Ghosttyのウィンドウが見つかりません")
		end
	else
		hs.alert.show("Ghosttyが起動していません")
	end
end

-- ホットキーを登録
hs.hotkey.bind(hyperKey, toggleKey, toggleGhosttyOverlay)

-- Hammerspoonの設定がロードされたことを通知
hs.alert.show("Hammerspoon configuration loaded!")
