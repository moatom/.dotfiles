local ghostty = nil
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "G", function()
    -- Ghosttyがすでに開いている場合、非表示にする
    if ghostty and ghostty:isRunning() then
        ghostty:hide()
    else
        -- Ghosttyが開いていない場合、表示する
        ghostty = hs.application.launchOrFocus("Ghostty")
    end
end)
