M = {
    font = "Hack Nerd Font",
    font_size = 11.5
}

if (vim.loop.os_uname().sysname == "Linux") then
    M.font = "Hack Nerd Font"
    if (vim.fn.exists("g:neovide") == 1) then
        vim.g.neovide_refresh_rate = 220
        vim.g.neovide_scroll_animation_length = 0.3
        vim.g.neovide_transparency = 0.8
    end
else
    M.font = "JetBrainsMono NF"
    M.font_size = "12"

    if (vim.fn.exists("g:neovide") == 1) then
        vim.g.neovide_refresh_rate = 220
        vim.g.neovide_scroll_animation_length = 0.3
        vim.g.neovide_transparency = 0.95
    end
end

return M
-- vim.g.gui_font_default_size = M.font_size
-- vim.g.gui_font_size = vim.g.gui_font_default_size
-- vim.g.gui_font_face = M.font
--
-- RefreshGuiFont = function()
--   vim.opt.guifont = string.format("%s:h%s",vim.g.gui_font_face, vim.g.gui_font_size)
-- end
--
-- ResizeGuiFont = function(delta)
--   vim.g.gui_font_size = vim.g.gui_font_size + delta
--   RefreshGuiFont()
-- end
--
-- ResetGuiFont = function ()
--   vim.g.gui_font_size = vim.g.gui_font_default_size
--   RefreshGuiFont()
-- end
--
-- -- Call function on startup to set default value
-- ResetGuiFont()
--
-- -- Keymaps
-- local opts = { noremap = true, silent = true }
--
-- vim.keymap.set({'n', 'i'}, "<z+>", function() ResizeGuiFont(1)  end, opts)
-- vim.keymap.set({'n', 'i'}, "<z->", function() ResizeGuiFont(-1) end, opts)
-- vim.keymap.set({'n', 'i'}, "<C-BS>", function() ResetGuiFont() end, opts)
