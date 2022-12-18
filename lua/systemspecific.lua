M = {
    -- font = "Hack Nerd Font",
    font = "JetBrainsMono Nerd Font",
    font_size = 11.5
}

if (vim.loop.os_uname().sysname == "Linux") then
    M.font = "JetBrainsMono Nerd Font"
else
    M.font = "JetBrainsMono NF"
    M.font_size = 12

    vim.cmd [[
        let &shell = has('win32') ? 'powershell' : 'pwsh'
        let &shellcmdflag = '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;'
        let &shellredir = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
        let &shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
        set shellquote= shellxquote=
    ]]

end

vim.opt.guifont = { M.font, ":h" .. M.font_size }

if (vim.fn.exists("g:neovide") == 1) then
    vim.g.neovide_refresh_rate = 220
    vim.g.neovide_scroll_animation_length = 0.3
    vim.g.neovide_transparency = 1
    vim.api.nvim_set_keymap("c", "<C-S-V>", "<c-r>+", {})
    vim.api.nvim_set_keymap("n", "<C-=>", ":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.05<CR>", { silent = true })
    vim.api.nvim_set_keymap("n", "<C-->", ":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.05<CR>", { silent = true })
    vim.api.nvim_set_keymap("n", "<C-0>", ":lua vim.g.neovide_scale_factor = 1<CR>", { silent = true })
end

return M
