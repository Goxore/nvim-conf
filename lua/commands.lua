vim.cmd "command W w"
vim.cmd "command Wq wq"
vim.cmd "command Q q"

vim.api.nvim_create_user_command('Colorscheme', function()
    require("colorschemepicker").select_colorscheme()
  end,
  {nargs = 0, desc = 'Apply prose settings'}
)
